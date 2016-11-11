require 'base64'
require 'json'

require 'instant2fa/resources'
require 'instant2fa/errors'
require 'instant2fa/middleware/unprocessable_entity_status'

module Instant2fa
  class Client

    attr_accessor :config

    def initialize(config=Instant2fa.config.dup, options={})
      @config = config

      Resources::Base.site = @config.api_base
      Resources::Base.connection(true) do |connection|
        # hack because it currently doesn't raise for 422
        connection.use Middleware::UnprocessableEntityStatus
        connection.use FaradayMiddleware::FollowRedirects
        connection.use Faraday::Request::BasicAuthentication, @config.access_key, @config.access_secret
      end
    end

    def create_settings(distinct_id, options = {})
      raise Errors::BadDistinctID, "distinct_id cannot be nil" unless distinct_id

      user_access_token = Resources::UserAccessToken.create(distinct_id: distinct_id.to_s)
      raise_if_errors(user_access_token)
      return user_access_token.hosted_page_url
    end

    def create_verification(distinct_id, options = {})
      raise Errors::BadDistinctID, "distinct_id cannot be nil" unless distinct_id

      begin
        verification_request = Resources::VerificationRequest.create(distinct_id: distinct_id.to_s)
        raise_if_errors(verification_request)
      rescue JsonApiClient::Errors::UnprocessableEntity
        raise Errors::MFANotEnabled.new, "User has not enabled an MFA device on their account."
      end

      return verification_request.hosted_page_url
    end

    def confirm_verification(distinct_id, token, options = {})
      raise Errors::BadDistinctID, "distinct_id cannot be nil" unless distinct_id

      verification_response_result_set = Resources::VerificationResponseToken.find(token)
      verification_response = verification_response_result_set[0]

      if verification_response.distinct_id != distinct_id.to_s
        raise Errors::VerificationMismatch, "The distinctID passed back from the request didn't match the one passed into this function. Are you passing in the right value for distinctID?"
      end

      if verification_response.status != 'succeeded'
        raise Errors::VerificationFailed, "The verification did not pass. The status was: #{verification_response.status}."
      end

      true
    end

    protected

    def raise_if_errors(resource)
      unless resource.errors.empty?
        raise Errors::ValidationError, "#{resource.class} could not be created due to a validation error."
      end
    end

    def symoblize_keys(hash)
      hash.inject({}) do |memo, (k, v)|
        memo[k.to_sym] = v.is_a?(Hash) ? symoblize_keys(v) : v
        memo
      end
    end
  end
end

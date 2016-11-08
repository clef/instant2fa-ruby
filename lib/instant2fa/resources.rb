require 'json_api_client'

module Instant2fa
  class ConnectionConfiguration
  end

  module Resources
    class UnprocessableEntity < JsonApiClient::Errors::ServerError
      def message
        "Unable to process request"
      end
    end

    class Base < JsonApiClient::Resource
      property :distinct_id, type: :string

      def self.site=(url)
        super(url)
        self.connection(rebuild: true)
      end

      def self.path(params)
        previous = super(params)
        previous + "/"
      end

      self.site = 'https://api.instant2fa.com/'
      self.route_format = :dasherized_key
    end

    class UserAccessToken < Base
      property :hosted_page_url, type: :string
    end

    class VerificationRequest < Base
      property :hosted_page_url, type: :string
    end

    class VerificationResponseToken < Base
    end

    class VerificationResponse < Base
      property :status, type: :string
    end
  end
end

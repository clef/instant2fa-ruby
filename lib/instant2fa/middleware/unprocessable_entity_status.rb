module JsonApiClient::Errors
  unless defined? UnprocessableEntity
    class UnprocessableEntity < ServerError
      def message
        "Unable to process request"
      end
    end
  end
end

module Instant2fa
  module Middleware
    class UnprocessableEntityStatus < Faraday::Middleware
      def call(environment)
        @app.call(environment).on_complete do |env|
          handle_status(env[:status], env)

          # look for meta[:status]
          if env[:body].is_a?(Hash)
            code = env[:body].fetch("meta", {}).fetch("status", 200).to_i
            handle_status(code, env)
          end
        end
      rescue Faraday::ConnectionFailed, Faraday::TimeoutError
        raise Errors::ConnectionError, environment
      end

      protected

      def handle_status(code, env)
        if code == 422
          raise JsonApiClient::Errors::UnprocessableEntity, env
        end
      end
    end
  end
end

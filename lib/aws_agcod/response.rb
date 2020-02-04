require "json"

class AGCOD
  class Response
    attr_reader :status, :payload
    attr_accessor :code

    def initialize(raw_json)
      @payload = JSON.parse(raw_json)

      # All status:
      # SUCCESS -- Operation succeeded
      # FAILURE -- Operation failed
      # RESEND -- A temporary/recoverable system failure that can be resolved by the partner retrying the request
      if payload["status"]
        @status = payload["status"]
      elsif payload["agcodResponse"]
        @status = payload["agcodResponse"]["status"]
      else
        @status = "FAILURE"
      end
    end

    def success?
      status == "SUCCESS"
    end

    def resend?
      status == "RESEND"
    end

    def failure?
      status == "FAILURE"
    end

    def error_code
      payload["errorCode"]
    end

    def error_message
      "#{payload["errorCode"]} #{payload["errorType"]} - #{payload["message"]}"
    end
  end
end

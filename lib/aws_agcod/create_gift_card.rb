class AGCOD
  class CreateGiftCardError < StandardError; end

  class CreateGiftCard
    extend Forwardable

    CURRENCIES = %w(USD EUR JPY CNY CAD GBP).freeze

    attr_accessor :request, :response

    def_delegators :@response, :status, :success?, :error_message

    def initialize(request)
      @request = request
    end

    def execute(request_id, amount, currency = "USD")
      unless CURRENCIES.include?(currency.to_s)
        raise CreateGiftCardError, "Currency #{currency} not supported, available types are #{CURRENCIES.join(", ")}"
      end

      @response = request.create("CreateGiftCard",
        "creationRequestId" => request_id,
        "value" => {
          "currencyCode" => currency,
          "amount" => amount
        }
      )

      self
    end

    def card_status
      status = @response.payload["cardInfo"]["cardStatus"]
      if ["fulfilled", "created"].include?(status.downcase)
        :created
      elsif status.downcase == "refundedtopurchaser"
        :refunded
      else
        :unknown
      end
    end

    def claim_code
      @response.payload["gcClaimCode"]
    end

    def expiration_date
      @expiration_date ||= Time.parse @response.payload["gcExpirationDate"]
    end

    def gc_id
      @response.payload["gcId"]
    end

    def request_id
      @response.payload["creationRequestId"]
    end
  end
end

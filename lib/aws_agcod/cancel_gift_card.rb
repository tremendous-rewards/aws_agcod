class AGCOD
  class CancelGiftCard
    extend Forwardable

    attr_accessor :request

    def_delegators :@response, :status, :success?, :error_message

    def initialize(request)
      @request = request
    end

    def execute(request_id, gc_id)
      @response = request.create("CancelGiftCard",
        "creationRequestId" => request_id,
        "gcId" => gc_id
      ).response
    end
  end
end

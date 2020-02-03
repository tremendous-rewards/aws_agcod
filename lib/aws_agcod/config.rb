class AGCOD
  class Config
    attr_writer   :uri
    attr_accessor :access_key,
                  :secret_key,
                  :partner_id,
                  :region,
                  :timeout,
                  :production,
                  :uri,
                  :debug_output

    def initialize(hash)
      # API defaults
      @production = false
      @timeout = 30

      hash.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end
  end
end

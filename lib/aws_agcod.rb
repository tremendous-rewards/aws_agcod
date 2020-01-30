require "aws_agcod/version"
require "aws_agcod/config"
require "aws_agcod/create_gift_card"
require "aws_agcod/cancel_gift_card"
require "aws_agcod/gift_card_activity_list"
require "aws_agcod/request"

class AGCOD
  attr_accessor :config, :request, :activity_list, :create_gift_card, :cancel_gift_card

	def initialize(config_hash)
		@config = config = Config.new(config_hash)
		@request = request = Request.new(config)

		@activity_list = GiftCardActivityList.new(request)
		@create_gift_card = CreateGiftCard.new(request)
		@cancel_gift_card = CancelGiftCard.new(request)
	end
end

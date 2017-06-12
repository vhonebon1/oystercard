class Oystercard

	CARD_LIMIT = 90

	attr_accessor :balance, :in_use

	def initialize(balance = 0, in_use = false)
		@balance = balance
		@in_use = in_use
	end

	def top_up(amount)
		fail "Can't top up above £#{CARD_LIMIT}" unless @balance + amount <= CARD_LIMIT
		@balance += amount
	end

	def deduct(amount)
		@balance -= amount
	end

	def touch_in
		fail "Not enough credit - please top up!" unless @balance > 1
		@in_use = true
	end

	def in_journey?
		@in_use == true
	end

	def touch_out
		@in_use = false
	end
end

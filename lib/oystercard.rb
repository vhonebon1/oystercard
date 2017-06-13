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

	def touch_in(station)
		fail "Not enough credit - please top up." unless @balance > 1
		station.name
		@in_use = true
	end

	def in_journey?
		in_use
	end

	def touch_out(fare_journey)
		@in_use = false
		deduct(fare_journey)
	end
end

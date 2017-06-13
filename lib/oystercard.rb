class Oystercard

	CARD_LIMIT = 90

	attr_accessor :balance, :entry_station, :exit_station, :journey, :journey_history

	def initialize(balance = 0)
		@balance = balance
		@entry_station = nil
		@exit_station = nil
		@journey = {}
		@journey_history = []
	end

	def top_up(amount)
		fail "Can't top up above £#{CARD_LIMIT}" unless balance + amount <= CARD_LIMIT
		self.balance = balance + amount
	end

	def deduct(amount)
		self.balance = balance - amount
	end

	def touch_in(station)
		@journey.clear
		fail "Not enough credit - please top up." unless balance > 1
		@entry_station = station.name
	end

	def in_journey?
		@entry_station != nil
	end

	def create_journey(exit_station)
		@journey = {entry_station: entry_station, exit_station: exit_station.name }
	end

	def store_journey
		@journey_history << @journey
	end

	def touch_out(fare_journey, exit_station)
    create_journey(exit_station)
		store_journey
		@exit_station = exit_station.name
		@entry_station = nil
		deduct(fare_journey)
	end
end

# Unwiped exit station

class Oystercard
	
	CARD_LIMIT = 90

	attr_accessor :balance, :in_use
	
	def initialize
		@balance = 0
		@in_use = false
	end 
	
	def top_up(amount)
		fail "Total balance cannot exceed £#{CARD_LIMIT}" unless self.balance + amount <= CARD_LIMIT 
		self.balance  = self.balance + amount
	end

	def deduct(amount)
		self.balance = self.balance - amount
	end 

	def touch_in
		@in_use = true
	end

	def in_journey? 
		@in_use == true 
	end 
end
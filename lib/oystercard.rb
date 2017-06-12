class Oystercard
	
	CARD_LIMIT = 90

	attr_accessor :balance
	
	def initialize
		@balance = 0
	end 
	
	def top_up(amount)
		fail "Total balance cannot exceed £90" unless self.balance + amount <= CARD_LIMIT 
		self.balance  = self.balance + amount
	end

end
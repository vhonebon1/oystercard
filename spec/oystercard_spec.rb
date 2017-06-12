require './lib/oystercard.rb'
describe Oystercard do
	it "expects the card to have a balance of 0 when initialized" do 
		card = Oystercard.new 
		expect(card.balance).to eq 0
	end 

	describe "#top_up" do 
		it "increases the card balance by a specified amount" do 
			card = Oystercard.new
			card.top_up(5)
			expect(card.balance).to eq 5 
		end 
		context "If top up makes balance exceed limit of £90"
		it "raises an error" do
			card = Oystercard.new
			card.top_up(Oystercard::CARD_LIMIT)
			expect{card.top_up(1)}.to raise_error("Total balance cannot exceed £90")
		end
	end 
	describe "#deduct" do 
		it "deducts some amount from the card balance" do
			card = Oystercard.new
			random_amount = rand(1..90)
			card.top_up(random_amount)
			expect(card.deduct(random_amount)).to eq 0 
		end 
	end 
end
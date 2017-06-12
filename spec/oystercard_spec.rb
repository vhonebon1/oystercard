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
	end 
end
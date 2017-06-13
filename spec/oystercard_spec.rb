require './lib/oystercard.rb'
describe Oystercard do

	let(:card) {described_class.new}
	let(:entry_station) { double("entry_station") }
	let(:exit_station) { double("exit_station") }

	before do
		allow(entry_station).to receive(:name).and_return("Bank")
		allow(exit_station).to receive(:name).and_return("Mile End")
	end

	describe "#initialize" do

		it "expects the card to have a balance of 0 when initialized" do
			expect(card.balance).to eq(0)
		end

		it "sets journey history as empty by default" do
			expect(card.journey_history).to be_empty
		end

	end


	describe "#top_up" do
		it "increases the card balance by a specified amount" do
			card.top_up(5)
			expect(card.balance).to eq(5)
		end
		context "If top up makes balance exceed limit of #{Oystercard::CARD_LIMIT}"
		it "raises an error" do
			card.top_up(Oystercard::CARD_LIMIT)
			expect{card.top_up(1)}.to raise_error("Can't top up above £#{Oystercard::CARD_LIMIT}")
		end
	end

	describe "#deduct" do
		it "deducts some amount from the card balance" do
			random_amount = rand(1..90)
			card.top_up(random_amount)
			expect(card.deduct(random_amount)).to eq(0)
		end
	end

	describe "#touch_in" do
		context "Where there is greater than £1 credit on card" do
		it "lets user touch in" do
			card.top_up(10)
			card.touch_in(entry_station)
			expect(card.entry_station).to eq "Bank"
		end
	end
		context "when card has less than £1 credit" do
			it "raises an error" do
				card.deduct(10)
			expect{card.touch_in(entry_station)}.to raise_error("Not enough credit - please top up.")
		end
	end

		before do
			card.top_up(10)
		end

	  it "passes a message \'name\' to a entry_station object" do
			expect(entry_station).to receive(:name)
			card.touch_in(entry_station)
		end

		it "returns the entry_station name when \'name\' message is called" do
			expect(entry_station).to receive(:name).and_return("Bank")
			card.touch_in(entry_station)
		end

		it "assigns the entry_station name to entry entry_station instance variable" do
			expect{card.touch_in(entry_station)}.to change{card.entry_station}.from(nil).to ("Bank")
			card.touch_in(entry_station)
		end

end

	describe "#in_journey?" do
		it "tells whether a card is in use" do
			card.top_up(10)
			card.touch_in(entry_station)
			expect(card.in_journey?).to eq(true)
		end
	end

	describe "#touch_out" do
		before do
			card.top_up(10)
			card.touch_in(entry_station)
		end
		it "changes card status to not in use" do
			fare_journey = 5
			card.touch_out(fare_journey, exit_station)
			expect(card).not_to be_in_journey
		end
		it "deducts the fare for the journey when journey ends" do
			fare_journey = 5
			expect{card.touch_out(fare_journey, exit_station)}.to change{card.balance}.from(card.balance).to (card.balance - fare_journey)
		end

		it "records the exit station's name" do
			fare_journey = 5
			expect{card.touch_out(fare_journey, exit_station)}.to change{card.exit_station}.from(nil).to (exit_station.name)
		end

		it "creates a record of the completed journey" do
			 fare_journey = 5
			 card.touch_out(fare_journey, exit_station)
			 expect(card.journey).to eq({entry_station: "Bank", exit_station: "Mile End"})
		end


		it "wipes the name of entry station" do
			fare_journey = 5
			expect{card.touch_out(fare_journey, exit_station)}.to change{card.entry_station}.from(card.entry_station).to (nil)
		end
	end
end

require "./lib/station.rb"

describe Station do

  subject(:station) { described_class.new(:Stepney_Green, :Zone_Two)}

  describe "attributes" do
  it {is_expected.to respond_to(:name, :zone)}

  it "initializes with a name" do
    expect(station.name).to be :Stepney_Green
  end

  it "initializes with a zone" do
    expect(station.zone).to be :Zone_Two
  end

 end
end

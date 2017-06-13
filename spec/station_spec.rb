require "./lib/station.rb"

describe Station do
  it {is_expected.to respond_to(:name, :zone)}
end

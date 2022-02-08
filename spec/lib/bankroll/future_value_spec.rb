require "spec_helper"

RSpec.describe Bankroll::FutureValue do
  it "returns the correct amount with a basic scenario" do
    result = described_class.call(
      present_value: 56.74,
      interest_rate: 0.12,
      periods: 5
    ).round(2)

    expect(result).to eq BigDecimal(100)
  end
end

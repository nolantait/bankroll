require "spec_helper"

RSpec.describe Bankroll::FutureValue do
  it "returns the correct amount with a basic scenario" do
    result = described_class.call(
      present_value: 0,
      interest_rate: Bankroll::Decimal[0.01] / 12,
      periods: 360,
      payment: Bankroll::Decimal['1_608.20']
    ).round

    expect(result).to eq Bankroll::Decimal["674_846.1"]
  end
end

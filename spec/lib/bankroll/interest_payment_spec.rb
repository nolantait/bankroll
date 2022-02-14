require "spec_helper"

RSpec.describe Bankroll::InterestPayment do
  it "returns the correct amount with a basic scenario" do
    interest_payment = described_class.call(
      interest_rate: Bankroll::Decimal["0.03"] / 12,
      periods: 360,
      period: 17,
      present_value: 165_000,
    ).round

    expect(interest_payment).to eq Bankroll::Decimal["400.96"]
  end

  # See: https://support.microsoft.com/en-us/office/ipmt-function-5cce0ad6-8402-4a41-8d29-61a0b054cb6f
  it "matches an excel version of the function" do
    interest_payment = described_class.call(
      interest_rate: Bankroll::Decimal["0.1"] / 12,
      periods: 36,
      period: 1,
      present_value: 8_000
    ).round

    expect(interest_payment).to eq Bankroll::Decimal["66.67"]
  end
end

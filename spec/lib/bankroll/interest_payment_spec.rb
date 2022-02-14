require "spec_helper"

RSpec.describe Bankroll::InterestPayment do
  it "returns the correct amount with a basic scenario" do
    interest_payment = described_class.call(
      interest_rate: Bankroll::Decimal["0.03"] / 12,
      periods: 360,
      periods_elapsed: 16,
      present_value: 165_000,
    ).round

    expect(interest_payment).to eq Bankroll::Decimal["400.96"]
  end
end

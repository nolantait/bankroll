require "spec_helper"

RSpec.describe Bankroll::UnpaidBalance do
  it "returns the correct amount" do
    result = described_class.call(
      present_value: 50_000,
      payment: 4_685,
      interest_rate: 0.08,
      periods: 25,
      period: 7
    ).round

    expect(result).to eq Bankroll::Decimal['43_897.35']
  end
end

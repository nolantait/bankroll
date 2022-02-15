require "spec_helper"

RSpec.describe Bankroll::CumulativeInterest do
  it "returns the expected amount of interest at period 1" do
    result = Bankroll::CumulativeInterest.call(
      periods: 1,
      interest_rate: Bankroll::Decimal[0.01] / Bankroll::Decimal[12],
      payment: Bankroll::Decimal['1_608.20'],
      present_value: Bankroll::Decimal[500_000]
    ).round

    expect(result).to eq Bankroll::Decimal['416.67']
  end

  it "returns the expected amount of interest at period 2" do
    result = Bankroll::CumulativeInterest.call(
      periods: 2,
      interest_rate: Bankroll::Decimal[0.01] / Bankroll::Decimal[12],
      payment: Bankroll::Decimal['1_608.20'],
      present_value: Bankroll::Decimal[500_000]
    ).round

    expect(result).to eq Bankroll::Decimal['832.34']
  end

  it "returns the expected amount of interest at the last period" do
    result = Bankroll::CumulativeInterest.call(
      periods: 360,
      interest_rate: Bankroll::Decimal[0.01] / Bankroll::Decimal[12],
      payment: Bankroll::Decimal['1_608.20'],
      present_value: Bankroll::Decimal[500_000]
    ).round

    expect(result).to eq Bankroll::Decimal['78_950.99']
  end
end

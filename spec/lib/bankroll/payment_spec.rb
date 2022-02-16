# frozen_string_literal: true

require "spec_helper"

RSpec.describe Bankroll::Payment do
  it "example A returns the correct amount" do
    result = described_class.call(
      present_value: 135_000,
      interest_rate: 0.005,
      periods: 300
    ).round

    expect(result).to eq Bankroll::Decimal["869.81"]
  end

  it "example B returns the correct amount" do
    result = described_class.call(
      present_value: 50_000,
      interest_rate: 0.08,
      periods: 25
    ).round

    expect(result).to eq Bankroll::Decimal["4683.94"]
  end
end

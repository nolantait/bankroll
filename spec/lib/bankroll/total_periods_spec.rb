# frozen_string_literal: true

require "spec_helper"

RSpec.describe Bankroll::TotalPeriods do
  it "returns the total periods of an investment" do
    periods = described_class.call(
      interest_rate: Bankroll::Decimal["0.12"] / 12,
      payment: -100,
      present_value: -1_000,
      future_value: 10_000
    ).round

    expect(periods).to eq Bankroll::Decimal["59.67"]
  end
end

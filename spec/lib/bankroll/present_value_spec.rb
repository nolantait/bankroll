# frozen_string_literal: true

require "spec_helper"

RSpec.describe Bankroll::PresentValue do
  it "returns the expected value" do
    result = described_class.call(
      future_value: 0,
      interest_rate: Bankroll::Decimal["0.01"] / Bankroll::Decimal["12"],
      payment: 643.28,
      periods: 360
    ).round

    expect(result).to eq Bankroll::Decimal["200_000.3"]
  end
end

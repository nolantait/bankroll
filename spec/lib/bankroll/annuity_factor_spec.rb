# frozen_string_literal: true

require "spec_helper"

ANNUITY_TABLE = [
  # Rates
  # 1%       2%     3%      4%       5%      6%
  [0.9901, 0.9804, 0.9709, 0.9615, 0.9524, 0.9434], # period = 1
  [1.9704, 1.9416, 1.9135, 1.8861, 1.8594, 1.8334], # period = 2
  [2.9410, 2.8839, 2.8286, 2.7751, 2.7232, 2.6730] # period = 3
].freeze

RSpec.describe Bankroll::AnnuityFactor do
  ANNUITY_TABLE.each_with_index do |periods, period_index|
    periods.each_with_index do |_rates, rate_index|
      it "#{period_index + 1} periods and #{rate_index + 1}% interest_rate is correct" do
        result = described_class.call(
          interest_rate: Bankroll::Decimal[rate_index + 1] * Bankroll::Decimal["0.01"],
          periods: period_index + 1
        )

        annuity = ANNUITY_TABLE[period_index][rate_index]

        expect(result.round(4)).to eq Bankroll::Decimal[annuity]
      end
    end
  end
end

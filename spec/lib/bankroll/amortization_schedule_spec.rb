# frozen_string_literal: true

require "spec_helper"

RSpec.describe Bankroll::AmortizationSchedule do
  let(:amortization_schedule) do
    described_class.new(
      present_value: 165_000,
      interest_rate: Bankroll::Decimal["0.03"] / 12,
      periods: 360
    )
  end

  describe "#initialization" do
    it "returns an amortization schedule" do
      expect { amortization_schedule }
        .not_to raise_error
    end
  end

  describe "#payments" do
    let(:payments) { amortization_schedule.payments }

    it "returns the expected first payment" do
      expect(payments.first.to_h).to eq(
        described_class::Payment.new(
          payment: Bankroll::Decimal["695.65"],
          principal: Bankroll::Decimal["283.15"],
          interest: Bankroll::Decimal["412.50"],
          total_interest: Bankroll::Decimal["412.50"],
          balance: Bankroll::Decimal["164_716.85"]
        ).to_h
      )
    end

    it "returns the expected middle payment" do
      expect(payments[1].to_h).to eq(
        described_class::Payment.new(
          payment: Bankroll::Decimal["695.65"],
          principal: Bankroll::Decimal["283.86"],
          interest: Bankroll::Decimal["411.79"],
          total_interest: Bankroll::Decimal["824.29"],
          balance: Bankroll::Decimal["164_432.99"]
        ).to_h
      )
    end

    it "returns the expected last payment" do
      expect(payments[2].to_h).to eq(
        described_class::Payment.new(
          payment: Bankroll::Decimal["695.65"],
          principal: Bankroll::Decimal["284.57"],
          interest: Bankroll::Decimal["411.08"],
          total_interest: Bankroll::Decimal["1_235.37"],
          balance: Bankroll::Decimal["164_148.42"]
        ).to_h
      )
    end
  end
end

# frozen_string_literal: true

RSpec.describe Bankroll do
  let(:interest_rate) { Bankroll::Decimal["0.01"] / Bankroll::Decimal["12"] }
  let(:periods) { 360 }
  let(:loan_amount) { Bankroll::Decimal["1_000_000"] }
  let(:payment) { Bankroll::Decimal["3_216.40"] }

  it "has a version number" do
    expect(Bankroll::VERSION).not_to be_nil
  end

  describe ".payment" do
    it "returns the expected payment" do
      result = described_class.payment(
        present_value: loan_amount,
        periods:,
        interest_rate:
      ).round

      expect(result).to eq payment
    end
  end

  describe ".unpaid_balance" do
    it "returns the amount remaining in a loans payment schedule" do
      result = described_class.unpaid_balance(
        present_value: loan_amount,
        interest_rate:,
        periods:,
        period: 1,
        payment:
      ).round

      expect(result).to eq Bankroll::Decimal["997_616.94"]
    end
  end

  describe ".interest_rate" do
    it "returns the expected rate" do
      result = described_class.interest_rate(
        present_value: loan_amount,
        periods:,
        payment: -payment
      ).round(3)

      expect(result).to eq interest_rate.round(3)
    end
  end

  describe ".present_value" do
    it "returns the expected loan amount" do
      result = described_class.present_value(
        periods:,
        payment:,
        interest_rate:
      ).round

      expect(result).to eq Bankroll::Decimal["1_000_001.49"]
    end
  end

  describe ".annuity_factor" do
    it "returns the expected factor" do
      result = described_class.annuity_factor(
        interest_rate: 0.01,
        periods: 2
      ).round(4)

      expect(result).to eq Bankroll::Decimal["1.9704"]
    end
  end

  describe ".cumulative_interest" do
    it "returns the expected cumulative interest" do
      result = described_class.cumulative_interest(
        periods: 2,
        interest_rate: Bankroll::Decimal["0.01"] / 12.0,
        payment: 1_608.20,
        present_value: 500_000
      ).round

      expect(result).to eq Bankroll::Decimal["832.34"]
    end
  end

  describe ".future_value" do
    it "returns the expected future value" do
      result = described_class.future_value(
        present_value: 0,
        interest_rate: Bankroll::Decimal["0.01"] / 12.0,
        periods: 360,
        payment: 1_608.20
      ).round

      expect(result).to eq Bankroll::Decimal["674_846.10"]
    end
  end

  describe ".total_periods" do
    it "returns the expected periods" do
      result = described_class.total_periods(
        interest_rate: Bankroll::Decimal["0.12"] / 12.0,
        present_value: -1_000,
        payment: -100,
        future_value: 10_000
      ).round

      expect(result).to eq Bankroll::Decimal["59.67"]
    end
  end

  describe ".amortization_schedule" do
    let(:amortization_schedule) do
      described_class.amortization_schedule(
        present_value: 165_000,
        interest_rate: 0.03 / 12.0,
        periods: 360
      )
    end

    it "returns the expected payments" do
      expect(result.payments.first).to eq Bankroll::AmortizationSchedule::Payment.new(
        payment: Bankroll::Decimal["695.65"],
        principal: Bankroll::Decimal["283.15"],
        interest: Bankroll::Decimal["412.50"],
        total_interest: Bankroll::Decimal["412.50"],
        balance: Bankroll::Decimal["164_716.85"]
      )
    end
  end
end

# frozen_string_literal: true

RSpec.describe Bankroll do
  it "has a version number" do
    expect(Bankroll::VERSION).not_to be nil
  end

  let(:payment) { Bankroll::Decimal['3_216.40'] }
  let(:loan_amount) { Bankroll::Decimal['1_000_000'] }
  let(:periods) { Bankroll::Decimal['360'] }
  let(:interest_rate) { Bankroll::Decimal['0.01'] / Bankroll::Decimal['12'] }

  describe ".payment" do
    it "returns the expected payment" do
      result = Bankroll.payment(
        present_value: loan_amount,
        periods: periods,
        interest_rate: interest_rate
      ).round

      expect(result).to eq payment
    end
  end

  describe ".unpaid_balance" do
    it "returns the amount remaining in a loans payment schedule" do
      result = Bankroll.unpaid_balance(
        present_value: loan_amount,
        interest_rate: interest_rate,
        periods: periods,
        period: 1,
        payment: payment
      ).round

      expect(result).to eq Bankroll::Decimal['997_616.94']
    end
  end

  # describe ".interest_rate" do
  #   it "returns the expected rate" do
  #     result = Bankroll.interest_rate(
  #       loan_amount: loan_amount,
  #       periods: periods,
  #       payment: payment
  #     )

  #     expect(result).to eq interest_rate
  #   end
  # end

  describe ".loan_amount" do
    it "returns the expected loan amount" do
      result = Bankroll.loan_amount(
        periods: periods,
        payment: payment,
        interest_rate: interest_rate
      ).round

      expect(result).to eq Bankroll::Decimal['1_000_001.49']
    end
  end
end

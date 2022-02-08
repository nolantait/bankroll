module Bankroll
  class UnpaidBalance
    extend Callable
    extend Dry::Initializer

    ONE = Decimal['1'].freeze

    option :loan_amount, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"]
    option :periods, Types["bankroll.decimal"]
    option :periods_elapsed, Types["bankroll.decimal"]

    def call
      unpaid_balance
    end

    private

    def unpaid_balance
      payment * annuity_factor
    end

    def payment
      Payment.call(
        loan_amount: @loan_amount,
        interest_rate: @interest_rate,
        periods: @periods
      )
    end

    def annuity_factor
      AnnuityFactor.call(interest_rate: @interest_rate, periods: remaining)
    end

    def remaining
      @periods - @periods_elapsed
    end
  end
end

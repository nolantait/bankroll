module Bankroll
  class InterestPayment
    # The interest portion of a payment at period N

    extend Callable
    extend Dry::Initializer

    option :interest_rate, Types["bankroll.decimal"]
    option :periods, Types["bankroll.decimal"]
    option :periods_elapsed, Types["bankroll.decimal"]
    option :present_value, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"] | Types["nil"], default: -> { nil }

    def call
      future_loan_balance * @interest_rate
    end

    private

    def future_loan_balance
      FutureValue.call(
        periods: @periods_elapsed - 1,
        payment: payment,
        present_value: @present_value,
        interest_rate: @interest_rate
      )
    end

    def payment
      @payment ||= -Payment.call(
        loan_amount: @present_value,
        interest_rate: @interest_rate,
        periods: @periods
      )
    end
  end
end

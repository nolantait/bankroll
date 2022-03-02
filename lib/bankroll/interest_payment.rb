# frozen_string_literal: true

module Bankroll
  class InterestPayment
    # The interest portion of a payment at period N

    extend Callable
    extend Dry::Initializer

    option :interest_rate, Types["bankroll.decimal"]
    option :periods, Types["bankroll.decimal"]
    option :period, Types["integer"]
    option :present_value, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"] | Types["nil"], default: -> {}

    def call
      future_loan_balance * @interest_rate
    end

    private

    def future_loan_balance
      FutureValue.call(
        periods: @period - 1,
        payment:,
        present_value: @present_value,
        interest_rate: @interest_rate
      )
    end

    def payment
      @payment ||= -Payment.call(
        present_value: @present_value,
        interest_rate: @interest_rate,
        periods: @periods
      )
    end
  end
end

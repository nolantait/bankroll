# frozen_string_literal: true

module Bankroll
  class AmortizationSchedule
    extend Dry::Initializer
    extend Callable

    Payment = Struct.new(
      :payment,
      :principal,
      :interest,
      :total_interest,
      :balance,
      keyword_init: true
    )

    option :present_value, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"]
    option :periods, Types["integer"]

    def each
      Enumerator.new do |yielder|
        current_payment = Payment.new(
          payment: monthly_payment.round,
          total_interest: Decimal["0"],
          balance: @present_value
        )

        periods.times do |period|
          yielder << current_payment = payment_for_period(period, current_payment)
        end
      end
    end

    def payments
      @payments ||= each.to_a
    end

    def call
      self
    end

    private

    def payment_for_period(period, last_payment)
      interest = interest_payment(period + 1)
      principal = last_payment.payment - interest

      Payment.new(
        payment: last_payment.payment,
        principal: principal.round,
        interest: interest.round,
        total_interest: (last_payment.total_interest + interest).round,
        balance: (last_payment.balance - principal).round
      )
    end

    def interest_payment(period)
      InterestPayment.call(
        interest_rate: @interest_rate,
        periods: @periods,
        period:,
        present_value: @present_value,
        payment: -monthly_payment
      )
    end

    def monthly_payment
      @monthly_payment ||= Bankroll::Payment.call(
        present_value: @present_value,
        interest_rate: @interest_rate,
        periods: @periods
      )
    end
  end
end

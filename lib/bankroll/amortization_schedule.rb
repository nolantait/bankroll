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
        total_interest = Decimal["0"]
        balance = @present_value

        periods.times do |period|
          interest = interest_payment(period + 1)
          principal = payment - interest
          total_interest += interest
          balance -= principal

          yielder << Payment.new(
            payment: payment.round,
            principal: principal.round,
            interest: interest.round,
            total_interest: total_interest.round,
            balance: balance.round
          )
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

    def interest_payment(period)
      InterestPayment.call(
        interest_rate: @interest_rate,
        periods: @periods,
        period: period,
        present_value: @present_value,
        payment: -payment
      )
    end

    def payment
      @payment ||= Bankroll::Payment.call(
        present_value: @present_value,
        interest_rate: @interest_rate,
        periods: @periods
      )
    end
  end
end

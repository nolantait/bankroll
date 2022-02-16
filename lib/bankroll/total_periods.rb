# frozen_string_literal: true

module Bankroll
  class TotalPeriods
    extend Callable
    extend Dry::Initializer

    # Equivalent to Excel's NPER
    # Calculates the total periods of an investment given a fixed payment,
    # an interest rate and the loan's present value.
    # Future value can be 0 for the end of a loan or any intermediate value

    option :interest_rate, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"]
    option :present_value, Types["bankroll.decimal"]
    option :future_value, Types["bankroll.decimal"]
    option :type, Types["annuity_type"], default: -> { :ordinary }

    def call
      return (-@present_value - @future_value) / @payment if interest_rate.zero?

      Bankroll::Decimal[periods]
    end

    private

    def periods
      Math.log(percentage_of_total_interest_on_principal) /
        Math.log((1 + @interest_rate))
    end

    def percentage_of_total_interest_on_principal
      (-@future_value + initial_payment_interest) /
        (@present_value + initial_payment_interest)
    end

    def initial_payment_interest
      case type
        when :ordinary
          (@payment * (1 + @interest_rate)) / @interest_rate
        else
          0
      end
    end
  end
end

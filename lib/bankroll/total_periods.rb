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

    def call
      return (-@present_value - @future_value) / @payment if interest_rate.zero?

      Bankroll::Decimal[periods]
    end

    private

    def periods
      Math.log((-@future_value + contribution) / (@present_value + contribution)) /
        Math.log((1 + @interest_rate))
    end

    def contribution
      (@payment * (1 + @interest_rate)) / @interest_rate
    end
  end
end

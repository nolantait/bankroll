module Bankroll
  class CumulativeInterest
    # Calculate the total interest paid at any period
    #
    extend Callable
    extend Dry::Initializer

    option :periods, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"], default: -> { ZERO }
    option :present_value, Types["bankroll.decimal"]

    def call
      payments_made + 
        ((total_interest - @payment) * percentage_of_interest_per_period)
    end

    private

    def percentage_of_interest_per_period
      ((compound_rate - ONE) / @interest_rate)
    end

    def payments_made
      @payment * @periods
    end

    def compound_rate
      (ONE + @interest_rate) ** @periods
    end

    def total_interest
      @present_value * @interest_rate
    end
  end
end

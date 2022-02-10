module Bankroll
  class CumulativeInterest
    # Calculate the total interest paid at any period
    #
    extend Callable
    extend Dry::Initializer

    option :periods, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"], default: -> { ZERO }
    option :loan_amount, Types["bankroll.decimal"]

    def call
      payments_made + (total_interest_paid_per_period - @payment) * portion_of_interest_paid
    end

    private

    def portion_of_interest_paid
      ((compound_rate - ONE) / @interest_rate)
    end

    def payments_made
      @payment * @periods
    end

    def compound_rate
      (ONE + @interest_rate) ** @periods
    end

    def total_interest_paid_per_period
      @loan_amount * @interest_rate
    end
  end
end

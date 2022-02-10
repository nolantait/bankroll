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
      temp = (interest_on_principle - @payment) *
        ((effective_rate - ONE) / @interest_rate)

      temp + payments_made
    end

    private

    def payments_made
      @payment * @periods
    end

    def effective_rate
      (ONE + @interest_rate) ** @periods
    end

    def interest_on_principle
      @loan_amount * @interest_rate
    end
  end
end

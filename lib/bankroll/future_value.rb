module Bankroll
  class FutureValue
    # Future value is the value to which an investment will grow 
    # after one or more periods. Usage is with a fixed payment 

    extend Callable
    extend Dry::Initializer

    def self.call(**kwargs)
      new(**kwargs).call
    end

    option :periods, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"], default: -> { ZERO }
    option :present_value, Types["bankroll.decimal"], default: -> { ZERO }

    def call
      (effective_rate * present_value) +
        (@payment * (1 + @interest_rate * 0) * (effective_rate - 1) / @interest_rate)
    end

    private

    def effective_rate
      (ONE + @interest_rate) ** @periods
    end
  end
end

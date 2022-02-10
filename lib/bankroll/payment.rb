module Bankroll
  class Payment
    extend Callable
    extend Dry::Initializer

    option :loan_amount, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"]
    option :periods, Types["bankroll.decimal"]

    def call
      payment
    end

    private

    def payment
      @loan_amount * mortgage_constant
    end

    def mortgage_constant
      ONE / annuity_factor
    end

    def annuity_factor
      AnnuityFactor.call(interest_rate: @interest_rate, periods: @periods)
    end
  end
end

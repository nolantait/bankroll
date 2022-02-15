module Bankroll
  class AnnuityFactor
    extend Callable
    extend Dry::Initializer

    ONE = Decimal['1'].freeze

    option :periods, Types["bankroll.decimal"]
    option :interest_rate, Types["bankroll.decimal"]

    def call
      annuity_factor
    end

    private

    def annuity_factor
      (ONE - interest_contribution_per_period) / @interest_rate
    end

    def interest_contribution_per_period
      (ONE + @interest_rate) ** -@periods
    end
  end
end

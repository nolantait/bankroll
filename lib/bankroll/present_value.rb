module Bankroll
  class PresentValue
    extend Callable
    extend Dry::Initializer

    # Calculates the present value of an annuity
    # ==========================================
    # A borrower gets a loan with the following:
    # - Loan amount: $100,000
    # - Term: 25 years
    # - Interest rate: 10%

    ZERO = Decimal['0'].freeze

    option :periods, Types["bankroll.decimal"]
    option :payment, Types["bankroll.decimal"]
    option :future_value, Types["bankroll.decimal"], default: -> { ZERO }
    option :interest_rate, Types["bankroll.decimal"], default: -> { ZERO }

    def call
      present_value.round
    end

    private

    def present_value
      @payment * annuity_factor
    end

    def annuity_factor
      AnnuityFactor.call(periods: @periods, interest_rate: @interest_rate)
    end
  end
end

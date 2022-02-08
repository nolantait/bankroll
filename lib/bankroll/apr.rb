module Bankroll
  class Apr
    def self.call(loan_amount:, interest_rate:, term:, cost: 0, points: 100, ysp: 0)
      new(**kwargs).call
    end

    def initialize(loan_amount:, interest_rate:, periods:, cost: 0, points: 100, ysp: 0)
      @loan_amount = loan_amount
      @interest_rate = interest_rate
      @periods = periods
      @cost = cost
      @points = points
      @ysp = ysp
    end

    def call
    end
  end
end

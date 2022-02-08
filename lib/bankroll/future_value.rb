module Bankroll
  class FutureValue
    # Future value is the value to which an investment will grow 
    # after one or more compounding periods. 

    def self.call(**kwargs)
      new(**kwargs).call
    end

    # @params annuity: [:ordinary, :due]
    # @returns BigDecimal: The value at the end of the period
    def initialize(present_value:, interest_rate:, periods:, payment: 0)
      @present_value = BigDecimal(present_value.to_s)
      @interest_rate = BigDecimal(interest_rate.to_s)
      @payment = BigDecimal(payment.to_s)
      @periods = BigDecimal(periods.to_s)
      @annuity = annuity
    end

    def call
      # (@present_value * compound_rate) -
      #   (@payment * (1 + @interest_rate) / @interest_rate) *
      #   (compound_rate - 1)

      # case @payment
      # when 0
      #   case @periods
      #   when 0
      #     @present_value
      #   when 1
      #     @present_value * interest
      #   else
      #     @present_value * compound_interest
      #   end
      # else
      # else
      #   raise ArgumentError
      # end
    end

    private

    def compound_interest
      interest ** @periods
    end

    def interest
      (1 + @interest_rate)
    end
  end
end

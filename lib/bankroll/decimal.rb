module Bankroll
  class Decimal < Delegator
    include Dry::Equalizer.new(:value)

    ROUNDING = :half_even

    def self.[](value)
      if value.is_a? self
        value
      else
        new(value.to_s)
      end
    end

    attr_reader :value
    alias_method :__getobj__, :value

    def initialize(value)
      decimal = case value
      when self.class
        value.value.to_s
      else
        value.to_s
      end

      @value = BigDecimal(Types["string"][decimal])
    end

    def round(precision = 2, rounding = ROUNDING)
      wrap @value.round(precision, rounding)
    end

    def +(other)
      wrap super(Decimal[other].value)
    end

    def -(other)
      wrap super(Decimal[other].value)
    end

    def *(other)
      wrap super(Decimal[other].value)
    end

    def /(other)
      wrap super(Decimal[other].value)
    end

    def **(other)
      wrap super(Decimal[other].value)
    end

    private

    def wrap(value)
      Decimal[value]
    end
  end
end

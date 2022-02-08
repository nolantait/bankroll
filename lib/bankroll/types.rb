module Bankroll
  module Types
    include Dry.Types()

    Constructor = Dry::Types::Constructor

    def self.[](key)
      Dry::Types[key]
    end

    def self.register(key, value)
      Dry::Types.register(key, value)
    end

    ConvertToDecimal = lambda do |value|
      if value.is_a? Bankroll::Decimal
        return value
      else
        Bankroll::Decimal[value.to_s]
      end
    end

    register("bankroll.decimal", Constructor[Bankroll::Decimal, fn: ConvertToDecimal])
  end
end

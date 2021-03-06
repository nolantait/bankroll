# frozen_string_literal: true

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
      return value if value.is_a? Bankroll::Decimal

      Bankroll::Decimal[value.to_s]
    end

    register("bankroll.decimal", Constructor[Bankroll::Decimal, fn: ConvertToDecimal])
    register("annuity_type", Types["symbol"].enum(:ordinary, :due))
  end
end

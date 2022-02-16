# frozen_string_literal: true

module Bankroll
  module Callable
    def call(**kwargs)
      new(**kwargs).call
    end
  end
end

# frozen_string_literal: true

require "bigdecimal"
require "dry-types"
require "dry-initializer"
require "dry-equalizer"
require "delegate"

require_relative "bankroll/version"
require_relative "bankroll/callable"
require_relative "bankroll/decimal"
require_relative "bankroll/types"

require_relative "bankroll/cumulative_interest"
require_relative "bankroll/present_value"
require_relative "bankroll/future_value"
require_relative "bankroll/annuity_factor"
require_relative "bankroll/payment"
require_relative "bankroll/unpaid_balance"
require_relative "bankroll/interest_payment"
require_relative "bankroll/amortization_schedule"

BigDecimal.mode(BigDecimal::ROUND_MODE, Bankroll::Decimal::ROUNDING)

module Bankroll
  ZERO = Decimal['0'].freeze
  ONE = Decimal['1'].freeze


  class Error < StandardError; end
  # Your code goes here...

  def self.payment(**kwargs)
    Payment.call(**kwargs)
  end

  def self.interest_rate(**kwargs)
    InterestRate.call(**kwargs)
  end

  def self.unpaid_balance(**kwargs)
    UnpaidBalance.call(**kwargs)
  end

  def self.loan_amount(**kwargs)
    PresentValue.call(**kwargs)
  end
end

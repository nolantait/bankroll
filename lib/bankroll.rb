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
require_relative "bankroll/total_periods"
require_relative "bankroll/interest_rate"

BigDecimal.mode(BigDecimal::ROUND_MODE, Bankroll::Decimal::ROUNDING)

module Bankroll
  ZERO = Decimal["0"].freeze
  ONE = Decimal["1"].freeze

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

  def self.present_value(**kwargs)
    PresentValue.call(**kwargs)
  end

  def self.future_value(**kwargs)
    FutureValue.call(**kwargs)
  end

  def self.cumulative_interest(**kwargs)
    CumulativeInterest.call(**kwargs)
  end

  def self.annuity_factor(**kwargs)
    AnnuityFactor.call(**kwargs)
  end

  def self.total_periods(**kwargs)
    TotalPeriods.call(**kwargs)
  end

  def self.amortization_schedule(**kwargs)
    AmortizationSchedule.call(**kwargs)
  end
end

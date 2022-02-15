# Bankroll

Bankroll is a set of financial calculations for mortgages and loans.

The goal of this library is to make time value of money calculations
understandable and decomposed into well written functions.

I find most financial math libraries to be somewhat opaque so hopefully
this helps when learning how to calculate mortgages and other annuity based
investments.

Features:
- Uses safe math with BigDecimal through the Bankroll::Decimal api
- Handles only ordinary annuities (annuities due at the END of the period)
- Implements most excel functions using some inspiration from Exonio gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bankroll'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bankroll

## Usage

```ruby

# What is the monthly payment?
payment = Bankroll.payment(
  periods: 360, 
  interest_rate: 0.01 / 12.0,
  present_value: 1_000_000
).round
puts payment #=> Bankroll::Decimal["3_216.40"]

# What was the original loan amount?
original_amount = Bankroll.present_value(
  periods: 360, # 30 years
  monthly_payment: 3_216.40, 
  interest_rate: 0.01 / 12.0, # 2.5%
).round
puts original_amount #=> Bankroll::Decimal["1_000_001.49"]

# What does the balance look like after a single mortgage payment?
unpaid_balance = Bankroll.unpaid_balance(
  present_value: 1_000_000,
  interest_rate: 0.01 / 12.0,
  periods: 360,
  period: 1,
  payment: 3_216.40
).round
puts unpaid_balance #=> Bankroll::Decimal["997_616.94"]

# What was the interest rate?
interest_rate = Bankroll.interest_rate(
  present_value: 1_000_000,
  periods: 360,
  payment: -3_216.40,
).round(3)
puts interest_rate #=> Bankroll::Decimal["0.833e-3"]

# What is the annuity factor of a rate for n periods?
annuity_factor = Bankroll.annuity_factor(
  interest_rate: 0.01,
  periods: 2
).round(4)
puts annuity_factor #=> Bankroll::Decimal["1.9704"]

# What is the total interest paid on a 500_000 1% mortgage
interest_paid = Bankroll.cumulative_interest(
  periods: 360,
  interest_rate: 0.01 / 12.0,
  payment: 1_608.20,
  present_value: 500_000
).round
puts interest_paid #=> Bankroll::Decimal["832.34"]

# What is the total cost of a 500_000 1% loan with interest?
total_amount = Bankroll.future_value(
  present_value: 0,
  interest_rate: 0.01 / 12.0,
  periods: 360,
  payment: 1_608.20
).round
puts total_amount #=> Bankroll::Decimal["647_846.10"]

# What is the interest payment on the 17th period of a $165,000 3% mortgage?
interest_payment = Bankroll.interest_payment(
  interest_rate: 0.03 / 12.0,
  periods: 360,
  period: 17,
  present_value: 165_000
).round
puts interest_payment #=> Bankroll::Decimal["400.96"]

# How many periods until a -$1000 account with -$100/month reaches $10_000 with
# 12% interest rate?
total_periods = Bankroll.total_periods(
  interest_rate: 0.12 / 12.0,
  payment: -100,
  present_value: -1_000,
  future_value: 10_000
)
puts total_periods #=> Bankroll::Decimal["59.67"]

# What is the amortization schedule of a $165_000 3% 30 year mortgage?
amortization_schedule = Bankroll.amortization_schedule(
  present_value: 165_000,
  interest_rate: 0.03 / 12.0,
  periods: 360
)
puts amortization_schedule.payments #=> [
#   Bankroll::AmortizationSchedule::Payment.new(
#     payment: Bankroll::Decimal["695.65"],
#     principal: Bankroll::Decimal["283.15"],
#     interest: Bankroll::Decimal["412.50"],
#     total_interest: Bankroll::Decimal["412.50"],
#     balance: Bankroll::Decimal["164_716.85"]
#   )
#   ... and 359 more payments
# ]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 
Then, run `rake spec` to run the tests. You can also run `bin/console` for an 
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then 
run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and the created tag, and push the `.gem` file 
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nolantait/bankroll.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

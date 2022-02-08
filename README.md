# Bankroll

Bankroll is a set of calculations for mortgages and loans.

Features:
- Uses safe math with BigDecimal
- Returns using Money or Percentage gems

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

apr = Bankroll.apr(interest_rate: 0.025, duration: 30.years, amount: 360_000)
puts apr #=> Percentage.new(0.11)

payment = Bankroll.payment(duration: 30.years, interest_rate: 0.025, loan_amount: 360_000)
puts payment #=> Payment(total: Money(59_680.69), per_month: Money(3_600.00))
puts payment.per_month #=> Money.new(3_600.00)

net_credit = Bankroll.net_credit(points: 100.1, ysp: 0.0025, loan_amount: 360_000)
puts net_credit #=> Money.new()

original_amount = Bankroll.present_value(
  periods: 360, # 30 years
  monthly_payment: 3_600, 
  interest_rate: 0.025, # 2.5%
  future_value: 0
)
puts original_amount #=> Money(360_000)

loan_to_value_ratio = Bankroll.ltv(
  loan_amount: 360_000, 
  total_assets: 800_000
)
combined_loan_to_value_ratio = Bankroll.cltv(
  loan_amounts: [
    480_000,
    360_000
  ],
  total_assets: 800_000
)
high_combined_loan_to_value_ratio = Bankroll.hcltv(
  loans: [
    ["Loan A", 360_000, "heloc"]
    ["Loan B", 360_000, "mortgage"]
  ],
  total_assets: 800_000
)

simulation = Bankroll.simulate do |sim|
  sim.loan = Bankroll::Loan["Original", 400_000]
  sim.assets << Bankroll::Asset["House", 360_000]
  sim.debts << Bankroll::Debt["Car", 36_000]
  sim.income << Bankroll::Income["Work", 400_000]
end

situation_a = simulation.refinance(interest_rate:, cash_out:, closing_costs:, points:)
situation_b = simulation.refinance(interest_rate:, cash_out:, closing_costs:, points:)

result = Bankroll.compare(situation_a, situation_b)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bankroll.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

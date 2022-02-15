require "spec_helper"

RSpec.describe Bankroll::InterestRate do
  it "returns the expected interest rate" do
    # Exonio.rate(12, 363.78, -3056.00) # ==> 0.05963422268883278

    result = described_class.call(
      periods: 12,
      payment: 363.78,
      present_value: -3056.00
    )

    expect(result).to eq Bankroll::Decimal["0.05963422268883270675"]
  end
end

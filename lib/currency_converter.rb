# frozen_string_literal: true

# converts xml input to sorted creatives and placements
class CurrencyConverter
  CONVERSION_RATES_TO_EURO = {
    TYR: 3.31,
    USD: 1.13,
    SEK: 10.65
  }.freeze

  def self.call(**args)
    new(from_currency: args[:from_currency], to_currency: args[:to_currency], amount: args[:amount]).convert
  rescue Exception
    @return_value
  end

  def initialize(from_currency: 'EUR', to_currency: 'EUR', amount: 0)
    @from_currency = from_currency
    @to_currency = to_currency
    @amount = amount.to_f
  end

  def convert
    return 0 if @amount.zero?

    apply_conversion_rate_to_euro
    apply_conversion_rate_to_target_currency
    @return_value
  end

  private

  def apply_conversion_rate_to_euro
    conversion_rate = CONVERSION_RATES_TO_EURO[@from_currency.to_sym] || 1
    @return_value = (@amount / conversion_rate).round(2)
  end

  def apply_conversion_rate_to_target_currency
    conversion_rate = CONVERSION_RATES_TO_EURO[@to_currency.to_sym] || 1
    @return_value = (@return_value * conversion_rate).round(2)
  end
end

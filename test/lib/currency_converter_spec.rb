# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/currency_converter'

describe 'CurrencyConverter' do
  describe '#call' do
    describe 'when currency from and to currency is passed' do
      it 'returns a converted rate hash' do
        _(CurrencyConverter.call(from_currency: 'USD', to_currency: 'SER', amount: 1)).must_equal 0.88
      end
      it 'returns a converted rate hash' do
        _(CurrencyConverter.call(from_currency: 'TYR', to_currency: 'EUR', amount: 1)).must_equal 0.3
      end
      it 'returns a converted rate hash' do
        _(CurrencyConverter.call(from_currency: 'EUR', to_currency: 'EUR', amount: 1)).must_equal 1
      end
      it 'returns a converted rate hash' do
        _(CurrencyConverter.call(from_currency: 'EUR', to_currency: 'EUR', amount: 0)).must_equal 0
      end
    end
  end
end

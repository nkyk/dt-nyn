# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/input_to_hash_processor'

describe 'InputToHashProcessor' do
  let(:response) do
    {
      'creatives' => [
        { 'id' => 'Video-12', 'price' => '16.4567', 'currency' => 'EUR', 'conversion_amount' => 16.46 },
        { 'id' => 'Video-25', 'price' => '9.4567', 'currency' => 'USD', 'conversion_amount' => 8.37 },
        { 'id' => 'Video-1', 'price' => '6.4567', 'currency' => 'EUR', 'conversion_amount' => 6.46 },
        { 'id' => 'Video-7', 'price' => '55.123', 'currency' => 'SEK', 'conversion_amount' => 5.18 },
        { 'id' => 'Video-4', 'price' => '1.1234', 'currency' => 'USD', 'conversion_amount' => 0.99 }
      ],
      'placements' => [
        { 'id' => 'plc-1', 'floor' => '1.3456', 'currency' => 'EUR' },
        { 'id' => 'plc-2', 'floor' => '90.234', 'currency' => 'SEK' },
        { 'id' => 'plc-3', 'floor' => '8.343', 'currency' => 'TYR' },
        { 'id' => 'plc-4', 'floor' => '20.56', 'currency' => 'USD' },
        { 'id' => 'plc-5', 'floor' => '27.9856', 'currency' => 'EUR' },
        { 'id' => 'plc-6', 'floor' => '22.5656', 'currency' => 'SEK' },
        { 'id' => 'plc-7', 'floor' => '0', 'currency' => 'EUR' },
        { 'id' => 'plc-8', 'floor' => '1.3456', 'currency' => 'USD'}
      ]
    }
  end

  describe '#call' do
    describe 'when file path is given' do
      it 'returns a sorted hash' do
        _(InputToHashProcessor.call(file_path: "#{__dir__}/fixtures/sample_input.xml")).must_equal response
      end

      it 'returns a empty hash' do
        _(InputToHashProcessor.call(file_path: "#{__dir__}/fixtures/invalid_sample_input.xml")).must_equal nil
      end
    end
  end
end

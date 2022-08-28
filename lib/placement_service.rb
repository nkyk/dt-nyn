# frozen_string_literal: true

require_relative 'input_to_hash_processor'
require_relative 'currency_converter'
require_relative 'placement_seq'
# converts xml input to sorted creatives and placements
class PlacementService
  def self.call(**args)
    new(payload: args[:payload], type: args[:type]).mapped_data
  rescue Exception
    nil
  end

  def initialize(payload: nil, type: :file)
    @payload = payload
    @type = type
    @return_value = PlacementSeq.new
  end

  def mapped_data
    return if @payload.nil?

    find_and_format_placements
    # To Generate Protobuf output
    open("output/sample_output.test", "wb") do |f|
      @return_value.serialize(f)
    end
    # To return non-protobuf output
    @return_value.to_hash
  end

  private

  def creative_for_for_placement(placement_amount)
    creatives = []
    @parsed_data[:creatives].each do |creative|
      break if creative[:conversion_amount] < placement_amount

      creatives << Creative.new(
        id: creative[:id],
        price: creative[:conversion_amount]
      )
    end

    creatives
  end

  def find_and_format_placements
    @parsed_data = InputToHashProcessor.call(@type.to_sym => @payload)
    @parsed_data[:placements].each do |placement|
      @return_value.placement << Placement.new(
        id: placement[:id],
        creative: creative_for_for_placement(CurrencyConverter.call(from_currency: placement['currency'], to_currency: 'EURO', amount: placement['floor']))
      )
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext'
require_relative 'currency_converter'

# converts xml input to sorted creatives and placements
class InputToHashProcessor
  def self.call(**args)
    new(args[:file], args[:file_path]).process_input
  rescue NoMethodError
    nil
  end

  def initialize(file = nil, file_path = nil)
    @return_value = {
      creatives: [],
      placements: []
    }
    @file = file
    @file_path = file_path
  end

  def process_input
    return @return_value if @file.nil? && @file_path.nil?

    load_xml
    map_creatives_in_ascending_order
    map_placements
    @return_value.with_indifferent_access
  end

  private

  def load_xml
    content = @file_path && File.file?( @file_path) ? File.read(@file_path) : @file
    @xml_content = Hash.from_xml content
  rescue RuntimeError => e
    @xml_content = Hash.from_xml("<data>#{content}</data>")
  end

  def map_creatives_in_ascending_order
    @return_value[:creatives] = @xml_content['data']['Creatives']['Creative']
      &.map do |hsh|
        hsh['conversion_amount'] = CurrencyConverter.call(from_currency: hsh['currency'], to_currency: 'EURO', amount: hsh['price']) 
        hsh
      end
      &.sort_by { |hsh| hsh['conversion_amount'] * -1 }
  end

  def map_placements
    @return_value[:placements] = @xml_content['data']['Placements']['Placement']
  end
end

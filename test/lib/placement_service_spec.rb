# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/placement_service'

describe 'PlacementService' do
  let(:response) do
    {
      placement: [
        {
          id: 'plc-1',
          creative: [
            { id: 'Video-12', price: 16.46 },
            { id: 'Video-25', price: 8.37 },
            { id: 'Video-1', price: 6.46 },
            { id: 'Video-7', price: 5.18 }
          ]
        },
        {
          id: 'plc-2',
          creative: [
            { id: 'Video-12', price: 16.46 }
          ]
        },
        {
          id: 'plc-3',
          creative: [
            { id: 'Video-12', price: 16.46 },
            { id: 'Video-25', price: 8.37 },
            { id: 'Video-1', price: 6.46 },
            { id: 'Video-7', price: 5.18 }
          ]
        },
        {
          id: 'plc-4',
          creative: []
        },
        {
          id: 'plc-5',
          creative: []
        },
        {
          id: 'plc-6',
          creative: [
            { id: 'Video-12', price: 16.46 },
            { id: 'Video-25', price: 8.37 },
            { id: 'Video-1', price: 6.46 },
            { id: 'Video-7', price: 5.18 }
          ]
        },
        {
          id: 'plc-7',
          creative: [
            { id: 'Video-12', price: 16.46 },
            { id: 'Video-25', price: 8.37 },
            { id: 'Video-1', price: 6.46 },
            { id: 'Video-7', price: 5.18 },
            { id: 'Video-4', price: 0.99 }
          ]
        },
        {
          id: 'plc-8',
          creative: [
            { id: 'Video-12', price: 16.46 },
            { id: 'Video-25', price: 8.37 },
            { id: 'Video-1', price: 6.46 },
            { id: 'Video-7', price: 5.18 }
          ]
        }
      ]
    }
  end

  describe '#call' do
    describe 'when input with data valid data is paased' do
      it 'returns a converted rate hash' do
        _(PlacementService.call(payload: "#{__dir__}/fixtures/sample_input.xml", type: 'file_path')).must_equal response
      end
    end
  end
end

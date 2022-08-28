# frozen_string_literal: true

require 'protocol_buffers'

class Creative < ProtocolBuffers::Message
  required :string, :id, 1
  required :float, :price, 2
end

class CreativeSeq < ProtocolBuffers::Message
  repeated Creative, :creative, 1
end

class Placement < ProtocolBuffers::Message
  required :string, :id, 1
  repeated Creative, :creative, 2
end

class PlacementSeq < ProtocolBuffers::Message
  repeated Placement, :placement, 1
end

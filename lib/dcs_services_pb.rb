# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: dcs.proto for package 'dcs'

require 'grpc'
require 'dcs_pb'

module Dcs
  module Mission
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'dcs.Mission'

      # https://wiki.hoggitworld.com/view/DCS_func_outText
      rpc :OutText, ::Dcs::OutTextRequest, ::Dcs::OutTextResponse
      # https://wiki.hoggitworld.com/view/DCS_func_getUserFlag
      rpc :GetUserFlag, ::Dcs::GetUserFlagRequest, ::Dcs::GetUserFlagResponse
      # https://wiki.hoggitworld.com/view/DCS_func_setUserFlag
      rpc :SetUserFlag, ::Dcs::SetUserFlagRequest, ::Dcs::SetUserFlagResponse
      rpc :StreamEvents, ::Dcs::StreamEventsRequest, stream(::Dcs::Event)
    end

    Stub = Service.rpc_stub_class
  end
end

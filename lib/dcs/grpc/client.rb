# frozen_string_literal: true

require 'grpc'
require_relative '../../dcs_services_pb'

module Dcs
  module Grpc
    # The client that will handle communication with the DCS server's RPC interface
    class Client
      # Generic exception that will wrap all implementation raised
      # exceptions.
      class Error < StandardError; end

      # The class that implements the actual gRPC interface
      SERVICE_CLASS = Dcs::Mission::Stub

      # Instantiate the Client
      #
      # @param host [String] the DCS gRPC host address as either an IP or hostname
      # @param port [Integer] the port DCS gRPC is running on
      # @return [String] the object converted into the expected format.
      def initialize(host: 'localhost', port: 50_051)
        @service = SERVICE_CLASS.new("#{host}:#{port}", :this_channel_is_insecure)
      end

      # Send a message to all players on the server
      #
      # Displays the specified text to all players on the DCS server in the top right
      # of the game window. This maps to the `outText` command in DCS.
      #
      # @see https://wiki.hoggitworld.com/view/DCS_func_outText
      # @param text [String] the text to be displayed to the players
      # @param display_time [Integer] the time in seconds the message will be visible
      # @param clear_view [Bool] whether to clear existing messages when displaying this one
      # @return [Void]
      def send_message_to_all(text:, display_time: 10, clear_view: false)
        request = Dcs::OutTextRequest.new(text: text,
                                          display_time: display_time,
                                          clear_view: clear_view)
        @service.out_text(request)
      rescue GRPC::BadStatus
        raise Error
      end

      # Set a user defined flag in the mission to a numeric value
      #
      # @see https://wiki.hoggitworld.com/view/DCS_func_setUserFlag
      # @param flag [String] the id or the name of the flag we want to set the value of
      # @param value [Integer] the value we want to set the flag to
      # @return [Void]
      def set_user_flag(flag:, value:)
        request = Dcs::SetUserFlagRequest.new(flag: flag,
                                              value: value)
        @service.set_user_flag(request)
      rescue GRPC::BadStatus
        raise Error
      end

      # Get the current value of a user defined flag in the mission
      #
      # @see https://wiki.hoggitworld.com/view/DCS_func_getUserFlag
      # @param flag [String] the id or the name of the flag we want to get the value of
      # @return [Integer] the current value of the flag
      def get_user_flag(flag)
        request = Dcs::GetUserFlagRequest.new(flag)
        @service.get_user_flag(request).value
      rescue GRPC::BadStatus
        raise Error
      end

      # Stream mission events
      #
      # Streams DCS mission events as a series of hash objects and yields them
      # to the passed in block. Every hash will have a `:time` key and an
      # `:event` key which corresponds to the type of event. Other key/value
      # pairs will be present depending on the properties normally associated
      # with the event
      #
      # @note This is a blocking method and will block until an error is raised
      # @see https://wiki.hoggitworld.com/view/Category:Events
      # @yield [Hash] A hash representing a DCS event
      def stream_mission_events
        @service.stream_events(Dcs::StreamEventsRequest.new).each do |event|
          yield convert_to_hash(event)
        end
      rescue GRPC::BadStatus
        raise Error
      end

      private

      def convert_to_hash(event)
        hash = { time: event.time }
        event.to_h.each_pair do |key, value|
          if key != :time && !value.nil?
            hash[:event] = key
            hash.merge! value
          end
        end
        hash
      end
    end
  end
end

# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Game
      # Available position type within a game
      #
      # @!attribute type [String] the abbreviation of this type
      # @!attribute display_name [String] the full name of this type
      #
      PositionType = Struct.new(:type, :display_name)
    end
  end
end

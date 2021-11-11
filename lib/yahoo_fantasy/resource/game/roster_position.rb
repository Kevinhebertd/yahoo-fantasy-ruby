# frozen_string_literal: true

module YahooFantasy
  module Resource
    class Game < YahooFantasy::Resource::Base
      RosterPosition = Struct.new(:position, :abbreviation, :display_name, :position_type)
    end
  end
end

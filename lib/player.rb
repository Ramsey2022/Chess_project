# frozen_string_literal: true

# class for player & symbol
class Player
  attr_accessor :name, :symbol

  def initialize(symbol)
    @name = nil
    @symbol = symbol
  end
end
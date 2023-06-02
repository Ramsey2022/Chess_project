# frozen_string_literal: true

require_relative 'custom_content'

# class for chess board
class Board
  include ChessPieces

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def display_board
    @grid.each do |row|
      puts row.join(' ')
    end
    puts ('a'..'h').to_a.join(' ')
  end
end
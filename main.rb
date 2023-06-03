# frozen_string_literal: true

require_relative './lib/board'
require_relative './lib/displayable'
require_relative './lib/game'
require_relative './lib/game_prompts'
require_relative './lib/notation_translator'
require_relative './lib/move_validator'
require_relative './lib/serializer'
require_relative './lib/pieces/piece'
require_relative './lib/pieces/king'
require_relative './lib/pieces/queen'
require_relative './lib/pieces/rook'
require_relative './lib/pieces/bishop'
require_relative './lib/pieces/knight'
require_relative './lib/pieces/pawn'
require_relative './lib/movement/movement_factory'
require_relative './lib/movement/basic_movement'
require_relative './lib/movement/en_passant_movement'
require_relative './lib/movement/pawn_promotion_movement'
require_relative './lib/movement/castling_movement'

extend GamePrompts
extend Serializer

def play_game(input)
  if input == '1'
    single_player = Game.new(1)
    single_player.setup_board
    single_player.play
  elsif input == '2'
    two_player = Game.new(2)
    two_player.setup_board
    two_player.play
  elsif input == '3'
    load_game.play
  end
end

loop do
  puts game_mode_choices
  mode = select_game_mode
  play_game(mode)
  break if repeat_game == :quit
end
# frozen_string_literal: true

# contains text content for game
module GamePrompts
  def select_game_mode
    user_mode = gets.chomp
    return user_mode if user_mode.match?(/^[123]$/)
    
    puts 'Input error! Enter 1, 2, or 3.'
    select_game_mode
  end

  def repeat_game
    puts repeat_game_choices
    input = gets.chomp
    choice = input.upcase == 'Q' ? :quit : :repeat
    return choice if input.match?(/^[QP]$/i)

    puts 'Input error! Enter Q or P.'
    repeat_game
  end

  def final_message
    return unless @player_count.positive?

    if @board.king_in_check?(@current_turn)
      puts "#{previous_color} wins! The #{@current_turn} king is in checkmate."
    else
      puts "#{previous_color} wins in a stalemate!"
    end
  end

  private

  def game_mode_choices
    <<~HEREDOC

    Welcome to Chess!

    Each turn will be in two steps.

    First enter the coordinates of the piece you want to move.

    Next, enter coordinates of any legal move or capture.

    To begin, enter one of the following to play:
      [1] to play against CPU
      [2] to play a two player game
      [3] to play a saved game

    HEREDOC
  end

  def repeat_game_choices
    <<~HEREDOC

    Would you like to quit or play again?
    [Q] to quit
    [P] to play again

   HEREDOC
  end

  def user_piece_selection
    <<~HEREDOC

    Enter coordinates of the piece you want to move.

    [Q] to quit
    [S] to save

   HEREDOC
  end

  def user_move_selection
    <<~HEREDOC

    Enter coordinates of a legal move or capture.

   HEREDOC
  end

  def en_passant_warning
    <<~HEREDOC
      One of these moves is to capture the opposing pawn that just moved. To capture this pawn en passant (in passing) enter the highlighted coordinates.

      As part of en passant, your pawn will be moved to the square in front of the captured pawn.

    HEREDOC
  end

  def king_check_warning
    puts 'Warning! Your king is in check!'
  end

  def castling_warning
    <<~HEREDOC
    One of these moves will move the king two spaces and will castle with the rook.

    As part of castling, your rook will be moved to the square that the king passes through.

   HEREDOC
  end

  def previous_color
    @current_turn == :white ? 'Black' : 'White'
  end

  def resign_game
    puts "#{previous_color} wins because #{@current_turn} resigned!"
    @player_count = 0
  end
end


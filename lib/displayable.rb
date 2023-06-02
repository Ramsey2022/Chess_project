# frozen_string_literal: true

# creates visual chess board from data array
module Displayable
  private

  def print_chess_board
    system 'clear'
    puts
    print_board
    puts ' a  b  c  d  e  f  g  h '
    puts
  end

  def print_board
    @data.each_with_index do |row, index|
      print "#{8 - index}"
      print_row(row, index)
      print "#{8 - index}"
      puts
    end
  end

  def print_row(row, row_index)
    row.each_with_index do |square, index|
      background_color = select_background(row_index, index)
      print_square(row_index, index, square, background_color)
    end
  end

  # 106 = light cyan
  # 41 = red
  # 46 = cyan
  # 100 = dark grey
  # 47 = light grey
  def select_background(row_index, column_index)
    if @active_piece&.location == [row_index, column_index]
      106
    elsif capture_background?(row_index, column_index)
      41
    elsif @previous_piece&.location == [row_index, column_index]
      46
    elsif (row_index + column_index).even?
      100
    else
      47
    end
  end

  def capture_background?(row, column)
    @active_piece&.captures&.any?([row, column]) && @data[row][column]
  end

  # 97 = white
  # 30 = black
  # 41 = red
  # 90 = dark grey
  def print_square(row_index, column_index, square, background)
    if square
      text_color = square.color == :white? 97 : 30
      color_square(text_color, background, square.symbol)
    elsif @active_piece&.moves&.any?([row_index, column_index])
      color_square(41, background, " \u25CF ")
    else
      color_square(90, background, '  ')
    end
  end

  def color_square(font, background, string)
    print "#{font} #{background} #{string}"
  end
end
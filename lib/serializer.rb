# frozen_string_literal: true

# methods to save and load game
module Serializer
  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'
    filename = create_filename
    File.open("saved_games/#{filename}", 'w+') do |file|
      Marshal.dump(self, file)
    end
    puts "Game was saved as #{filename}"
    @player_count = 0
  rescue SystemCallError => e
    puts "Error while writing to file #{filename}."
    puts e
  end

  def create_filename
    date = Time.now.strftime('%Y-%m-%d').to_s
    time = Time.now.strftime('%H:%M:%S').to_s
    "Chess #{date} at #{time}"
  end

  def load_game
    filename = find_saved_file
    File.open("saved_games/#{filename}") do |file|
      Marshal.load(file)
    end
  end

  def find_saved_file
    saved_games = create_game_list
    if saved_games.empty? 
      puts 'There are no saved games to play yet.'
      exit
    else
      print_saved_games(saved_games)
      file_number = select_saved_game(saved_games.size)
      saved_games[file_number.to_i - 1]
    end
  end

  def print_saved_games(game_list)
    puts "[#] File Name(s)"
    game_list.each_with_index do |name, index|
      puts "[#{index + 1}] #{name}"
    end
  end

  def select_saved_game(number)
    file_number = gets.chomp
    return file_number if file_number.to_i.between?(1, number)
    
    puts 'Input Error! Enter a valid file number.'
    select_saved_game(number)
  end

  def create_game_list
    game_list = []
    return game_list unless Dir.exist? 'saved_games'

    Dir.entries('saved_games').each do |name|
      game_list << name if name.match(/(Chess)/)
    end
    game_list
  end
end
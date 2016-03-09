require_relative 'player.rb'
require_relative 'field.rb'
require 'byebug'

# Main game control class
class Game
  def initialize
    @field = Field.new
    @players = []
    @game_state = :game

    @players << Player.new(:x)
    @players << Player.new(:o)
  end

  def start
    puts 'Welcome to Tic tac toe'
    introduce_players
    first_player
    @field.visualize
    while @game_state == :game
      # binding.pry
      puts "#{@players[@player_index].name}, your turn"
      step
    end
  end

  private

  def introduce_players
    2.times do |i|
      catch(:incorrect_name) do
        puts "Player#{i + 1}, enter your name:"
        name = gets.chomp
        throw :incorrect_name if name.empty?
        @players[i].name = name
      end
    end
  end

  def first_player
    @player_index = Random.rand(1000) % 2
  end

  def next_step
    @player_index = (@player_index + 1) % 2
  end

  def step
    catch(:incorrect_input) do
      x, y = gets.chomp.split.map(&:to_i)
      throw :incorrect_input if !x.between?(0, 2) || !y.between?(0, 2)

      @field.step(x, y, @players[@player_index])
      @field.visualize

      is_game_over = check_game_over
      unless is_game_over.nil?
        if is_game_over == :x || is_game_over == :o
          puts "Player #{@players[@player_index].name} won!"
        end
        puts 'Draw!' if is_game_over == :draw
        @game_state = :game_over
        return
      end

      next_step
    end
  end

  def check_game_over
    return @players[@player_index].sign if @field.win?
    return :draw if @field.draw?
    nil
  end
end

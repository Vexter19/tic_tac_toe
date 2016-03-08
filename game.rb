require_relative 'player.rb'
require_relative 'field.rb'
require 'pry'

class Game
  def initialize
    @field = Field.new
    @players = []

    @players << Player.new(1)
    @players << Player.new(0)
  end

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

  def get_first_player
    @player_index = Random.rand(1000) % 2
  end

  def next_step
    @player_index = (@player_index + 1) % 2
  end

  def start
    puts 'Welcome to Tic tac toe'
    introduce_players
    get_first_player
    @field.visualize
    loop do
      # binding.pry
      puts "#{@players[@player_index].name}, your turn"
      step
    end
  end

  def step
    catch(:incorrect_input) do
      x, y = gets.chomp.split.map { |e| e.to_i }
      throw :incorrect_input if !x.between?(0, 2) || !y.between?(0, 2)

      @field.step(x, y, @players[@player_index])
      next_step
      @field.visualize
    end
  end
end

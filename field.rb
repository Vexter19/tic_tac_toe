require 'byebug'
require_relative './core_extensions.rb'

# Implements game field
class Field
  FIELD_SIZE = 3

  def initialize
    @field = []
    FIELD_SIZE.times do
      line = []
      FIELD_SIZE.times { line << nil }
      @field << line.clone
    end
  end

  def visualize
    out_line = ''
    @field.each do |line|
      line.each do |cell|
        out_line += visualize_cell(cell).to_s
      end
      out_line += "\n"
    end

    puts out_line
  end

  def step(x, y, player)
    throw :incorrect_input unless @field[x][y].nil?
    @field[x][y] = player.sign
  end

  def win?
    field_transposed = @field.transpose
    diag1 = Array.new(3) { |i| @field[i][i] }
    diag2 = Array.new(3) { |i| @field[i][2 - i] }

    3.times do |i|
      return true if !@field[i].all_nil? && @field[i].all_same?
    end

    3.times do |j|
      return true if !field_transposed[j].all_nil? &&
                      field_transposed[j].all_same?
    end

    return true if !diag1.all_nil? && diag1.all_same?
    return true if !diag2.all_nil? && diag2.all_same?
    false
  end

  def draw?
    !@field.any?(&:any_nil?)
  end

  private

  def visualize_cell(cell)
    case cell
    when nil
      return '. '
    else
      return "#{cell} "
    end
  end
end

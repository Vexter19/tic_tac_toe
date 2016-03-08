require 'byebug'


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
    out_line = ""
    @field.each do |line|
      line.each do |cell|
        case cell
        when nil
          out_line += ". "
        when 0
          out_line += "o "
        when 1
          out_line += "x "
        end
      end

      out_line += "\n"
    end

    puts out_line
  end

  def step(x, y, player)
    @field[x][y] = player.sign
  end
end

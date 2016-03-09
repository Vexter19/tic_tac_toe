# Implemets player with name and game sign
class Player
  attr_reader :sign
  attr_accessor :name

  def initialize(sign)
    @sign = sign
  end
end

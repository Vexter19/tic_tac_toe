# Extends Array class with necessary for Tic-tac-toe game methods
class Array
  def all_same?
    uniq.length == 1
  end

  def all_nil?
    all_same? && self[0].nil?
  end

  def any_nil?
    any?(&:nil?)
  end
end

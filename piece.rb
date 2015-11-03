
class Piece
  attr_reader :color

  def initialize(board, pos, type = "i", color = :black)
    @board = board
    @current_pos = pos
    @past_pos = []
    @type = type
    @color = color
  end

  def to_s
    " #{@type} "
  end

  def valid_move?(end_pos)
    if @board.[](end_pos).nil?
      true
    else
      return false if @board.[](end_pos).color == color
    end
  end


  
end

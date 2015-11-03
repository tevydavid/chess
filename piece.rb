require "colorize"

class Piece
  attr_reader :color
  attr_accessor :current_pos
  def initialize(board, pos, color)
    @board = board
    @current_pos = pos
    @past_pos = []
    @type = "i"
    @color = color
  end

  def to_s
    " #{@type} ".colorize(@color)
  end

  def valid_move?(end_pos)
    if @board.[](end_pos).nil?
      true
    else
      return false if @board.[](end_pos).color == color
    end
  end




end

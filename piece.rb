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
    raise "same color" if !@board.[](end_pos).nil? && @board.[](end_pos).color == @color
    return false unless pos_move?(end_pos)
    raise "would put you in check" if @board.in_check?(@color, @board.temp_move(@current_pos, end_pos))
    true
  end

  def valid_move!(end_pos)
    return false if !@board.[](end_pos).nil? && @board.[](end_pos).color == @color
    return false unless pos_move?(end_pos)

    true
  end



end

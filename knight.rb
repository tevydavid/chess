class Knight < Piece

  def initialize(board, pos, color)
    super
    @type = "H"
  end

  def pos_move?(end_pos)
    ((@current_pos.first - end_pos.first).abs == 2 &&
    (@current_pos.last - end_pos.last).abs == 1) ||
    ((@current_pos.first - end_pos.first).abs == 1 &&
    (@current_pos.last - end_pos.last).abs == 2)

  end

end

class Sliders < Piece

  def valid_move?(end_pos)
    super
    #return false if theres another peice on the way to end_pos
  end

  def piece_in_path?(end_pos)


  end

end


class Rook < Sliders

  def initialize(board, pos, type = "i", color = :black)
    super
    @type = "R"
  end

  def valid_move?(end_pos)
    @current_pos[0] == end_pos[0] || @current_pos[1] == end_pos[1]

  end

  def piece_in_path?



  end




end

class Sliders < Piece

  def valid_move?(end_pos)
    super
    #return false if theres another peice on the way to end_pos
  end

  def piece_in_path?(end_pos)


  end

end


class Rook < Sliders

  def initialize(board, pos, color)
    super
    @type = "R"
  end

  def valid_move?(end_pos)
    @total_moves = pos_moves
    return false if !@board.[](end_pos).nil? && @board.[](end_pos).color == @color
    return false unless @current_pos[0] == end_pos[0] || @current_pos[1] == end_pos[1]
    return false if piece_in_path?(end_pos)
    #return false if board_in_check
    true
  end

  def piece_in_path?(end_pos)
    directions = {right: [0, 1], left: [0,-1], down: [1,0], up: [-1, 0]}
    if end_pos.first < @current_pos.first
      step = directions[:up]
    elsif end_pos.first > @current_pos.first
      step = directions[:down]
    elsif end_pos.last < @current_pos.last
      step = directions[:left]
    else
      step = directions[:right]
    end
    path = @current_pos.dup
    until path == end_pos
      return true unless @board.[](path).nil? || @current_pos == path
      path = [path.first + step.first, path.last + step.last]
    end
    false
  end

  def pos_moves
    arr = (0..7).to_a
    same_col = arr.map do |i|
      [i, @current_pos[1]]
    end
    same_row = arr.map do |i|
      [@current_pos[0], i]
    end
    same_col.concat(same_row).uniq
  end

end

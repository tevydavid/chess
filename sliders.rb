class Sliders < Piece

  def valid_move?(end_pos)
    return false unless super
    return false if piece_in_path?(end_pos)
    true
  end

  def piece_in_path?(end_pos)
    step = [0, 0]
    if @current_pos.first < end_pos.first
      step = [1, step.last]
    elsif @current_pos.first > end_pos.first
      step = [-1, step.last]
    end
    if @current_pos.last < end_pos.last
      step = [step.first, 1]
    elsif @current_pos.last > end_pos.last
      step = [step.first, -1]
    end
    path = @current_pos.dup
    until path == end_pos
      return true unless @board.[](path).nil? || @current_pos == path
      path = [path.first + step.first, path.last + step.last]
    end
    false
  end
end

class King < Sliders

  def initialize(board, pos, color)
    super
    @type = "K"
  end

  def pos_move?(end_pos)
    (@current_pos.first - end_pos.first).abs <= 1 &&
    (@current_pos.last - end_pos.last).abs <= 1
  end
end

class Queen < Sliders

  def initialize(board, pos, color)
    super
    @type = "Q"
  end

  def pos_move?(end_pos)
    ((@current_pos.first - end_pos.first).abs == (@current_pos.last - end_pos.last).abs) ||
    (@current_pos[0] == end_pos[0] || @current_pos[1] == end_pos[1])
  end
end

class Bishop < Sliders

  def initialize(board, pos, color)
    super
    @type = "B"
  end

  def pos_move?(end_pos)
    (@current_pos.first - end_pos.first).abs == (@current_pos.last - end_pos.last).abs
  end
end

class Rook < Sliders

  def initialize(board, pos, color)
    super
    @type = "R"
  end

  def pos_move?(end_pos)
    @current_pos[0] == end_pos[0] || @current_pos[1] == end_pos[1]
  end
end

class Pawn < Sliders

  def initialize(board, pos, color)
    super
    @type = "i"
    if pos.first == 1
      @direction = 1
    else
      @direction = -1
    end
  end

  def pos_move?(end_pos)
    if !(@board.[](end_pos).nil?) #attacking
      @current_pos.first + @direction == end_pos.first &&
      (end_pos.last - @current_pos.last).abs == 1
    elsif @current_pos.first == 1 && @direction == 1 #first_go
      end_pos == [2, @current_pos.last] || end_pos == [3, @current_pos.last]
    elsif @current_pos.first == 6 && @direction == -1 #first_go
      end_pos == [5, @current_pos.last] || end_pos == [4, @current_pos.last]
    else
      @current_pos.first + @direction == end_pos.first &&
      @current_pos.last == end_pos.last
    end
  end


end

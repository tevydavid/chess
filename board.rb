require_relative "display"
require_relative "piece"
require_relative "sliders"
require_relative "knight"
require "byebug"

class Board
  attr_reader :grid

  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
    populate
  end

  def temp_move(start, end_pos)
    temp_board = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        temp_board.grid[i][j] = (piece ? piece.class.new(temp_board, [i, j], piece.color) : nil)
      end
    end
    temp_board.grid[end_pos.first][end_pos.last] = temp_board.grid[start.first][start.last]
    temp_board.grid[start.first][start.last] = nil
    temp_board.grid[end_pos.first][end_pos.last].current_pos = end_pos
    temp_board
  end

  def in_check?(color, temp_board_self)
    king_pos = temp_board_self.grid.flatten.find do |piece|
      piece.is_a?(King) && piece.color == color
    end.current_pos
    temp_board_self.grid.flatten.each do |piece|
      next if piece.nil?
      return true if piece.color != color && piece.valid_move!(king_pos)
    end
    false
  end

  def populate
    [1, 6].each do |row|
      @grid[row].each_index do |space|
        if row == 1
          @grid[row][space] = Pawn.new(self, [row,space], :red)
        else
          @grid[row][space] = Pawn.new(self, [row,space], :black)
        end
      end
    end
    [0, 7].each do |row|
      @grid[row].each_index do |space|
        (row == 0) ? color = :red : color = :black
        case space
        when 0
          @grid[row][space] = Rook.new(self, [row, space], color)
        when 7
          @grid[row][space] = Rook.new(self, [row, space], color)
        when 1
          @grid[row][space] = Knight.new(self, [row, space], color)
        when 6
          @grid[row][space] = Knight.new(self, [row, space], color)
        when 2
          @grid[row][space] = Bishop.new(self, [row, space], color)
        when 5
          @grid[row][space] = Bishop.new(self, [row, space], color)
        when 3
          @grid[row][space] = Queen.new(self, [row, space], color)
        when 4
          @grid[row][space] = King.new(self, [row, space], color)
        end
      end
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end


  def render
    @grid.each do |row|
      row.each do |piece|
        if piece.nil?
          print "[ ]"
        else
          print "[ #{piece} ]"
        end
      end
      puts
    end
  end

  def move(start, end_pos)
    begin
      raise "No piece at this location" if @grid[start[0]][start[1]].nil?
      raise "Cannot Move to Same Position" if start == end_pos
      raise "Invalid move for class!" unless @grid[start[0]][start[1]].valid_move?(end_pos)
      @grid[end_pos[0]][end_pos[1]] = @grid[start[0]][start[1]]
      @grid[start[0]][start[1]] = nil
      @grid[end_pos[0]][end_pos[1]].current_pos = end_pos
    rescue Exception => e
      puts e.message
    end
  end

  def in_bounds?(pos)
    pos.each do |i|
        return false if !(0..7).to_a.include?(i)
    end
    true
  end

end









#

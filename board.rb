require_relative "display"
require_relative "piece"
require_relative "sliders"


class Board
  attr_reader :grid

  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
    populate
  end

  def populate
    [0, 1, 6, 7].each do |row|
      @grid[row].each_index do |space|
        if row == 0 || row == 1
          @grid[row][space] = Rook.new(self, [row,space], :red)
        else
          @grid[row][space] = Rook.new(self, [row,space], :black)
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
      raise "Invalid move!" unless @grid[start[0]][start[1]].valid_move?(end_pos)
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

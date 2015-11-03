require_relative "board"
require_relative "cursorable"
require "colorize"

class Display
  include Cursorable

  attr_reader :board
  def initialize(board = Board.new)
    @board = board
    @cursor_pos = [0, 0]
    @selected_pos = nil
  end

  def render
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.nil?
          print "   ".colorize(colors_for(i, j))
        else
          print piece.to_s.colorize(colors_for(i, j))
        end
      end
      puts
    end
    nil
  end

  def colors_for(i, j)
    if [i, j] == @selected_pos
      bg = :red
    elsif [i, j] == @cursor_pos
      bg = :light_blue
    elsif (i + j).even?
      bg = :light_green
    else
      bg = :green
    end
    { background: bg }
    
  end
end



if __FILE__ == $PROGRAM_NAME
  d = Display.new

  while true
    d.render
    d.get_input
    system ("clear")
  end

end

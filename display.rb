require 'colorize'
require_relative 'piece'
require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    # @selected = nil
  end

  def render
    system("clear")
    @board.grid.each_with_index do |row, i|
      row_string = ""
      row.each_with_index do |piece, j|
        color_options = colors_for(i, j)
        if piece.nil?
          row_string += "#{'    '.colorize(color_options)}"
        else
          row_string += "#{piece.to_s.colorize(color_options)}"
        end
      end
      puts "#{row_string}\n"
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :white }
  end
end

if __FILE__ == $PROGRAM_NAME
  d = Display.new(Board.new)
  d.render
end

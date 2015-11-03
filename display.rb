require 'colorize'
require_relative 'piece'
require_relative 'board'
require_relative 'cursorable'
require_relative 'game'

class Display
  include Cursorable

  def initialize(board, game)
    @board = board
    @cursor_pos = [0, 0]
    @game = game
    # @selected = false
  end

  def render
    system("clear")
    puts "Your turn #{@game.active_player.color}"
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
      if @game.active_player.color == :white
        bg = :light_blue
      else
        bg = :light_red
      end
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :white
    end
    square = @board.grid[@cursor_pos[0]][@cursor_pos[1]]
    if !square.nil? && square.color == @game.active_player.color
      if square.valid_moves.include?([i, j]) && !@board.selected
        bg = :light_green
      end
    end
    { background: bg, color: :black }
  end
end

if __FILE__ == $PROGRAM_NAME
  d = Display.new(Board.new)
  d.render
end

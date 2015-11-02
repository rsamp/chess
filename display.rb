require_relative "piece"

class Display

  def initialize(board)
    @board = board
  end

  def render
    @board.grid.each do |row|
      row_string = ""
      row.each do |piece|
        if piece.nil?
          row_string += "|x| "
        else
          row_string += "#{piece.name} "
        end
      end
      puts "#{row_string}\n"
    end
  end



end

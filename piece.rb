class Piece

  SYMBOLS_WHITE = {king: "\u2654", queen: "\u2655", rook: "\u2656",
    bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
  SYMBOLS_BLACK = {king: "\u265A", queen: "\u265B", rook: "\u265C",
    bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}

  attr_reader :name, :color

  def initialize(name, color, position, board)
    @name = name
    @color = color
    @position = position
    @board = board
  end

  def to_s
    if nil?
      "\s\s\s"
    else
      if color == :white
        " #{SYMBOLS_WHITE[name]}  "
      else
        " #{SYMBOLS_BLACK[name]}  "
      end
    end
  end

end

class SlidingPiece < Piece

end

class SteppingPiece < Piece

end

class Pawn < Piece

end

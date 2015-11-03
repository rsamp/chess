class Piece

  SYMBOLS_WHITE = {king: "\u2654", queen: "\u2655", rook: "\u2656",
    bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
  SYMBOLS_BLACK = {king: "\u265A", queen: "\u265B", rook: "\u265C",
    bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}

  attr_reader :name, :color, :position, :board

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
  def moves
    potential_moves = []
    if move_dirs.include?(:axial)
      # curr_x, curr_y = @position[0], @position[1]
      # 0.upto(7) do |i|
      #   potential_pos = [curr_x + i, curr_y]
      #   potential_piece = @board[potential_pos[0], potential_pos[1]]
      #
      #   potential_moves << potential_pos unless @color == potential_piece.color
      #   break unless potential_piece.nil?
      # end
      potential_moves += check_direction(true, false) +
                        check_direction(false, true) +
                        check_direction(true, false, false) +
                        check_direction(false, true, false)
    end
    if move_dirs.include?(:diagonal)

    end
    #return check_direction(true, false)
    return potential_moves
  end

  def check_direction(inc_x, inc_y, add=true)
    potential_moves = []
    curr_x, curr_y = @position[0], @position[1]

    7.times do
      curr_x += 1 if inc_x && add
      curr_y += 1 if inc_y && add
      curr_x -= 1 if inc_x && !add
      curr_y -= 1 if inc_y && !add

      potential_pos = [curr_x, curr_y]
      potential_piece = @board[[potential_pos[0], potential_pos[1]]]
      unless potential_piece.nil?
        if @color != potential_piece.color &&
                curr_x.between?(0, 7) &&
                curr_y.between?(0, 7)
          potential_moves << potential_pos
        end
      end
      if potential_piece.nil? && curr_x.between?(0, 7) && curr_y.between?(0, 7)
        potential_moves << potential_pos
      end
      #potential_moves << potential_pos
      break unless potential_piece.nil?
    end
    potential_moves
  end
end

class Queen < SlidingPiece
  def move_dirs
    [:axial, :diagonal]
  end
end

class Bishop < SlidingPiece
  def move_dirs
    [:diagonal]
  end
end

class Rook < SlidingPiece
  def move_dirs
    [:axial]
  end
end

class SteppingPiece < Piece
  def moves

  end
end

class King < SteppingPiece
  def move_dirs

  end
end

class Knight < SteppingPiece
  def move_dirs

  end
end

class Pawn < Piece
  def moves

  end

  def move_dirs

  end
end

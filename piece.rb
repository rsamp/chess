class Piece

  SYMBOLS_WHITE = {king: "\u2654", queen: "\u2655", rook: "\u2656",
    bishop: "\u2657", knight: "\u2658", pawn: "\u2659"}
  SYMBOLS_BLACK = {king: "\u265A", queen: "\u265B", rook: "\u265C",
    bishop: "\u265D", knight: "\u265E", pawn: "\u265F"}

  attr_reader :board
  attr_accessor :color, :position

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def valid_moves
    valid_moves = []
    moves.each do |potential_move|
      dup_board = @board.dup
      dup_board.move!(@position, potential_move)
      valid_moves << potential_move unless dup_board.in_check?(color)
    end

    valid_moves
  end

  def to_s
    if nil?
      "\s\s\s"
    else
      if color == :white
        " #{SYMBOLS_WHITE[self.class.to_s.downcase.to_sym]}  "
      else
        " #{SYMBOLS_BLACK[self.class.to_s.downcase.to_sym]}  "
      end
    end
  end
end

class SlidingPiece < Piece
  def moves
    # create move diffs class constant and iterate through
    potential_moves = []
    if move_dirs.include?(:axial)
      potential_moves += check_direction(true, false, true, false) +
                        check_direction(false, true, true, false) +
                        check_direction(true, false, false, true) +
                        check_direction(false, true, false, true)
    end
    if move_dirs.include?(:diagonal)
      potential_moves += check_direction(true, true, true, true) +
                        check_direction(true, true, true, false) +
                        check_direction(true, true, false, false) +
                        check_direction(true, true, false, true)
    end
    return potential_moves
  end

  def check_direction(delta_x, delta_y, add_x, add_y)
    potential_moves = []
    curr_x, curr_y = @position[0], @position[1]

    7.times do
      curr_x += 1 if delta_x && add_x
      curr_y += 1 if delta_y && add_y
      curr_x -= 1 if delta_x && !add_x
      curr_y -= 1 if delta_y && !add_y
      next unless @board.in_bounds?([curr_x, curr_y])

      potential_pos = [curr_x, curr_y]
      potential_piece = @board[potential_pos]

      if potential_piece.nil?
        potential_moves << potential_pos
      else
        potential_moves << potential_pos if @color != potential_piece.color
        break
      end

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
    potential_moves = []
    x,y = @position[0], @position[1]

    possible_destinations.each do |coords|
      temp_x = x + coords[0]
      temp_y = y + coords[1]
      next unless @board.in_bounds?([temp_x, temp_y])

      potential_piece = @board[[temp_x, temp_y]]
      unless potential_piece.nil?
        next if potential_piece.color == @color
      end

      potential_moves << [temp_x, temp_y]
    end

    potential_moves
  end
end

class King < SteppingPiece
  def possible_destinations
    [
      [-1, -1],
      [-1,  1],
      [ 1,  1],
      [ 1, -1],
      [ 0, -1],
      [-1,  0],
      [ 0,  1],
      [ 1,  0],
    ]
  end
end

class Knight < SteppingPiece
  def possible_destinations
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end

class Pawn < Piece
  def moves
    x, y = @position[0], @position[1]
    potential_moves = []
    blocked_after_first_step = true

    possible_destinations(@color).each_with_index do |coords, i|
      temp_x = x + coords[0]
      temp_y = y + coords[1]
      potential_piece = @board[[temp_x, temp_y]]

      if i == 0 && potential_piece.nil?
        potential_moves << [temp_x, temp_y]
        blocked_after_first_step = false
      elsif i == 1 && x == coords[2] && potential_piece.nil? && !blocked_after_first_step
        potential_moves << [temp_x, temp_y]
      end

      if i >= 2 && !potential_piece.nil?
        if potential_piece.color != @color
          potential_moves << [temp_x, temp_y]
        end
      end
    end

    potential_moves
  end

  def possible_destinations(color)
    if color == :black
      [[1, 0], [2, 0, 1], [1, 1], [1, -1]] #3rd coord row ref
    else
      [[-1, 0],[-2, 0, 6], [-1, 1], [-1, -1]]
    end
  end

end

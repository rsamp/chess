require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
    @selected = nil
  end

  def populate
    # Populate top row (back row for black side)
    @grid[0] = [Rook.new(:rook, :black, [0,0], self),
                Knight.new(:knight, :black, [0,1], self),
                Bishop.new(:bishop, :black, [0,2], self),
                Queen.new(:queen, :black, [0,3], self),
                King.new(:king, :black, [0,4], self),
                Bishop.new(:bishop, :black, [0,5], self),
                Knight.new(:knight, :black, [0,6], self),
                Rook.new(:rook, :black, [0,7], self)]

    # Populate rows of Pawns
    @grid[1].map!.with_index {|square, i| square = Pawn.new(:pawn, :black, [1, i], self) }
    @grid[6].map!.with_index {|square, i| square = Pawn.new(:pawn, :white, [6, i], self) }

    # Populate bottom row (back row for white side)
    @grid[7] = [Rook.new(:rook, :white, [7,0], self),
                Knight.new(:knight, :white, [7,1], self),
                Bishop.new(:bishop, :white, [7,2], self),
                Queen.new(:queen, :white, [7,3], self),
                King.new(:king, :white, [7,4], self),
                Bishop.new(:bishop, :white, [7,5], self),
                Knight.new(:knight, :white, [7,6], self),
                Rook.new(:rook, :white, [7,7], self)]
  end

  def move(start, end_pos)
    temp_piece = @grid[start[0]][start[1]]
    raise "No piece there" if temp_piece.nil?

    @grid[start[0]][start[1]] = nil
    @grid[end_pos[0]][end_pos[1]] = temp_piece
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

  # def convert(pos)
  #   letter = pos[0]
  #   number = pos[1].to_i
  #
  #   alpha = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,
  #     "g" => 6, "h" => 7}
  #
  #   new_num = 8 - number
  #
  #   [[new_num],[alpha[letter]]].flatten
  # end

  def in_check?

  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def select_piece(pos)
    @selected = pos
  end

  def place_piece(pos)
    move(@selected, pos)
  end

  def game_over?
    false
  end

end

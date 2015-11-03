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
    @grid[0] = [Piece.new(:rook, :black, [0,0], self),
                Piece.new(:knight, :black, [0,1], self),
                Piece.new(:bishop, :black, [0,2], self),
                Piece.new(:queen, :black, [0,3], self),
                Piece.new(:king, :black, [0,4], self),
                Piece.new(:bishop, :black, [0,5], self),
                Piece.new(:knight, :black, [0,6], self),
                Piece.new(:rook, :black, [0,7], self)]

    # Populate rows of Pawns
    0.upto(7) do |i|
      @grid[1].map! {|square| square = Piece.new(:pawn, :black, [1, i], self) }
      @grid[6].map! {|square| square = Piece.new(:pawn, :white, [6, i], self) }
    end

    # Populate bottom row (back row for white side)
    @grid[7] = [Piece.new(:rook, :white, [7,0], self),
                Piece.new(:knight, :white, [7,1], self),
                Piece.new(:bishop, :white, [7,2], self),
                Piece.new(:queen, :white, [7,3], self),
                Piece.new(:king, :white, [7,4], self),
                Piece.new(:bishop, :white, [7,5], self),
                Piece.new(:knight, :white, [7,6], self),
                Piece.new(:rook, :white, [7,7], self)]
  end

  def move(start, end_pos)
    # conv_start = convert(start)
    # conv_end = convert(end_pos)

    conv_start = start
    conv_end = end_pos

    temp_piece = @grid[conv_start[0]][conv_start[1]]
    raise "No piece there" if temp_piece.nil?

    @grid[conv_start[0]][conv_start[1]] = nil
    @grid[conv_end[0]][conv_end[1]] = temp_piece
  end

  # def [](pos)
  #   @grid[pos[0]][pos[1]]
  # end
  #
  # def []=(pos, piece)
  #   @grid[pos[0]][pos[1]] = piece
  # end

  def convert(pos)
    letter = pos[0]
    number = pos[1].to_i

    alpha = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,
      "g" => 6, "h" => 7}

    new_num = 8 - number

    [[new_num],[alpha[letter]]].flatten
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

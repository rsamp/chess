require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    # Populate top row (back row for black side)
    @grid[0] = [Piece.new(:rook, :black),
                Piece.new(:knight, :black),
                Piece.new(:bishop, :black),
                Piece.new(:queen, :black),
                Piece.new(:king, :black),
                Piece.new(:bishop, :black),
                Piece.new(:knight, :black),
                Piece.new(:rook, :black)]

    # Populate black row of Pawns
    @grid[1].map! {|square| square = Piece.new(:pawn, :black)}

    # Populate white row of Pawns
    @grid[6].map! {|square| square = Piece.new(:pawn, :white)}

    # Populate bottom row (back row for white side)
    @grid[7] = [Piece.new(:rook, :white),
                Piece.new(:knight, :white),
                Piece.new(:bishop, :white),
                Piece.new(:queen, :white),
                Piece.new(:king, :white),
                Piece.new(:bishop, :white),
                Piece.new(:knight, :white),
                Piece.new(:rook, :white)]
  end

  def move(start, end_pos)
    conv_start = convert(start)
    conv_end = convert(end_pos)

    temp_piece = @grid[conv_start[0]][conv_start[1]]
    raise "No piece there" if temp_piece.nil?

    @grid[conv_start[0]][conv_start[1]] = nil
    @grid[conv_end[0]][conv_end[1]] = temp_piece
  end

  def []=(pos)
    @grid[pos[0]][pos[1]]
  end

  def convert(pos)
    letter = pos[0]
    number = pos[1].to_i

    alpha = {"a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5,
      "g" => 6, "h" => 7}

    new_num = 8 - number

    [[new_num],[alpha[letter]]].flatten
  end

end

require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid, :selected

  def initialize(default=true)
    @grid = Array.new(8) { Array.new(8) }
    populate if default
    @selected = nil
  end

  def move(start, end_pos)
    curr_piece = self[start]
    move!(start, end_pos) if curr_piece.valid_moves.include?(end_pos)
  end

  def move!(start, end_pos)
    curr_piece = self[start]
    self[start] = nil
    self[end_pos] = curr_piece
    curr_piece.position = end_pos
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def in_check?(color)
    king = find_king(color)
    opponents_possible_moves = []

    # potential flatten
    @grid.each do |row|
      row.each do |square|
        unless square.nil? || square.color == color
          opponents_possible_moves += square.moves
        end
      end
    end
    opponents_possible_moves.include?(king.position)
  end

  def find_king(color)
    king = nil
    @grid.each do |row|
      row.each do |square|
        unless square.nil?
          king = square if square.class == King && color == square.color
        end
      end
    end
    king
  end

  def checkmate?(color)
    return false unless in_check?(color)

    teammates = find_all_of_color(color)
    teammates.each do |teammate|
      return false unless teammate.valid_moves.empty?
    end

    true
  end

  def dup
    board_dup = Board.new(false)
    @grid.each do |row|
      row.each do |square|
        unless square.nil?
          color, position = square.color, square.position
          board_dup[position] = square.class.new(color, position, board_dup)
        end
      end
    end
    board_dup
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def select_piece(pos)
    # raise ArgumentError, "No piece there" if self[pos].nil?
    @selected = pos
  end

  def place_piece(pos)
    move(@selected, pos)
    @selected = nil
  end

  def game_over?
    if checkmate?(:white) || checkmate?(:black)
      true
    else
      false
    end
  end

  # private

  def populate
    # Populate top row (back row for black side)
    @grid[0] = [Rook.new(:black, [0,0], self),
                Knight.new(:black, [0,1], self),
                Bishop.new(:black, [0,2], self),
                Queen.new(:black, [0,3], self),
                King.new(:black, [0,4], self),
                Bishop.new(:black, [0,5], self),
                Knight.new(:black, [0,6], self),
                Rook.new(:black, [0,7], self)]

    # Populate rows of Pawns
    @grid[1].map!.with_index {|square, i| square = Pawn.new(:black, [1, i], self) }
    @grid[6].map!.with_index {|square, i| square = Pawn.new(:white, [6, i], self) }

    # Populate bottom row (back row for white side)
    @grid[7] = [Rook.new(:white, [7,0], self),
                Knight.new(:white, [7,1], self),
                Bishop.new(:white, [7,2], self),
                Queen.new(:white, [7,3], self),
                King.new(:white, [7,4], self),
                Bishop.new(:white, [7,5], self),
                Knight.new(:white, [7,6], self),
                Rook.new(:white, [7,7], self)]
  end

  def find_all_of_color(color)
    teammates = []
    @grid.each do |row|
      row.each do |square|
        teammates << square if !square.nil? && (color == square.color)
      end
    end
    teammates
  end


end

class Piece

  attr_reader :name
  
  def initialize(name, color)
    @name = name
    @color = color
  end

end

class SlidingPiece < Piece

end

class SteppingPiece < Piece

end

class Pawn < Piece

end

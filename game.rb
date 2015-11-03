require_relative 'board'
require_relative 'player'

class Game
  def initialize()
    @board = Board.new
    @player = Player.new( @board )
  end

  def play
    until @board.game_over?
      pos = @player.move
      @board.select_piece(pos)
      pos = @player.move
      @board.place_piece(pos)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end

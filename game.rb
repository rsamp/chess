require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :active_player

  def initialize()
    @board = Board.new
    @display = Display.new(@board, self)
    @player_1 = Player.new(color = :white, @display)
    @player_2 = Player.new(color = :black, @display)
    @active_player = @player_1
  end

  def play
    until @board.game_over?
      take_turn(@active_player)
      switch_player
    end
  end

  private

  def switch_player
    if @active_player == @player_1
      @active_player = @player_2
    else
      @active_player = @player_1
    end
  end

  def take_turn(player)
    # begin
      start_pos = player.move
      curr_square = @board[start_pos]
      until !curr_square.nil? && player.color == curr_square.color
        start_pos = player.move
      end
      @board.select_piece(start_pos)
      end_pos = player.move
      @board.place_piece(end_pos)
    # rescue ArgumentError => e
    #   puts "Something went wrong: #{e.message}"
    #   retry
    # end
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end

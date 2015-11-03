require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :active_player

  def initialize()
    @board = Board.new
    @display = Display.new(@board, self)
    @player_1 = Player.new( color=:white )
    @player_2 = Player.new( color=:black )
    @active_player = @player_1
  end

  def play
    until @board.game_over?
      # @display.render
      take_turn(@active_player)
      switch_player
    end
  end

  def switch_player
    if @active_player == @player_1
      @active_player = @player_2
    else
      @active_player = @player_1
    end
  end

  def take_turn(player)
    # begin
      pos = move
      curr_square = @board.grid[pos[0]][pos[1]]
      until !curr_square.nil? && player.color == curr_square.color
        pos = move
      end
      @board.select_piece(pos)
      pos = move
      @board.place_piece(pos)
    # rescue ArgumentError => e
    #   puts "Something went wrong: #{e.message}"
    #   retry
    # end
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end

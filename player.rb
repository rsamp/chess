require_relative 'display'

class Player
  attr_reader :color

  def initialize(color, display)
    @display = display
    @color = color
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

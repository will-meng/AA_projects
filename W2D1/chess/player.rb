class Player

  def initialize(name)
    @name = name
  end

  def play_turn(display, color)
    start_pos = nil
    until start_pos
      display.render(@name, color)
      start_pos = display.cursor.get_input
    end

    end_pos = nil
    until end_pos
      display.render(@name, color)
      end_pos = display.cursor.get_input
    end

    [start_pos, end_pos]
  end
end

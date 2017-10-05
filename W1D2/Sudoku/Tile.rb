class Tile
  attr_reader :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def update(value)
    if @given
      puts "invalid move (given tile)"
      return
    end
    @value = value
  end

  def to_s
    return @value.colorize(:red).on_light_yellow if @given
    return ' '.on_light_yellow if @value == '0'
    @value.on_light_yellow 
  end
end

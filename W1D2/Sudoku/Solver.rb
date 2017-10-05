class Solver

  def get_position
    return @next_pos if @next_pos
    @previous_pos = [(0..8).to_a.sample,(0..8).to_a.sample]
  end

  def get_value
    return @next_value if @next_value
    @previous_value = ('1'..'9').to_a.sample
  end

  def receive_result(valid_move)
    if valid_move
      @next_pos = nil
      @next_value = nil
    else
      @next_pos = @previous_pos
      @next_value = '0'
    end
  end
end

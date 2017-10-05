class Card

  attr_reader :value, :face_up

  CARD_BACK_DISPLAY = 'X'

  def initialize(value, face_up = false)
    @value, @face_up = value, face_up

  end

  def to_s
    @face_up ? @value.to_s : CARD_BACK_DISPLAY
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(card)
    @value == card.value
  end

end

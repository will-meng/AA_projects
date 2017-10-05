class Array

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    result = []
    self.my_each { |el| result << el if prc.call(el) }
    result
  end

  def my_reject(&prc)
    result = []
    self.my_each { |el| result << el unless prc.call(el) }
    result
  end

  def my_any?(&prc)
    self.my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    self.my_each { |el| return false unless prc.call(el) }
    true
  end

  def my_flatten
    result = []
    self.each do |el|
      if el.is_a?(Array)
        el.my_flatten.each { |sub_el| result << sub_el }
      else
        result << el
      end
    end
    result
  end

  def my_zip(*args)
    result = []
    self.each_with_index do |el, idx|
      chunk = [el]
      args.each { |arr| chunk << arr[idx] }
      result << chunk
    end
    result
  end

  def my_rotate(num = 1)
    num = num % self.length
    self[0...self.length] = self.drop(num) + self.take(num)
  end

  def my_join(sep="")
    result = ""
    self.each_with_index do |el, idx|
      result << el
      result << sep unless idx == self.length - 1
    end
    result
  end

  def my_reverse
    result = []
    self.each { |el| result.unshift(el) }
    result
  end

end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

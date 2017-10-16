require_relative 'mystack'

class MinMaxStackQueue
  attr_reader :in_stack, :out_stack

  def initialize(w)
    @in_stack = MyStack.new
    @out_stack = MyStack.new
    @w = w
  end

  def enqueue(el)
    if in_stack.size >= @w
      move_stacks
      in_stack.push([el, el, el])
    else
      dequeue unless out_stack.empty?
      enqueue_single(el, in_stack)
    end
  end

  def dequeue
    out_stack.pop
  end

  def min
    if in_stack.last.nil?
      out_stack.last[1]
    elsif out_stack.last.nil?
      in_stack.last[1]
    else
      [in_stack.last[1], out_stack.last[1]].min
    end
  end

  def max
    if in_stack.last.nil?
      out_stack.last[2]
    elsif out_stack.last.nil?
      in_stack.last[2]
    else
      [in_stack.last[2], out_stack.last[2]].max
    end
  end

  def peek
    print "In: "
    in_stack.peek
    print "Out: "
    out_stack.peek
  end

  private

  def enqueue_single(el, stack)
    cur_el = [el, nil, nil]
    cur_el[1..2] = if stack.empty?
                     [cur_el[0], cur_el[0]]
                   else
                     last_el = stack.last
                     [stack_min(cur_el, last_el), stack_max(cur_el, last_el)]
                   end
    stack.push(cur_el)
  end

  def move_stacks
    # moves w - 1 elements from in_stack to out_stack
    enqueue_single(in_stack.pop[0], out_stack) until in_stack.size == 1
    in_stack.pop
  end

  def stack_min(top_el, bot_el)
    # min is stored in 2nd element of el
    [top_el[0], bot_el[1]].min
  end

  def stack_max(top_el, bot_el)
    # max is stored in 3rd element of el
    [top_el[0], bot_el[2]].max
  end

end

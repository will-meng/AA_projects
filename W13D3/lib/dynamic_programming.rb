require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = [1, 2]
    @frog_cache = { 1 => [[1]],
                    2 => [[1, 1], [2]], 
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]] 
                  }
    @super_frog_cache = {} # keys will be [n, k], values will be like @frog_cache
  end

  def blair_nums(n)
    return nil if n < 1
    return @blair_cache[n - 1] if @blair_cache[n - 1]

    @blair_cache[n - 1] = blair_nums(n - 1) + blair_nums(n - 2) + 2 * n - 3
  end

  def blair_nums_bot_up(n)
    return nil if n < 1

    # build cache
    cache = [1, 2]
    until cache.length >= n
      cache << cache[-2] + cache[-1] + 2 * cache.length - 1
    end

    cache[n-1]
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    cache = { 1 => [[1]],
              2 => [[1, 1], [2]], 
              3 => [[1, 1, 1], [1, 2], [2, 1], [3]] 
            }

    4.upto(n) do |n|
      cache[n] = []
      1.upto(3) do |i|
        cache[n - i].each { |subarr| cache[n] << subarr + [i] }
      end
    end

    cache
  end

  def frog_hops_top_down(n)
    return nil if n < 1
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    @frog_cache[n] = []
    1.upto(3) do |i|
      frog_hops_top_down_helper(n - i).each do |subarr|
        @frog_cache[n] << subarr + [i]
      end
    end

    @frog_cache[n]
  end

  def super_frog_hops(n, k) # n = total stairs, k = max jump
    return nil if n < 1 || k < 1
    @super_frog_cache[[n, k]] = { 1 => [[1]] } unless @super_frog_cache[[n, k]]
    super_frog_hops_top_down_helper(n, k)
  end

  def super_frog_hops_top_down_helper(n, k, n_max = n)
    return @super_frog_cache[[n_max, k]][n] if @super_frog_cache[[n_max, k]][n]

    @super_frog_cache[[n_max, k]][n] = []
    1.upto([n - 1, k].min) do |i|
      super_frog_hops_top_down_helper(n - i, k, n_max).each do |subarr|
        @super_frog_cache[[n_max, k]][n] << subarr + [i]
      end
    end
    @super_frog_cache[[n_max, k]][n] << [n] if k >= n

    @super_frog_cache[[n_max, k]][n]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

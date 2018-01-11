require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = [1, 2]
    @frog_cache = { 1 => [[1]],
                    2 => [[1, 1], [2]], 
                    3 => [[1, 1, 1], [1, 2], [2, 1], [3]] 
                  }
    @super_frog_cache = {} # keys will be [n, k], values will be like @frog_cache
    @maze_paths = []
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
    nk = [n_max, k] # key for the cache for this particular n, k pair
    return @super_frog_cache[nk][n] if @super_frog_cache[nk][n]

    @super_frog_cache[nk][n] = []
    1.upto([n - 1, k].min) do |i|
      super_frog_hops_top_down_helper(n - i, k, n_max).each do |subarr|
        @super_frog_cache[nk][n] << subarr + [i] # solutions for n - i with i as last step
      end
    end
    @super_frog_cache[nk][n] << [n] if k >= n # one jump to reach top

    @super_frog_cache[nk][n]
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    # p table
    table[-1][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    n = weights.length
    table = [Array.new(n, 0)]

    1.upto(capacity) do |cur_cap|
      cur_row = []
      n.times do |i|
        # best combined value from this value + prev best
        prev_weight = cur_cap - weights[i] # highest weight not including mine
        prev_best = 
        if prev_weight >= 0
          i > 0 ? table[prev_weight][i - 1] + values[i] : values[i]
        else
          0 # current weight is higher than current capacity
        end

        # pick best solution from prev index in row or prev solution + current
        cur_row[i] = [cur_row[i - 1] || 0, prev_best].max
      end
      table << cur_row
    end

    table
  end

  def maze_solver2(maze, start_pos, end_pos)
    return [end_pos] if start_pos == end_pos

    # try 4 possible directions and pick one with shortest path
    x, y = start_pos
    possibilities = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
    best = [nil, nil] # [dist, pos]
    finish_found = false

    possibilities.each_with_index do |pos, i|
      if pos == end_pos
        finish_found = true
        best[1] = pos
      end

      next unless pos[0].between?(0, maze.length) &&
                  pos[1].between?(0, maze[0].length) &&
                  maze[pos[0]][pos[1]] != 'X' &&
                  !finish_found
      
      dist = (pos[0] - end_pos[0]) ** 2 + (pos[1] - end_pos[1]) ** 2
      best = [dist, pos] if !best[0] || dist < best[0]
    end

    [start_pos] + maze_solver(maze, best[1], end_pos)
  end

  def maze_solver(maze, start_pos, end_pos, path = [])
    if start_pos == end_pos
      @maze_paths << path + [start_pos]
      return
    end

    x, y = start_pos
    possibilities = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
    
    possibilities.each do |pos|
      next unless pos[0].between?(0, maze.length - 1) &&
                  pos[1].between?(0, maze[0].length - 1) &&
                  maze[pos[0]][pos[1]] != 'X' &&
                  !path.include?(pos) # path never backtracks
      maze_solver(maze, pos, end_pos, path + [start_pos])
    end

    @maze_paths
  end
end

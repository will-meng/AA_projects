def max_window_range(arr, w)
  max = 0

  arr.each_cons(w) do |subarr|
    range = subarr.max - subarr.min
    range = max if range > max
  end

  max
end

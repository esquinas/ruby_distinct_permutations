class Array
  # Yields distinct permutations of _self_ to the block.
  # This method requires that all array elements be Comparable.
  def distinct_permutation  # :yields: _ary_
    # If no block, return an enumerator.
    return enum_for(:distinct_permutation) unless block_given?

    copy = self.sort #=> copy #=> [1, 1, 2] ; self #=> [1, 1, 2].
    yield copy.dup #=> [1, 1, 2].
    return if size < 2 #=> size #=> 3; size < 2 #=> false; continue.

    while true
      # from: "The Art of Computer Programming" by Donald Knuth.
      j = size - 2; #=> j = 3 - 2; j #=> 1.
      j -= 1 while j > 0 && copy[j] >= copy[j+1] #=> 1 > 0 && 1 >= 2; false ; j #=> 1.
      if copy[j] < copy[j+1] #=> if 1 < 2 #=> true.
        l = size - 1 #=> l = 3 - 1; l #=> 2.
        l -= 1 while copy[j] >= copy[l] # 1 >= 2 #=> false ; l #=> 2.
        copy[j] , copy[l] = copy[l] , copy[j] # copy #=> [1, 2, 1].
        copy[j+1..-1] = copy[j+1..-1].reverse # copy #=> [1, 2, 1].
        yield copy.dup #=> [1, 2, 1].
      else # .
        break # .
      end
    end
  end
end

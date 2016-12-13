# :nodoc:
class Array
  # Yields distinct permutations of _self_ to the block.
  # This method requires that all array elements be Comparable.
  # rubocop:disable CyclomaticComplexity, AbcSize, MethodLength, PerceivedComplexity, LineLength
  def distinct_permutation # :yields: _ary_
    # If no block, return an enumerator.
    return enum_for(:distinct_permutation) unless block_given?

    # IDEA:
    # The copy should have the object_id of every item, work with that, then,
    # before yielding, restore each object_id back to its value. Use a hash?
    copy = sort #=> copy #=> [1, 1, 2] ; self #=> [1, 1, 2].
    yield copy.dup #=> [1, 1, 2].
    return if length < 2 #=> length #=> 3; length < 2 #=> false; continue.
    # rubocop:disable InfiniteLoop, LiteralInCondition
    while true # fasterer gem says this is faster than `Kernel#loop`.
      # from: "The Art of Computer Programming" by Donald Knuth.
      # Reset `j` to be the index of the penultimate item.
      j = length - 2; #=> j = 3 - 2; j #=> 1.  2nd=> j #=> 1.
      # Reduce `j` until the index of the last pair who is ordered.
      j -= 1 while 0 < j && copy[j + 1] <= copy[j] #=> false ; j #=> 1.
      # 2nd=> copy #=> [1, 2, 1]; true ; j -= 1 ; false ; j #=> 0.
      # 3rd=> copy #=> [2, 1, 1]; true ; j -= 1 ; j #=> 0; false ; j #=> 0.
      # Break if there aren't any more ordered pairs left.
      break if copy[j + 1] <= copy[j] #=> break if 1 >= 2 #=> continue.
      # 2nd=> break if 2 <= 1 #=> continue.
      # 3rd=> break if 1 <= 2 #=> break !!

      # Reset `l` to be the index of the last item.
      l = length - 1 #=> l = 3 - 1; l #=> 2.
      # 2nd=> l #=> 2
      # Set `l` to be the index of the last item greater than the item at `j` .
      l -= 1 while copy[l] <= copy[j] # 2 <= 1 #=> false ; l #=> 2.
      # 2nd=> 1 <= 1 #=> true ; l #=> 1 ; 2 <= 1 ; false ; l #=> 1.
      # Swap item at `j` and `l`.
      copy[j], copy[l] = copy[l], copy[j] # copy #=> [1, 2, 1].
      # 2nd=> copy #=> [2, 1, 1].
      # Reverse the order from index `j` to the end.
      # Now old value at `j` is at the end.
      copy[j + 1..-1]  = copy[j + 1..-1].reverse # copy #=> [1, 2, 1].
      # 2nd=> copy #=> [2, 1, 1].
      yield copy.dup #=> [1, 2, 1].
      #            2nd=> [2, 1, 1].
    end
  end
end

__END__

## Yield history: ##

```ruby
[1, 1, 2] # 0th iteration.
[1, 2, 1] # 1st   "
[2, 1, 1] # 2nd   "
```

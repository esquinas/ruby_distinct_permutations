# :nodoc:
class Array
  # Yields unique and distinct permutations of _self_ to the block.
  # This method does NOT require that array elements are Comparable.
  # rubocop:disable CyclomaticComplexity, AbcSize, MethodLength, PerceivedComplexity, LineLength
  def distinct_permutation
    return enum_for(:distinct_permutation) unless block_given?

    copy = []
    # Store in a hash like `{ object_id => object, ... }` to look-up later.
    hash = map.with_object({}) do |obj, mem|
      oid = find { |o| o == obj }.object_id # TODO: optimize `find`.
      copy << oid
      mem.merge!(oid => obj)
    end

    copy.sort!
    yield copy.map { |oid| hash[oid] } # retrieves original objects.
    return if length < 2
    # rubocop:disable InfiniteLoop, LiteralInCondition
    while true # fasterer gem says this is faster than `Kernel#loop`.
      # from: "The Art of Computer Programming" by Donald Knuth.
      j = length - 2
      j -= 1 while 0 < j && copy[j + 1] <= copy[j]
      break if copy[j + 1] <= copy[j]

      l = length - 1
      l -= 1 while copy[l] <= copy[j]
      copy[j], copy[l] = copy[l], copy[j]
      copy[j + 1..-1]  = copy[j + 1..-1].reverse
      yield copy.map { |oid| hash[oid] }
    end
  end
end

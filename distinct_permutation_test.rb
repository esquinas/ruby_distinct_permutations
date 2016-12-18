#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/benchmark'
require 'minitest/pride'
require 'set'
require_relative 'distinct_permutation'

class DistinctPermutationTest < Minitest::Test
  def test_behaves_like_array_permutations_when_all_numbers_are_different
    # skip
    array = [0, 1, 2, 3]
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_behaves_like_array_permutations_when_all_strings_are_different
    # skip
    array = %w(A B C D)
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_makes_distinct_permutations
    # skip
    array = [1, 1, 2, 3]
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_makes_distinct_permutations_of_strings
    # skip
    array = %w(A A B C)
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_returns_enumerator_when_no_block_is_given
    # skip
    array = [0, 1, 2, 3]
    each_permutation          = array.permutation
    each_distinct_permutation = array.distinct_permutation

    assert_equal each_distinct_permutation.to_set, each_permutation.to_set
    assert_kind_of Enumerator, each_distinct_permutation

    array.permutation.to_a.uniq.each do |x|
      assert_equal x, each_distinct_permutation.next
    end

    assert_raises(StopIteration) { each_distinct_permutation.next }
  end

  def test_makes_permutations_with_nil
    # skip
    array = [nil, nil, 2]
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_makes_permutations_with_no_comparables
    # skip
    array = ['A', 0, 1.1, nil, [1], { a: 2 }, :b, Object.new]
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end

  def test_makes_distinct_permutations_with_repeated_strings
    # skip
    array = ['A', 'A', 'A', 'B', Object.new]
    expected = array.permutation.to_a.uniq.size # => 20
    assert_equal expected, array.distinct_permutation.to_a.size
  end

  def test_makes_distinct_permutations_based_only_on_object_ids
    # skip
    array1 = [Object.new, Object.new, Object.new]
    array2 = [array1,     array1,     Object.new]
    expected1 = array1.permutation.to_a.size # => 6
    expected2 = array2.permutation.to_a.size # => 6
    assert_equal expected1, array1.distinct_permutation.to_a.size # => 6
    refute_equal expected2, array2.distinct_permutation.to_a.size # => 3
  end

  def test_makes_distinct_permutations_with_repeated_no_comparables
    # skip
    array = [['A'], ['A'], { a: 1 }, { a: 1 }, 'A', 'A', nil, nil].shuffle
    expected = array.permutation.to_a.uniq.size # => 20
    assert_equal expected, array.distinct_permutation.to_a.size
  end
end

# TODO: finish this.
class DistinctPermutationComplexityTest < Minitest::Benchmark
  def setup
    @arry = ['A', 'A', 0, nil, Object.new]
  end

  def bench_distinct_permutations
    skip # WARNING: slow
    assert_performance_linear 0.999 do |n|
      n.times do
        @arry.shuffle!
        @arry.distinct_permutation.to_a
      end
    end
  end
end

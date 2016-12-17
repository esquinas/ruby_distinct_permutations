#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/pride'
require 'set'
require_relative 'distinct_permutation'

# Test data version:
# 6a886e0
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

  def test_makes_distinct_permutations_with_nil
    # skip
    array = [nil, nil, 2]
    expected = array.permutation.to_set
    assert_equal expected, array.distinct_permutation.to_set
  end
end

# Distinct Permutations in Ruby

Use this to get unique and distinct [permutations](https://en.wikipedia.org/wiki/Permutation) for ruby Arrays when `Array#permutation.to_a.uniq` is not fast enough.

## How to get distinct/unique permutations in Ruby.

Normal permutations:
```ruby
[0, 1, 2].permutation.to_a      #=> [[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0]]
[0, 1, 2].permutation.to_a.size #=> 6
```

Distinct permutations:
```ruby
[0, 0, 1].permutation.to_a.size      #=> 6
[0, 0, 1].permutation.to_a.uniq.size #=> 3
```

**Problem:** `Array#permutation` treats each `0` like a different object!
```ruby
[0, 0, 1].permutation.to_a 
# => [[0, 0, 1], [0, 1, 0], [0, 0, 1], [0, 1, 0], [1, 0, 0], [1, 0, 0]]
# There are 3 duplicates!       ^1         ^2                    ^3.
```
The same happens with strings or other objects.

However, the result we want is:
```ruby
[0, 0, 1].permutation.to_a.uniq 
# => [[0, 0, 1], [0, 1, 0], [1, 0, 0]]
```

But that can be very inefficient when the array size increases.

Instead you can use `Array#distinct_permutation`:
```ruby
require_relative 'distinct_permutation'

[0, 0, 1].distinct_permutation.to_a
# => [[0, 0, 1], [0, 1, 0], [1, 0, 0]] (order may vary)
```
The uniqueness of objects is based on `Object#object_id`, so order may vary from one Ruby implementation to another.

This is mainly a rewrite of [this code](http://rosettacode.org/wiki/Permutations#Ruby) from awesome site [Rosetta Code](http://rosettacode.org/).

Dynamic programming algorithm is based on "The Art of Computer Programming" by Donald Knuth.

## ToDo

+ Benchmark different approaches and show the results here.
+ Ask for advise, improvements, naming tips, nit-picks to more experienced Rubists.
+ Make this a module? 
+ Decide to write this as a gem or not.

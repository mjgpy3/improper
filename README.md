improper
========

Property based test generators for ruby, yay!

While testing, sometimes we really want to fling a wide variety of values at a particular case.

`improper` is a fluent and useful tool for generating such values.

## Chain-able methods
 - `and_above` - Inclusive, lower range bound, `and_` is optional
 - `and_below` - Inclusive, upper range bound, `and_` is optional
 - `that_are_even` - Only generate even numbers, `are` could be `is`
 - `that_are_odd` - Only generate odd numbers, `are` could be `is`


## Example usage
To get 5 random integers
```
generating(5).numbers { |x| puts x }
# Might output:
# => 42
# => -135
# => 89235
# => 5235
# => -2
```

To get an even number
```
generating(:a).
  number.
  that_is_even { |x| puts x } # => 82
```

To get ten thousand positive, non-zero integers
```
generating(10000).numbers.above(1) { |x| puts x }
# => <ten thousand nums...>
```

improper
========

Property based test generators for ruby, yay!

While testing, sometimes we really want to fling a wide variety of values at a particular case.

`improper` is a fluent and useful tool for generating such values.

# Generating Strings

## Chain-able methods
 - `of_sizes` - Specifies the length(s) of the strings to be generated (accepts `Array`s, `Range`s, or a flat list of `Fixnum`s). `of_size` does the same thing
 - `from_values` - Specifies possible character values for the string's characters

## Example Usage
To get 5 random strings
```
generating(5).strings { |x| puts x }
# Might output:
# => ']$mhX3SH'
# => 'E#u6'
# => 'D$Q*3m5I>DV{'
# => '.5XP'
# => "'r4"
```

To get a random string that has lower, alphabetic characters and a length of 8
```
generating(:a).
  string.
  of_size(8).
  from_values('a'..'z') { |x| puts x }
# => jtayhgem
```

# Generating Numbers

## Chain-able methods
 - `and_above` - Inclusive, lower range bound, `and_` is optional
 - `and_below` - Inclusive, upper range bound, `and_` is optional
 - `that_are_even` - Only generate even numbers, `are` could be `is`
 - `that_are_odd` - Only generate odd numbers, `are` could be `is`


## Example Usage
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

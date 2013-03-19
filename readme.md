#Enthralled

This is a random number generator with a twist, it only uses a timer and a
counter to generate random numbers. I'm about 30% convinced it's
cryptographically secure.

Here's how it works:

* In `lib/enthralled/sources/counter_source.rb` we run a timer and a counter,
  every time the counter fires we tap some bits off it and shove them into a
  pool
* When the pool gets sufficiently full it takes the sha256 digest of the pool
  and dumps it

You'd have to be able to accurately predict the lower bits of a counter going
round really quickly, and know when the timer is going to stop. I don't think
you can.

Set it up with `bundle install`. Run it with `ruby -Ilib bin/random_pipe.rb`.

The first column of output is the random byte, the second is the byte number
and the third is how many bytes we're planning to generate. Swag.

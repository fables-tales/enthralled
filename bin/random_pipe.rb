#!/usr/bin/env ruby

require "enthralled"

OUTPUT_AMOUNT = 10_000

p = Enthralled::BitPool.new(32)
Enthralled::CounterSource.new(p)

OUTPUT_AMOUNT.times do |i|
  b = p.blocking_next_byte
  puts "#{b},#{i},#{OUTPUT_AMOUNT}"
end

s.shutdown

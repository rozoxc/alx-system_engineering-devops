#!/usr/bin/env ruby

# Check if the argument matches the regular expression
if ARGV.length == 1
  match_result = ARGV[0].scan(/School/)
  puts match_result.join
end


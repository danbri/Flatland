#!/usr/bin/ruby

# generates labels.m
# ./labels.rb > labels.m

puts "PL = { \n"
f = File.read('programmes.txt')
f.each do |x|
  x.chomp!
  x.gsub!(/_/,' ')
  id,url = x.split(/\t/)
  puts "'#{url}', \n"
end
puts "}\n"

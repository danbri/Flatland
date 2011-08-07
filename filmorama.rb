#!/usr/bin/ruby

clusters = 'clusters-res1.txt'
labels = {} 
cat = {}
numcats=10

f = File.read('data/programmes-b.txt')
f.each do |x|
  x.chomp!
  x.gsub!(/_/,' ')
  id,name = x.split(/\t/)
#  puts "id: #{id} name: #{name}\n"
  labels[id]=name
end

items = File.read(clusters)

i=0
items.each do |x|
  x.chomp!
#  puts "#{i}: #{labels[i.to_s]} CATEGORY: #{x}"
  cat[i.to_s] = x
  i=i+1
  if (i==10) 
    i=11 
  end
end


(1..numcats).each do |n|
  puts "Category: #{n}\n"
  cat.each do |c,v|
    #puts "#{c} -> #{v}"  if v==n.to_s
    puts labels[c] if v==n.to_s
  end
  print "\n\n"
end

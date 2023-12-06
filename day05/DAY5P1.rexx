/*REXX*/
file = "input.txt"

numeric digits 16

line = linein(file)
parse var line "seeds:" seeds 
do i = 1 to words(seeds) by 1
  seeds.i = word(seeds,i)
end 

seeds.0 = words(seeds) 

do while lines(file) > 0 
  line = linein(file)
  if words(line) == 2 then do  
    do i = 1 to seeds.0 by 1
      seeds.i.b = 1
    end
  end
  if words(line) == 3 then do
    dest_range = word(line,1)
    source_range = word(line,2)
    range = word(line,3)
    do i = 1 to seeds.0 by 1
      if seeds.i >= source_range & seeds.i =< (source_range + range) & seeds.i.b then do
        seeds.i = dest_range + (seeds.i - source_range)
        seeds.i.b = 0
      end
    end
  end
end

min = seeds.1
do i = 2 to seeds.0 by 1
  if seeds.i < min then 
    min = seeds.i
end

say "part1:" min

exit
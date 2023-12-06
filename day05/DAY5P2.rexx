/*REXX*/
file = "input.txt"

numeric digits 31

line = linein(file)
parse var line "seeds:" seeds_str 
j = 0
do i = 1 to words(seeds_str) by 2 
  j = j + 1
  seeds.j.start = word(seeds_str,i)
  seeds.j.range = word(seeds_str,i+1) 
end

seeds.0 = j

do while lines(file) > 0 
    line = linein(file)
    if words(line) == 2 then do  
        do i = 1 to seeds.0 by 1
            seeds.i.b = 1                                                     
        end
    end
    if words(line) == 3 then do
        dest_start = word(line,1)
        source_start = word(line,2)
        range_len = word(line,3)
        
        do i = 1 to seeds.0 by 1
            if seeds.i.b then do
                x1 = seeds.i.start 
                x2 = seeds.i.start + seeds.i.range 
                y1 = source_start 
                y2 = source_start + range_len
                select
                    when x1 >= y1 & x2 <= y2 then do
                        seeds.i.start = x1 - y1 + dest_start
                        seeds.i.range = seeds.i.range + 0
                        seeds.i.b = 0
                    end 
                    when x1 >= y1 & x1 < y2 & x2 > y2 then do
                        seeds.i.start = x1 - y1 + dest_start 
                        seeds.i.range = y1 + range_len - x1
                        seeds.i.b = 0
                        n = seeds.0 + 1
                        seeds.n.start = y1 + range_len
                        seeds.n.range  = x2 - y1 - range_len
                        seeds.n.b = 1
                        seeds.0 = n
                    end
                    when x1 < y1 & x2 > y1 & x2 <= y2 then do
                        seeds.i.start = dest_start
                        seeds.i.range = x2 - y1
                        seeds.i.b = 0
                        n = seeds.0 + 1
                        seeds.n.start = x1
                        seeds.n.range = y1 - x1
                        seeds.n.b = 1
                        seeds.0 = n
                    end
                    when x1 < y1 & x2 > y2 then do
                        seeds.i.start = dest_start
                        seeds.i.range = range_len
                        seeds.i.b = 0
                        n = seeds.0 + 1
                        seeds.n.start = y2
                        seeds.n.range = x2 - y2
                        seeds.n.b = 1
                        n = n + 1
                        seeds.n.start = x1
                        seeds.n.range = y1 - x1
                        seeds.n.b = 1
                        seeds.0 = n
                    end
                    otherwise 
                        nop
                end
            end
        end
    end
end

min = seeds.1.start
do i = 2 to seeds.0 by 1 
    if seeds.i.start < min then 
        min = seeds.i.start
end

say "part2:" min

exit
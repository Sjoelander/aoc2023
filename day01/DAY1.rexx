/*REXX*/
numbers.1 = "one"
numbers.2 = "two"
numbers.3 = "three"
numbers.4 = "four"
numbers.5 = "five"
numbers.6 = "six"
numbers.7 = "seven"
numbers.8 = "eight"
numbers.9 = "nine"

part1_sum = 0
part2_sum = 0 
do while lines(input.txt) > 0 
   line = linein(input.txt) 

   /* PART 1 */
   first_pos = length(line) + 1
   first_digit = 0
   last_pos = 0
   last_digit = 0

   do i = 1 to 9 by 1
     x = pos(i, line)
     if ((x < first_pos) & (x > 0)) then do
        first_pos = x
        first_digit = i
     end 
     y = lastpos(i, line)
     if y > last_pos then do
       last_pos = y
       last_digit = i
     end
   end

   part1_sum = part1_sum + ( first_digit || last_digit)

   /* PART 2 */
   first_pos = length(line) + 1
   first_digit = 0
   last_pos = 0
   last_digit = 0

   do i = 1 to 9 by 1

     x_1 = pos(i, line)
     x_2 = pos(numbers.i, line)
     if x_1 == 0 then x_1 = first_pos
     if x_2 == 0 then x_2 = first_pos 
        
     x = min(x_1, x_2)
     if (x < first_pos) then do
        first_pos = x
        first_digit = i
     end 
     y = max(lastpos(i, line), lastpos(numbers.i, line))
     if y > last_pos then do
       last_pos = y
       last_digit = i
     end
   end
   part2_sum = part2_sum + ( first_digit || last_digit)

end

say "part 1: " part1_sum
say "part 2: " part2_sum
exit
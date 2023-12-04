/*REXX*/
s.0 = 0
do while lines(input.txt) > 0 
  line = linein(input.txt)
  i = s.0 + 1
  s.i = line 
  s.0 = i 
  cards.i.num = 1
end
cards.0 = s.0

sum = 0; amount = 0;

do i = 1 to s.0 by 1
  parse var s.i a ":" b "|" c
  n = 0
  do j = 1 to words(c) by 1
    if wordpos(word(c,j),b) > 0 then 
      n = n + 1 
  end 
  /* Part 1 */
  if n > 0 then do
    sum = sum + (2**(n-1))
  end
  /* Part 2 */
  do cards.i.num 
    do j = 1 to n
      k = min(i+j,cards.0)
      cards.k.num = cards.k.num + 1
    end
  end
  amount = amount + cards.i.num
end

say "part1:" sum
say "part2:" amount
exit
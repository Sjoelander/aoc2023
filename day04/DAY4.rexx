/*REXX*/
cards. = ""
sum = 0
cards.0 = 0
do while lines(input.txt) > 0 
  line = linein(input.txt)
  parse var line a ":" b "|" c
  n = 0
  do i = 1 to words(c) by 1
    if wordpos(word(c,i),b) > 0 then 
      n = n + 1
  end 
  if n > 0 then do
    sum = sum + (2**(n-1))
  end
  i = cards.0 + 1
  cards.i.num = 1
  cards.i.wins = n
  cards.0 = i
end

amount = 0
do i = 1 to cards.0 by 1
  do cards.i.num 
    do j = 1 to cards.i.wins
      k = min(i+j,cards.0)
      cards.k.num = cards.k.num + 1
    end
  end
  amount = amount + cards.i.num
end

say "part1:" sum
say "part2:" amount
exit
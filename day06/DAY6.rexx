file = "input.txt"

line1 = linein(file)
line2 = linein(file)
parse var line1 "Time:" times
parse var line2 "Distance:" distances
do i = 1 to words(times) by 1
    race.i.time = word(times,i)
    race.i.distance = word(distances,i)
end
race.0 = i - 1

s = 1
do i = 1 to race.0
    n = 0
    do j = 1 to (race.i.time - 1) by 1
        d = j * (race.i.time - j) 
        if d > race.i.distance then
            n = n + 1
    end
    s = s * n
end

say "Part 1:" s

exit
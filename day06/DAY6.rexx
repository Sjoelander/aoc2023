file = "input.txt"

numeric digits 16

line1 = linein(file)
line2 = linein(file)
parse var line1 "Time:" times
parse var line2 "Distance:" distances
time2 = ""; distance2 = "";
do i = 1 to words(times) by 1
    race.i.time = word(times,i)
    race.i.distance = word(distances,i)
    /* concatenate for part2 */
    time2 = time2 || race.i.time
    distance2 = distance2 || race.i.distance
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

say "Part 1:" part1()
say "Part 2:" part2(time2, distance2)
say "Part 1 (again):" part1_2()

exit

/* slow and steady wins the race */
part1: procedure expose race.
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
    return s

part2: procedure
    parse arg time, distance
    q = (time**2 - (-1 * 4 * - distance))
    x1 = (((-1 * time) + sqrt(q)) / -2)
    x2 = (((-1 * time) - sqrt(q)) / -2)
    /* floor() ?!?!?! */
    x1 = substr(x1,1,pos(".",x1)-1)
    x2 = substr(x2,1,pos(".",x2)-1)
    return abs(x1 - x2)

part1_2: procedure expose race.
    s = 1
    do i = 1 to race.0
        n = part2(race.i.time, race.i.distance)
        s = s * n
    end
    return s

/* newton-raphson*/
sqrt: procedure
    arg num
    if ^datatype(num,"Number") | num < 0 then
        return ""
    eps = 0.5 * 10**(1+fuzz()-digits())
    new = num
    old = num
    do until abs(old-new) < (eps*new)
        old = new                      
        new = 0.5 * (old + num / old)  
    end
    return new
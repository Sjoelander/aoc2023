       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
         SPECIAL-NAMES. 
         CLASS DIGITS IS '0123456789'. 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE RECORD IS VARYING DEPENDING ON RECORD-LENGTH.
       01  CALIBRATION-LINE        PIC X(256).
       WORKING-STORAGE SECTION.
       01 RECORD-LENGTH            PIC 9(4) BINARY.
       01 I                        PIC 9(4) BINARY.
       01 NUMBER-NAMES             PIC 9(4) BINARY.
       01 LINE-DIGITS. 
         05 FIRST-DIGIT            PIC 9.
         05 LAST-DIGIT             PIC 9.
       01 TOTAL-SUM                PIC 9(9) BINARY VALUE ZERO.
       01 TOTAL-SUM-WITH-NAMES     PIC 9(9) BINARY VALUE ZERO.
       01 INPUT-FILE-STATUS        PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 
               
           PERFORM UNTIL INPUT-FILE-EOF

              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END 

      *            PART 1
                   PERFORM CHECK-FOR-FIRST-AND-LAST-DIGIT
                   ADD FUNCTION NUMVAL(LINE-DIGITS) 
                    TO TOTAL-SUM

      *            PART 2
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "one"   BY "o1e"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "two"   BY "t2o"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "three" BY "t 3 e"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "four"  BY "f 4r"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "five"  BY "f 5e"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "six"  BY "s6x"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "seven" BY "s 7 n"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "eight" BY "e 8 t"
                   INSPECT CALIBRATION-LINE(1:RECORD-LENGTH)
                     REPLACING ALL "nine"  BY "n 9e"
                   
                   PERFORM CHECK-FOR-FIRST-AND-LAST-DIGIT
                   ADD FUNCTION NUMVAL(LINE-DIGITS) 
                    TO TOTAL-SUM-WITH-NAMES

              END-READ

           END-PERFORM

           DISPLAY 'PART1: ' TOTAL-SUM
           DISPLAY 'PART2: ' TOTAL-SUM-WITH-NAMES

           CLOSE INPUT-FILE

           STOP RUN
           .

       CHECK-FOR-FIRST-AND-LAST-DIGIT.

           PERFORM VARYING I FROM 1 BY 1 
             UNTIL CALIBRATION-LINE(I:1) IS DIGITS
             CONTINUE
           END-PERFORM

           MOVE CALIBRATION-LINE(I:1) TO FIRST-DIGIT

           PERFORM VARYING I FROM RECORD-LENGTH BY -1
             UNTIL CALIBRATION-LINE(I:1) IS DIGITS
             CONTINUE
           END-PERFORM
           MOVE CALIBRATION-LINE(I:1) TO LAST-DIGIT 
           .
         
       END PROGRAM DAY1.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY2.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE RECORD IS VARYING DEPENDING ON RECORD-LENGTH.
       01  GAME-RECORD             PIC X(256).
       WORKING-STORAGE SECTION.
       01 RECORD-LENGTH            PIC 9(4) BINARY.
       01 I                        PIC 9(4) BINARY.
       01 J                        PIC 9(4) BINARY.
       01 GAME-STR.
         05 FILLER                 PIC X(5).
         05 GAME-NUMBER            PIC X(5).
       01 GAME-NUMBER-NUM          PIC 9(4) BINARY.
       01 SETS-STR                 PIC X(200).
       01 SUBSET-STR               PIC X(200).
       01 SUBSET                   PIC X(200).
       01 AMOUNT-STR               PIC X(10).
       01 AMOUNT-NUM               PIC 9(4) BINARY.
       01 COLOUR                   PIC X(10).
       01 MINIMUM-RED              PIC 9(4) BINARY.
       01 MINIMUM-GREEN            PIC 9(4) BINARY.
       01 MINIMUM-BLUE             PIC 9(4) BINARY. 
       01 GAME-POWER               PIC 9(9) BINARY.
       01 TOTAL-SUM                PIC 9(9) BINARY VALUE ZERO.
       01 GAME-POSSIBILITY         PIC X(1) VALUE X'00'.
           88 GAME-POSSIBLE                 VALUE X'D7'.
           88 GAME-IMPOSSIBLE               VALUE X'C9'.

       01 INPUT-FILE-STATUS        PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 
               
           PERFORM UNTIL INPUT-FILE-EOF

              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END 
                   PERFORM CHECK-GAME
              END-READ

           END-PERFORM

      *    PART1
           DISPLAY TOTAL-SUM

      *    PART2 
           DISPLAY GAME-POWER

           CLOSE INPUT-FILE

           STOP RUN
           .

       CHECK-GAME.
           SET GAME-POSSIBLE TO TRUE

           MOVE ZERO TO MINIMUM-RED
                        MINIMUM-GREEN
                        MINIMUM-BLUE

           UNSTRING GAME-RECORD DELIMITED BY ':' 
               INTO GAME-STR
                    SETS-STR

           COMPUTE GAME-NUMBER-NUM = FUNCTION NUMVAL(GAME-NUMBER)

           MOVE 1 TO I
           PERFORM UNTIL I > LENGTH OF SETS-STR

             UNSTRING SETS-STR DELIMITED BY ';'
                 INTO SUBSET-STR
                 WITH POINTER I

             MOVE 1 TO J
             PERFORM UNTIL J > LENGTH OF SUBSET-STR

               UNSTRING SUBSET-STR DELIMITED BY ','
                   INTO SUBSET
                   WITH POINTER J 

               UNSTRING SUBSET(2:) DELIMITED BY SPACE
                   INTO AMOUNT-STR
                        COLOUR 

               COMPUTE AMOUNT-NUM = FUNCTION NUMVAL(AMOUNT-STR)

               EVALUATE COLOUR ALSO TRUE  
                 WHEN 'red' ALSO AMOUNT-NUM > 12
                 WHEN 'green' ALSO AMOUNT-NUM > 13 
                 WHEN 'blue' ALSO AMOUNT-NUM > 14   
                   SET GAME-IMPOSSIBLE TO TRUE
               END-EVALUATE  

               EVALUATE COLOUR ALSO TRUE  
                 WHEN 'red' ALSO AMOUNT-NUM > MINIMUM-RED
                   MOVE AMOUNT-NUM TO MINIMUM-RED
                 WHEN 'green' ALSO AMOUNT-NUM > MINIMUM-GREEN
                   MOVE AMOUNT-NUM TO MINIMUM-GREEN
                 WHEN 'blue' ALSO AMOUNT-NUM > MINIMUM-BLUE
                   MOVE AMOUNT-NUM TO MINIMUM-BLUE
               END-EVALUATE 

             END-PERFORM

           END-PERFORM

           IF GAME-POSSIBLE THEN 
             ADD GAME-NUMBER-NUM TO TOTAL-SUM
           END-IF

           COMPUTE GAME-POWER = GAME-POWER + 
             (MINIMUM-RED * MINIMUM-GREEN * MINIMUM-BLUE)
           .

       END PROGRAM DAY2.

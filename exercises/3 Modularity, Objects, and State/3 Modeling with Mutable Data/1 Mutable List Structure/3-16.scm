#lang sicp

; Ben Bitdiddle decides to write a procedure to count the number of pairs in any list
; structure. ``It's easy,'' he reasons. ``The number of pairs in any structure is the number in the car plus the
; number in the cdr plus one more to count the current pair.'' So Ben writes the following procedure:

(define (count-pairs x)
    (if (not (pair? x))
        0
        (+  (count-pairs (car x))
            (count-pairs (cdr x))
            1)))

; Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list
; structures made up of exactly three pairs for which Ben's procedure would return 3; return 4; return 7;
; never return at all.




(define x 'a)
(define y (cons x x))
(define z (cons y y))



(count-pairs (list x x x))      ; 3

;        [ * | * ]  ->  [ * | * ] ->  [ * | / ]
;          |              |             |
;          v ---------------------------
; x  ->  [ * | / ]
;          |
;          v
;        [ a ]



(count-pairs (list x x y))      ; 4

; -----------------------------------
; |                                  |
; |   [ * | * ]  ->  [ * | * ] ->  [ * | / ]
; |   |                |
; |   |                |
; |   --------------------------------
; ----------                          |
;          |                          |
;          v                          |
; y  ->  [ * | * ] ->  [ * | / ]      |
;          |             |            |
;          v--------------------------
; x  ->  [ * | / ]
;          |
;          v
;        [ a ]



(count-pairs (list x y z))      ; 7

; ----------------------              -----------
; |                    |             |           |
; |   [ * | * ]  ->  [ * | * ] ->  [ * | / ]     |
; |   |                |                         |
; |   |                |                         |
; |   -----------------------------------        |
; ----------                             |       |
;             |                          |       |
;             v                          |       |
; y  ->  [ * | * ] ->  [ * | / ]         |       |
;             |             |            |       |
;             v--------------------------        |
; x  ->  [ * | / ]                       |       |
;             |                          |       |
;             v                          |       |
;         [ a ]                          |       |
;                                        |       |
;           ------------------------------       |
;          |              |             |        |
; z  ->  [ * | * ]  ->  [ * | * ] ->  [ * | / ]  |
;          ^                                     |
;          |                                     |
;           --------------------------------------



(define qwe (list x x x))
(set-cdr! (cddr qwe) qwe)
; (count-pairs qwe)               ; never return at all

;        --------------------------------
;       |                                |
; ----------------------              -----------
; |     v              |             |   |       |
; |   [ * | * ]  ->  [ * | * ] ->  [ * | / ]     |
; |   |                |                         |
; |   |                |                         |
; |   -----------------------------------        |
; ----------                             |       |
;             |                          |       |
;             v                          |       |
; y  ->  [ * | * ] ->  [ * | / ]         |       |
;             |             |            |       |
;             v--------------------------        |
; x  ->  [ * | / ]                       |       |
;             |                          |       |
;             v                          |       |
;         [ a ]                          |       |
;                                        |       |
;           ------------------------------       |
;          |              |             |        |
; z  ->  [ * | * ]  ->  [ * | * ] ->  [ * | / ]  |
;          ^                                     |
;          |                                     |
;           --------------------------------------

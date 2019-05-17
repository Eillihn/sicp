#lang sicp

; Consider the following make-cycle procedure, which uses the last-pair procedure
; defined in exercise 3.12:

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
        
(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

; Draw a box-and-pointer diagram that shows the structure z created by

(define z (make-cycle (list 'a 'b 'c)))

; What happens if we try to compute (last-pair z)?



(display z)             ; #0=(a b c . #0#)
; (last-pair z)           ; -> infinite recursion
; The last element pointing to the first element after call of make-circle, so 
; calling (last-pair z) will run into infinite recursion.

; x -> [ * | * ] -> [ * | * ] -> [ * | * ]
;        |            |            |   |
;        v            v            v   |    
;                                      |      
;       [a]          [b]          [c]  |
;                                      |
;        ^                             |
;        |                             |
;        -------------------------------

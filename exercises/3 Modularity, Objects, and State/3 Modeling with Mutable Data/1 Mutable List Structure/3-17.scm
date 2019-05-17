#lang sicp

; Devise a correct version of the count-pairs procedure of exercise 3.16 that returns the
; number of distinct pairs in any structure. (Hint: Traverse the structure, maintaining an auxiliary data
; structure that is used to keep track of which pairs have already been counted.)



(define (count-pairs x)
    (let ((processed '()))
        (define (calc x)
            (if (or (not (pair? x)) (memq x processed))
                0
                (begin
                    (set! processed (cons x processed))
                    (+  (calc (car x))
                        (calc (cdr x))
                        1))))
        (calc x)))

(define x 'a)
(define y (cons x x))
(define z (cons y y))
(count-pairs (list x x x))      ; 3
(count-pairs (list x x y))      ; 4
(count-pairs (list x y z))      ; 5

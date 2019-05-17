#lang sicp

; Redo exercise 3.18 using an algorithm that takes only a constant amount of space. (This
; requires a very clever idea.)

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
        
(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)



(define (cycle? lst)
    (define (check x)
        (if (not (pair? x))
            false
            (if (eq? (cdr x) lst)
                true
                (check (cdr x)))))
    (check lst))

(define z (make-cycle (list 'a 'b 'c)))
(cycle? (list 'a 'b 'c))
(cycle? z)

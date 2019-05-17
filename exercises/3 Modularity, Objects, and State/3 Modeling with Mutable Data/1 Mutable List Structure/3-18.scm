#lang sicp

; Write a procedure that examines a list and determines whether it contains a cycle, that is,
; whether a program that tried to find the end of the list by taking successive cdrs would go into an infinite
; loop. Exercise 3.13 constructed such lists.

(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
        
(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)



(define (cycle? x)
    (let ((processed '()))
        (define (calc x)
            (if (not (pair? x))
                false
                (if (memq x processed)
                    true
                    (begin
                        (set! processed (cons x processed))
                        (calc (cdr x))))))
        (calc x)))

(define z (make-cycle (list 'a 'b 'c)))
(cycle? (list 'a 'b 'c))
(cycle? z)

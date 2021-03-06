#lang sicp

;; Define a procedure reverse that takes a list as argument and returns a list of the 
;; same elements in reverse order:
;; (reverse (list 1 4 9 16 25))
;; (25 16 9 4 1)

(define (reverse a)
    (define (iter a result)
        (if (null? a)
            result
            (iter (cdr a) (cons (car a) result))))
    (iter a nil))

(reverse (list 1 4 9 16 25))

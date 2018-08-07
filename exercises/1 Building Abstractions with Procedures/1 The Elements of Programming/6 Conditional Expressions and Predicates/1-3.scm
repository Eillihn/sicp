#lang sicp

;; Define a procedure that takes three numbers as arguments
;; and returns the sum of the squares of the two larger numbers.

(define (squares-sum-largest-two x y z)
    (if (= x (return-largest x y))
            (squares-sum x (return-largest z y))
            (squares-sum y (return-largest x z))
    ))

(define (return-largest x y)
    (if (> x y) x y))

(define (squares-sum x y)
    (+ (square x) (square y)))

(define (square x)
    (* x x))

(squares-sum-largest-two 1 2 3)



;; Answer:
;; 13
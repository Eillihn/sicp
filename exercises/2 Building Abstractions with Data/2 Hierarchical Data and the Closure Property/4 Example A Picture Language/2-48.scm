#lang sicp

;; A directed line segment in the plane can be represented as a pair of vectors -- the 
;; vector running from the origin to the start-point of the segment, and the vector 
;; running from the origin to the endpoint of the segment. Use your vector representation 
;; from exercise 2.46 to define a representation for segments with a constructor 
;; make-segment and selectors start-segment and end-segment.


(define (make-vect x y) (cons x y))

(define (make-segment start end) (cons start end))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))


;; Test code:
(define s (make-segment (make-vect 1 2) (make-vect 3 4)))
(display (start-segment s))
(display (end-segment s))

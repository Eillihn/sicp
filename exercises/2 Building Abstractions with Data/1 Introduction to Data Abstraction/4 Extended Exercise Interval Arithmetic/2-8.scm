#lang sicp

;; Using reasoning analogous to Alyssa's, describe how the difference of two intervals 
;; may be computed. Define a corresponding subtraction procedure, called sub-interval.

(define (make-interval a b) (cons a b))
(define (upper-bound interval) (max (car interval) (cdr interval))) 
(define (lower-bound interval) (min (car interval) (cdr interval))) 



;; Answer:

(define (sub-interval a b)
    (make-interval  (- (lower-bound a) (lower-bound b))
                    (- (upper-bound a) (upper-bound b))))



;; Test code:

(define a-interval (make-interval 3 10))
(define b-interval (make-interval 1 5))
(define test-sub-interval  (sub-interval a-interval b-interval))
(upper-bound test-sub-interval)                         ; 5
(lower-bound test-sub-interval)                         ; 2

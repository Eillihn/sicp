#lang sicp

;; The width of an interval is half of the difference between its upper and lower bounds. 
;; The width is a measure of the uncertainty of the number specified by the interval. 
;; For some arithmetic operations the width of the result of combining two intervals 
;; is a function only of the widths of the argument intervals, whereas for others the 
;; width of the combination is not a function of the widths of the argument intervals. 
;; Show that the width of the sum (or difference) of two intervals is a function only of 
;; the widths of the intervals being added (or subtracted). 
;; Give examples to show that this is not true for multiplication or division.

(define (make-interval a b) (cons a b))
(define (upper-bound interval) (max (car interval) (cdr interval))) 
(define (lower-bound interval) (min (car interval) (cdr interval))) 
(define (sub-interval a b)
    (make-interval  (- (lower-bound a) (lower-bound b))
                    (- (upper-bound a) (upper-bound b))))
(define (mul-interval x y)
    (let    ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval  (min p1 p2 p3 p4)
                        (max p1 p2 p3 p4))))

;; Answer:



(define (half a) (/ a 2))

(define (width-interval a)
    (half (- (lower-bound a) (upper-bound a))))



;; Test code:

(define a-interval (make-interval 3 10))
(define b-interval (make-interval 1 5))

(define width-a-interval (width-interval a-interval))
(define width-b-interval (width-interval b-interval))
(define test-sub-interval  (sub-interval a-interval b-interval))
(define test-mul-interval  (mul-interval a-interval b-interval))

(=  (width-interval test-mul-interval)
    (* width-a-interval width-b-interval))        ; f

(=  (width-interval test-sub-interval) 
    (- width-a-interval width-b-interval))        ; t

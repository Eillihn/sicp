#lang sicp

;; Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder and 
;; comments that it is not clear what it means to divide by an interval that spans 
;; zero. Modify Alyssa's code to check for this condition and to signal an error if 
;; it occurs.

(define (make-interval a b) (cons a b))
(define (upper-bound interval) (max (car interval) (cdr interval))) 
(define (lower-bound interval) (min (car interval) (cdr interval))) 
(define (mul-interval x y)
    (let    ((p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval  (min p1 p2 p3 p4)
                        (max p1 p2 p3 p4))))
(define (print-interval p)
    (newline)
    (display "[")
    (display (lower-bound p))
    (display ";")
    (display (upper-bound p))
    (display "]"))


;; Answer:

(define (div-interval x y)
    (if (or (= 0 (lower-bound y)) (= 0 (upper-bound y)))
        (error "Error: second interval spans 0" y)
        (mul-interval   x  
                        (make-interval  (/ 1. (upper-bound y)) 
                                        (/ 1. (lower-bound y))))))



;; Test code:
(define a-interval (make-interval 1 2))
(define b-interval (make-interval 0 5))
(print-interval (div-interval a-interval a-interval))       ; [0.5;2.0]
(print-interval (div-interval a-interval b-interval))       ; Error: second interval spans 0 {0 . 5}

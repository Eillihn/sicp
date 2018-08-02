#lang sicp

;; Simpson's Rule is a more accurate method of numerical integration than the method
;; illustrated above. Using Simpson's Rule, the integral of a function f between a and b is approximated as

;; where h = (b - a)/n, for some even integer n, and yk = f(a + kh). 
;; (Increasing n increases the accuracy of the approximation.) Define a procedure that takes 
;; as arguments f, a, b, and n and returns the value of the integral, computed using Simpson's Rule. 
;; Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000), and compare the 
;; results to those of the integral procedure shown above.

(define (cube x) (* x x x))

(define (even? x)
    (= (remainder x 2) 0))

(define (sum term a next b)
    (if (> a b)
        0
        (+  (term a)
            (sum term (next a) next b))))

(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (*  (sum f (+ a (/ dx 2.0)) add-dx b)
        dx))

(define (simpsons-rule f a b n)
    (define h (/ (- b a) n))
    (define (add-dx k) (+ a (* k h)))
    (define (y k)
        (cond   ((or (= k 0) (= k n)) (f (add-dx k)))
                ((even? k) (* 2 (f (add-dx k))))
                (else (* 4 (f (add-dx k))))))
    (*  (/ h 3)
        (sum y 0 inc n)))

(integral cube 0 1 0.01)            ; 0.24998750000000042
(integral cube 0 1 0.001)           ; 0.249999875000001

(simpsons-rule cube 0 1 100)        ; 1/4
(simpsons-rule cube 0 1 1000)       ; 1/4
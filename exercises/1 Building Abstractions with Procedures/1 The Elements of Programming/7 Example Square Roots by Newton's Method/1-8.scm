#lang sicp

;; Newton's method to get square root for x of successive approximations y

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter  (improve guess x)
                    x)))
(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (square x) (* x x))

;; Newton's method for cube roots is based on the fact that if y is
;; an approximation to the cube root of x, then a better approximation is given by
;; the value
;; x/y^2 + 2y
;; ----------
;;     3
;; Use this formula to implement a cube-root procedure
;; analogous to the square-root procedure.



;; Answer:
(define (cube-root-iter guess x)
    (if (cube-good-enough? guess x)
        guess
        (cube-root-iter (cube-improve guess x)
                        x)))

(define (cube-improve guess x)
    (/(+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-good-enough? guess x)
    (< (abs (- (cube guess) x)) 0.001))

(define (cube-root x)
    (cube-root-iter 1.0 x))

(define (cube x) (* (square x) x))

(cube-root 4096)
;; 16.000000000003983

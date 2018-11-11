#lang sicp
(#%require "../../../helpers/base.scm")
(#%require "../../helpers/fixed-point.scm")

;; Define a procedure cubic that can be used together with the newtons-method
;; procedure in expressions of the form
;; (newtons-method (cubic a b c) 1)
;; to approximate zeros of the cubic x3 + ax2 + bx + c.

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

(define (deriv g)
    (lambda (x)
        (/  (- (g (+ x dx)) (g x))
            dx)))

(define dx 0.00001)


;; Answer:

(define (cubic a b c)
    (lambda (x)
        (+  (cube x)
            (* a (square x))
            (* b x)
            c)))

(newtons-method (cubic 1 2 3) 1)        ; -1.2756822036498454

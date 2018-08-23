#lang sicp
(#%require "../../../helpers/gcd.scm")
(#%require "../../../helpers/expt.scm")


;; Show that we can represent pairs of nonnegative integers using only numbers and 
;; arithmetic operations if we represent the pair a and b as the integer that is the
;; product 2^a 3^b. 
;; Give the corresponding definitions of the procedures cons, car, and cdr.

(define (cons a b)
    (* (expt 2 a) (expt 3 b)))

(define (car z)
    (logb 2 (gcd z (expt 2 (logb 2 z)))))
(define (cdr z)
    (logb 3 (gcd z (expt 3 (logb 3 z)))))

(define (logb b x) (ceiling (/ (log x) (log b)))) 



;; Test code:
(car (cons 7 9))    ; 7
(cdr (cons 5 12))   ; 12

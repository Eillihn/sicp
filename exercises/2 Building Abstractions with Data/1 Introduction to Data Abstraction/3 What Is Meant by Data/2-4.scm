#lang sicp

;; Here is an alternative procedural representation of pairs. 
;; 1) For this representation, verify that (car (cons x y)) yields x for any 
;; objects x and y.

(define (cons x y)
    (lambda (m) (m x y)))

(define (car z)
    (z (lambda (p q) p)))

;; 2) What is the corresponding definition of cdr? 
;; (Hint: To verify that this works, make use of the substitution model of section 1.1.5.)



;; Answer:

;; 1) (car (cons x y)) yields x for any objects x and y:
;; (car (cons x y))
;; (car (lambda (m) (m x y)))
;; ((lambda (m) (m x y)) (lambda (p q) p))
;; ((lambda (m) (m x y)) (lambda (p q) p))
;; ((lambda (p q) p) x y)
;; x

;; 2) the corresponding definition of cdr:
(define (cdr z)
    (z (lambda (p q) q)))



;; Test code:
(car (cons 1 2))    ; 1
(cdr (cons 1 2))    ; 2

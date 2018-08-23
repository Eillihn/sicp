#lang sicp

;; In case representing pairs as procedures wasn't mind-boggling enough, consider 
;; that, in a language that can manipulate procedures, we can get by without numbers 
;; (at least insofar as nonnegative integers are concerned) by implementing 0 and the 
;; operation of adding 1 as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))

;; This representation is known as Church numerals, after its inventor, Alonzo Church, 
;; the logician who invented the calculus.
;; Define one and two directly (not in terms of zero and add-1). 
;; (Hint: Use substitution to evaluate (add-1 zero)).
;; Give a direct definition of the addition procedure + (not in terms of repeated
;; application of add-1).



;; Answer:

;; 1) Define one and two directly (not in terms of zero and add-1):

;; (add-1 zero)
;; (lambda (f) (lambda (x) (f ((zero f) x))))
;; (lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

;; (add-1 one)
;; (lambda (f) (lambda (x) (f ((one f) x))))
;; (lambda (f) (lambda (x) (f (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

;; 2) Give a direct definition of the addition procedure + (not in terms of repeated
;; application of add-1):

;; (add-1 two)
;; (lambda (f) (lambda (x) (f ((two f) x))))
;; (lambda (f) (lambda (x) (f (f (f x)))))
;; => (add n m) f should be applied n times, then m times:

(define (add n m)
    (lambda (f)
        (lambda (x)
            ((m f) ((n f) x)))))

;; Test code:
(define (square x) (* x x))
((zero square) 1)               ; 1
((one square) 2)                ; 4
((two square) 3)                ; 81
(((add one two) square) 2)      ; 256

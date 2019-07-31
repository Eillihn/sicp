#lang sicp
(#%require "../../../helpers/celsius-fahrenheit.scm")

; Louis Reasoner wants to build a squarer, a constraint device with two terminals such that
; the value of connector b on the second terminal will always be the square of the value a on the first
; terminal. He proposes the following simple device made from a multiplier:
; (define (squarer a b)
;     (multiplier a a b))
; There is a serious flaw in this idea. Explain.



(define (squarer a b)
    (multiplier a a b))

(define a (make-connector))
(define b (make-connector))
(probe 'A a)
(probe 'B b)
(squarer a b)

(set-value! b 4 'user)

; Answer:
; A will not be calculated by (process-new-value), as m1/m2 are unset, in other words multiplier 
; should have at least 2 arguments set.

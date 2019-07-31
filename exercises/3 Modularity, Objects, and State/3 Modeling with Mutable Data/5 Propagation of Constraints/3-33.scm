#lang sicp
(#%require "../../../helpers/celsius-fahrenheit.scm")

; Using primitive multiplier, adder, and constant constraints, define a procedure averager
; that takes three connectors a, b, and c as inputs and establishes the constraint that the value of c is the
; average of the values of a and b

(define (averager a b c) 
    (let ((x (make-connector)) 
          (y (make-connector))) 
      (adder a b x)
      (multiplier c y x)
      (constant 2 y)
      'ok)) 

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))
(probe 'A a)
(probe 'B b)
(probe 'C c)
(averager a b c)

(set-value! a 13 'user)
(set-value! b 27 'user)

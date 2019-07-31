#lang sicp
(#%require "../../../helpers/celsius-fahrenheit.scm")

; Suppose we evaluate the following sequence of expressions in the global environment:
; (define a (make-connector))
; (define b (make-connector))
; (set-value! a 10 'user)
; At some time during evaluation of the set-value!, the following expression from the connector's local
; procedure is evaluated:
; (for-each-except setter inform-about-value constraints)
; Draw an environment diagram showing the environment in which the above expression is evaluated.



; Answer:

; 1)
; global environment
; ---------------------
; | for-each-except   |
; | make-connector    |
; | a                 |
; | b                 |
; ---------------------

; 2) (set-value! a 10 'user)

; global environment
; ---------------------
; | for-each-except   |
; | make-connector    |
; | a                 | -> E1: (for-each-except 'user inform-about-value '())
; | b                 |
; ---------------------

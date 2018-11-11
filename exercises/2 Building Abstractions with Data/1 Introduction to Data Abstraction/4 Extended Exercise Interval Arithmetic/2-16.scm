#lang sicp
(#%require "../../helpers/interval.scm")

;; Explain, in general, why equivalent algebraic expressions may lead to different answers.
;; Can you devise an interval-arithmetic package that does not have this shortcoming, or 
;; is this task impossible? (Warning: This problem is very difficult.)

;; Answer:
;; Equivalent algebraic expressions may lead to different answers when they are applied
;; to intervals because of their uncertainty.


(define test-a-interval (make-center-percent 4 0.01))
(define test-b-interval (make-center-percent 3 0.01))

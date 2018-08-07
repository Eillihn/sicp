#lang sicp

;; Ben Bitdiddle has invented a test to determine whether the interpreter 
;; he is faced with is using applicative-order evaluation or normal-order 
;; evaluation. He defines the following two procedures:
(define (p) (p))
(define (test x y)
    (if (= x 0)
        0
        y))
;; Then he evaluates the expression
(test 0 (p))
;; 1) What behavior will Ben observe with an interpreter that uses 
;; applicative-order evaluation? 
;; 2) What behavior will he observe with an interpreter that uses 
;; normal-order evaluation? Explain your answer.
;; (Assume that the evaluation rule for the special form if is the same 
;; whether the interpreter is using normal or applicative order: 
;; The predicate expression is evaluated first, and the result determines 
;; whether to evaluate the consequent or the alternative expression.)



;; Answer:
;; Using applicative-order evaluation, the expression never terminates ( (p) is infinitely 
;; (test 0 (p))
;; (test 0 (p))
;; ....
;; (test 0 (p))

;; Using normal-order evaluation, the expression evaluates to 0:
;; (test 0 (p))
;; (if (= x 0) 0 (p))
;; (if #t 0 (p))
;; 0

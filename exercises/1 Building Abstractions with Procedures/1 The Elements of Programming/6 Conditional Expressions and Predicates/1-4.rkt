#lang sicp

;; Observe that our model of evaluation allows for combinations 
;; whose operators are compound expressions. Use this observation 
;; to describe the behavior of the following procedure:
(define (a-plus-abs-b a b)
        ((if (> b 0) + -) a b))



;; Answer:
;; (a + |b|) - value of a plus absolute value of b:
(a-plus-abs-b 2 3)          ;5
(a-plus-abs-b 2 -3)         ;5
(a-plus-abs-b -2 3)         ;1
(a-plus-abs-b -2 -3)        ;1
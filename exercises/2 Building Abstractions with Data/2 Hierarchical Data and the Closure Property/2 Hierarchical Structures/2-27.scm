#lang sicp

;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure 
;; that takes a list as argument and returns as its value the list with its elements 
;; reversed and with all sublists deep-reversed as well. For example,
(define x (list (list 1 2) (list 3 4)))
;; x
;; ((1 2) (3 4))
;; (reverse x)
;; ((3 4) (1 2))
;; (deep-reverse x)
;; ((4 3) (2 1))

(define (reverse a)
    (define (iter a result)
        (if (null? a)
            result
            (iter (cdr a) (cons (car a) result))))
    (iter a nil))

(define (deep-reverse a)
    (define (iter a result)
        (if (pair? a)
            (iter (cdr a) (cons (reverse (car a)) result))
            result))
    (iter a nil))



;; Test code:
(reverse x)
(deep-reverse x)

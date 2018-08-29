#lang sicp
(#%require "../../../helpers/base.scm")

;; Louis Reasoner tries to rewrite the first square-list procedure of exercise 2.21 so 
;; that it evolves an iterative process:

(define (square-list-iter items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter   (cdr things)
                    (cons   (square (car things))
                            answer))))
    (iter items nil))

;; Unfortunately, defining square-list this way produces the answer list in the reverse 
;; order of the one desired. Why?

;; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list-iter-fix items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter   (cdr things)
                    (cons   answer
                            (square (car things))))))
    (iter items nil))

;; This doesn't work either. Explain.



;; Answer:
(square-list-iter (list 1 2 3 4))
;; The solution above start filling list from the last item of the entire list.
(square-list-iter-fix (list 1 2 3 4))
;; This solution put list to the car position of list, so lists values are lists 
;; themselves, not squared items.

#lang sicp

;; Write a procedure fringe that takes as argument a tree (represented as a list) and 
;; returns a list whose elements are all the leaves of the tree arranged in 
;; left-to-right order. For example,
(define x (list (list 1 2) (list 3 4)))
;; (fringe x)
;; (1 2 3 4)
;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)


(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

(define (fringe a)
    (cond   ((null? a) nil)
            ((and (pair? a) (pair? (car a))(pair? (cdr a)))
                (append (fringe (car a)) (fringe (cdr a))))
            ((and (pair? a) (pair? (car a)))
                (append (fringe (car a)) (cdr a)))
            ((and (pair? a) (pair? (cdr a)))
                (append (list (car a)) (fringe (cdr a))))
            (else a)))
            
(fringe x)
(fringe (list x x))
(fringe (list 456 (list x) x 123))

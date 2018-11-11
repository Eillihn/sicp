#lang sicp
(#%require "../../helpers/tree.scm")

;; Use the results of exercises 2.63 and 2.64 to give (n) 
;; implementations of union-set and intersection-set for sets 
;; implemented as (balanced) binary trees.

(define (element-of-set? x set)
    (cond   ((null? set) false)
            ((equal? x (car set)) true)
            (else (element-of-set? x (cdr set)))))

(define (union-set-list set1 set2)
    (cond   ((null? set1) set2)
            ((null? set2) set1)
            (else (union-set-list (cdr set1) (cons (car set1) set2)))))

(define (adjoin-set x set) (cons x set))

(define (remove-element-of-set x set)
    (define (iter x set result)
        (cond   ((null? set) result)
                ((equal? x (car set)) (append result (cdr set)))
                (else (iter x (cdr set) (append result (car set))))))
    (iter x set '()))
    

(define (intersection-set-list set1 set2)
    (cond   ((or (null? set1) (null? set2)) '())
            ((element-of-set? (car set1) set2)
                (cons   (car set1)
                        (intersection-set-list (cdr set1) (remove-element-of-set (car set1) set2))))
            (else (intersection-set-list (cdr set1) set2))))



;; Answer:

(define (union-set tree1 tree2)
    (list->tree (union-set-list (tree->list tree1) (tree->list tree2))))

(define (intersection-set tree1 tree2)
    (list->tree (intersection-set-list (tree->list tree1) (tree->list tree2))))

(define t1 (list->tree (list 1 3 5 9)))
(define t2 (list->tree (list 3 9 11)))
(display (union-set t1 t2))
(display (intersection-set t1 t2))

#lang sicp

;; Abstract your answer to exercise 2.30 to produce a procedure tree-map with the 
;; property that square-tree could be defined as
;; (define (square-tree tree) (tree-map square tree))

(define (square x) (* x x))

(define (map proc items)
    (if (null? items)
        nil
        (cons (proc (car items)) (map proc (cdr items)))))

(define (tree-map proc tree)
    (map    (lambda (x)
                (cond   ((null? x) nil)
                        ((not (pair? x)) (proc x))
                        (else (tree-map proc x))))
            tree))

(define (square-tree tree) (tree-map square tree))

(square-tree
    (list   1
            (list 2 (list 3 4) 5)
            (list 6 7)))
#lang sicp

;; Implement the union-set operation for the unordered-list representation of sets.

(define (element-of-set? x set)
    (cond   ((null? set) false)
            ((equal? x (car set)) true)
            (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
    (cond   ((null? set1) set2)
            ((null? set2) set1)
            ((element-of-set? (car set1) set2)
                (union-set (cdr set1) set2))
            (else (union-set (cdr set1) (cons (car set1) set2)))))



;; Test code:
(display (union-set (list 1 2 3) (list 4 5 6)))
(newline)
(display (union-set (list 1 2 3) (list 3 4 5)))
(newline)
(display (union-set (list 1 2 3) '()))

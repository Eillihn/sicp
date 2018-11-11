#lang sicp

(define (element-of-set? x set)
    (cond   ((null? set) false)
            ((equal? x (car set)) true)
            (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
    (cond   ((null? set1) set2)
            ((null? set2) set1)
            (else (union-set (cdr set1) (cons (car set1) set2)))))

(define (adjoin-set x set) (cons x set))

(define (remove-element-of-set x set)
    (define (iter x set result)
        (cond   ((null? set) result)
                ((equal? x (car set)) (append result (cdr set)))
                (else (iter x (cdr set) (append result (car set))))))
    (iter x set '()))

(define (intersection-set set1 set2)
    (cond   ((or (null? set1) (null? set2)) '())
            ((element-of-set? (car set1) set2)
                (cons   (car set1)
                        (intersection-set (cdr set1) (remove-element-of-set (car set1) set2))))
            (else (intersection-set (cdr set1) set2))))

(#%provide (all-defined))
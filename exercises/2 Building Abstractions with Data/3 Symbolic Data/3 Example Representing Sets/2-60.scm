#lang sicp

;; We specified that a set would be represented as a list with no duplicates. 
;; Now suppose we allow duplicates. For instance, the set {1,2,3} could be represented 
;; as the list (2 3 2 1 3 2 2).
;; Design procedures element-of-set?, adjoin-set, union-set, and intersection-set that
;; operate on this representation. How does the efficiency of each compare with the 
;; corresponding procedure for the non-duplicate representation? Are there applications 
;; for which you would use this representation in preference to the non-duplicate one?

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


;; Test code:
(display (union-set (list 1 2 2 2 3) (list 4 4 5 6)))
(newline)
(display (intersection-set (list 1 2 3 3 3) (list 3 3 4 5)))
(newline)
(display (adjoin-set 123 (list 1 2 3 3)))

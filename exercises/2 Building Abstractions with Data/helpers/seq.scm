#lang sicp

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))


(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))

(define (filter predicate sequence)
    (cond   ((null? sequence) nil)
            ((predicate (car sequence))
                (cons (car sequence)
            (filter predicate (cdr sequence))))
            (else (filter predicate (cdr sequence)))))

(#%provide (all-defined))
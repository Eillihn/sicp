#lang sicp
(#%require "../../../helpers/prime.scm")

;; Define a procedure unique-pairs that, given an integer n, generates the sequence of
;; pairs (i,j) with 1<=j<=i<=n. Use unique-pairs to simplify the definition of 
;; prime-sum-pairs given above.

(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

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

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))



;; Answer:

(define (unique-pairs n)
    (flatmap
        (lambda (i)
            (map (lambda (j) (list i j))
                (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
    (map make-pair-sum
        (filter prime-sum?
                (unique-pairs n))))

(unique-pairs 5)
(prime-sum-pairs 5)

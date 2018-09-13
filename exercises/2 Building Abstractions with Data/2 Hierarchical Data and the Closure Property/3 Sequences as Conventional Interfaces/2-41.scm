#lang sicp

;; Write a procedure to find all ordered triples of distinct positive integers i, j, 
;; and k less than or equal to a given integer n that sum to a given integer s.

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



;; Answer:

(define (equals-sum? sum t)
    (= sum (+ (car t) (car (cdr t)) (car (cdr (cdr t))))))

(define (unique-triples n)
    (flatmap
        (lambda (i)
            (flatmap    (lambda (j)
                            (map    (lambda (k) (list i j k))
                                    (enumerate-interval 1 (- j 1))))
                        (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

(define (triples-sum-to s n)
    (filter (lambda (t) (equals-sum? s t))
            (unique-triples n)))

(unique-triples 5)
(triples-sum-to 9 5)

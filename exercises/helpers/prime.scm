#lang racket
(require "base.scm")

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
    (= n (smallest-divisor n)))

(provide (all-defined-out))
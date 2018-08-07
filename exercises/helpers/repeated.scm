#lang racket
(require "base.scm")

(define (compose f g)
    (lambda (x)
        (f (g x))))

(define (repeated f k)
    (define (iter a result)
        (if (> a k)
            result
            (iter (inc a) (compose f result))))
    (iter 2 f))

(provide (all-defined-out))
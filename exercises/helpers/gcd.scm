#lang racket
(require "base.scm")

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(provide (all-defined-out))
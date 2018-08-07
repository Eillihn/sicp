#lang racket
(require "base.scm")

(define (expt b n)
    (define (expt-iter b counter product)
        (cond   ((= counter 0) product)
                ((even? counter) (expt-iter (square b) (/ counter 2) product))
                (else (expt-iter b (- counter 1) (* product b)))))
    (expt-iter b n 1))


(provide (all-defined-out))
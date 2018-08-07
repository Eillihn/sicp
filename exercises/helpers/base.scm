#lang racket

(define (even? n) (= (remainder n 2) 0))

(define (divides? a b) (= (remainder b a) 0))

(define (square x) (* x x))

(define (cube x) (* (square x) x))

(define (double x) (+ x x))

(define (halve x) (/ x 2))

(define (identity x) x)

(define (inc x) (+ x 1))

(define (dec x) (- x 1))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (average x y) (/ (+ x y) 2))

(provide (all-defined-out))

#lang sicp

;; a. The sum procedure is only the simplest of a vast number of similar abstractions that 
;; can be captured as higher-order procedures. 
;; 1) Write an analogous procedure called product that returns the product of the values of 
;; a function at points over a given range. 
;; 2) Show how to define factorial in terms of product. 
;; 3) Also use product to compute approximations to using the formula

;; b. If your product procedure generates a recursive process, write one that generates an
;; iterative process. If it generates an iterative process, write one that generates a 
;; recursive process.

;; pi/4 = (2 * 4 * 4 * 6 * 6 * 8 * ...) / (3 * 3 * 5 * 5 * 7 * 7 * ...)

;; Answer:
;; a. 1) Iterative process

(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))

;; 2) Factorial

(define (identity x) x)

(define (factorial x)
    (product identity 1 inc x))

(factorial 5)                                           ; 120

;; 3) approximations to pi

(define (square x) (* x x))
(define (even? x) (= (remainder x 2) 0))

(define (pi-approx accuracy)
    (define (term-top n)
        (if (even? n)
            (+ 2 n)
            (+ 2 (- n 1))))
    (define (term-bottom n)
        (if (even? n)
            (+ 2 (- n 1))
            (+ 2 n)))
    (/  (product term-top 1 inc accuracy)
        (product term-bottom 1 inc accuracy)))

(* 4 (pi-approx 6))                                     ; 3 421/1225

;; b. Recursive process
(define (product-rec term a next b)
    (if (> a b)
        1
        (*  (term a)
            (product-rec term (next a) next b))))

(define (factorial-rec x)
    (product-rec identity 1 inc x))

(factorial-rec 5)                                       ; 120
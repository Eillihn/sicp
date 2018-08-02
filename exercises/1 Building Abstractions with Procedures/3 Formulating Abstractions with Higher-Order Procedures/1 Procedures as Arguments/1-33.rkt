#lang sicp

;; You can obtain an even more general version of accumulate (exercise 1.32) by
;; introducing the notion of a filter on the terms to be combined. That is, 
;; combine only those terms derived from values in the range that satisfy a 
;; specified condition. The resulting filtered-accumulate abstraction takes the 
;; same arguments as accumulate, together with an additional predicate of one argument
;; that specifies the filter. 

;; Write filtered-accumulate as a procedure. 
;; Show how to express the following using filtered-accumulate:
;; a. the sum of the squares of the prime numbers in the interval a to b (assuming that 
;; you have a prime? predicate already written)
;; b. the product of all the positive integers less than n that are relatively prime to 
;; n (i.e., all positive integers i < n such that GCD(i,n) = 1).

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
    (= (remainder b a) 0))

(define (prime? n)
    (= n (smallest-divisor n)))

(define (square n) (* n n))

(define (identity n) n)

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

;; Answer:
(define (filtered-accumulate filter combiner null-value term a next b)
    (define (filtered-combiner x result)
        (if (filter x)
            (combiner (term x) result)
            result))
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (filtered-combiner a result))))
    (iter a null-value))

;; a. The sum of the squares of the prime numbers in the interval a to b:

(define (sum-prime-squares a b)
    (filtered-accumulate prime? + 0 square a inc b))

(sum-prime-squares 1 10)            ; 88

;; b. The product of all the positive integers, i < n such that GCD(i,n) = 1:

(define (product-relative-primes a)
    (define (rel-gcd? b)
        (= (gcd a b) 1))
    (filtered-accumulate rel-gcd? * 1 identity 1 inc a))

(product-relative-primes 5)         ; 24
(product-relative-primes 6)         ; 5
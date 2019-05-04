#lang sicp

; In section 1.2.1 we used the substitution model to analyze two procedures for computing
; factorials, a recursive version

; (define (factorial n)
;     (if (= n 1)
;         1
;         (* n (factorial (- n 1)))))

; and an iterative version

; (define (factorial n)
;     (fact-iter 1 1 n))
; (define (fact-iter product counter max-count)
;     (if (> counter max-count)
;         product
;         (fact-iter  (* counter product)
;                     (+ counter 1)
;                     max-count)))

; Show the environment structures created by evaluating (factorial 6) using each version of the
; factorial procedure.
 


; 1. Recursive
;                 ----------------
; global env ->   | factorial:    |
;                 |    |          |
;                 |    V          |
;                 ----------------
;                 parameters: n
;                 body: (if (= n 1) 1 (* n (factorial (- n 1))))



; (factorial 6)
;                                                         global env
;                                                     -----------------
; E1                                              ->  |               |
; n: 6                                                |               |
; (factorial 6)                                       |               |
;                                                     |               |
; E2                                              ->  |               |
; n: 5                                                |               |
; (* 6 (factorial 5))                                 |               |
;                                                     |               |
; E3                                              ->  |               |
; n: 4                                                |               |
; (* 6 (* 5 (factorial 4)))                           |               |
;                                                     |               |
; E4                                              ->  |               |
; n: 3                                                |               |
; (* 6 (* 5 (* 4 (factorial 3))))                     |               |
;                                                     |               |
; E5                                              ->  |               |
; n: 2                                                |               |
; (* 6 (* 5 (* 4 (* 3 (factorial 2)))))               |               |
;                                                     |               |
; E6                                              ->  |               |
; n: 1                                                |               |
; (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))         |               |
;                                                     -----------------


; 2. Iterative
;                 ------------------------------------------------
; global env ->   | factorial:                    fact-iter:      |
;                 |    |                            |             |
;                 |    V                            V             |
;                 ------------------------------------------------
;                 parameters: n                   parameters: product counter max-count
;                 body: (fact-iter 1 1 n)         body: (if (> counter max-count) product (fact-iter  (* counter product) (+ counter 1) max-count)))
               
                

; (factorial 6)
;                                                         global env
;                                                     -----------------
; E1                                              ->  |               |
; n: 6                                                |               |
; (factorial 6)                                       |               |
;                                                     |               |
; E2                                              ->  |               |
; n: 6                                                |               |
; (fact-iter 1 1 6)                                   |               |
;                                                     |               |
; E3                                              ->  |               |
; product counter max-count:  1 1 6                   |               |
; (fact-iter  1 2 6)))                                |               |
;                                                     |               |
; E4                                              ->  |               |
; product counter max-count:  1 2 6                   |               |
; (fact-iter  2 3 6)))                                |               |
;                                                     |               |
; E5                                              ->  |               |
; product counter max-count:  2 3 6                   |               |
; (fact-iter  6 4 6)))                                |               |
;                                                     |               |
; E5                                              ->  |               |
; product counter max-count:  6 4 6                   |               |
; (fact-iter  24 5 6)))                               |               |
;                                                     |               |
; E6                                              ->  |               |
; product counter max-count:  24 5 6                  |               |
; (fact-iter  120 6 6)))                              |               |
;                                                     |               |
; E7                                              ->  |               |
; product counter max-count:  120 6 6                 |               |
; (fact-iter  720 7 6)))                              |               |
;                                                     |               |
; E8                                              ->  |               |
; product counter max-count:  720 7 6                 |               |
; 720                                                 |               |
;                                                     -----------------

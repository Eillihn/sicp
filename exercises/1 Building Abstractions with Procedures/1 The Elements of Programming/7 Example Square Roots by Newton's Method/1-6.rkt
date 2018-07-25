#lang sicp

;; Newton's method to get square root for x of successive approximations y

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter  (improve guess x)
                    x)))
(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (square x) (* x x))

;; Alyssa P. Hacker doesn't see why if needs to be provided as a special form.
;; ``Why can't I just define it as an ordinary procedure in terms of cond?'' she asks.
;; Alyssa's friend Eva Lu Ator claims this can indeed be done, 
;; and she defines a new version of if:
(define (new-if predicate then-clause else-clause)
    (cond   (predicate then-clause)
            (else else-clause)))
;; Eva demonstrates the program for Alyssa:
(new-if (= 2 3) 0 5)        ;5
(new-if (= 1 1) 0 5)        ;0
;; Delighted, Alyssa uses new-if to rewrite the square-root program:
(define (new-sqrt-iter guess x)
    (new-if (good-enough? guess x)
            guess
            (new-sqrt-iter  (improve guess x)
                        x)))
;; What happens when Alyssa attempts to use this to compute square roots? Explain.



;; Answer:
(define (new-sqrt x)
    (new-sqrt-iter 1.0 x))

;; (new-sqrt 9)

;; new-if (Scheme uses applicative order evaluation) evaluates to infinite recursion 
;; because the else clause is always evaluated, 
;; thus calling new-sqrt-iter infinite times.
;; If (and cond by themselves) first evaluates the predicate, 
;; and then evaluates either the consequent (the predicate is #t)
;; or the alternative (the predicate is #f). 
;; If we use if or cond without wrapper it inside procedure new-if - 
;; it'll still work as expected.

#lang sicp

;; Prove that Fib(n) is the closest integer to φ^n/√5, where φ = (1 + √5)/2. 
;; Hint: ψ = (1 - √5)/2. 
;; Use induction and the definition of the Fibonacci numbers 
;; to prove that Fib(n) = (φ^n - ψ^n) / √5.

;; Answer:

;; Golden ratio properties:
;; φ^2 = φ + 1
;; φ =  √(1 + √5)/2 + 1
;; 1/φ + 1 = φ
;; =>
;; ψ^2 = ψ + 1
;; 1/ψ + 1 = ψ

;; Induction:
;; 1) Fib(0) = (φ^0 - ψ^0) / √5 = (1 - 1) / √5 = 0;
;; 2) Fib(1) = (φ^1 - ψ^1) / √5 = (1 - 1) / √5 = 0;
;; 3) Fib(n + 1) = Fib(n) + Fib(n - 1) = 
;; = (φ^n - ψ^n) / √5 + (φ^(n-1) - ψ^(n-1)) / √5 =
;; = (φ^n - ψ^n + φ^(n-1) - ψ^(n-1)) / √5 =
;; = (φ^n + φ^(n-1) - ψ^n - ψ^(n-1)) / √5 =
;; = ((φ^n + φ^(n-1)) - (ψ^n + ψ^(n-1))) / √5 =
;; = (φ^n(1 + 1/φ) - ψ^n(1 + 1/ψ)) / √5 =
;; = [1/φ + 1 = φ] =
;; = (φ * φ^n - ψ * ψ^n ) / √5 =
;; = (φ^(n+1) - ψ^(n+1) / √5 = Fib(n + 1)

;; Procedure:
(define phi
    (/ (+ 1 (sqrt 5)) 2))

(define psi
    (/ (- 1 (sqrt 5)) 2))

(define (pow x n)
  (if   (= n 0)
        1
        (* x (pow x (- n 1)))))

(define (fib n)
    (/ (- (pow phi n) (pow psi n)) (sqrt 5)))

(fib 1)         ; 1
(fib 2)         ; 1
(fib 3)         ; 2
(fib 4)         ; 3
(fib 5)         ; 5
(fib 6)         ; 8
(fib 7)         ; 13
(fib 8)         ; 21

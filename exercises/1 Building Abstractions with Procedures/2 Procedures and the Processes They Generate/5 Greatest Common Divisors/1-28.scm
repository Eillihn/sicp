#lang sicp
(#%require (lib "27.ss" "srfi"))

;; One variant of the Fermat test that cannot be fooled is called the Miller-Rabin test. 
;; This starts from an alternate form of Fermat's Little Theorem, which states that 
;; if n is a prime number and a is any positive integer less than n, then a raised 
;; to the (n - 1)st power is congruent to 1 modulo n. 

;; To test the primality of a number n by the Miller-Rabin test, we pick a random number 
;; a < n and raise a to the (n - 1)st power modulo n using the expmod procedure. 
;; However, whenever we perform the squaring step in expmod, we check to see if we have 
;; discovered a ``nontrivial square root of 1 modulo n,'' that is, a number not equal 
;; to 1 or n - 1 whose square is equal to 1 modulo n. 

;; It is possible to prove that if such a nontrivial square root of 1 exists, then n is 
;; not prime. It is also possible to prove that if n is an odd number that is not prime, 
;; then, for at least half the numbers a<n, computing a^(n-1) in this way will reveal a 
;; nontrivial square root of 1 modulo n. (This is why the Miller-Rabin test cannot be 
;; fooled.) 

;; 1) Modify the expmod procedure to signal if it discovers a nontrivial square root of 1, 
;; and use this to implement the Miller-Rabin test with a procedure analogous to 
;; fermat-test. 
;; 2) Check your procedure by testing various known primes and non-primes. 
;; Hint: One convenient way to make expmod signal is to have it return 0.



;; Answer:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
            (let ((tmp (expmod base (/ exp 2) m)))
            (if (non-trivial-sqrt tmp m)
                0
                (remainder   (square tmp)
                                m))))
        (else
            (let ((tmp (expmod base (- exp 1) m)))
            (if (non-trivial-sqrt tmp m)
                0
                (remainder  (* base tmp)
                            m))))))

(define (non-trivial-sqrt n m) 
  (cond ((= n 1) false) 
        ((= n (- m 1)) false) 
        (else (= (remainder (square n) m) 1))))
  
 (define (miller-rabin-test a n) 
   (cond ((= a 0) true) 
         ((= (expmod a (- n 1) n) 1) true) 
         (else false)))

(define (miller-rabin n) 
   (miller-rabin-test (+ 1 (random (- n 1))) n))

(define (square n) (* n n))

(miller-rabin 8)
(miller-rabin 561)
(miller-rabin 56)
(miller-rabin 3)
(miller-rabin 13)
(miller-rabin 17)

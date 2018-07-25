#lang sicp
(#%require (lib "27.ss" "srfi"))

;; Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime? (the Fermat method), 
;; and test each of the 12 primes you found in that exercise. 
;; Since the Fermat test has O(log n) growth, how would you expect the time to test primes near 
;; 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this 
;; out? Can you explain any discrepancy you find?



;; Answer:

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (fast-prime? n 100)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (fast-prime? n times)
    (cond   ((= times 0) true)
            ((fermat-test n) (fast-prime? n (- times 1)))
            (else false)))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random-integer (- n 1)))))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
        ((even? exp)
            (remainder (square (expmod base (/ exp 2) m))
                        m))
        (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))

(define (square n) (* n n))

(define (search-for-primes a b)
    (timed-prime-test a)
    (cond ((< a b) (search-for-primes (+ a 1) b))))

(search-for-primes 1000 1020)
(search-for-primes 10000 10038)
(search-for-primes 100000 100044)
(search-for-primes 1000000 1000038)
(search-for-primes 10000000 10000104)
(search-for-primes 100000000 100000040)
(search-for-primes 1000000000 1000000022)
(search-for-primes 10000000000 10000000061)

;; 1009 *** 1000
;; 1013 *** 0
;; 1019 *** 0
;; 10007 *** 0
;; 10009 *** 0
;; 10037 *** 0
;; 100003 *** 0
;; 100019 *** 0
;; 100043 *** 0
;; 1000003 *** 1001
;; 1000033 *** 0
;; 1000037 *** 0
;; 10000019 *** 0
;; 10000079 *** 1000
;; 10000103 *** 0
;; 100000007 *** 1001
;; 100000037 *** 0
;; 100000039 *** 1001
;; 1000000007 *** 1000
;; 1000000009 *** 0
;; 1000000021 *** 0
;; 10000000019 *** 2001
;; 10000000033 *** 1001
;; 10000000061 *** 2001

;; Expectation about “to run twice as fast” was confirmed.

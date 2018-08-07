#lang sicp
(#%require (lib "27.ss" "srfi"))

;; Alyssa P. Hacker complains that we went to a lot of extra work in writing expmod. 
;; After all, she says, since we already know how to compute exponentials, we could have simply written
;; (define (expmod base exp m)
;;     (remainder (fast-expt base exp) m))
;; Is she correct? Would this procedure serve as well for our fast prime tester? Explain.



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
    (remainder (fast-expt base exp) m))

(define (fast-expt b n)
    (cond   ((= n 0) 1)
            ((even? n) (square (fast-expt b (/ n 2))))
            (else (* b (fast-expt b (- n 1))))))

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

;; 1009 *** 1006
;; 1013 *** 1001
;; 1019 *** 2001
;; 10007 *** 94080
;; 10009 *** 70192
;; 10037 *** 68062
;; 100003 *** 2813639
;; 100019 *** 2979608
;; 100043 *** 2949436
;; 1000003 *** 110135532
;; 1000033 *** 113420339
;; ...

;; Changes caused significant increase of execution time because they contain 
;; frequent call of square calculation, because lack of reminder procedure
;; which alternates with a call square in previous variation.

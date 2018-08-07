#lang sicp

;; Most Lisp implementations include a primitive called runtime that returns an integer
;; that specifies the amount of time the system has been running
;; (measured, for example, in microseconds). The following timed-prime-test procedure,
;; when called with an integer n, prints n and checks to see if n is prime.
;; If n is prime, the procedure prints three asterisks followed by the amount of time
;; used in performing the test.

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

;; Using this procedure, write a procedure search-for-primes that checks the primality
;; of consecutive odd integers in a specified range. Use your procedure to find the three
;; smallest primes larger than 1000; larger than 10,000; larger than 100,000;
;; larger than 1,000,000.

;; Note the time needed to test each prime.
;; Since the testing algorithm has order of growth of O(√n), you should expect that
;; testing for primes around 10,000 should take about √10 times as long as testing for
;; primes around 1000.
;; 1) Do your timing data bear this out? How well do the data for 100,000 and 1,000,000
;; support the n prediction?
;; 2) Is your result compatible with the notion that programs on your machine run in time
;; proportional to the number of steps required for the computation?

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

;; 1009 *** 0
;; 1013 *** 0
;; 1019 *** 0
;; 10007 *** 0
;; 10009 *** 0
;; 10037 *** 0
;; 100003 *** 0
;; 100019 *** 0
;; 100043 *** 0
;; 1000003 *** 0
;; 1000033 *** 0
;; 1000037 *** 502
;; 10000019 *** 0
;; 10000079 *** 0
;; 10000103 *** 0
;; 100000007 *** 1001
;; 100000037 *** 1014
;; 100000039 *** 1006
;; 1000000007 *** 2484
;; 1000000009 *** 2001
;; 1000000021 *** 2501
;; 10000000019 *** 8005
;; 10000000033 *** 8023
;; 10000000061 *** 7988



;; Answer:

;; Timing data for primes numbers less than 100 000 000 is not useful.
;; Other data shows that 10 increase in number leads to ~3 increase of runtime, 
;; e.g. 1000000009 *** 2001 and 10000000019 *** 8005.

;; Since the testing algorithm has order of growth of O(√n), 
;; if we have 10 increase in number than
;; O(√10 * n) = O(√10 * √n) = O(3√n) = 3 * O(√n)

;; So, timing results prove that programs run in time 
;; proportional to the number of steps required for the computation.

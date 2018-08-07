#lang sicp

;; The smallest-divisor procedure shown at the start of this section does lots of needless testing: 
;; After it checks to see if the number is divisible by 2 there is no point in checking to see 
;; if it is divisible by any larger even numbers. This suggests that the values used for test-divisor 
;; should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, .... 
;; To implement this change, define a procedure "next" that returns 3 if its input is equal to 2 
;; and otherwise returns its input plus 2. 
;; 1) Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1). 
;; 2) With timed-prime-test incorporating this modified version of smallest-divisor, run the test for 
;; each of the 12 primes found in exercise 1.22. 
;; 3) Since this modification halves the number of test steps, you should expect it to run about 
;; twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of 
;; the two algorithms, and how do you explain the fact that it is different from 2?

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

(define (smallest-divisor n)
    (find-divisor n 2))
(define (find-divisor n test-divisor)
    (cond   ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (next test-divisor)))))

(define (next divisor)
    (if  (= divisor 2)
        (+ divisor 1)
        (+ divisor 2)))

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
;; 1000037 *** 1002
;; 10000019 *** 0
;; 10000079 *** 0
;; 10000103 *** 0
;; 100000007 *** 502
;; 100000037 *** 501
;; 100000039 *** 100
;; 1000000007 *** 1500
;; 1000000009 *** 1000
;; 1000000021 *** 1501
;; 10000000019 *** 4005
;; 10000000033 *** 5003
;; 10000000061 *** 4003



;; Answer:
; Expectation about “to run twice as fast” was confirmed.

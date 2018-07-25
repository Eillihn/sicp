#lang sicp
(#%require (lib "27.ss" "srfi"))

;; Louis Reasoner is having great difficulty doing exercise 1.24. His fast-prime? test seems to run 
;; more slowly than his prime? test. Louis calls his friend Eva Lu Ator over to help. When they 
;; examine Louis's code, they find that he has rewritten the expmod procedure to use an explicit 
;; multiplication, rather than calling square:
;; (define (expmod base exp m)
;;     (cond   ((= exp 0) 1)
;;             ((even? exp) (remainder (* (expmod base (/ exp 2) m)
;;                                         (expmod base (/ exp 2) m))
;;                                     m))
;;             (else (remainder    (* base (expmod base (- exp 1) m)) 
;;                                 m))))
;; ``I don't see what difference that could make,'' says Louis. ``I do.'' says Eva. 
;; ``By writing the procedure like that, you have transformed the (log n) process into a (n) process.'' 
;; Explain.



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
            (remainder (* (expmod base (/ exp 2) m) (expmod base (/ exp 2) m))
                        m))
        (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))

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

;; 1009 *** 11004
;; 1013 *** 11007
;; 1019 *** 11004
;; 10007 *** 144116
;; 10009 *** 148155
;; 10037 *** 168980
;; 100003 *** 3634636
;; 100019 *** 2695012
;; 100043 *** 1388612
;; 1000003 *** 11234393
;; 1000033 *** 10836592
;; ...

;; Instead of a linear recursion, the rewritten expmod generates a tree recursion, 
;; whose execution time grows exponentially with the depth of the tree, which is 
;; the logarithm of N. Therefore, the execution time is linear with N.

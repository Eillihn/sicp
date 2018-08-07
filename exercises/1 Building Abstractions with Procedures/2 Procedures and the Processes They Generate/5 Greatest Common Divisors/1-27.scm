#lang sicp

;; Demonstrate that the Carmichael numbers listed in footnote 47 really do fool 
;; the Fermat test. That is, write a procedure that takes an integer n and tests 
;; whether an is congruent to a modulo n for every a<n, and try your procedure 
;; on the given Carmichael numbers.



;; Answer:

(define (expmod base exp m)
    (cond   ((= exp 0) 1)
            ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                    m))
            (else (remainder    (* base (expmod base (- exp 1) m))
                                m))))

(define (carmichel-test n) 
    (define (iter a n) 
        (cond   ((and (= (expmod a n n ) a) (< a n)) (iter (+ a 1) n)) 
                ((= a n) #t) 
                (else #f))) 
    (iter 1 n)) 

(define (square n) (* n n))

;; Carmichel numbers:
(carmichel-test 561) 
(carmichel-test 1105) 
(carmichel-test 1729) 
(carmichel-test 2465) 
(carmichel-test 2821) 
(carmichel-test 6601)

;; Not Carmichel numbers:
(carmichel-test 22) 
(carmichel-test 30)
(carmichel-test 12)

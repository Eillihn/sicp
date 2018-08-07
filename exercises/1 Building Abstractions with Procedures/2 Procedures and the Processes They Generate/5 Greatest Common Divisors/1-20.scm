#lang sicp

;; The process that a procedure generates is of course dependent on the rules used by the interpreter. 
;; As an example, consider the iterative gcd procedure.
(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
;; Suppose we were to interpret this procedure using normal-order evaluation 
;; (delaying evaluation of procedure arguments until the last possible moment 
;; (e.g., until they are required by a primitive operation), that is named as lazy evaluation) 
;; Using the substitution method (for normal order), illustrate the process generated 
;; in evaluating (gcd 206 40) and indicate the remainder operations that are actually performed. 
;; How many remainder operations are actually performed in the normal order evaluation of (gcd 206 40)?
;; In the applicative-order evaluation?



;; Answer:

;; 1) Applicative-order:
(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2)
(gcd 2 0) 
;; Total: 4 calls of reminder

;; 2) Normal-order:
(gcd 206 40)
(gcd 40 (remainder 206 40))
;; calc (remainder 206 40) = 6 for if condition - +1 call
(gcd    (remainder 206 40) 
        (remainder 40 (remainder 206 40))) 
;; calc (remainder 40 (remainder 206 40)) = 4 for if condition - +2 calls
(gcd    (remainder 40 (remainder 206 40)) 
        (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 
;; calc (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) = 2 - +4 calls

(gcd    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
        (remainder  (remainder 40 (remainder 206 40)) 
                    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;; calc (remainder (remainder 40 (remainder 206 40)) 
;; (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) = 0 - +7 calls
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;; +4 calls
;; Total:  18 calls of reminder.


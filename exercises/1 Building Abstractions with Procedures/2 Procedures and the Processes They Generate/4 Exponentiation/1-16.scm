#lang sicp

;; Design a procedure that evolves an iterative exponentiation process
;; that uses successive squaring and uses a logarithmic number of steps,
;; as does fast-expt.

;; (Hint:
;; Using the observation that (b^(n/2)^2 = (b^2)^(n/2), keep,
;; along with the exponent n and the base b,
;; an additional state variable a, and define the state transformation
;; in such a way that the product ab^n is unchanged from state to state.
;; At the beginning of the process a is taken to be 1, and the answer is given
;; by the value of a at the end of the process.
;; In general, the technique of defining an invariant quantity that remains
;; unchanged from state to state is a powerful way to think about the design
;; of iterative algorithms.)

(define (fast-expt b n)
    (fast-expt-iter b n 1))

(define (fast-expt-iter b counter product)
    (cond   ((= counter 0) product)
            ((even? counter) (fast-expt-iter (square b) (/ counter 2) product))
            (else (fast-expt-iter b (- counter 1) (* product b)))))

(define (even? n)
    (= (remainder n 2) 0))

(define (square n)
    (* n n))

(fast-expt 2 0)
(fast-expt 2 1)
(fast-expt 2 2)
(fast-expt 2 4)
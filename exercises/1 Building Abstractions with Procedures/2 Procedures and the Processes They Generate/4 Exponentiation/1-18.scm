#lang sicp

;; Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative
;; process for multiplying two integers in terms of adding, doubling,
;; and halving and uses a logarithmic number of steps.



;; Answer:
(define (mult a b)
    (mult-iter a b 0))

(define (mult-iter a counter product)
    (cond   ((= counter 0)      product)
            ((< a counter)      (mult-iter  a
                                            (- counter a)
                                            (+ product (square a))))
            ((even? counter)    (mult-iter  (double a)
                                            (halve counter)
                                            product))
            (else               (mult-iter  (double a)
                                            (halve (- counter 1))
                                            (+ product a)))))

(define (even? n)
    (= (remainder n 2) 0))

(define (square n)
    (* n n))

(define (double x) (+ x x))

(define (halve x) (/ x 2))

(mult 2 0)
(mult 2 10)
(mult 3 1)
(mult 2 2)
(mult 3 5)
(mult 4 10)

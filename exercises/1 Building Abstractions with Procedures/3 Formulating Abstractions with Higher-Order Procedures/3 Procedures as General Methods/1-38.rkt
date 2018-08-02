#lang sicp

;; In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus
;; Continuis, which included a continued fraction expansion for e - 2, where e is the 
;; base of the natural logarithms. In this fraction, the Ni are all 1, and the Di are 
;; successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... 
;; Write a program that uses your cont-frac procedure from exercise 1.37 to 
;; approximate e, based on Euler's expansion.

(define (cont-frac n d k)
    (define (frac i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i)
                (+  (d i) 
                    (frac (inc i))))))
    (frac 1))

(define (cont-frac-euler accuracy)
    (cont-frac  (lambda (i) 1)
                (lambda (i)
                    (if (= (remainder i 3) 2)
                        (* 2 (/ (+ i 1) 3))
                        1))
                accuracy))


(define (e-approx accuracy)
    (+  2 (cont-frac-euler accuracy)))

(e-approx 100)

#lang sicp

;; A continued fraction representation of the tangent function was published in 1770 
;; by the German mathematician J.H. Lambert:
;;                r
;; tan r = ---------------
;;                 r^2
;;         1 - -----------
;;                   r^2
;;             3 - -------
;;                
;;                 5 - ...
;; where x is in radians. 
;; Define a procedure (tan-cf x k) that computes an approximation to the tangent 
;; function based on Lambert's formula. K specifies the number of terms to compute, 
;; as in exercise 1.37.

(define (cont-frac n d k)
    (define (frac i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i)
                (+  (d i) 
                    (frac (inc i))))))
    (frac 1))

(define (square x) (* x x))

(define (tan-cf x k)
    (cont-frac  (lambda (i)
                    (if (= i 1)
                        x
                        (- 0 (square x))))
                (lambda (i) (+ i (- i 1)))
                k))

(tan-cf 1 5)                ; 1 301/540

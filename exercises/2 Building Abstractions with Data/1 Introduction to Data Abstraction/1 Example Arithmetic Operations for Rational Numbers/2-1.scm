#lang sicp
(#%require "../../../helpers/gcd.scm")

;; Define a better version of make-rat that handles both positive and negative arguments.
;; Make-rat should normalize the sign so that if the rational number is positive, both 
;; the numerator and denominator are positive, and if the rational number is negative, 
;; only the numerator is negative.

(define (make-rat n d)
    (let ((g ((if (< (/ n d) 0) - +)(gcd n d))))
        (cons (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

(print-rat (make-rat -1 2))             ; -1/2
(print-rat (make-rat 1 -2))             ; -1/2
(print-rat (make-rat -1 -2))            ; 1/2
(print-rat (make-rat 1 2))              ; 1/2
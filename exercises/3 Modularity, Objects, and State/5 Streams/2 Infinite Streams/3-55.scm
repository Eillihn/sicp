#lang sicp
(#%require "../../../helpers/stream.scm")

(define (add-streams s1 s2)
    (stream-map + s1 s2))
(define integers (cons-stream 1 (add-streams ones integers)))
(define ones (cons-stream 1 ones))

; Define a procedure partial-sums that takes as argument a stream S and returns the
; stream whose elements are S0, S0 + S1, S0 + S1 + S2, .... For example, (partial-sums integers)
; should be the stream 1, 3, 6, 10, 15, ....



(define (partial-sums s)
    (cons-stream (stream-car s) (add-streams (stream-cdr s) (partial-sums s))))


; Test:
(do ((i 0 (+ i 1)))
    ((= i 5))
    (newline)
    (display (stream-ref (partial-sums integers) i)))

#lang sicp
(#%require "../../../helpers/stream.scm")

; Give an interpretation of the stream computed by the following procedure:

(define (expand num den radix)
    (cons-stream
        (quotient (* num radix) den)
        (expand (remainder (* num radix) den) den radix)))

; (Quotient is a primitive that returns the integer quotient of two integers.) What are the successive
; elements produced by (expand 1 7 10) ? What is produced by (expand 3 8 10) ?

; Answer:
; This is the decimal fraction of the division result (num / den) with radix as the base.

; Test:
(display "(expand 1 7 10):")
(do ((i 0 (+ i 1)))
    ((= i 10))
    (newline)
    (display (stream-ref (expand 1 7 10) i)))
(display "(expand 3 8 10):")
(do ((i 0 (+ i 1)))
    ((= i 10))
    (newline)
    (display (stream-ref (expand 3 8 10) i)))

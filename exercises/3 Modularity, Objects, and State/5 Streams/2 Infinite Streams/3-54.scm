#lang sicp
(#%require "../../../helpers/stream.scm")

(define (add-streams s1 s2)
    (stream-map + s1 s2))
(define integers (cons-stream 1 (add-streams ones integers)))
(define ones (cons-stream 1 ones))

; Define a procedure mul-streams, analogous to add-streams, that produces the
; elementwise product of its two input streams. Use this together with the stream of integers to complete
; the following definition of the stream whose nth element (counting from 0) is n + 1 factorial:
; (define factorials (cons-stream 1 (mul-streams <??> <??>)))



(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define factorials (cons-stream 1 (mul-streams (add-streams ones integers) factorials)))

; Test:
(stream-ref factorials 5)

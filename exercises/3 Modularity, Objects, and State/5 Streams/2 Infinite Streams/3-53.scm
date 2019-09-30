#lang sicp
(#%require "../../../helpers/stream.scm")

(define (add-streams s1 s2)
    (stream-map + s1 s2))

; Without running the program, describe the elements of the stream defined by
(define s (cons-stream 1 (add-streams s s)))



; Answer:
; 0 - (1 delayed)
; 1 - (1 (add-streams 1 1)) -> (1 2 delayed) 
; 2 - (1 2 (add-streams 2 2)) -> (1 2 4 delayed) 
; 3 - (1 2 4 (add-streams 4 4)) -> (1 2 4 8 delayed)
; ...
; s(1) = 1
; s(n) = s(n-1) + s(n-1)

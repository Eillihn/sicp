#lang sicp
(#%require "../../../helpers/stream.scm")

; Consider the sequence of expressions

(define sum 0)
(define (accum x)
    (set! sum (+ x sum))
    sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                        seq))
(stream-ref y 7)
(display-stream z)

; What is the value of sum after each of the above expressions is evaluated? What is the printed response to
; evaluating the stream-ref and display-stream expressions? Would these responses differ if we
; had implemented (delay <exp>) simply as (lambda () <exp>) without using the optimization
; provided by memo-proc ? Explain.



; Answer:
; 1) The value of sum after each of the above expressions is evaluated
; - define accum - sum = 0
; - define seq - sum = 1
; - define y - sum = 6
; - define z - sum = 10
; - call stream-ref - sum = 136
; - call display-stream - sum = 210

; 2) The printed response to evaluating the stream-ref and display-stream expressions:
; stream-ref - 136
; and display-stream:
; 10
; 15
; 45
; 55
; 105
; 120
; 190
; 210'done

; 3) Would these responses differ if we had implemented (delay <exp>) simply as (lambda () <exp>) 
; without using the optimization provided by memo-proc ? Explain.
; - define accum - sum = 0
; - define seq - sum = 1
; - define y - sum = 6
; - define z - sum = 15
; - call stream-ref - sum = 162
; - call display-stream - sum = 362

; stream-ref - 162
; and display-stream:
; 15
; 180
; 230
; 305'done
; This happens because calculations are not memorised, so after each call of stream-cdr 
; recalculation of all previous results happens and sum is increased.

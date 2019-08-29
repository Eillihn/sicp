#lang sicp

; Which of the five possibilities in the parallel execution shown above remain if we instead
; serialize execution as follows:

; (define x 10)
; (define s (make-serializer))
; (parallel-execute   (lambda () (set! x ((s (lambda () (* x x))))))
;                     (s (lambda () (set! x (+ x 1)))))



; Answer:
; 101: P1 sets x to 100 and then P2 increments x to 101.
; 121: P2 increments x to 11 and then P1 sets x to x times x.
; 110: P2 changes x from 10 to 11 between the two times that P1 accesses the value of x during the
; evaluation of (* x x).
; 100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.

#lang sicp

; Give all possible values of x that can result from executing
; (define x 10)
; (parallel-execute   (lambda () (set! x (* x x)))
;                     (lambda () (set! x (* x x x))))

; Which of these possibilities remain if we instead use serialized procedures:
; (define x 10)
; (define s (make-serializer))
; (parallel-execute   (s (lambda () (set! x (* x x))))
;                     (s (lambda () (set! x (* x x x)))))



; Answer:

; P1:
; 1. access x
; 2. calc (* x x)
; 3. set x

; P2:
; 1. access x
; 2. calc (* x x x)
; 3. set x

; 1000000: P1 sets x to 10 * 10 and then P2 increments x to 100 * 100 * 100.
; 1000000: P2 sets x to 10 * 10 * 10 and then P1 increments x to 1000 * 1000.
; 100: P1 access x, P2 ..., P1 set 100.
; 1000: P2 access x, P1 ..., P2 set 1000.

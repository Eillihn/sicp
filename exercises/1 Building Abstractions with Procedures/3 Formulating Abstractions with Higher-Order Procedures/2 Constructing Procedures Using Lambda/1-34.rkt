#lang sicp

(define (square x) (* x x))
;; Suppose we define the procedure

(define (f g) (g 2))

;; Then we have
(f square)                          ; 4
(f (lambda (z) (* z (+ z 1))))      ; 6
;; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? 
;; Explain.



;; Answer:
;; Error is occured, because procedure is expected as argument of f
;; but integer is given
;; (f f)
;; (f (f 2)) => error: 2 not a procedure
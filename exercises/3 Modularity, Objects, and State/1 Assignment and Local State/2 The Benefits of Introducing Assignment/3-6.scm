#lang sicp

; It is useful to be able to reset a random-number generator to produce a sequence starting
; from a given value. Design a new rand procedure that is called with an argument that is either the symbol
; generate or the symbol reset and behaves as follows: (rand 'generate) produces a new
; random number; ((rand 'reset) <new-value>) resets the internal state variable to the
; designated <new-value>. Thus, by resetting the state, one can generate repeatable sequences. These are
; very handy to have when testing and debugging programs that use random numbers.

(define random-init 0) 

(define rand 
    (let ((x random-init)) 
      (define (dispatch message) 
        (cond ((eq? message 'generate) 
                (begin (set! x (rand-update x)) 
                    x)) 
              ((eq? message 'reset) 
                (lambda (new-value) (set! x new-value))))) 
      dispatch)) 

(define (rand-update x) (+ x 1))
(rand 'generate)        ; 1 
(rand 'generate)        ; 2 
(rand 'generate)        ; 3 
((rand 'reset) 0)       ; 0 
(rand 'generate)        ; 1 
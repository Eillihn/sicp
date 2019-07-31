#lang sicp
(#%require "../../../helpers/digital-circuits.scm")

; Another way to construct an or-gate is as a compound digital logic device, built from andgates
; and inverters. Define a procedure or-gate that accomplishes this. What is the delay time of the orgate
; in terms of and-gate-delay and inverter-delay?


(define (or-gate a1 a2 output) 
    (let    ((w1 (make-wire))
            (w2 (make-wire))
            (w3 (make-wire)))
      (inverter a1 w1)
      (inverter a2 w2)
      (and-gate w1 w2 w3)
      (inverter w3 output)))



; Test code:
(define input-1 (make-wire))
(define input-2 (make-wire))
(define output (make-wire))
(probe 'input-1 input-1)
(probe 'input-2 input-2)
(probe 'output output)
(or-gate input-1 input-2 output)
(set-signal! input-1 0)
(propagate)
(set-signal! input-2 1)
(propagate)

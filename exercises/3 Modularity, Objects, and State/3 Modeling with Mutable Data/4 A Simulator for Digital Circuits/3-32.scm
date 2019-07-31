#lang sicp
(#%require "../../../helpers/digital-circuits.scm")

; The procedures to be run during each time segment of the agenda are kept in a queue.
; Thus, the procedures for each segment are called in the order in which they were added to the agenda (first
; in, first out). Explain why this order must be used. In particular, trace the behavior of an and-gate whose
; inputs change from 0,1 to 1,0 in the same segment and say how the behavior would differ if we stored a
; segment's procedures in an ordinary list, adding and removing procedures only at the front (last in, first
; out).



(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value
                (logical-and (get-signal a1) (get-signal a2))))
            (after-delay and-gate-delay
                (lambda ()
                    (set-signal! output new-value)))))
    
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

; LIFO propagate
(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (remove-first-agenda-item! the-agenda)
            (propagate)
            (first-item))))



; Test code:
(define input-1 (make-wire))
(define input-2 (make-wire))
(define output (make-wire))
(and-gate input-1 input-2 output)
(set-signal! input-2 1)
(propagate)
(set-signal! input-1 1)
(set-signal! input-2 0)
(propagate)
(get-signal output)



; Answer: 
; input: 0 1 -> (propagate) -> input: 1 0 -> (propagate)

; 1) (input 0 1) -> after-delay: (set-signal! output 0)
; 2) -> (propagate)
; 3) (input 1 1) -> after-delay: (set-signal! output 1)
; 4) (input 1 0) -> after-delay: (set-signal! output 0)
; 5) -> (propagate)

; LIFO: 5) -> 4) -> output 1
; FIFO: 4) -> 5) -> output 0

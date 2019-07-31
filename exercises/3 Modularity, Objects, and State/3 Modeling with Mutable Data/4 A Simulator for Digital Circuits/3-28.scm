#lang sicp
(#%require "../../../helpers/digital-circuits.scm")


; Define an or-gate as a primitive function box. Your or-gate constructor should be
; similar to and-gate.



(define (logical-or s1 s2)
    (cond   ((or (= s1 1) (= s2 1)) 1)
            ((and (= s1 0) (= s2 0)) 0)
            (else (error "Invalid signals" s1 s2))))

(define (or-gate a1 a2 output)
    (define (or-action-procedure)
        (let ((new-value
                (logical-or (get-signal a1) (get-signal a2))))
            (after-delay or-gate-delay
                (lambda ()
                    (set-signal! output new-value)))))
    (add-action! a1 or-action-procedure)
    (add-action! a2 or-action-procedure)
    'ok)



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

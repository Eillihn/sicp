#lang sicp
(#%require "../../../helpers/digital-circuits.scm")


; The internal procedure accept-action-procedure! defined in make-wire
; specifies that when a new action procedure is added to a wire, the procedure is immediately run. Explain
; why this initialization is necessary. In particular, trace through the half-adder example in the paragraphs
; above and say how the system's response would differ if we had defined accept-actionprocedure!
; as

; (define (accept-action-procedure! proc)
;     (set! action-procedures (cons proc action-procedures)))

(define (make-wire)
    (let ((signal-value 0) (action-procedures '()))
        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin  (set! signal-value new-value)
                    (call-each action-procedures))
                    'done))
        (define (accept-action-procedure! proc)
            (set! action-procedures (cons proc action-procedures))
            (proc)
            )
        (define (dispatch m)
            (cond   ((eq? m 'get-signal) signal-value)
                    ((eq? m 'set-signal!) set-my-signal!)
                    ((eq? m 'add-action!) accept-action-procedure!)
                    (else (error "Unknown operation -- WIRE" m))))
        dispatch))



; Test code:
(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(probe 'sum sum)
(probe 'carry carry)
(half-adder input-1 input-2 sum carry)
(set-signal! input-1 1)
(propagate)
(set-signal! input-2 1)
(propagate)



; Answer: 
; From the book "The simulation is driven by the procedure propagate, which operates on the-agenda, executing
; each procedure on the agenda in sequence.". New items are added to the the agenda only after after-delay is called,
; which is not happens if we remove (proc) from the accept-action-procedure!. So the agenda will be without half-adder
; actions at the end.

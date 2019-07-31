#lang sicp
(#%require "../../../helpers/digital-circuits.scm")

; Figure 3.27 shows a ripple-carry adder formed by stringing together n full-adders. This is
; the simplest form of parallel adder for adding two n-bit binary numbers. The inputs A1, A2, A3, ..., An
; and B1, B2, B3, ..., Bn are the two binary numbers to be added (each Ak and Bk is a 0 or a 1). The circuit
; generates S1, S2, S3, ..., Sn, the n bits of the sum, and C, the carry from the addition. Write a procedure
; ripple-carry-adder that generates this circuit. The procedure should take as arguments three lists
; of n wires each -- the Ak, the Bk, and the Sk -- and also another wire C. The major drawback of the ripplecarry
; adder is the need to wait for the carry signals to propagate. What is the delay needed to obtain the
; complete output from an n-bit ripple-carry adder, expressed in terms of the delays for and-gates, or-gates,
; and inverters?

(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire))
            (c1 (make-wire))
            (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)
        'ok))

(define (ripple-carry-adder a b c sum)
    (if (not (null? a)) 
        (let ((c-out (make-wire)))
            (full-adder (car a) (car b) c (car sum) c-out)
            (ripple-carry-adder (cdr a) (cdr b) c-out (cdr sum)))))

(define (make-list-wire signals) 
    (if (null? signals) 
        '() 
        (let ((new-wire (make-wire))) 
            (set-signal! new-wire (car signals)) 
            (cons new-wire (make-list-wire (cdr signals))))))

(define (print-signals wires) 
    (display (map (lambda (w) (get-signal w)) wires)))



; Test code:
(define input-1 (make-list-wire (list 0 0 1 0)))
(define input-2 (make-list-wire (list 1 0 1 0)))
(define sum (make-list-wire (list 0 0 0 0)))
(define carry (make-wire))


(ripple-carry-adder input-1 input-2 carry sum)

(propagate)
(print-signals sum)

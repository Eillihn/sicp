#lang sicp
(#%require "../../../helpers/base.scm")
(#%require "../../helpers/repeated.scm")
(#%require "../../helpers/fixed-point.scm")

;; We saw in section 1.3.3 that attempting to compute square roots by naively finding a 
;; fixed point of y -> x/y does not converge, and that this can be fixed by average 
;; damping. The same method works for finding cube roots as fixed points of the 
;; average-damped y -> x/y^2. 
;; Unfortunately, the process does not work for fourth roots -- a single average damp 
;; is not enough to make a fixed-point search for y -> x/y^3 converge. 
;; On the other hand, if we average damp twice (i.e., use the average damp of the average
;; damp of y -> x/y3) the fixed-point search does converge.
;; Do some experiments to determine how many average damps are required to compute nth 
;; roots as a fixed-point search based upon repeated average damping of y -> x/y^n-1. 
;; Use this to implement a simple procedure for computing nth roots using fixedpoint,
;; average-damp, and the repeated procedure of exercise 1.43. Assume that any arithmetic
;; operations you need are available as primitives.



;; Answer:
;; Experiments to determine how many average damps are required to compute nth 
;; roots as a fixed-point search based upon repeated average damping of y -> x/y^n-1:

;; (n-roots 2 1)        ; y^1   || average-damp 1 || x = 1.9999923706054687
;; (n-roots 4 2)        ; y^2   || average-damp 1 || x = 2.000000000000002
;; (n-roots 8 3)        ; y^3   || average-damp 1 || x = 1.9999981824788517
;; (n-roots 16 4)       ; y^4   || average-damp 2 || x = 2.0000000000021965
;; (n-roots 32 5)       ; y^5   || average-damp 2 || x = 2.000001512995761
;; (n-roots 64 6)       ; y^6   || average-damp 2 || x = 2.0000029334662086
;; (n-roots 128 7)      ; y^7   || average-damp 2 || x = 2.0000035538623377
;; (n-roots 256 8)      ; y^8   || average-damp 3 || x = 2.000000000003967
;; (n-roots 512 9)      ; y^9   || average-damp 3 || x = 1.9999997106840102
;; (n-roots 1024 10)    ; y^10  || average-damp 3 || x = 2.0000011830103324

;; So, from results we can see that required amount of average damping for 
;; y -> x/y^n-1 is x = log2 n

(define (log2 x) (/ (log x) (log 2)))

(define (n-roots x n)
    (fixed-point    ((repeated average-damp (floor (log2 n)))
                        (lambda (y)
                                (/ x (expt y (- n 1)))))
                    1.0))

(n-roots 1024 10)      ;2.0000011830103324

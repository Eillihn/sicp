#lang sicp
(#%require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; Right-split and up-split can be expressed as instances of a general splitting 
;; operation. Define a procedure split with the property that evaluating

;; (define right-split (split beside below))
;; (define up-split (split below beside))

;; produces procedures right-split and up-split with the same behaviors as the ones 
;; already defined.

(define (split func1 func2)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split func1 func2) painter (- n 1))))
                (func1 painter (func2 smaller smaller)))))
    )

(define right-split (split beside below))

(define up-split (split below beside))

(paint (right-split einstein 1))
(paint (up-split einstein 1))

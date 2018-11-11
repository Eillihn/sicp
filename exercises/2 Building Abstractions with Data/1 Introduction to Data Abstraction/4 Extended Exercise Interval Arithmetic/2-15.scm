#lang sicp
(#%require "../../helpers/interval.scm")

;; Eva Lu Ator, another user, has also noticed the different intervals computed by 
;; different but algebraically equivalent expressions. She says that a formula to 
;; compute with intervals using Alyssa's system will produce tighter error bounds if 
;; it can be written in such a form that no variable that represents an uncertain 
;; number is repeated. 
;; Thus, she says, par2 is a ``better'' program for parallel resistances than par1. 
;; Is she right? Why?

(define (par1 r1 r2)
    (div-interval   (mul-interval r1 r2)
                    (add-interval r1 r2)))
(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval   one
                        (add-interval   (div-interval one r1)
                                        (div-interval one r2)))))


;; Answer:

(define test-a-interval (make-center-percent 4 0.01))
(define test-b-interval (make-center-percent 3 0.01))

(eql-interval (par1 test-a-interval test-b-interval) (par2 test-a-interval test-b-interval))    ; #f
(eql-interval (par1 test-a-interval test-a-interval) (par2 test-a-interval test-a-interval))    ; #f

(print-interval (par1 test-a-interval test-b-interval))     ; [1.7137714971360007;1.7148000685782867]
(print-interval (par2 test-a-interval test-b-interval))     ; [1.7141142857142855;1.714457142857143]

(print-interval (par1 test-a-interval test-a-interval))     ; [1.9994000799920009;2.0006000800080006]
(print-interval (par2 test-a-interval test-a-interval))     ; [1.9998000000000002;2.0002]

;; Test code above shows that she is right - par2 shows more precise result.
;; This difference goes from tha fact that par2 uses intervals r1 and r2 only once in computation.

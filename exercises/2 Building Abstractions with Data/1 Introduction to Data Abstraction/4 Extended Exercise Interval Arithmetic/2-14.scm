#lang sicp
(#%require "../../../helpers/interval.scm")

;; After considerable work, Alyssa P. Hacker delivers her finished system. Several years
;; later, after she has forgotten all about it, she gets a frenzied call from an irate 
;; user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel 
;; resistors can be written in two algebraically equivalent ways:

;;  R1R2
;; -------
;; R1 + R2

;; and

;;      1
;; -----------
;; 1/R1 + 1/R2

(define (par1 r1 r2)
    (div-interval   (mul-interval r1 r2)
                    (add-interval r1 r2)))
(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval   one
                        (add-interval   (div-interval one r1)
                                        (div-interval one r2)))))

;; Lem complains that Alyssa's program gives different answers for the two ways of 
;; computing. 
;; This is a serious complaint.

;; Demonstrate that Lem is right. Investigate the behavior of the system on a variety of
;; arithmetic expressions. Make some intervals A and B, and use them in computing the 
;; expressions A/A and A/B. You will get the most insight by using intervals whose width 
;; is a small percentage of the center value. 
;; Examine the results of the computation in center-percent form (see exercise 2.12).



;; Answer:

(define test-a-interval (make-center-percent 4 0.01))
(define test-b-interval (make-center-percent 3 0.01))

(eql-interval (par1 test-a-interval test-b-interval) (par2 test-a-interval test-b-interval))    ; #f
(eql-interval (par1 test-a-interval test-a-interval) (par2 test-a-interval test-a-interval))    ; #f

(print-interval (par1 test-a-interval test-b-interval))     ; [1.7137714971360007;1.7148000685782867]
(print-interval (par2 test-a-interval test-b-interval))     ; [1.7141142857142855;1.714457142857143]

(print-interval (par1 test-a-interval test-a-interval))     ; [1.9994000799920009;2.0006000800080006]
(print-interval (par2 test-a-interval test-a-interval))     ; [1.9998000000000002;2.0002]

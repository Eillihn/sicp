#lang sicp
(#%require "../../../helpers/interval.scm")

;; Show that under the assumption of small percentage tolerances there is a simple 
;; formula for the approximate percentage tolerance of the product of two intervals in 
;; terms of the tolerances of the factors. You may simplify the problem by assuming that 
;; all numbers are positive. 



;; Answer:

;; (c1 +- w1) = c1 +- (c1p1 * 0.01) =  c1 * (1 +- p1 * 0.01)
;; (c2 +- w2) = c2 +- (c2p2 * 0.01) =  c2 * (1 +- p2 * 0.01)

;; (c1 +- w1) (c2 +- w2) =
;; = c1c2 +- (w1c2 + w2c1 + w1w2) =
;; = c1c2  +- (c1c2p1 * 0.01 + c1c2p2 * 0.01 + c1c2p1p2 * 0.0001) =
;; = c1c2 * (1 +- p1 * 0.01 +- p2 * 0.01 +- p1p2 * 0.0001)
;; = (if p1,p2 are too small) = c1c2 * (1 +- p1 * 0.01 +- p2 * 0.01)
;; => The approximate percentage tolerance of the product of two 
;; intervals equals to sum of their own percentage tolerance

; Test code:

(define test-a-interval (make-center-percent 4 0.001))
(define test-b-interval (make-center-percent 6 0.002))
(define test-interval (mul-interval test-a-interval test-b-interval))

(percent test-interval)    ; 0.002999999999397449
(center test-interval)     ; 24.0000000048
(width test-interval)      ; 0.0007199999999993878

#lang sicp
(#%require "../../helpers/fixed-point.scm")

;; Show that the golden ratio φ (section 1.2.2) is a fixed point of the transformation 
;; x -> 1 + 1/x, and use this fact to compute φ by means of the fixed-point procedure.

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)        ; 1.6180327868852458

#lang sicp

;; Here are two possible constructors for frames:
;; (define (make-frame origin edge1 edge2)
;;     (list origin edge1 edge2))
;; (define (make-frame origin edge1 edge2)
;;     (cons origin (cons edge1 edge2)))
;; For each constructor supply the appropriate selectors to produce an implementation for 
;; frames.

; (define (make-frame origin edge1 edge2)
;     (list origin edge1 edge2))
; (define (origin f) (car f))
; (define (first-edge f) (cadr f))
; (define (second-edge f) (caddr f))
    
(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))
(define (origin f) (car f))
(define (first-edge f) (car (cdr f)))
(define (second-edge f) (cdr (cdr f)))



;; Test code:
(define f (make-frame 1 2 3))
(origin f)
(first-edge f)
(second-edge f)

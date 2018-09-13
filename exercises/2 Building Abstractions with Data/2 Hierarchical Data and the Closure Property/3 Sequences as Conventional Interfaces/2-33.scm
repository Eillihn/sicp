#lang sicp

;; Fill in the missing expressions to complete the following definitions of some basic 
;; list manipulation operations as accumulations:
;; (define (map p sequence)
;;     (accumulate (lambda (x y) <??>) nil sequence))
;; (define (append seq1 seq2)
;;     (accumulate cons <??> <??>))
;; (define (length sequence)
;;     (accumulate <??> 0 sequence))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (square x) (* x x))



(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length sequence)
    (accumulate (lambda (x y) (+ y 1)) 0 sequence))



(map square (list 1 2 3 9 5 7))
(append (list 1 2 3) (list 9 5 7))
(length (list 1 2 3 9 5 7))

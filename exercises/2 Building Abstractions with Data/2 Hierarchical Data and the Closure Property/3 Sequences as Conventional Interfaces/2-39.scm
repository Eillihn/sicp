#lang sicp

;; Complete the following definitions of reverse (exercise 2.18) in terms of fold-right
;; and fold-left from exercise 2.38:
;; (define (reverse sequence)
;;     (fold-right (lambda (x y) <??>) nil sequence))
;; (define (reverse sequence)
;;     (fold-left (lambda (x y) <??>) nil sequence))

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter   (op result (car rest))
                    (cdr rest))))
    (iter initial sequence))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

(define (fold-right op initial sequence)
    (accumulate op initial sequence))

(define (reverse-left sequence)
    (fold-left (lambda (x y) (cons y x)) nil sequence))

(define (reverse-right sequence)
    (fold-right (lambda (x y) (append y (list x))) nil sequence))

(reverse-left (list 1 2 3))
(reverse-right (list 1 2 3))

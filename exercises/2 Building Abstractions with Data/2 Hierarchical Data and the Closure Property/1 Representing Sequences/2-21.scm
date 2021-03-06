#lang sicp
(#%require "../../../helpers/base.scm")

;; The procedure square-list takes a list of numbers as argument and returns a list of 
;; the squares of those numbers.

;; (square-list (list 1 2 3 4))
;; (1 4 9 16)

;; Here are two different definitions of square-list. Complete both of them by filling 
;; in the missing expressions:

;; (define (square-list items)
;;     (if (null? items)
;;         nil
;;         (cons <??> <??>)))

;; (define (square-list items)
;;     (map <??> <??>))

(define (map proc items)
    (if (null? items)
        nil
        (cons   (proc (car items))
                (map proc (cdr items)))))


;; Answer:

(define (square-list-cons items)
    (if (null? items)
        nil
        (cons (square (car items)) (square-list-cons (cdr items)))))

(define (square-list-map items)
    (map square items))

(square-list-cons (list 1 2 3 4))
(square-list-map (list 1 2 3 4))

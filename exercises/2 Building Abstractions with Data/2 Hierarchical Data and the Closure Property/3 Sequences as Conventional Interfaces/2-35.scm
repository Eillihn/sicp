#lang sicp

;; Redefine count-leaves from section 2.2.2 as an accumulation:
;; (define (count-leaves t)
;;     (accumulate <??> <??> (map <??> <??>)))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (count-leaves t)
    (accumulate + 0 (map (lambda (x) (if (pair? x) (count-leaves x) 1)) t)))


(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
(count-leaves (list x x))

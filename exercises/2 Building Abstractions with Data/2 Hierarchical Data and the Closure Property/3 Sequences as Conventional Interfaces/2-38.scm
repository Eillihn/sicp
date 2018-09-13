#lang sicp

;; The accumulate procedure is also known as fold-right, because it combines the first 
;; element of the sequence with the result of combining all the elements to the right. 
;; There is also a foldleft, which is similar to fold-right, except that it combines 
;; elements working in the opposite direction:
(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter   (op result (car rest))
                    (cdr rest))))
    (iter initial sequence))
;; What are the values of
;; (fold-right / 1 (list 1 2 3))
;; (fold-left / 1 (list 1 2 3))
;; (fold-right list nil (list 1 2 3))
;; (fold-left list nil (list 1 2 3))
;; Give a property that op should satisfy to guarantee that fold-right and fold-left 
;; will produce the same values for any sequence.

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))



(define (fold-right op initial sequence)
    (accumulate op initial sequence))

(fold-right / 1 (list 1 2 3))
;; (/ 1 (accumulate / 1 (list 2 3)))
;; (/ 1 (/ 2 (accumulate / 1 (list 3))))
;; (/ 1 (/ 2 (/ 3 (accumulate / 1 null))))
;; (/ 1 (/ 2 (/ 3 1)))
;; (/ 1 (/ 2 3))
;; (/ 3 2)
;; 1 1/2

(fold-left / 1 (list 1 2 3))
;; (iter 1 (list 1 2 3))
;; (iter (/ 1 1) (list 2 3))
;; (iter 1 (list 2 3))
;; (iter (/ 1 2) (list 3))
;; (iter 0.5 (list 3))
;; (iter (/ 0.5 3) nil)
;; (iter (/ 0.5 3) nil)
;; 1/6

(fold-right list nil (list 1 2 3))
;; (list 1 (accumulate list nil (list 2 3)))
;; (list 1 (list 2 (accumulate list nil (list 3))))
;; (list 1 (list 2 (list 3 (accumulate list nil null))))
;; (list 1 (list 2 (list 3 nil)))


(fold-left list nil (list 1 2 3))
;; (iter nil (list 1 2 3))
;; (iter (list nil 1) (list 2 3))
;; (iter (list (list nil 1) 2) (list 3))
;; (iter (list (list (list nil 1) 2) 3) nil)
;; (list (list (list nil 1) 2) 3)

;; If op should satisfy commutative property, then fold-right and fold-left 
;; will produce the same values for any sequence

(fold-right * 1 (list 1 2 3))
(fold-left * 1 (list 1 2 3))

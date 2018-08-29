#lang sicp

;; Give combinations of cars and cdrs that will pick 7 from each of the following lists:
;; (1 3 (5 7) 9)
;; ((7))
;; (1 (2 (3 (4 (5 (6 7))))))

(define list1 (list 1 3 (list 5 7) 9))
(car(cdr(car(cdr(cdr list1)))))

(define list2 (list (list 7)))
(car(car list2))

(define list3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr(car(cdr list3))))))))))))

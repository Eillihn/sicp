#lang sicp

;; The following pattern of numbers is called Pascal's triangle.

;;                 1
;;             1       1
;;         1       2       1
;;     1       3       3       1
;; 1       4       6       4       1

;; The numbers at the edge of the triangle are all 1, 
;; and each number inside the triangle is the sum of the two numbers above it. 
;; Write a procedure that computes elements of Pascal's triangle 
;; by means of a recursive process.

;; Answer:
(define (pascal row col)
    (cond   ((or (= col 0) (= row col)) 1)
            ((> col row) 0)
            (else (+ (pascal (- row 1) col) (pascal (- row 1) (- col 1))))
    ))

(display (pascal 0 0))
(newline)
(display (pascal 1 0))
(display (pascal 1 1))
(newline)
(display (pascal 2 0))
(display (pascal 2 1))
(display (pascal 2 2))
(newline)
(display (pascal 3 0))
(display (pascal 3 1))
(display (pascal 3 2))
(display (pascal 3 3))
(newline)
(display (pascal 4 0))
(display (pascal 4 1))
(display (pascal 4 2))
(display (pascal 4 3))
(display (pascal 4 4))
(newline)

;; 1
;; 11
;; 121
;; 1331
;; 14641
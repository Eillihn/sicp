#lang sicp

;; The ``eight-queens puzzle'' asks how to place eight queens on a chessboard 
;; so that no queen is in check from any other (i.e., no two queens are in 
;; the same row, column, or diagonal).

;; (define (queens board-size)
;;     (define (queen-cols k)
;;         (if (= k 0)
;;             (list empty-board)
;;             (filter
;;                 (lambda (positions) (safe? k positions))
;;                 (flatmap
;;                     (lambda (rest-of-queens)
;;                         (map (lambda (new-row)
;;                                     (adjoin-position new-row k rest-of-queens))
;;                             (enumerate-interval 1 board-size)))
;;                     (queen-cols (- k 1))))))
;;     (queen-cols board-size))

;; In this procedure rest-of-queens is a way to place k - 1 queens in the first 
;; k - 1 columns, and new-row is a proposed row in which to place the queen for 
;; the kth column. Complete the program by implementing the representation for 
;; sets of board positions, including the procedure adjoin-position, which adjoins 
;; a new row-column position to a set of positions, and empty-board, which 
;; represents an empty set of positions. You must also write the procedure safe?, 
;; which determines for a set of positions, whether the queen in the kth column is 
;; safe with respect to the others. (Note that we need only check whether the new 
;; queen is safe -- the other queens are already guaranteed safe with respect to 
;; each other.)

(define (enumerate-interval low high)
    (if (> low high)
        nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
    (accumulate append nil (map proc seq)))

(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))

(define (filter predicate sequence)
    (cond   ((null? sequence) nil)
            ((predicate (car sequence))
                (cons (car sequence)
            (filter predicate (cdr sequence))))
            (else (filter predicate (cdr sequence)))))



;; Answer:

(define empty-board nil)

(define (adjoin-position row col rest)
    (cons (list row col) rest)) 

 (define (safe? k positions) 
     (let ((first-row (caar positions)) 
           (first-col (cadar positions)) 
           (rest (cdr positions))) 
       (accumulate (lambda (pos result) 
                     (let ((row (car pos)) 
                           (col (cadr pos))) 
                       (and result
                            (not (= first-row row))
                            (not (= first-col col)) 
                            (not (= (- first-row first-col) 
                                    (- row col))) 
                            (not (= (+ first-row first-col) 
                                    (+ row col)))))) 
                   true 
                   rest))) 

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)
                                    (adjoin-position new-row k rest-of-queens))
                            (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))

(display (queens 3))
(display (queens 4))

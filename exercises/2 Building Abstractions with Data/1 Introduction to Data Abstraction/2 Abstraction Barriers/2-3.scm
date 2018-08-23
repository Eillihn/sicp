#lang sicp

;; Implement a representation for rectangles in a plane. 
;; (Hint: You may want to make use of exercise 2.2.) 
;; 1) In terms of your constructors and selectors, create procedures that compute the 
;; perimeter and the area of a given rectangle. 
;; 2) Now implement a different representation for rectangles. 
;; Can you design your system with suitable abstraction barriers, so that the same 
;; perimeter and area procedures will work using either representation?

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

(define (make-segment start end)
    (cons start end))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (x-point-length p1 p2)
    (-  (x-point p2)
        (x-point p1)))

(define (y-point-length p1 p2)
    (-  (y-point p2)
        (y-point p1)))

(define (segment-length segment)
    (let    ((start (start-segment segment))
            (end (end-segment segment)))
        (max    (x-point-length start end)
                (y-point-length start end))))

(define (rectangle x1 x2 y1 y2)
    (cons (make-segment (make-point x1 y1) (make-point x2 y1))
          (make-segment (make-point x2 y1) (make-point x2 y2))))

(define (top rect) (car rect))

(define (right rect) (cdr rect))

(define (rect-length rect) (segment-length (top rect)))

(define (rect-width rect) (segment-length (right rect)))

(define (perimeter rect)
    (* 2 (+ (rect-length rect) (rect-width rect))))

(define (area rect)
    (* (rect-length rect) (rect-width rect)))



;; Test code:

(define r1 (rectangle 1 4 5 9))
(perimeter r1)      ; 14
(area r1)           ; 12

(define r2 (rectangle 2 3 4 5))
(perimeter r2)      ; 4
(area r2)           ; 1

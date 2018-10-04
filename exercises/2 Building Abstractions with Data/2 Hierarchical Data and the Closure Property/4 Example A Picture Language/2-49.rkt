#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; Use segments->painter to define the following primitive painters:
;; a. The painter that draws the outline of the designated frame.
;; b. The painter that draws an ``X'' by connecting opposite corners of the frame.
;; c. The painter that draws a diamond shape by connecting the midpoints of the sides of 
;; the frame.
;; d. The wave painter.



;; Answer:
;; a. The painter that draws the outline of the designated frame.
(define (outline f)
    (let    ((opposite-vect (make-vect  (vector-xcor (frame-edge1 f))
                                        (vector-ycor (frame-edge2 f)))))
        (segments->painter (list    (make-segment (frame-origin f) (frame-edge2 f))
                                    (make-segment (frame-origin f) (frame-edge1 f))
                                    (make-segment (frame-edge1 f) opposite-vect)
                                    (make-segment (frame-edge2 f) opposite-vect)
                                    ))))
;; b. The painter that draws an ``X'' by connecting opposite corners of the frame.
(define (X->painter f)
    (let    ((opposite-vect (make-vect  (vector-xcor (frame-edge1 f))
                                        (vector-ycor (frame-edge2 f)))))
        (segments->painter (list    (make-segment (frame-origin f) opposite-vect)
                                    (make-segment (frame-edge2 f) (frame-edge1 f))
                                    ))))
;; c. The painter that draws a diamond shape by connecting the midpoints of the sides of 
;; the frame.
(define (diamond f)
    (let    ((half-x (/ (+ (vector-xcor (frame-edge1 f)) (vector-xcor (frame-edge2 f))) 2))
            (half-y (/ (+ (vector-ycor (frame-edge2 f)) (vector-ycor (frame-origin f))) 2)))
        (let    ((midpoint1 (make-vect  (vector-xcor (frame-edge2 f)) half-y))
                (midpoint2 (make-vect half-x (vector-ycor (frame-edge1 f))))
                (midpoint3 (make-vect  (vector-xcor (frame-edge1 f)) half-y))
                (midpoint4 (make-vect half-x (vector-ycor (frame-edge2 f)))))
        (segments->painter (list    (make-segment midpoint1 midpoint2)
                                        (make-segment midpoint2 midpoint3)
                                        (make-segment midpoint3 midpoint4)
                                        (make-segment midpoint4 midpoint1)
                                        )))))
;; d. The wave painter.
(define (wave f)
    (let    ((y (- (vector-ycor (frame-edge2 f)) (vector-ycor (frame-origin f))))
            (x (- (vector-xcor (frame-edge1 f)) (vector-xcor (frame-origin f))))
            (max-y (vector-ycor (frame-edge2 f)))
            (max-x (vector-xcor (frame-edge1 f)))
            (min-y (vector-ycor (frame-origin f)))
            (min-x (vector-xcor (frame-origin f))))
        (let    ((y1 (+ (- y (* (/ 3 16) y)) (vector-ycor (frame-origin f))))
                (y2 (+ (- y (* (/ 6 16) y)) (vector-ycor (frame-origin f))))
                (y3 (+ (- y (* (/ 7 16) y)) (vector-ycor (frame-origin f))))
                (y4 (+ (- y (* (/ 8 16) y)) (vector-ycor (frame-origin f))))
                (y5 (+ (- y (* (/ 9 16) y)) (vector-ycor (frame-origin f))))
                (y6 (+ (- y (* (/ 10 16) y)) (vector-ycor (frame-origin f))))
                (y7 (+ (- y (* (/ 11 16) y)) (vector-ycor (frame-origin f))))
                (y8 (+ (- y (* (/ 12 16) y)) (vector-ycor (frame-origin f))))
                (y9 (+ (- y (* (/ 14 16) y)) (vector-ycor (frame-origin f))))
                (x1 (+ (- x (* (/ 14 16) x)) (vector-xcor (frame-origin f))))
                (x2 (+ (- x (* (/ 12 16) x)) (vector-xcor (frame-origin f))))
                (x3 (+ (- x (* (/ 11 16) x)) (vector-xcor (frame-origin f))))
                (x4 (+ (- x (* (/ 10 16) x)) (vector-xcor (frame-origin f))))
                (x5 (+ (- x (* (/ 9 16) x)) (vector-xcor (frame-origin f))))
                (x6 (+ (- x (* (/ 7 16) x)) (vector-xcor (frame-origin f))))
                (x7 (+ (- x (* (/ 5 16) x)) (vector-xcor (frame-origin f))))
                (x8 (+ (- x (* (/ 4 16) x)) (vector-xcor (frame-origin f))))
                (x9 (+ (- x (* (/ 3 16) x)) (vector-xcor (frame-origin f)))))
            (segments->painter (list    
                                        ;; left hand
                                        (make-segment (make-vect min-x y1) (make-vect x1 y3))
                                        (make-segment (make-vect x1 y3) (make-vect x3 y2))
                                        (make-segment (make-vect x3 y2) (make-vect x5 y2))
                                        (make-segment (make-vect min-x y2) (make-vect x1 y6))
                                        (make-segment (make-vect x1 y6) (make-vect x3 y3))
                                        (make-segment (make-vect x3 y3) (make-vect x4 y4))
                                        ;; left leg
                                        (make-segment (make-vect x4 y4) (make-vect x2 min-y))
                                        (make-segment (make-vect x5 min-y) (make-vect x6 y8))
                                        ;; right leg
                                        (make-segment (make-vect x6 y8) (make-vect x7 min-y))
                                        (make-segment (make-vect x9 min-y) (make-vect x7 y5))
                                        ;; right hand
                                        (make-segment (make-vect x7 y5) (make-vect max-x y9))
                                        (make-segment (make-vect x9 y2) (make-vect max-x y7))
                                        (make-segment (make-vect x9 y2) (make-vect x7 y2))
                                        ; head
                                        (make-segment (make-vect x7 y2) (make-vect x8 y1))
                                        (make-segment (make-vect x8 y1) (make-vect x7 max-y))
                                        (make-segment (make-vect x5 max-y) (make-vect x4 y1))
                                        (make-segment (make-vect x4 y1) (make-vect x5 y2))
                                        )))))


;; Test code:
(define f (make-frame (make-vect 0.25 0.25) (make-vect 0.75 0.25) (make-vect 0.25 0.75)))
(paint (outline f))
(paint (X->painter f))
(paint (diamond f))
(paint (wave f))

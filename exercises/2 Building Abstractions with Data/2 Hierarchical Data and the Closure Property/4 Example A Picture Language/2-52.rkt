#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; Make changes to the square limit of wave shown in figure 2.9 by working at each of the
;; levels described above. In particular:
;; a. Add some segments to the primitive wave painter of exercise 2.49 (to add a smile, 
;; for example).
;; b. Change the pattern constructed by corner-split (for example, by using only one copy 
;; of the upsplit and right-split images instead of two).
;; c. Modify the version of square-limit that uses square-of-four so as to assemble the 
;; corners in a different pattern. (For example, you might make the big Mr. Rogers look 
;; outward from each corner of the square.)

(define (split func1 func2)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split func1 func2) painter (- n 1))))
                (func1 painter (func2 smaller smaller)))))
    )

(define right-split (split beside below))

(define up-split (split below beside))

(define (square-of-four tl tr bl br)
    (lambda (painter)
        (let    ((top (beside (tl painter) (tr painter)))
                (bottom (beside (bl painter) (br painter))))
            (below bottom top))))


;; Answer:
;; a. The smile is added:
(define (wave f)
    (let    ((y (- (vector-ycor (frame-edge2 f)) (vector-ycor (frame-origin f))))
            (x (- (vector-xcor (frame-edge1 f)) (vector-xcor (frame-origin f))))
            (max-y (vector-ycor (frame-edge2 f)))
            (max-x (vector-xcor (frame-edge1 f)))
            (min-y (vector-ycor (frame-origin f)))
            (min-x (vector-xcor (frame-origin f))))
        (let    ((y1 (+ (- y (* (/ 3 16) y)) (vector-ycor (frame-origin f))))
                (ys (+ (- y (* (/ 4 16) y)) (vector-ycor (frame-origin f))))
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
                                        ; smile
                                        (make-segment (make-vect x5 y1) (make-vect x6 ys))
                                        (make-segment (make-vect x7 y1) (make-vect x6 ys))
                                        )))))




;; b. The pattern constructed by corner-split is changed by using only one copy of the 
;; up-split and right-split images instead of two:

(define (corner-split painter n)
    (if (= n 0)
        painter
        (beside (below painter (up-split painter (- n 1)))
                (below (right-split painter (- n 1)) (corner-split painter (- n 1))))))



;; c. Square-limit that uses square-of-four is modified in a way, that Einstein looks 
;; outward from each corner of the square:

(define (square-limit painter n)
    (let    ((combine4 (square-of-four  flip-vert rotate180
                                        identity flip-horiz)))
        (combine4 (corner-split painter n))))

;; Test code:
(define f (make-frame (make-vect 0.25 0.25) (make-vect 0.75 0.25) (make-vect 0.25 0.75)))
(paint (wave f))
(paint (corner-split einstein 4))
(paint (square-limit einstein 4))

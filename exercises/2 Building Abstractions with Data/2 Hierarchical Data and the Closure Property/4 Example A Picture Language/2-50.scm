#lang sicp
(#%require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; Define the transformation flip-horiz, which flips painters horizontally, and
;; transformations that rotate painters counterclockwise by 180 degrees and 270 
;; degrees.

(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                                (vector-sub (m corner1) new-origin)
                                (vector-sub (m corner2) new-origin)))))))

(define (flip-horiz painter)
    (transform-painter  painter
                        (make-vect 1.0 0.0) ; new origin
                        (make-vect 0.0 0.0) ; new end of edge1
                        (make-vect 1.0 1.0))) ; new end of edge2

(define (rotate180 painter)
    (transform-painter  painter
                        (make-vect 1.0 1.0)
                        (make-vect 0.0 1.0)
                        (make-vect 1.0 0.0)))

(define (rotate270 painter)
    (transform-painter  painter
                        (make-vect 0.0 1.0)
                        (make-vect 0.0 0.0)
                        (make-vect 1.0 1.0)))



;; Test code:
(paint (flip-horiz einstein))
(paint (rotate180 einstein))
(paint (rotate270 einstein))

#lang sicp
(#%require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; Define the below operation for painters. Below takes two painters as arguments. The
;; resulting painter, given a frame, draws with the first painter in the bottom of the 
;; frame and with the second painter in the top. 
;; Define below in two different ways -- first by writing a procedure that is analogous 
;; to the beside procedure given above, and again in terms of beside and suitable 
;; rotation operations (from exercise 2.50).

(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                                (vector-sub (m corner1) new-origin)
                                (vector-sub (m corner2) new-origin)))))))

(define (beside painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let    ((paint-left
                    (transform-painter  painter1
                                        (make-vect 0.0 0.0)
                                        split-point
                                        (make-vect 0.0 1.0)))
                (paint-right
                    (transform-painter  painter2
                                        split-point
                                        (make-vect 1.0 0.0)
                                        (make-vect 0.5 1.0))))
        (lambda (frame)
            (paint-left frame)
            (paint-right frame)))))

(define (rotate90 painter)
    (transform-painter  painter
                        (make-vect 1.0 0.0)
                        (make-vect 1.0 1.0)
                        (make-vect 0.0 0.0)))

(define (rotate270 painter)
    (transform-painter  painter
                        (make-vect 0.0 1.0)
                        (make-vect 0.0 0.0)
                        (make-vect 1.0 1.0)))


                        
(define (below painter1 painter2)
    (let ((split-point (make-vect 0.0 0.5)))
        (let    ((paint-left
                    (transform-painter  painter1
                                        (make-vect 0.0 0.0)
                                        (make-vect 1.0 0.0)
                                        split-point))
                (paint-right
                    (transform-painter  painter2
                                        split-point
                                        (make-vect 1.0 0.5)
                                        (make-vect 0.0 1.0))))
        (lambda (frame)
            (paint-left frame)
            (paint-right frame)))))

(define (below-from-beside painter1 painter2)
    (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))



;; Test code:
(paint (below black einstein))
(paint (below-from-beside black einstein))

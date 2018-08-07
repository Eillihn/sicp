#lang sicp

;; 1) Modify fixed-point so that it prints the sequence of approximations it generates, using
;; the newline and display primitives shown in exercise 1.22. 
;; 2) Then find a solution to x^x = 1000 by finding a fixed point of x -> log(1000)/log(x). 
;; (Use Scheme's primitive log procedure, which computes natural logarithms.) 
;; 3) Compare the number of steps this takes with and without average damping. 
;; (Note that you cannot start fixed-point with a guess of 1, as this would cause division 
;; by log(1) = 0.)

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (display guess)
        (newline)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

;; 34 steps
(fixed-point 
    (lambda (x) 
        (/ (log 1000)(log x))) 
    2.0)                                        ; 4.555532270803653

;; 9 steps
(fixed-point 
    (lambda (x) 
        (/  (+  x 
                (/ (log 1000)(log x)))
            2))
    2.0)                                        ; 4.555537551999825
#lang sicp

;; Several of the numerical methods described in this chapter are instances of an extremely
;; general computational strategy known as iterative improvement. Iterative improvement 
;; says that, to compute something, we start with an initial guess for the answer, test 
;; if the guess is good enough, and otherwise improve the guess and continue the process 
;; using the improved guess as the new guess. 

;; 1) Write a procedure iterative-improve that takes two procedures as arguments: a method 
;; for telling whether a guess is good enough and a method for improving a guess. 
;; Iterative-improve should return as its value a procedure that takes a guess as argument 
;; and keeps improving the guess until it is good enough.
;; 2) Rewrite the sqrt procedure of section 1.1.7 and the fixed-point procedure of section 
;; 1.3.3 in terms of iterative-improve.



(define (iterative-improve good-enough? improve-guess)
    (lambda (guess)
        (define (try x)
            (if (good-enough? x)
                x
                (try (improve-guess x))))
        
        (try guess)))

(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
    (let    ((good-enough? 
                            (lambda (guess) 
                                (< (abs (- (square guess) x)) 0.00001)))
            (improve-guess 
                            (lambda (guess) 
                                (average guess (/ x guess)))))
        ((iterative-improve good-enough? improve-guess) 1)))

(define (fixed-point f first-guess)
    (let    ((close-enough? 
                            (lambda (guess) 
                                (< (abs (- (f guess) guess)) 0.00001)))
            (improve-guess 
                            (lambda (guess) 
                                (f guess))))
        ((iterative-improve close-enough? improve-guess) first-guess)))


(sqrt 9)                    ;3 2/1431655765
(fixed-point cos 1.0)       ;0.7390893414033927
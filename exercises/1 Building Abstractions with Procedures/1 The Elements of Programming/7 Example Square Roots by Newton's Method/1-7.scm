#lang sicp

;; Newton's method to get square root for x of successive approximations y

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter  (improve guess x)
                    x)))
(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define (square x) (* x x))

;; The good-enough? test used in computing square roots 
;; will not be very effective for finding the square roots of very small numbers. 
;; Also, in real computers, arithmetic operations are almost always performed
;; with limited precision. This makes our test inadequate for very large numbers.
;; 1) Explain these statements, with examples showing how the test fails 
;; for small and large numbers.
;; 2) An alternative strategy for implementing good-enough? is
;; to watch how guess changes from one iteration to the next and to stop 
;; when the change is a very small fraction of the guess. 
;; Design a square-root procedure that uses this kind of end test. 
;; Does this work better for small and large numbers?



;; Answer:

;; 1)
;; If square is less than precision the result will be wrong.
(sqrt 0.0001)
;; 0.03230844833048122
;; If the number is too large and the square root is not an integer 
;; than code will run to endless loop
;; (sqrt 10000000000000)
;; endless loop

;; 2)
(define (se-sqrt-iter guess prev-guess x)
    (if (small-enough? guess prev-guess)
        guess
        (se-sqrt-iter (improve guess x)
                   guess
                    x)))

(define (small-enough? guess prev-guess)
    (< (abs (- prev-guess guess)) 0.001))

(define (se-sqrt x)
    (se-sqrt-iter 1.0 0 x))


(se-sqrt 0.0001)
;; 0.010000714038711746
(se-sqrt 10000000000000)
;; 3162277.6601683795

;; Small-enough variation works better for small numbers, and for large numbers
;; it doesn't go to endless loop.

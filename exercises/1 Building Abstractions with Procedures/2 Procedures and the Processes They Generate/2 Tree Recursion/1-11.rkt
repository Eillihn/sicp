#lang sicp

;; A function f is defined by the rule that 
;; f(n) = n if n<3 and 
;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n -3) if n> 3. 
;; 1) Write a procedure that computes f by means of a recursive process. 
;; 2) Write a procedure that computes f by means of an iterative process.



;; Answer:
;; 1) Procedure that computes f by means of a recursive proces
(define (f-recursive n)
    (if (< n 3)
        n
        (+  (f-recursive (- n 1))
            (* 2 (f-recursive (- n 2)))
            (* 3 (f-recursive (- n 3))))))

(f-recursive 0)             ; 0
(f-recursive 1)             ; 1
(f-recursive 2)             ; 2
(f-recursive 3)             ; 4
(f-recursive 4)             ; 11
(f-recursive 5)             ; 25
(f-recursive 6)             ; 59
(f-recursive 7)             ; 142

;; 2) Procedure that computes f by means of an iterative process

(define (f-iterative n)
    (f-iter 0 1 2 n))
(define (f-iter a b c count)
    (cond   ((< count 3) count)
            ((= count 3) (+ c (* 2 b) (* 3 a)))
            (else (f-iter b c (+ c (* 2 b) (* 3 a)) (- count 1)))))

(f-iterative 0)             ; 0
(f-iterative 1)             ; 1
(f-iterative 2)             ; 2
(f-iterative 3)             ; 4
(f-iterative 4)             ; 11
(f-iterative 5)             ; 25
(f-iterative 6)             ; 59
(f-iterative 7)             ; 142
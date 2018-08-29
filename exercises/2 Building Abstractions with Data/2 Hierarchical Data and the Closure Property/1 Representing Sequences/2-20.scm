#lang sicp

;; The procedures +, *, and list take arbitrary numbers of arguments. One way to define
;; such procedures is to use define with dotted-tail notation. In a procedure definition, 
;; a parameter list that has a dot before the last parameter name indicates that, when 
;; the procedure is called, the initial parameters (if any) will have as values the 
;; initial arguments, as usual, but the final parameter's value will be a list of any 
;; remaining arguments.

;; Use this notation to write a procedure same-parity that takes one or more integers 
;; and returns a list of all the arguments that have the same even-odd parity as the 
;; first argument. For example,
;; (same-parity 1 2 3 4 5 6 7)
;; (1 3 5 7)
;; (same-parity 2 3 4 5 6 7)
;; (2 4 6)



;; Answer:
(define (reverse a)
    (define (iter a result)
        (if (null? a)
            result
            (iter (cdr a) (cons (car a) result))))
    (iter a nil))
(define (even? n) (= (remainder n 2) 0))
(define (odd? n) (= (remainder n 2) 1))
(define (same-parity . args)
    (define (same-parity? a b)
        (or (and (even? a) (even? b)) 
            (and (odd? a) (odd? b))))
    (define (iter a result)
        (if (null? a)
            (reverse result)
            (if (same-parity? (car args) (car a))
                (iter (cdr a) (cons (car a) result))
                (iter (cdr a) result))))
    (iter args nil))



;; Test code:
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

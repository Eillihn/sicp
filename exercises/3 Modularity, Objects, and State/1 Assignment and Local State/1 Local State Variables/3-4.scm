#lang sicp

; Modify the make-account procedure of exercise 3.3 by adding another 
; local state variable so that, if an account is accessed more than 
; seven consecutive times with an incorrect password, it invokes the 
; procedure call-the-cops.

(define (make-account balance password)
    (define pass-errors 0)
    (define (incorrect-password m)
        (if (> pass-errors 6)
            (call-the-cops)
            (begin (set! pass-errors (+ pass-errors 1))
                "Incorrect password")))
    (define (call-the-cops)
        "Call the cops")
    (define (withdraw amount)
        (set! pass-errors 0)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! pass-errors 0)
        (set! balance (+ balance amount))
            balance)
    (define (dispatch p m)
        (cond ((not (eq? p password)) incorrect-password)
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                m))))
    dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)       ; 60
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Incorrect password"
((acc 'some-other-password 'deposit) 50)    ; "Call the cops"

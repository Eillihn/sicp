#lang sicp
(#%require "../../../helpers/serializer.scm")

; Explain in detail why the deadlock-avoidance method described above, (i.e., the accounts
; are numbered, and each process attempts to acquire the smaller-numbered account first) avoids deadlock
; in the exchange problem. Rewrite serialized-exchange to incorporate this idea. (You will also
; need to modify make-account so that each account is created with a number, which can be accessed by
; sending an appropriate message.)



(define (make-account-and-serializer balance)
    (let ((id (random 4294967087)))
        (define (withdraw amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                    balance)
                "Insufficient funds"))
        (define (deposit amount)
            (set! balance (+ balance amount))
            balance)
        (let ((balance-serializer (make-serializer)))
            (define (dispatch m)
                (cond   ((eq? m 'withdraw) withdraw)
                        ((eq? m 'deposit) deposit)
                        ((eq? m 'balance) balance)
                        ((eq? m 'serializer) balance-serializer)
                        ((eq? m 'id) id)
                        (else (error "Unknown request -- MAKE-ACCOUNT"
                                m))))
            dispatch)))

(define (serialized-exchange account1 account2)
    (let    ((id1 (account1 'id))
            (id2 (account2 'id))
            (serializer1 (account1 'serializer))
            (serializer2 (account2 'serializer)))
        (if (< id1 id2)
            (serializer1 (serializer2 exchange))
            (serializer2 (serializer1 exchange)))
        account1
        account2))

(define (exchange account1 account2)
    (let    ((difference (- (account1 'balance)
                            (account2 'balance))))
        ((account1 'withdraw) difference)
        ((account2 'deposit) difference)))



; Test code:
(define account1 (make-account-and-serializer 100))
(define account2 (make-account-and-serializer 50))
(serialized-exchange account1 account2)
(account1 'balance)
(account2 'balance)



; Answer:
; Imagine that Peter attempts to exchange a1 with a2 while Paul concurrently attempts to exchange a2 with a1. 
; If the accounts are numbered, and each process attempts to acquire the smaller-numbered account first,
; than both Peter and Paul will attemp to exchange a1 with a2 or a2 with a1. So, when Peter's process reaches 
; the point where it has entered a serialized procedure protecting a1 and, just after that,
; Paul's process fail to enters a1, it will wait the end of Peters process, so no deadlock will happen.

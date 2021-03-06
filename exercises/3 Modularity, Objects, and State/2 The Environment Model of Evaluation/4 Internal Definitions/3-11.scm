#lang sicp

; In section 3.2.3 we saw how the environment model described the behavior of procedures
; with local state. Now we have seen how internal definitions work. A typical message-passing procedure
; contains both of these aspects. Consider the bank account procedure of section 3.1.1:

; (define (make-account balance)
;     (define (withdraw amount)
;         (if (>= balance amount)
;             (begin (set! balance (- balance amount))
;                 balance)
;             "Insufficient funds"))
;     (define (deposit amount)
;         (set! balance (+ balance amount))
;             balance)
;     (define (dispatch m)
;         (cond ((eq? m 'withdraw) withdraw)
;         ((eq? m 'deposit) deposit)
;         (else (error "Unknown request -- MAKE-ACCOUNT"
;             m))))
;     dispatch)

; Show the environment structure generated by the sequence of interactions
; (define acc (make-account 50))
; ((acc 'deposit) 40)     ; 90
; ((acc 'withdraw) 60)    ; 30
; Where is the local state for acc kept? Suppose we define another account
; (define acc2 (make-account 100))
; How are the local states for the two accounts kept distinct? Which parts of the environment structure are
; shared between acc and acc2?



; global env
; ---------------------
; | make-account: -   |
; |               |   |
; |               V   |
; ---------------------
; parameters: balance             
; body:
; (define (withdraw) ...)
; (define (deposit) ...)
; (define (dispatch) ...)
; dispatch



; (define acc (make-account 50))
; global env
; ---------------------
; | make-account: ... |
; | acc:          -   |
; |               |   |
; |               V   |
; ---------------------
;                                         -> E1
; parameters: balance                     balance: 50   
; body: (cond ((eq? m 'withdraw) ...      withdraw    -> parameters: amount || body: (if (>= balance amo...
;                                         deposit     -> parameters: amount || body: (set! balance...



; ((acc 'deposit) 40)     ; 90
; global env
; ---------------------
; | make-account: ... |
; | acc:          -   |
; |               |   |
; |               V   |
; ---------------------
;                                         -> E1               -> E2
; parameters: balance                     balance: 50         amount: 40
; body: (cond ((eq? m 'withdraw) ...      withdraw            (call to deposit, will inc balance to 90)
;                                         deposit



; ((acc 'withdraw) 60)    ; 30
; global env
; ---------------------
; | make-account: ... |
; | acc:          -   |
; |               |   |
; |               V   |
; ---------------------
;                                         -> E1               -> E3
; parameters: balance                     balance: 90         amount: 60
; body: (cond ((eq? m 'withdraw) ...      withdraw            (call to withdraw, will dec balance to 30)
;                                         deposit



; (define acc2 (make-account 100))
; global env
; ---------------------
; | make-account: ... |
; | acc:          ->  |                   -> E1 || balance: 30, withdraw, deposit
; | acc2:         -   |
; |               |   |
; |               V   |
; ---------------------
;                                         -> E4
; parameters: balance                     balance: 100   
; body: (cond ((eq? m 'withdraw) ...      withdraw    -> parameters: amount || body: (if (>= balance amo...
;                                         deposit     -> parameters: amount || body: (set! balance...

; The local states for the two accs each have their own environments.
; Only global environment is shared between acc and acc2.

#lang sicp

; Louis Reasoner thinks our bank-account system is unnecessarily complex and error-prone
; now that deposits and withdrawals aren't automatically serialized. He suggests that make-accountand-
; serializer should have exported the serializer (for use by such procedures as serializedexchange)
; in addition to (rather than instead of) using it to serialize accounts and deposits as makeaccount
; did. He proposes to redefine accounts as follows:

; (define (make-account-and-serializer balance)
;     (define (withdraw amount)
;         (if (>= balance amount)
;             (begin (set! balance (- balance amount))
;                 balance)
;             "Insufficient funds"))
;     (define (deposit amount)
;         (set! balance (+ balance amount))
;         balance)
;     (let ((balance-serializer (make-serializer)))
;         (define (dispatch m)
;             (cond   ((eq? m 'withdraw) (balance-serializer withdraw))
;                     ((eq? m 'deposit) (balance-serializer deposit))
;                     ((eq? m 'balance) balance)
;                     ((eq? m 'serializer) balance-serializer)
;                     (else (error "Unknown request -- MAKE-ACCOUNT"
;                         m))))
;         dispatch))

; Then deposits are handled as with the original make-account:

; (define (deposit account amount)
;     ((account 'deposit) amount))

; Explain what is wrong with Louis's reasoning. In particular, consider what happens when serializedexchange
; is called.



; Answer:
; When serializedexchange is called withdraw/deposit will never be run, as they will wait while there 
; accounts will be available. But serializedexchange have already occupy them.

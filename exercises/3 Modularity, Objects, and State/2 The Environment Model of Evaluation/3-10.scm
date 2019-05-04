#lang sicp

; In the make-withdraw procedure, the local variable balance is created as a
; parameter of make-withdraw. We could also create the local state variable explicitly, using let, as
; follows:

; (define (make-withdraw initial-amount)
;     (let ((balance initial-amount))
;         (lambda (amount)
;             (if (>= balance amount)
;                 (begin (set! balance (- balance amount))
;                     balance)
;                 "Insufficient funds"))))

; Recall from section 1.3.2 that let is simply syntactic sugar for a procedure call:
; (let ((<var> <exp>)) <body>)
; is interpreted as an alternate syntax for
; ((lambda (<var>) <body>) <exp>)
; Use the environment model to analyze this alternate version of make-withdraw, drawing figures like
; the ones above to illustrate the interactions

; (define W1 (make-withdraw 100))
; (W1 50)
; (define W2 (make-withdraw 100))

; Show that the two versions of make-withdraw create objects with the same behavior. How do the
; environment structures differ for the two versions?



; global env
; ---------------------------------
; |make-withdraw: -               |
; |               |               |
; |               V               |
; ---------------------------------
; parameters: initial-amount
; body: (let ((balance ...



; (define W1 (make-withdraw 100))
; ---------------------------------
; |make-withdraw: ...             |
; |W1:            -               |
; |               |               |
; |               V               |
; ---------------------------------
;                                         -> E1                       -> E2
; parameters: balance                     balance: initial-amount     initial-amount: 100
; body: (if (>= balance amount) ...          



; (W1 50)
; ---------------------------------
; |make-withdraw: ...             |
; |W1:            -               |
; |               |               |
; |               V               |
; ---------------------------------
;                                         -> E1                                           -> E2
; parameters: balance                     balance: initial-amount     <-  amount: 50      initial-amount: 100
; body: (if (>= balance amount) ...          

; ---------------------------------
; |make-withdraw: ...             |
; |W1:            -               |
; |               |               |
; |               V               |
; ---------------------------------
;                                         -> E1                       -> E2
; parameters: balance                     balance: 50                 initial-amount: 100
; body: (if (>= balance amount) ...          



; (define W2 (make-withdraw 100))
; --------------------
; |make-withdraw: ... |
; |W1:            ->  | par-s: balance, body: (if (>= balance ... || E1 balance: 50 || E2 initial-amount: 100
; |W2:            ->  | par-s: balance, body: (if (>= balance ... || E3 balance: initial-amount || E4 initial-amount: 100
; --------------------

#lang sicp
(#%require "../../../helpers/evaluator.scm")

; Recall the definitions of the special forms and and or from chapter 1:
;     and: The expressions are evaluated from left to right. If any expression evaluates to false, false is
; returned; any remaining expressions are not evaluated. If all the expressions evaluate to true
; values, the value of the last expression is returned. If there are no expressions then true is returned.
;     or: The expressions are evaluated from left to right. If any expression evaluates to a true value,
; that value is returned; any remaining expressions are not evaluated. If all expressions evaluate to
; false, or if there are no expressions, then false is returned.
; Install and and or as new special forms for the evaluator by defining appropriate syntax procedures and
; evaluation procedures eval-and and eval-or. Alternatively, show how to implement and and or as
; derived expressions.

(define (and? exp) (tagged-list? exp 'and))
(define (or? exp) (tagged-list? exp 'or))
(define (eval-and exp env)
    (cond   ((null? exp) false)
            ((null? (rest-exps exp)) (eval (first-exp exp) env))
            ((eval (first-exp exp) env) (eval-and (rest-exps exp) env))
            (else false)))
(define (eval-or exp env)
    (cond   ((null? exp) false)
            ((null? (rest-exps exp)) (eval (first-exp exp) env))
            ((eval (first-exp exp) env) true)
            (else (eval-and (rest-exps exp) env))))

(define (eval exp env)
    (cond   ((self-evaluating? exp) exp)
            ((variable? exp) (lookup-variable-value exp env))
            ((quoted? exp) (text-of-quotation exp))
            ((assignment? exp) (eval-assignment exp env))
            ((definition? exp) (eval-definition exp env))
            ((and? exp) (eval-and (operands exp) env))
            ((or? exp) (eval-or (operands exp) env))
            ((lambda? exp)
                (make-procedure (lambda-parameters exp)
                                (lambda-body exp)
                                env))
            ((begin? exp)
                (eval-sequence (begin-actions exp) env))
            ((cond? exp) (eval (cond->if exp) env))
            ((application? exp)
                (apply (eval (operator exp) env)
                        (list-of-values (operands exp) env)))
            (else
                (error "Unknown expression type -- EVAL" exp))))



; Test:
(eval (cons 'and (list 'true 'true)) the-global-environment)
(eval (cons 'and (list 'true 'false)) the-global-environment)
(eval (cons 'and (list 'false 'false)) the-global-environment)
(eval (cons 'or (list 'true 'true)) the-global-environment)
(eval (cons 'or (list 'true 'false)) the-global-environment)
(eval (cons 'or (list 'false 'false)) the-global-environment)

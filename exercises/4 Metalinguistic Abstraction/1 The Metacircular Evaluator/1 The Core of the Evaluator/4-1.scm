#lang sicp
(#%require "../../../helpers/evaluator.scm")


; Notice that we cannot tell whether the metacircular evaluator evaluates operands from left to
; right or from right to left. Its evaluation order is inherited from the underlying Lisp: If the arguments to
; cons in list-of-values are evaluated from left to right, then list-of-values will evaluate
; operands from left to right; and if the arguments to cons are evaluated from right to left, then list-ofvalues
; will evaluate operands from right to left.

; (define (list-of-values exps env)
;     (if (no-operands? exps)
;         '()
;         (cons (eval (first-operand exps) env)
;                 (list-of-values (rest-operands exps) env))))



; Answer:

(define (list-of-values-ltr exps env)
    (if (no-operands? exps)
        '()
        (let ((x (eval (first-operand exps) env)))
            (cons x (list-of-values (rest-operands exps) env)))))

(define (list-of-values-rtl exps env)
    (list-of-values-ltr (reverse exps) env))



; Test:
(list-of-values-ltr (cons 'mul (list 1 2 3)) the-global-environment)
(list-of-values-rtl (cons 'mul (list 1 2 3)) the-global-environment)

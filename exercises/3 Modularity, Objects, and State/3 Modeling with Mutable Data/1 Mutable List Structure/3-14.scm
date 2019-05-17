#lang sicp

; The following procedure is quite useful, although obscure:

(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                (set-cdr! x y)
                (loop temp x))))
    (loop x '()))

; Loop uses the ``temporary'' variable temp to hold the old value of the cdr of x, since the set-cdr! on
; the next line destroys the cdr. Explain what mystery does in general. Suppose v is defined by
; (define v (list 'a 'b 'c 'd)). Draw the box-and-pointer diagram that represents the list to
; which v is bound. Suppose that we now evaluate (define w (mystery v)). Draw box-and-pointer
; diagrams that show the structures v and w after evaluating this expression. What would be printed as the
; values of v and w ?



; Mystery produces the inverse order of list items.

(define v (list 'a 'b 'c 'd))

; v -> [ * | * ] -> [ * | * ] -> [ * | * ] -> [ * | \ ]
;        |            |            |            |
;        v            v            v            v
;       [a]          [b]          [c]          [d]

(define w (mystery v))
; (loop (a b c d) ())
; temp -> [ * | * ] -> [ * | * ] -> [ * | \ ]
;             |            |            |
;             v            v            v
;            [b]          [c]          [d]
; x,v -> [ * | \ ]
;          |
;          v
;         [a]
; (loop (b c d) (a))
; temp -> [ * | * ] -> [ * | \ ]
;             |            |
;             v            v
;            [c]          [d]
; x[prev temp] -> [ * | * ] -> [ * | \ ]
;                   |            |
;                   v            v
;                  [b]          [a]
; (loop (c d) (b a))
; temp -> [ * | \ ]
;             |
;             v
;            [d]
; x[prev temp] -> [ * | * ] -> [ * | * ] -> [ * | \ ]
;                   |            |            |
;                   v            v            v
;                  [c]          [b]          [a]
; (loop (d) (c b a))
; temp -> ()'
; x[prev temp] -> [ * | * ] -> [ * | * ] -> [ * | * ] -> [ * | \ ]
;                   |            |            |            |
;                   v            v            v            v
;                  [d]          [c]          [b]          [a]
; (loop () (d c b a))
; w -> [ * | * ] -> [ * | * ] -> [ * | * ] -> [ * | \ ]
;        |            |            |            |
;        v            v            v            v
;       [d]          [c]          [b]          [a]
(display v)             ; (a)
(display w)             ; (d c b a)

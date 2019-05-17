#lang sicp

; Draw environment diagrams to illustrate the evaluation of the sequence of expressions

; (define x (cons 1 2))
; (define z (cons x x))
; (set-car! (cdr z) 17)
; (car x)
; 17

; using the procedural implementation of pairs given above. (Compare exercise 3.11.)



(define (cons x y)
    (define (set-x! v) (set! x v))
    (define (set-y! v) (set! y v))
    (define (dispatch m)
        (cond   ((eq? m 'car) x)
                ((eq? m 'cdr) y)
                ((eq? m 'set-car!) set-x!)
                ((eq? m 'set-cdr!) set-y!)
                (else (error "Undefined operation -- CONS" m))))
    dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
    ((z 'set-car!) new-value)
    z)
(define (set-cdr! z new-value)
    ((z 'set-cdr!) new-value)
    z)



; global env
; ---------------------
; | cons: ->          | parameters: x y
; |                   | body:
; |                   |   (define (set-x!) ...)
; |                   |   (define (set-y!) ...)
; |                   |   (define (dispatch) ...)
; |                   |   dispatch
; |                   |
; | car: ->           | parameters: z
; |                   | body: (z 'car)
; |                   |
; | cdr: ->           | parameters: z
; |                   | body: (z 'cdr)
; |                   |
; | set-car!: ->      | parameters: z new-value
; |                   | body:
; |                   | ((z 'set-car!) new-value)
; |                   | z
; |                   |
; | set-cdr!: ->      | parameters: z new-value
; |                   | body:
; |                   | ((z 'set-cdr!) new-value)
; |                   | z
; ---------------------

(define x (cons 1 2))

; global env
; ---------------------
; | cons: ..          |
; | car: ..           |
; | cdr: ..           |
; | set-car!: ..      |
; | set-cdr!: ..      |
; | x: ->             |                               ->      E1
; |                   | parameters: x y                       parameters: 1 2
; |                   | body:                                 set-x! -> parameters: v || body: (set! 1 v)
; |                   |   (cond ((eq? m 'car)  ...            set-y! -> parameters: v || body: (set! 2 v)
; ---------------------

(define z (cons x x))

; global env
; ---------------------
; | cons: ..          |
; | car: ..           |
; | cdr: ..           |
; | set-car!: ..      |
; | set-cdr!: ..      |
; | x: ..             | [E1] <----------------------------------------------------
; | z: ->             |                               ->      E2                 |
; |                   | parameters: x y                       parameters: x x ----
; |                   | body:                                 set-x! -> parameters: v || body: (set! x v)
; |                   |   (cond ((eq? m 'car)  ...            set-y! -> parameters: v || body: (set! x v)
; ---------------------

(set-car! (cdr z) 17)

; global env
; ---------------------
; | cons: ..          |
; | car: ..           |
; | cdr: ..           |
; | set-car!: ..      |
; | set-cdr!: ..      |
; | x: ..             | 
; | z: ..             |
; |                   |
; | (set-car! ...     |                                           E3                  E4  [-> E2 -> E1]   E5
; |                   | parameters: z new-value                   p:(cdr z) 17        p: z -> x  -> 1     p: 1 17
; |                   | body:                                     ((z 'set-car!) 17)  body: (z 'car)      body: ((1 'set-car!) 17) 1
; |                   |   ((z 'set-cdr!) new-value)  ...          z
; |                   |   z                                       
; ---------------------

(car x)                 ;17

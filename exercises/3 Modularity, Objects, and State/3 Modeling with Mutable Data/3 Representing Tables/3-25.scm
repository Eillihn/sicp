#lang sicp

; Generalizing one- and two-dimensional tables, show how to implement a table in which
; values are stored under an arbitrary number of keys and different values may be stored under different
; numbers of keys. The lookup and insert! procedures should take as input a list of keys used to access
; the table.

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter   (op result (car rest))
                    (cdr rest))))
    (iter initial sequence))

(define (make-table)
    (let ((local-table (list '*table*)))
        (define (lookup keys)
            (define (lookup-helper records key)
                (if records
                    (let ((record (assoc key records))) 
                        (if record 
                            (cdr record) 
                                false))
                    false))
            (fold-left lookup-helper (cdr local-table) keys))
        (define (insert! keys value)
            (define (insert-helper resords key) 
                (let ((record (assoc key (cdr resords)))) 
                (if record 
                    record 
                    (let ((new (cons (list key) 
                                    (cdr resords)))) 
                        (set-cdr! resords new) 
                        (car new))))) 
            (set-cdr! (fold-left insert-helper local-table keys) 
                        value)) 
        (define (dispatch m)
            (cond   ((eq? m 'lookup-proc) lookup)
                    ((eq? m 'insert-proc!) insert!)
                    ((eq? m 'print) local-table)
                    (else (error "Unknown operation -- TABLE" m))))
    dispatch))



(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put (list 0 0 0) 'q)
(put (list 0 0 1) 'w)
(put (list 0 0 2) 'e)

(get (list 0 0 1))
(operation-table 'print)

#lang sicp

; In the table implementations above, the keys are tested for equality using equal? (called
; by assoc). This is not always the appropriate test. For instance, we might have a table with numeric keys
; in which we don't need an exact match to the number we're looking up, but only a number within some
; tolerance of it. Design a table constructor make-table that takes as an argument a same-key?
; procedure that will be used to test ``equality'' of keys. Make-table should return a dispatch
; procedure that can be used to access appropriate lookup and insert! procedures for a local table.

; (define (make-table)
;     (let ((local-table (list '*table*)))
;         (define (lookup key-1 key-2)
;             (let ((subtable (assoc key-1 (cdr local-table))))
;                 (if subtable
;                     (let ((record (assoc key-2 (cdr subtable))))
;                         (if record
;                             (cdr record)
;                             false))
;                     false)))
;         (define (insert! key-1 key-2 value)
;             (let ((subtable (assoc key-1 (cdr local-table))))
;                 (if subtable
;                     (let ((record (assoc key-2 (cdr subtable))))
;                         (if record
;                             (set-cdr! record value)
;                             (set-cdr! subtable
;                                     (cons (cons key-2 value)
;                                         (cdr subtable)))))
;                     (set-cdr! local-table
;                         (cons (list key-1
;                                 (cons key-2 value))
;                             (cdr local-table)))))
;             'ok)
;         (define (dispatch m)
;             (cond   ((eq? m 'lookup-proc) lookup)
;                     ((eq? m 'insert-proc!) insert!)
;                     (else (error "Unknown operation -- TABLE" m))))
;     dispatch))



(define (make-table same-key?)
    (let ((local-table (list '*table*)))
        (define (assoc key records)
            (cond   ((null? records) #f)
                    ((same-key? key (caar records)) (car records))
                    (else (assoc key (cdr records)))))
        (define (lookup key-1 key-2)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (cdr record)
                            false))
                    false)))
        (define (insert! key-1 key-2 value)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (set-cdr! record value)
                            (set-cdr! subtable
                                    (cons (cons key-2 value)
                                        (cdr subtable)))))
                    (set-cdr! local-table
                        (cons (list key-1
                                (cons key-2 value))
                            (cdr local-table)))))
            'ok)
        (define (dispatch m)
            (cond   ((eq? m 'lookup-proc) lookup)
                    ((eq? m 'insert-proc!) insert!)
                    (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table (lambda (a b) (< (abs (- a b)) 1))))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 0 0 'q)
(put 0 1 'w)
(put 0 2 'e)
(put 1 0 'a)
(put 1 1 's)
(put 1 2 'd)

(get 1 2)
(get 1 0)
(get 0 1)
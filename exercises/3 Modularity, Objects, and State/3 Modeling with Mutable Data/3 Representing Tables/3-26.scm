#lang sicp

; To search a table as implemented above, one needs to scan through the list of records. This
; is basically the unordered list representation of section 2.3.3. For large tables, it may be more efficient to
; structure the table in a different manner. Describe a table implementation where the (key, value) records
; are organized using a binary tree, assuming that keys can be ordered in some way (e.g., numerically or
; alphabetically). (Compare exercise 2.66 of chapter 2.)



(define (make-table)
    (let ((local-table '()))
        (define (entry tree) (car tree)) 
        (define (left-branch tree) (cadr tree)) 
        (define (right-branch tree) (caddr tree)) 
        (define (make-tree entry left right) 
            (list entry left right)) 
        (define (adjoin-set x set) 
            (cond   ((null? set) (make-tree x '() '())) 
                    ((= (car x) (car (entry set))) set) 
                    ((< (car x) (car (entry set))) 
                        (make-tree  (entry set) 
                                    (adjoin-set x (left-branch set)) 
                                    (right-branch set))) 
                    ((> (car x) (car (entry set))) 
                        (make-tree  (entry set) 
                                    (left-branch set) 
                                    (adjoin-set x (right-branch set)))))) 
        (define (key record) (car record))
        (define (data record) (cdr record))
        (define (make-record key data) (cons key data))
        (define (lookup-helper key records)
            (cond   ((null? records) false)
                    ((= key (car (entry records))) (entry records))
                    ((< key (car (entry records))) (lookup-helper key (left-branch records)))
                    ((> key (car (entry records))) (lookup-helper key (right-branch records)))))
        (define (insert! key value) 
            (let ((record (lookup-helper key local-table))) 
                (if record 
                    (set-cdr! record value) 
                    (set! local-table (adjoin-set (cons key value) local-table))))) 
        (define (lookup key) 
            (lookup-helper key local-table)) 
        (define (dispatch m)
            (cond   ((eq? m 'lookup-proc) lookup)
                    ((eq? m 'insert-proc!) insert!)
                    ((eq? m 'print) local-table)
                    (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put 123 'a)
(put 5 'b)
(put 56 'c)
(put 11 'd)
(put 1 'e)

(operation-table 'print)

(get 11)

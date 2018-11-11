#lang sicp
(#%require "../../helpers/tree.scm")

;; Implement the lookup procedure for the case where the set of records is structured 
;; as a binary tree, ordered by the numerical values of the keys.

; (define (lookup given-key set-of-records)
;     (cond   ((null? set-of-records) false)
;             ((equal? given-key (key (car set-of-records)))
;                 (car set-of-records))
;             (else (lookup given-key (cdr set-of-records)))))

(define (key record) (car record))
(define (data record) (cdr record))
(define (make-record key data) (cons key data))

(define (lookup given-key set-of-records)
    (cond   ((null? set-of-records) false)
            ((equal? given-key (key (entry set-of-records)))
                (data (entry set-of-records)))
            ((< given-key (key (left-branch set-of-records)))
                (lookup given-key (left-branch set-of-records)))
            (else (lookup given-key (right-branch set-of-records)))))

(define example
  (list->tree (list (make-record 1 'e)
                    (make-record 2 'dd)
                    (make-record 3 'ccc)
                    (make-record 4 'bbbb)
                    (make-record 5 'aaaaa))))
 
(lookup 3 example)

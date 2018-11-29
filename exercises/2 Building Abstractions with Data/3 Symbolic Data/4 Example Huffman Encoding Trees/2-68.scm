#lang sicp
(#%require "../../helpers/huffman-encoding-trees.scm")
(#%require (all-except "../../helpers/set.scm" adjoin-set))

;; The encode procedure takes as arguments a message and a tree and produces the 
;; list of bits that gives the encoded message.

; (define (encode message tree)
;     (if (null? message)
;         '()
;         (append (encode-symbol (car message) tree)
;             (encode (cdr message) tree))))

;; Encode-symbol is a procedure, which you must write, that returns the list of 
;; bits that encodes a given symbol according to a given tree. You should 
;; design encode-symbol so that it signals an error if the symbol is not in the 
;; tree at all. Test your procedure by encoding the result you obtained in 
;; exercise 2.67 with the sample tree and seeing whether it is the same as the 
;; original sample message.



(define (encode-symbol symbol tree)
    (define (build-encoded-str sub-tree result)
        (if (leaf? sub-tree)
            result
            (let    ((left (left-branch sub-tree))
                    (right (right-branch sub-tree)))
                (let    ((left-symbol? (element-of-set? symbol (symbols left)))
                        (right-symbol? (element-of-set? symbol (symbols right))))
                    (cond   (left-symbol? (build-encoded-str left (append result '(0))))
                            (right-symbol? (build-encoded-str right (append result '(1)))))))))
    (build-encoded-str tree '()))

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define sample-tree
    (make-code-tree (make-leaf 'A 4)
        (make-code-tree
            (make-leaf 'B 2)
            (make-code-tree (make-leaf 'D 1)
                (make-leaf 'C 1)))))

(display (encode '(A D A B B C A) sample-tree))       ; (0 1 1 0 0 1 0 1 0 1 1 1 0)

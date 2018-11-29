#lang sicp
(#%require "../../helpers/huffman-encoding-trees.scm")

;; The following procedure takes as its argument a list of symbol-frequency 
;; pairs (where no symbol appears in more than one pair) and generates a 
;; Huffman encoding tree according to the Huffman algorithm.

; (define (generate-huffman-tree pairs)
;     (successive-merge (make-leaf-set pairs)))

;; Make-leaf-set is the procedure given above that transforms the list of 
;; pairs into an ordered set of leaves. Successive-merge is the procedure 
;; you must write, using make-code-tree to successively merge the 
;; smallest-weight elements of the set until there is only one element 
;; left, which is the desired Huffman tree. (This procedure is slightly 
;; tricky, but not really complicated. If you find yourself designing a
;; complex procedure, then you are almost certainly doing something wrong. 
;; You can take significant advantage of the fact that we are using an 
;; ordered set representation.)

(define (successive-merge set)
    (if (null? (cdr set))
        (car set)
        (successive-merge (adjoin-set (make-code-tree (car set) (cadr set)) (cddr set)))))

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

    

;; Test code:

(define pairs (list (list 'A 4) (list 'B 2) (list 'C 1) (list 'D 1)))
(define sample-tree (generate-huffman-tree pairs))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(display (decode sample-message sample-tree))       ; (A D A B B C A)

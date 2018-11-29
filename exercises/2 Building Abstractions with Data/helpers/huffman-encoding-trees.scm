#lang sicp
(#%require "set.scm")
(#%require "tree.scm")

(define (make-leaf symbol weight)
    (list 'leaf symbol weight))
(define (leaf? object)
    (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
    (list   left
            right
            (append (symbols left) (symbols right))
            (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))
(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))

(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            '()
            (let ((next-branch
                    (choose-branch (car bits) current-branch)))
                (if (leaf? next-branch)
                    (cons (symbol-leaf next-branch)
                        (decode-1 (cdr bits) tree))
                    (decode-1 (cdr bits) next-branch)))))
    (decode-1 bits tree))
(define (choose-branch bit branch)
    (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
    (cond   ((null? set) (list x))
            ((< (weight x) (weight (car set))) (cons x set))
            (else (cons (car set)
    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair) ; symbol
                        (cadr pair)) ; frequency
                        (make-leaf-set (cdr pairs))))))

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
                
(define (successive-merge set)
    (if (null? (cdr set))
        (car set)
        (successive-merge (adjoin-set (make-code-tree (car set) (cadr set)) (cddr set)))))

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))
             
(#%provide (all-defined))
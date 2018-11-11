#lang sicp

;; Each of the following two procedures converts a binary tree to a list.

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right))

(define (tree->list-1 tree)
    (if (null? tree)
        '()
        (append (tree->list-1 (left-branch tree))
                (cons   (entry tree)
                        (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list   (left-branch tree)
                            (cons   (entry tree)
                                    (copy-to-list   (right-branch tree)
                                                    result-list)))))
    (copy-to-list tree '()))

;; a. Do the two procedures produce the same result for every tree? 
;; If not, how do the results differ? What lists do the two procedures 
;; produce for the trees in figure 2.16?

;; b. Do the two procedures have the same order of growth in the number 
;; of steps required to convert a balanced tree with n elements to a 
;; list? If not, which one grows more slowly?



;; Answer:

;             7
;            /\
;           3  9
;          /\   \
;         1  5   11

; (7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))



; (tree->list-1 (7
;                 (3 (1 () ()) (5 () ()))
;                 (9 () (11 () ()))))
; (append (tree->list-1 (3 (1 () ()) (5 () ())))
;     (cons 7 (tree->list-1 (9 () (11 () ())))))
; ((tree->list-1 (3 (1 () ()) (5 () ()))) 7 (tree->list-1 (9 () (11 () ())))))
; (append (append (tree->list-1 (1 () ()))
;                 (cons 3 (tree->list-1 (5 () ()))))
;     (cons 7
;         (append (tree->list-1 ()) 
;                 (cons 9 (tree->list-1 (11 () ()))))))
; (append (append (append (tree->list-1 ()) (cons 1 (tree->list-1 ())))
;         (cons 3
;             (append (tree->list-1 ()) (cons 5 (tree->list-1 ())))))
;     (cons 7
;         (append 
;             ()
;             (cons 9 
;                 (append (tree->list-1 ()) (cons 11 (tree->list-1 ())))))))
; (1 3 5 7 9 11)

;; Order of growth [space]: Q(n).
;; Order of growth [time]:
;; cons has Q(c) growth, append has Q(n).
;; If tree is unbalanced and contain all n items in the left, 
;; so the number of operations performed is 
;; (n − 1) + (n − 2) + (n − 3) + ... + 1 =
;; = Sum (n, k=1) (n - k) = 
;; = (n - 1)*n/2 = 1/2 * (n^2 - n).
;; If tree is balanced, only half items will included in next 
;; recursion call. So, tree->list-1 has Q(n^2) growth with 
;; unbalanced tree, and Q(nlogn).



; (tree->list-2 (7
;     (3 (1 () ()) (5 () ()))
;     (9 () (11 () ()))))
; (copy-to-list   (7
;                     (3 (1 () ()) (5 () ()))
;                     (9 () (11 () ())))
;                 '())
; (copy-to-list   (3 (1 () ()) (5 () ()))
;                 (cons   7
;                         (copy-to-list   (9 () (11 () ()))
;                                         '())))
; (copy-to-list   (3 (1 () ()) (5 () ()))
;                 (cons   7
;                         (copy-to-list   ()
;                                         (cons   9
;                                                 (copy-to-list   (11 () ())
;                                                                 ())))))
; (copy-to-list   (3 (1 () ()) (5 () ()))
;                 (cons   7
;                         (copy-to-list   ()
;                                         (cons   9
;                                                 (copy-to-list   ()
;                                                                 (cons   11
;                                                                         (copy-to-list   ()
;                                                                                         ())))))))
; (copy-to-list   (3 (1 () ()) (5 () ()))
;                 (7 9 11))
; (copy-to-list   (1 () ())
;                 (cons   3
;                         (copy-to-list   (5 () ())
;                                         (7 9 11))))
; (copy-to-list   (1 () ())
;                 (cons   3
;                         (copy-to-list   ()
;                                         (cons   5
;                                                 (copy-to-list   ()
;                                                                 (7 9 11))))))
; (copy-to-list   (1 () ())
;                 (3 5 7 9 11))
; (copy-to-list   ()
;                 (cons   1
;                         (copy-to-list   ()
;                                         (3 5 7 9 11))))
; (1 3 5 7 9 11)

;; Order of growth [space]: Q(n).
;; Order of growth [time]:
;; cons has Q(c) growth.
;; So, the overall number of steps required by 
;; tree->list-2 grows as Q(n).



(define tree1 (make-tree 7 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 9 '() (make-tree 11 '() '())))) 
(define tree2 (make-tree 3 (make-tree 1 '() '()) (make-tree 7 (make-tree 5 '() '()) (make-tree 9 '() (make-tree 11 '() '())))))
(define tree3 (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '()) (make-tree 9 (make-tree 7 '() '()) (make-tree 11 '() '()))))

(display (tree->list-1 tree1))              ; (1 3 5 7 9 11)
(newline)
(display (tree->list-2 tree1))              ; (1 3 5 7 9 11)
(newline)
(display (tree->list-1 tree2))              ; (1 3 5 7 9 11)
(newline)
(display (tree->list-2 tree2))              ; (1 3 5 7 9 11)
(newline)
(display (tree->list-1 tree3))              ; (1 3 5 7 9 11)
(newline)
(display (tree->list-2 tree3))              ; (1 3 5 7 9 11)

;; a. Do the two procedures produce the same result for every tree?
;; Yes, the two procedures produce the same result for every tree.

;; b. Do the two procedures have the same order of growth in 
;; the number of steps required to convert a balanced tree 
;; with n elements to a list? If not, which one grows more slowly?
;; No, the two procedures have NOT the same order of growth.
;; tree->list-2 grows more slowly.

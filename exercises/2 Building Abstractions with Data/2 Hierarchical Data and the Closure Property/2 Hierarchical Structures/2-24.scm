#lang sicp

;; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))). Give the result 
;; printed by the interpreter, the corresponding box-and-pointer structure, and the 
;; interpretation of this as a tree (as in figure 2.6).

(list 1 (list 2 (list 3 4)))    ; (mcons 1 (mcons (mcons 2 (mcons (mcons 3 (mcons 4 '())) '())) '()))

;; (1 (2 (3, 4)))
;; +----+----+     +----+----+
;; | *  | *  | --  | *  | *  | (2 (3, 4))
;; +----+----+     +----+----+
;;   |               |
;; +----+          +----+----+     +----+----+
;; | 1  |          | *  | *  | --  | *  | *  | (3, 4)
;; +----+          +----+----+     +----+----+
;;                   |               |
;;                 +----+          +----+----+     +----+----+
;;                 | 2  |          | *  | *  | --  | *  | /  |
;;                 +----+          +----+----+     +----+----+
;;                                   |               |
;;                                 +----+          +----+
;;                                 | 3  |          | 4  |
;;                                 +----+          +----+

;;   ^ (1 (2 (3, 4)))
;; /   \
;; 1    ^ (2 (3, 4))
;;    /   \
;;    2    ^ (3, 4)
;;       /   \
;;       3   4


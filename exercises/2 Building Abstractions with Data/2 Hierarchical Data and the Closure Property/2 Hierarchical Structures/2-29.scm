#lang sicp

;; A binary mobile consists of two branches, a left branch and a right branch. 
;; Each branch is a rod of a certain length, from which hangs either a weight 
;; or another binary mobile. We can represent a binary mobile using compound 
;; data by constructing it from two branches (for example, using list):
;; (define (make-mobile left right)
;;     (list left right))
;; A branch is constructed from a length (which must be a number) together 
;; with a structure, which may be either a number (representing a simple 
;; weight) or another mobile:
;; (define (make-branch length structure)
;;     (list length structure))

;; a. Write the corresponding selectors left-branch and right-branch, which 
;; return the branches of a mobile, and branch-length and branch-structure, 
;; which return the components of a branch.
;; b. Using your selectors, define a procedure total-weight that returns the 
;; total weight of a mobile.
;; c. A mobile is said to be balanced if the torque applied by its top-left 
;; branch is equal to that applied by its top-right branch (that is, if the 
;; length of the left rod multiplied by the weight hanging from that rod is 
;; equal to the corresponding product for the right side) and if each of the 
;; submobiles hanging off its branches is balanced. Design a predicate that 
;; tests whether a binary mobile is balanced.
;; d. Suppose we change the representation of mobiles so that the constructors 
;; are
;; (define (make-mobile left right)
;;     (cons left right))
;; (define (make-branch length structure)
;;     (cons length structure))
;; How much do you need to change your programs to convert to the new 
;; representation?



;; Answer:
;; a. Comment d), and uncomment next lines:
(define (make-mobile left right)
    (list left right))
(define (make-branch length structure)
    (list length structure))
(define (left-branch m) (car m))
(define (right-branch m) (car(cdr m)))
(define (branch-length b) (car b))
(define (branch-structure b) (car(cdr b)))
;; d. Comment a), and uncomment next lines:
; (define (make-mobile left right)
;     (cons left right))
; (define (make-branch length structure)
;     (cons length structure))
; (define (left-branch m) (car m))
; (define (right-branch m) (cdr m))
; (define (branch-length b) (car b))
; (define (branch-structure b) (cdr b))
;; b.
(define (total-weight mobile)
    (+  (branch-weight (left-branch mobile))
        (branch-weight (right-branch mobile))))

 (define (branch-weight branch)
    (let    ((structure (branch-structure branch)))
        (if (pair? structure)
            (total-weight structure)
            structure)))
;; Test code:
(define mobile1
    (make-mobile    (make-branch 2 5) 
                    (make-branch 1 10)))
(define mobile2 
    (make-mobile    (make-branch 1 4) 
                    (make-branch 3 (make-mobile (make-branch 1 4) 
                                                (make-branch 8 2)))))
(define mobile3 
    (make-mobile    (make-branch 2 (make-mobile (make-branch 5 2) 
                                                (make-branch 1 10))) 
                    (make-branch 1 (make-mobile (make-branch 2 8) 
                                                (make-branch 1 16)))))
(total-weight mobile1)      ; 15
(total-weight mobile2)      ; 10
(total-weight mobile3)      ; 36
;; c.
(define (balanced? mobile)
    (let    ((left (left-branch mobile))
            (right (right-branch mobile)))
        (and    (= (torque left) (torque right))
                (branch-balanced? left)
                (branch-balanced? right))))
 (define (branch-balanced? branch)
    (let    ((structure (branch-structure branch)))
        (or (and (pair? structure) (balanced? structure))
            (not (pair? structure)))))

(define (torque branch) 
    (*  (branch-weight branch)
        (branch-length branch)))
;; Test code:
(balanced? mobile1)
(balanced? mobile2)
(balanced? mobile3)

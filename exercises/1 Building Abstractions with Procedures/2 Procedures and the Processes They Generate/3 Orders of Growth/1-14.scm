#lang sicp

(define (count-change amount)
    (cc amount 5))
(define (cc amount kinds-of-coins)
    (cond   ((= amount 0) 1)
            ((or (< amount 0) (= kinds-of-coins 0)) 0)
            (else (+    (cc amount
                            (- kinds-of-coins 1))
                        (cc (- amount
                                (first-denomination kinds-of-coins))
                            kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
    (cond   ((= kinds-of-coins 1) 1)
            ((= kinds-of-coins 2) 5)
            ((= kinds-of-coins 3) 10)
            ((= kinds-of-coins 4) 25)
            ((= kinds-of-coins 5) 50)))

;; 1) Draw the tree illustrating the process generated 
;; by the count-change procedure in making change for 11 cents. 
;; 2) What are the orders of growth of the space 
;; and number of steps used by this process as the amount to be changed increases?



;; Answer:
;;                         cc 11 5
;;                         /       \
;;                     cc 11 4      cc -39 5
;;                     /     \
;;                 cc 11 3    cc -14 4
;;                 /     \
;;                /       \
;;         cc 11 2          ------------------------------------------------------------------     cc 1 3
;;         /      \                                                                               /     \
;;        /        \                                                                             /       \
;;     cc 11 1       -------------------- cc 6 2                                             cc 1 2      cc -9 3
;;     /      \                          /      \                                           /      \
;; cc 11 0     cc 10 1                 cc 6 1    --------------- cc 1 2                 cc 1 1     cc -4 2
;;             /      \                /     \                  /     \                 /    \
;;         cc 10 0     cc 9 1      cc 6 0  cc 5 1           cc 1 1    cc -4 2       cc 1 0   cc 0 1
;;                     /    \              /    \           /     \
;;                 cc 9 0   cc 8 1     cc 5 0   cc 4 1   cc 1 0    cc 0 1
;;                         /      \            /      \
;;                     cc 8 0    cc 7 1    cc 4 0      cc 3 1
;;                               /    \               /     \
;;                         cc 7 0      cc 6 1      cc 3 0  cc 2 1
;;                                     /    \              /     \
;;                                 cc 6 0  cc 5 1       cc 2 0    cc 1 1
;;                                         /    \                 /    \
;;                                     cc 5 0   cc 4 1         cc 1 0  cc 0 1
;;                                             /      \
;;                                         cc 4  0     cc 3 1
;;                                                     /     \
;;                                                 cc 3 0    cc 2 1
;;                                                         /       \
;;                                                     cc 2 0      cc 1 1
;;                                                                 /      \
;;                                                             cc 1 0      cc 0 1

;; Depth is 5 + 11 => k + n, k - kind of coins, n - amount os change.
;; So, O(n + k) - the order of growth of space is equal to the maximum depth of tree and
;; the order of growth of steps is O(2^(n+k)), 2 - number of tree brunches.

;; k - is constant (5), so for our example:
;;      O(n) - the order of growth of space;
;;      O(2^n) - the order of growth of steps.

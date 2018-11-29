#lang sicp

;; Consider the encoding procedure that you designed in exercise 2.68. 
;; What is the order of growth in the number of steps needed to encode 
;; a symbol? Be sure to include the number of steps needed to search 
;; the symbol list at each node encountered. To answer this question in 
;; general is difficult. Consider the special case where the relative 
;; frequencies of the n symbols are as described in exercise 2.71, and 
;; give the order of growth (as a function of n) of the number of steps 
;; needed to encode the most frequent and least frequent symbols in the 
;; alphabet.

; (define (encode-symbol symbol tree)
;     (define (build-encoded-str sub-tree result)
;         (if (leaf? sub-tree)
;             result
;             (let    ((left (left-branch sub-tree))
;                     (right (right-branch sub-tree)))
;                 (let    ((left-symbol? (element-of-set? symbol (symbols left)))
;                         (right-symbol? (element-of-set? symbol (symbols right))))
;                     (cond   (left-symbol? (build-encoded-str left (append result '(0))))
;                             (right-symbol? (build-encoded-str right (append result '(1)))))))))
;     (build-encoded-str tree '()))

;; n symbols, frequencies - 1, 2, 4, ..., 2^n-1.



;; Answer:
;; element-of-set?:
;; Order of growth [space]: Q(1).
;; Order of growth [time]: Q(n) as the function should processes all 
;; set elements (in the worst case).

;; => encode-symbol (2.68):
;; Order of growth [space]: Q(logn).
;; Order of growth [time]: Q(nlogn) =>
;; (n/2 + n/2) + (n/4 + n/4) + (1 + 1) = 
;; = Sum k=1,logn 2(n/2) = 
;; = Sum k=1,logn n = (1 + n)logn/2 => Q(nlogn)

;; => encode-symbol (2.71):
;; Order of growth [space]: Q(n).
;; Order of growth [time]: Q(n^2) =>
;; (1 + n - 1) + (1 + n - 2) + ... + 1 = 
;; = Sum k=1,n (1 + n - k) = 
;; = Sum k=1,n = (1 + n - 1 + 1)n/2 =
;; = Sum k=1,n = (1 + n)n/2 => Q(n^2)

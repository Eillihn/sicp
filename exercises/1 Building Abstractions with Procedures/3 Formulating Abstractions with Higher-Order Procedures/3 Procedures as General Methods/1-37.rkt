#lang sicp

;; a. An infinite continued fraction is an expression of the form
;;              N1
;; f = --------------------
;;                N2
;;     D1 + ---------------
;;                   N3
;;          D2 + ----------
;;                 D3 + ...
;; As an example, one can show that the infinite continued fraction expansion with 
;; the Ni and the Di all equal to 1 produces 1/φ, where φ is the golden ratio 
;; (described in section 1.2.2). One way to approximate an infinite continued fraction 
;; is to truncate the expansion after a given number of terms. Such a truncation -- a
;; so-called k-term finite continued fraction -- has the form
;;          N1
;; f = -------------
;;             N2
;;     D1 + --------
;;                Nk
;;          ... + --
;;                Dk
;; 1) Suppose that n and d are procedures of one argument (the term index i) that return 
;; the Ni and Di of the terms of the continued fraction. Define a procedure cont-frac 
;; such that evaluating (cont-frac n d k) computes the value of the k-term 
;; finite continued fraction.
;; 2) Check your procedure by approximating
;; 1/φ using
;; (cont-frac  (lambda (i) 1.0)
;;             (lambda (i) 1.0)
;;             k)
;; for successive values of k.
;; 3) How large must you make k in order to get an approximation that is accurate to
;; 4 decimal places?

;; b. If your cont-frac procedure generates a recursive process, write one that 
;; generates an iterative process. If it generates an iterative process, write one that 
;; generates a recursive process.



;; Answer:

;; a. Recursive process, k must be at least 10 to get an approximation that is accurate
;; to 4 decimal places

(define (cont-frac n d k)
    (define (frac i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i)
                (+  (d i) 
                    (frac (inc i))))))
    (frac 1))

(cont-frac  (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)                     ; 0.6180555555555556

;; b. Iterative process

(define (cont-frac-iter n d k)
    (define (frac i result)
        (if (> i 0)
            (frac   (dec i)
                    (/ (n i) (+ (d i) result)))
            result))
    (frac k 0))

(cont-frac-iter  (lambda (i) 1.0)
            (lambda (i) 1.0)
            11)                     ; 0.6180555555555556

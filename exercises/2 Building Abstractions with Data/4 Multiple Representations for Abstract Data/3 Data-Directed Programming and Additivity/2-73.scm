#lang racket

;; Section 2.3.2 described a program that performs symbolic differentiation:

; (define (deriv exp var)
;     (cond   ((number? exp) 0)
;             ((variable? exp) (if (same-variable? exp var) 1 0))
;             ((sum? exp)
;                 (make-sum   (deriv (addend exp) var)
;                             (deriv (augend exp) var)))
;             ((product? exp)
;                 (make-sum
;                     (make-product (multiplier exp)
;                         (deriv (multiplicand exp) var))
;                     (make-product (deriv (multiplier exp) var)
;                         (multiplicand exp))))
;             ; <more rules can be added here>
;             (else (error "unknown expression type -- DERIV" exp))))

;; We can regard this program as performing a dispatch on the type of the 
;; expression to be differentiated. In this situation the ``type tag'' of the 
;; datum is the algebraic operator symbol (such as +) and the operation
;; being performed is deriv. We can transform this program into data-directed 
;; style by rewriting the basic derivative procedure as

(define table (make-hash))

(define (put op type item)
  (hash-set! table (list op type) item))

(define (get op type)
  (hash-ref table (list op type)))

(define (deriv exp var)
    (cond   ((number? exp) 0)
            ((variable? exp) (if (same-variable? exp var) 1 0))
            (else ((get 'deriv (operator exp)) (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; a. Explain what was done above. Why can't we assimilate the predicates 
;; number? and same-variable? into the data-directed dispatch?
;; b. Write the procedures for derivatives of sums and products, and the 
;; auxiliary code required to install them in the table used by the program 
;; above.
;; c. Choose any additional differentiation rule that you like, such as the 
;; one for exponents (exercise 2.56), and install it in this data-directed 
;; system.
;; d. In this simple algebraic manipulator the type of an expression is the 
;; algebraic operator that binds it together. Suppose, however, we indexed 
;; the procedures in the opposite way, so that the dispatch line in deriv 
;; looked like

; ((get (operator exp) 'deriv) (operands exp) var)

;; What corresponding changes to the derivative system are required?



;; Answer:

;; a. number? and same-variable? can't be assimilated into the data-directed
;; dispatch because they have no operator and operation to be executed.

;; b. The procedures for derivatives of sums and products, and the auxiliary 
;; code required to install them in the table used by the program above.

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
    (and (number? exp) (= exp num)))

(define (install-deriv-sum-package)
    ;; internal procedures
    (define (make-sum a1 a2)
        (cond   ((=number? a1 0) a2)
                ((=number? a2 0) a1)
                ((and (number? a1) (number? a2)) (+ a1 a2))
                (else (list '+ a1 a2))))
    (define (addend s) (car s))
    (define (augend s) (cadr s))
    (define (deriv-sum exp var)
        (make-sum   (deriv (addend exp) var)
                    (deriv (augend exp) var)))
    ;; interface to the rest of the system
    (put 'make '+ make-sum)
    (put 'deriv '+ deriv-sum)
    'done)

(define (install-deriv-product-package)
    ;; internal procedures
    (define (make-product m1 m2)
        (cond   ((or (=number? m1 0) (=number? m2 0)) 0)
                ((=number? m1 1) m2)
                ((=number? m2 1) m1)
                ((and (number? m1) (number? m2)) (* m1 m2))
                (else (list '* m1 m2))))
    (define (multiplier p) (car p))
    (define (multiplicand p) (cadr p))
    (define (deriv-product exp var)
        ((get 'make '+)
            (make-product (multiplier exp)
                (deriv (multiplicand exp) var))
            (make-product (deriv (multiplier exp) var)
                (multiplicand exp))))
    ;; interface to the rest of the system
    (put 'make '* make-product)
    (put 'deriv '* deriv-product)
    'done)

;; c. Additional differentiation rule for exponents:

(define (install-deriv-expt-package)
    ;; internal procedures
    (define (make-exponentiation b e)
        (cond   ((=number? e 0) 1)
                ((=number? e 1) b)
                ((and (number? b) (number? e)) (expt b e))
                (else (list '** b e))))
    (define (exponentiation? x)
        (and (pair? x) (eq? (car x) '**)))
    (define (base p) (car p))
    (define (exponent p) (cadr p))
    (define (deriv-exponentiation exp var)
        (let    ((u (base exp))
                (n (exponent exp)))
            ((get 'make '*) ((get 'make '*) n
                                            (make-exponentiation    u
                                                                    ((get 'make '+) n -1)))
                            (deriv u var))))
    ;; interface to the rest of the system
    (put 'make '** make-exponentiation)
    (put 'deriv '** deriv-exponentiation)
    'done)

;; d. If we will indexed the procedures in the opposite way, so that the 
;; dispatch line in deriv looked like
; ((get (operator exp) 'deriv) (operands exp) var)
;; we should make appropriate changes in install packages that uses get and 
;; deriv procedure.



;; Test code:
(install-deriv-sum-package)
(install-deriv-product-package)
(install-deriv-expt-package)

(deriv 1 'x)                            ; 0
(deriv 'x 'x)                           ; 1
(deriv '(+ x 3) 'x)                     ; 1
(deriv '(* x y) 'x)                     ; y
(deriv '(** x 0) 'x)                    ; 0
(deriv '(** x 1) 'x)                    ; 1
(deriv '(** x 5) 'x)                    ; (* 5 (** x 4))

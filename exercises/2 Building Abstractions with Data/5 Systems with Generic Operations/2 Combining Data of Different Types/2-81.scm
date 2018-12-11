#lang racket

;; Louis Reasoner has noticed that apply-generic may try to coerce the arguments to each 
;; other's type even if they already have the same type. Therefore, he reasons, we need 
;; to put procedures in the coercion table to "coerce" arguments of each type to their 
;; own type. For example, in addition to the scheme-number->complex coercion shown above, 
;; he would do:

; (define (scheme-number->scheme-number n) n)
; (define (complex->complex z) z)
; (put-coercion 'scheme-number 'scheme-number
;     scheme-number->scheme-number)
; (put-coercion 'complex 'complex complex->complex)

;; a. With Louis's coercion procedures installed, what happens if apply-generic is called 
;; with two arguments of type scheme-number or two arguments of type complex for an 
;; operation that is not found in the table for those types? For example, assume that 
;; we've defined a generic exponentiation operation:

; (define (exp x y) (apply-generic 'exp x y))

;; and have put a procedure for exponentiation in the Scheme-number package but not in 
;; any other package:

; following added to Scheme-number package
; (put 'exp '(scheme-number scheme-number)
;     (lambda (x y) (tag (expt x y)))) ; using primitive expt

;; What happens if we call exp with two complex numbers as arguments?

;; b. Is Louis correct that something had to be done about coercion with arguments of 
;; the same type, or does apply-generic work correctly as is?

;; c. Modify apply-generic so that it doesn't try coercion if the two arguments have the 
;; same type.



(define (square x) (* x x))



(define table (make-hash))
(define (put op type item)
    (hash-set! table (list op type) item))
(define (get op type)
    (hash-ref table (list op type) #f))



(define coercion-table (make-hash))
(define (put-coercion op type item)
    (hash-set! coercion-table (list op type) item))
(define (get-coercion op type)
    (hash-ref coercion-table (list op type)))



(define (attach-tag type-tag contents)
    (cons type-tag contents))
(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
    (if (pair? datum)
        (cdr datum)
        (error "Bad tagged datum -- CONTENTS" datum)))


;; Example of apply-generic from book:
; (define (apply-generic op . args)
;     (let ((type-tags (map type-tag args)))
;         (let ((proc (get op type-tags)))
;             (if proc
;                 (apply proc (map contents args))
;                 (if (= (length args) 2)
;                     (let    ((type1 (car type-tags))
;                             (type2 (cadr type-tags))
;                             (a1 (car args))
;                             (a2 (cadr args)))
;                         (let    ((t1->t2 (get-coercion type1 type2))
;                                 (t2->t1 (get-coercion type2 type1)))
;                             (cond   (t1->t2
;                                         (apply-generic op (t1->t2 a1) a2))
;                                     (t2->t1
;                                         (apply-generic op a1 (t2->t1 a2)))
;                                     (else
;                                         (error "No method for these types"
;                                             (list op type-tags))))))
;                     (error "No method for these types"
;                         (list op type-tags)))))))
;; c.

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let    ((type1 (car type-tags))
                            (type2 (cadr type-tags))
                            (a1 (car args))
                            (a2 (cadr args)))
                        (let    ((t1->t2 (get-coercion type1 type2))
                                (t2->t1 (get-coercion type2 type1)))
                            (cond   ((eq? type1 type2)
                                        (error "No method for these types"
                                            (list op type-tags)))
                                    (t1->t2
                                        (apply-generic op (t1->t2 a1) a2))
                                    (t2->t1
                                        (apply-generic op a1 (t2->t1 a2)))
                                    (else
                                        (error "No method for these types"
                                            (list op type-tags))))))
                    (error "No method for these types"
                        (list op type-tags)))))))



(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (exp x y) (apply-generic 'exp x y))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))



(define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
        (sqrt (+ (square (real-part z))
            (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))
    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)



(define (install-polar-package)
    ;; internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z)
        (* (magnitude z) (cos (angle z))))
    (define (imag-part z)
        (* (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
            (atan y x)))
    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)



(define (install-scheme-number-package)
    (define (tag x)
        (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number
        (lambda (x) (tag x)))
    (put 'exp '(scheme-number scheme-number)
        (lambda (x y) (tag (expt x y))))
    'done)

(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))



(define (install-rational-package)
    ;; internal procedures
    (define (numer x) (car x))
    (define (denom x) (cdr x))
    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))
    (define (add-rat x y)
        (make-rat   (+  (* (numer x) (denom y))
                        (* (numer y) (denom x)))
                    (* (denom x) (denom y))))
    (define (sub-rat x y)
        (make-rat   (-  (* (numer x) (denom y))
                        (* (numer y) (denom x)))
                    (* (denom x) (denom y))))
    (define (mul-rat x y)
        (make-rat   (* (numer x) (numer y))
                    (* (denom x) (denom y))))
    (define (div-rat x y)
        (make-rat   (* (numer x) (denom y))
                    (* (denom x) (numer y))))
    ;; interface to rest of the system
    (define (tag x) (attach-tag 'rational x))
    (put 'add '(rational rational)
        (lambda (x y) (tag (add-rat x y))))
    (put 'sub '(rational rational)
        (lambda (x y) (tag (sub-rat x y))))
    (put 'mul '(rational rational)
        (lambda (x y) (tag (mul-rat x y))))
    (put 'div '(rational rational)
        (lambda (x y) (tag (div-rat x y))))
    (put 'make 'rational
        (lambda (n d) (tag (make-rat n d))))
    'done)

(define (make-rational n d)
    ((get 'make 'rational) n d))



(define (install-complex-package)
    ;; imported procedures from rectangular and polar packages
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))
    ;; internal procedures
    (define (add-complex z1 z2)
        (make-from-real-imag    (+ (real-part z1) (real-part z2))
                                (+ (imag-part z1) (imag-part z2))))
    (define (sub-complex z1 z2)
        (make-from-real-imag    (- (real-part z1) (real-part z2))
                                (- (imag-part z1) (imag-part z2))))
    (define (mul-complex z1 z2)
        (make-from-mag-ang  (* (magnitude z1) (magnitude z2))
                            (+ (angle z1) (angle z2))))
    (define (div-complex z1 z2)
        (make-from-mag-ang  (/ (magnitude z1) (magnitude z2))
                            (- (angle z1) (angle z2))))
    ;; interface to rest of the system
    (define (tag z) (attach-tag 'complex z))
    (put 'add '(complex complex)
        (lambda (z1 z2) (tag (add-complex z1 z2))))
    (put 'sub '(complex complex)
        (lambda (z1 z2) (tag (sub-complex z1 z2))))
    (put 'mul '(complex complex)
        (lambda (z1 z2) (tag (mul-complex z1 z2))))
    (put 'div '(complex complex)
        (lambda (z1 z2) (tag (div-complex z1 z2))))
    (put 'make-from-real-imag 'complex
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'complex
        (lambda (r a) (tag (make-from-mag-ang r a))))
    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    'done)

(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))



(install-rectangular-package)
(install-polar-package)
(install-scheme-number-package)
(install-rational-package)
(install-complex-package)


(define (scheme-number->complex n)
    (make-complex-from-real-imag (contents n) 0))
(put-coercion 'scheme-number 'complex scheme-number->complex)

(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number 'scheme-number
    scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)



;; Answer:

(define a (make-scheme-number 1))
(define b (make-scheme-number 3))
(exp a b)

(define x (make-complex-from-real-imag 1 2))
(define y (make-complex-from-real-imag 3 4))
(exp x y)


;; a. If we call exp with two complex numbers as arguments, the procedure will stack 
;; in recursive call apply-generic.

;; b. Louis is correct that something had to be done about coercion with arguments of 
;; the same type.

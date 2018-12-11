#lang racket

;; Show how to generalize apply-generic to handle coercion in the general case of multiple 
;; arguments. One strategy is to attempt to coerce all the arguments to the type of the 
;; first argument, then to the type of the second argument, and so on. Give an example of 
;; a situation where this strategy (and likewise the two-argument version given above) is 
;; not sufficiently general. (Hint: Consider the case where there are some suitable 
;; mixed-type operations present in the table that will not be tried.)



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
    (hash-ref coercion-table (list op type) #f))



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



(define (apply-generic op . args)
    (define (proc-types args)
        (let ((type-tags (map type-tag args)))
            (if (= (length type-tags) 1)
                type-tags
                (list (car type-tags) (car type-tags)))))
    (define (apply-proc args)
        (let ((proc (get op (proc-types args))))
            (if proc
                (apply proc (map contents args))
                (error "No method for these types"
                    (list op (map type-tag args))))))
    (define (get-coerced-args coerce-type)
        (filter (lambda (arg) arg)
                (map    (lambda (arg)
                            (let ((type (type-tag arg)))
                                (if (eq? type coerce-type)
                                    arg
                                    (let ((coerced (get-coercion type coerce-type)))
                                        (cond (coerced (coerced arg))
                                            (else #f))))))
                        args)))
    (define (coerce-apply-proc type-tags unique-type-tags)
        (let ((coerce-type (car unique-type-tags)))
            (let ((coerced-args (get-coerced-args coerce-type)))
                (cond   ((= (length type-tags) (length coerced-args))
                            (apply-proc coerced-args))
                        ((> (length unique-type-tags) 1)
                            (coerce-apply-proc type-tags (cdr unique-type-tags)))
                        (else
                            (error "No method for these types"
                                (list op type-tags)))))))
    (let ((type-tags (map type-tag args)))
        (let ((unique-type-tags (remove-duplicates type-tags)))
            (if (= (length unique-type-tags) 1)
                (apply-proc args)
                (coerce-apply-proc type-tags unique-type-tags)))))
                    


(define (add . args) (apply apply-generic 'add args))
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
        (lambda (x . args) (tag (apply + (cons x args)))))
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
    (define (add-complex x . args)
        (make-from-real-imag    (apply + (map real-part (cons x args)))
                                (apply + (map imag-part (cons x args)))))
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
        (lambda (z . args) (tag (apply add-complex (cons z args)))))
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



;; Test code:

(define a (make-scheme-number 1))
(define b (make-scheme-number 3))
(define c (make-scheme-number 2))
(add a b c)

(define x (make-complex-from-real-imag 1 2))
(define y (make-complex-from-real-imag 3 4))
(define z (make-complex-from-real-imag 5 6))
(add x y z)

(add a x c)

;; If we will add mixed types operations, like for example add (complex sheme-number), 
;; our apply-generic will ignore it, because it will convert all sheme-numbers to
;; complex first, and then look for add (complex complex) procedure.

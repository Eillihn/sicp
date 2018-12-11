#lang racket

;; Suppose we want to handle complex numbers whose real parts, imaginary parts,
;; magnitudes, and angles can be either ordinary numbers, rational numbers, or 
;; other numbers we might wish to add to the system. Describe and implement the 
;; changes to the system needed to accommodate this. You will have to define 
;; operations such as sine and cosine that are generic over ordinary numbers 
;; and rational numbers.



(define (square x) (* x x))



(define table (make-hash))
(define (put op type item)
    (hash-set! table (list op type) item))
(define (get op type)
    (hash-ref table (list op type) #f))



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
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((dropped-args (map drop args)))
                        (let ((dropped-type-tags (map type-tag dropped-args)))
                            (let ((proc (get op dropped-type-tags)))
                                (if proc
                                    (apply proc (map contents dropped-args))
                                    (let    ((type1 (car dropped-type-tags))
                                            (type2 (cadr dropped-type-tags))
                                            (a1 (car dropped-args))
                                            (a2 (cadr dropped-args)))
                                        (let    ((t1->t2 (is-higher? type2 a1))
                                                (t2->t1 (is-higher? type1 a2)))
                                            (cond   ((eq? type1 type2)
                                                        (error "No method for these types"
                                                            (list op dropped-type-tags)))
                                                    (t1->t2
                                                        (apply-generic op t1->t2 a2))
                                                    (t2->t1
                                                        (apply-generic op a1 t2->t1))
                                                    (else
                                                        (error "No method for these types"
                                                            (list op dropped-type-tags))))))))))
                    (error "No method for these types"
                        (list op type-tags)))))))

(define (drop x)
    (let ((projected-x (project x)))
        (if (and projected-x (equ? (raise projected-x) x))
            (drop projected-x)
            x)))



(define (raise x) (apply-generic 'raise x))

(define (is-higher? type x)
    (define (try-raise-to z)
        (let ((raised (raise z)))
            (cond   ((not raised) #f)
                    ((eq? (type-tag raised) type) raised)
                    (else (try-raise-to raised)))))
    (try-raise-to x))



(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (exp x y) (apply-generic 'exp x y))

(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (project x) (apply-generic 'project x))
(define (equ? x y) (apply-generic 'equ? x y))



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
    (put 'raise '(scheme-number)
        (lambda (x) (make-rational x 1)))
    (put 'project '(scheme-number)
        (lambda (x) #f))
    (put 'equ? '(scheme-number scheme-number)
        (lambda (x y) (= x y)))
    (put 'sine '(scheme-number)
        (lambda (x) (sin x)))
    (put 'cosine '(scheme-number)
        (lambda (x) (cos x)))
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
    (put 'raise '(rational)
        (lambda (x) (make-real (/ (numer x) (denom x)))))
    (put 'project '(rational)
        (lambda (x) (make-scheme-number (round (/ (numer x) (denom x))))))
    (put 'equ? '(rational rational)
        (lambda (x y) (and  (= (numer x) (numer y))
                            (= (denom x) (denom y)))))
    (put 'sine '(rational)
        (lambda (x) (sin (/ (numer x) (denom x)))))
    (put 'cosine '(rational)
        (lambda (x) (cos (/ (numer x) (denom x)))))
    'done)

(define (make-rational n d)
    ((get 'make 'rational) n d))



(define (install-real-package)
    ;; interface to rest of the system
    (define (tag x) (attach-tag 'real x))
    (put 'make 'real
        (lambda (x) (tag x)))
    (put 'raise '(real)
        (lambda (x) (make-complex-from-real-imag x 0)))
    (put 'project '(real)
        (lambda (x) (make-rational x 1)))
    (put 'equ? '(real real)
        (lambda (x y) (= x y)))
    'done)

(define (make-real x)
    ((get 'make 'real) x))



(define (install-complex-package)
    ;; imported procedures from rectangular and polar packages
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))
    ;; internal procedures
    (define (add-complex z1 z2)
        (make-from-real-imag    (add (real-part z1) (real-part z2))
                                (add (imag-part z1) (imag-part z2))))
    (define (sub-complex z1 z2)
        (make-from-real-imag    (sub (real-part z1) (real-part z2))
                                (sub (imag-part z1) (imag-part z2))))
    (define (mul-complex z1 z2)
        (make-from-mag-ang  (mul (magnitude z1) (magnitude z2))
                            (add (angle z1) (angle z2))))
    (define (div-complex z1 z2)
        (make-from-mag-ang  (div (magnitude z1) (magnitude z2))
                            (sub (angle z1) (angle z2))))
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
    (put 'raise '(complex)
        (lambda (x) #f))
    (put 'project '(complex)
        (lambda (x) (make-real (real-part x))))
    (put 'equ? '(complex complex)
        (lambda (a b) (and  (= (real-part a) (real-part b))
                            (= (imag-part a) (imag-part b)))))
    'done)

(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))



(install-rectangular-package)
(install-polar-package)
(install-scheme-number-package)
(install-rational-package)
(install-real-package)
(install-complex-package)



;; Answer:
;; We should change install-complex-package: add-complex, sub-complex, ... - replace 
;; +, -, /, * by add, sub, div, mul (so, the program will use apply-generic to 
;; handle such operations).

;; Test code:

(define x (make-complex-from-real-imag (make-scheme-number 1) (make-rational 2 1)))
(define y (make-complex-from-real-imag (make-scheme-number 3) (make-scheme-number 4)))
(define a (make-scheme-number 30))
(define b (make-rational 1 3))

(add x y)
(sine a)
(cosine b)

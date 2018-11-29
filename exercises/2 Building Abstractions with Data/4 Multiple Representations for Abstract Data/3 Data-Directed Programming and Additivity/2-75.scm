#lang sicp

;; Implement the constructor make-from-mag-ang in message-passing style. This
;; procedure should be analogous to the make-from-real-imag procedure given above.



(define (make-from-real-ang r a)
    (define (dispatch op)
        (cond   ((eq? op 'real-part) (* r (cos a)))
                ((eq? op 'imag-part) (* r (sin a)))
                ((eq? op 'magnitude) r)
                ((eq? op 'angle) a)
                (else
                    (error "Unknown op -- MAKE-FROM-REAL-ANG" op))))
    dispatch)



;; Test code:

(define test-real (make-from-real-ang 10 30))
(test-real 'real-part)      ; 1.5425144988758404
(test-real 'imag-part)      ; -9.880316240928618
(test-real 'magnitude)      ; 10
(test-real 'angle)          ; 30

#lang sicp
(#%require "../../../helpers/serializer.scm")

; A semaphore (of size n) is a generalization of a mutex. Like a mutex, a semaphore
; supports acquire and release operations, but it is more general in that up to n processes can acquire it
; concurrently. Additional processes that attempt to acquire the semaphore must wait for release operations.
; Give implementations of semaphores
; a. in terms of mutexes
; b. in terms of atomic test-and-set! operations.



; Answer:
; a. in terms of mutexes
(define (make-sempahore-mutexes n)
    (let ((count n)
        (the-mutex (make-mutex)))
        (define (the-sempahore s)
            (cond ((eq? s 'acquire)
                    (display "\nacquire")
                    (the-mutex 'acquire)
                    (if (= count 0)
                        (begin
                            (the-mutex 'release)
                            (the-sempahore 'acquire))
                        (begin
                            (set! count (- count 1))
                            (the-mutex 'release))))
                ((eq? s 'release)
                    (display "\nrelease")
                    (the-mutex 'acquire)
                    (if (= count n)
                        (the-mutex 'release)
                        (begin
                            (set! count (+ count 1))
                            (the-mutex 'release))))))
        the-sempahore))

; b. in terms of atomic test-and-set! operations.
(define (make-sempahore-test-and-set n)
    (let    ((count n)
            (cell (list false)))
        (define (the-sempahore s)
            (cond   ((eq? s 'acquire)
                        (display "\nacquire")
                        (if (test-and-set! cell)
                            (the-sempahore 'acquire)
                            (if (= count 0)
                                (clear! cell)
                                (begin
                                    (set! count (- count 1))
                                    (clear! cell)))))
                    ((eq? s 'release)
                        (display "\nrelease")
                        (if (test-and-set! cell)
                            (the-sempahore 'release)
                            (if (= count n)
                                (clear! cell)
                                (begin
                                    (set! count (+ count 1))
                                    (clear! cell)))))))
        the-sempahore))



; Test code:
(define sempahore1 (make-sempahore-mutexes 3))
(define sempahore2 (make-sempahore-test-and-set 3))

(sempahore1 'acquire)
(sempahore1 'acquire)
(sempahore1 'acquire)
(sempahore1 'release)
(sempahore1 'release)
(sempahore1 'release)


(sempahore2 'acquire)
(sempahore2 'acquire)
(sempahore2 'acquire)
(sempahore2 'release)
(sempahore2 'release)
(sempahore2 'release)

#lang sicp
(#%require "../../../helpers/serializer.scm")

; Suppose that we implement test-and-set! using an ordinary procedure as shown in
; the text, without attempting to make the operation atomic. Draw a timing diagram like the one in
; figure 3.29 to demonstrate how the mutex implementation can fail by allowing two processes to acquire
; the mutex at the same time.


; Answer:

; Peter                                                   Paul
; deposit -> ((serializer deposit) amount)        ->      deposit -> ((serializer deposit) amount)
;                                                 <-
; (test-and-set! cell) -> (car cell) == false     ->      (test-and-set! cell) -> (car cell) == false
;                                                 <-
; cell = true                                     ->      cell = true
;                                                 <-
; deposit -> (mutex 'release) -> cell = false     ->      deposit -> (mutex 'release) -> cell = false

; So, Peter and Paul, both have acquired the mutex.



; Test code:
(define mutex (make-mutex))

(mutex 'acquire)
(mutex 'release)

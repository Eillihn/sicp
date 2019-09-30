#lang sicp
(#%require "../../../helpers/stream.scm")

; How many additions are performed when we compute the nth Fibonacci number using the
; definition of fibs based on the add-streams procedure? Show that the number of additions would be
; exponentially greater if we had implemented (delay <exp>) simply as (lambda () <exp>),
; without using the optimization provided by the memo-proc procedure described in section 3.5.1.

(define (add-streams s1 s2)
    (stream-map + s1 s2))

(define fibs
    (cons-stream 0
        (cons-stream 1
            (add-streams (stream-cdr fibs)
                        fibs))))

; Answer:
; In memorised version as we should do sum 1 time for each f(n) - total number of additions O(n).
; In version without memorisation we should do F(n) = F(n-1) + F(n-2) -
; total number of additions O(ϕ^n), ϕ is the golden ratio.

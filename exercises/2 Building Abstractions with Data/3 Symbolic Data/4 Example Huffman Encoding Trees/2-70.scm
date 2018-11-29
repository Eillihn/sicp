#lang sicp
(#%require "../../helpers/huffman-encoding-trees.scm")
(#%require "../../helpers/seq.scm")

;; The following eight-symbol alphabet with associated relative frequencies 
;; was designed to efficiently encode the lyrics of 1950s rock songs. (Note 
;; that the ``symbols'' of an ``alphabet'' need not be individual letters.)

; A       2       NA      16
; BOOM    1       SHA     3
; GET     2       YIP     9
; JOB     2       WAH     1

;; Use generate-huffman-tree (exercise 2.69) to generate a corresponding 
;; Huffman tree, and use encode (exercise 2.68) to encode the following 
;; message:

; Get a job
; Sha na na na na na na na na
; Get a job
; Sha na na na na na na na na
; Wah yip yip yip yip yip yip yip yip yip
; Sha boom

;; How many bits are required for the encoding? What is the smallest 
;; number of bits that would be needed to encode this song if we used a 
;; fixed-length code for the eight-symbol alphabet?



;; Answer:

(define pairs (list (list 'NA 16) 
                    (list 'YIP 9) 
                    (list 'SHA 3) 
                    (list 'A 2) 
                    (list 'GET 2)
                    (list 'JOB 2)
                    (list 'BOOM 1)
                    (list 'WAH 1)))
(define rock-tree (generate-huffman-tree pairs))
(define rock-song 
    (list '(GET A JOB)
        '(SHA NA NA NA NA NA NA NA NA) 
        '(GET A JOB) 
        '(SHA NA NA NA NA NA NA NA NA)
        '(WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP)
        '(SHA BOOM)))

(define encoded-rock-song (flatmap (lambda (string) (encode string rock-tree)) rock-song))
(display encoded-rock-song)       ; (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)
(newline)
(display (length encoded-rock-song))
;; 84 bits are required for the encoding.

;; Eight-symbol alphabet = 8 = 2^3 => 3 bit per symbol.
;; 36 symbols in song => 108 bits - the smallest number of bits that 
;; would be needed to encode this song if we used a fixed-length code 
;; for the eight-symbol alphabet

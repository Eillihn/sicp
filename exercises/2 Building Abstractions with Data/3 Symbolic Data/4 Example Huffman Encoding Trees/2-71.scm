#lang sicp

;; Suppose we have a Huffman tree for an alphabet of n symbols, and that 
;; the relative frequencies of the symbols are 1, 2, 4, ..., 2^n-1. Sketch 
;; the tree for n=5; for n=10. In such a tree (for general n) how may 
;; bits are required to encode the most frequent symbol? the least 
;; frequent symbol?



;; Answer:

; A - 1
; B - 2
; C - 4
; D - 8
; E - 16

;     {ABCDEJ}31
;         /\
;        /  \
;     {E}16  {ABCD}15
;            /\
;           /  \
;         {D}8  {ABC}7
;               /\
;              /  \
;          {C}4    {AB}3
;                  /\
;                 /  \
;             {A}1    {B}2

; ...
; F - 32
; G - 64
; H - 128
; I - 256
; J - 512

;     {ABCDEFHIJ}1023
;          /\
;         /  \
;     {J}512  {ABCDEFHI}511
;             /\
;            /  \
;        {I}256  {ABCDEFH}127
;                /\
;               /  \
;            {H}128  {ABCDEFG}127
;                   /\
;                  /  \
;               {G}64  {ABCDEF}63
;                      /\
;                     /  \
;                   {F}32 {ABCDE}31
;                         /\
;                        /  \
;                     {E}16  {ABCD}15
;                            /\
;                           /  \
;                         {D}8  {ABC}7
;                               /\
;                              /  \
;                           {C}4   {AB}3
;                                  /\
;                                 /  \
;                             {A}1    {B}2

;; In such a tree (for general n) 1 bit is required to encode the 
;; most frequent symbol and (n-1) bits for the least frequent symbol.

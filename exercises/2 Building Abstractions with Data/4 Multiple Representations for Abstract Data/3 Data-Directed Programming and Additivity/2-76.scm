#lang sicp

;; As a large system with generic operations evolves, new types of data objects or new
;; operations may be needed. For each of the three strategies -- generic operations with 
;; explicit dispatch, data-directed style, and message-passing-style -- describe the 
;; changes that must be made to a system in order to add new types or new operations. 
;; Which organization would be most appropriate for a system in which new types must 
;; often be added? Which would be most appropriate for a system in which new operations
;; must often be added?



;; Answer:

;; Message-passing-style requires implementation of a new constructor function that 
;; returns dispatch function.
;; Data-directed style requires implementation of a new package with set of function
;; that is map for its own type and pasted into data table.
;; Generic operations with explicit dispatch require implementation of new set of 
;; methods with uniq names, adding new cond clauses to each common method, creating
;; tagged constructor.

;; Data-directed and message-passing-style are better for cases when types must be 
;; often added.
;; Data-directed and message-passing-style are most appropriate for a system in 
;; which new operations must often be added, too.
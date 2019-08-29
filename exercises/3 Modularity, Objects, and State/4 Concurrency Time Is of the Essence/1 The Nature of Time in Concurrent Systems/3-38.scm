#lang sicp

; Suppose that Peter, Paul, and Mary share a joint bank account that initially contains $100.
; Concurrently, Peter deposits $10, Paul withdraws $20, and Mary withdraws half the money in the account,
; by executing the following commands:

; Peter: (set! balance (+ balance 10))
; Paul: (set! balance (- balance 20))
; Mary: (set! balance (- balance (/ balance 2)))

; a. List all the different possible values for balance after these three transactions have been completed,
; assuming that the banking system forces the three processes to run sequentially in some order.
; b. What are some other values that could be produced if the system allows the processes to be interleaved?
; Draw timing diagrams like the one in figure 3.29 to explain how these values can occur.



; Answer:
; a. All the different possible values for balance
; Peter -> Paul -> Mary: (100 + 10 - 20)/2 = 45
; Peter -> Mary -> Paul: (100 + 10)/2 - 20 = 35
; Paul -> Peter -> Mary: (100 - 20 + 10)/2 = 45
; Paul -> Mary -> Peter: (100 - 20)/2 + 10 = 50
; Mary -> Paul -> Peter: 100/2 - 20 + 10 = 40
; Mary -> Peter -> Paul: 100/2 + 10 - 20 = 40
; b. Some other values can be achived if operation will be divided to parts (check balance, calculate, set new value)
; Ex.: Peter -> Paul -> Mary
; Peter -> 110
; Paul -> 80
; Mary -> 40
; Peter and Paul work at same time with balance 100, balance is set tj 80 by Paul, and Mary get half from 80.

#lang sicp

; Give a scenario where the deadlock-avoidance mechanism described above does not work.
; (Hint: In the exchange problem, each process knows in advance which accounts it will need to get access
; to. Consider a situation where a process must get access to some shared resources before it can know
; which additional shared resources it will require.)



; Answer:
; If we have a situation where a process p1 must get access to some shared resource r1, and only than 
; we will know second resource r2 technic with ordering resources will not work, because we should start
; acces objects after ordering was made.

#lang racket

;; Insatiable Enterprises, Inc., is a highly decentralized conglomerate 
;; company consisting of a large number of independent divisions located 
;; all over the world. The company's computer facilities have just been 
;; interconnected by means of a clever network-interfacing scheme that 
;; makes the entire network appear to any user to be a single computer. 
;; Insatiable's president, in her first attempt to exploit the ability of
;; the network to extract administrative information from division files, 
;; is dismayed to discover that, although all the division files have been 
;; implemented as data structures in Scheme, the particular data structure 
;; used varies from division to division. A meeting of division managers is 
;; hastily called to search for a strategy to integrate the files that will 
;; satisfy headquarters' needs while preserving the existing autonomy of the
;; divisions.

;; Show how such a strategy can be implemented with data-directed 
;; programming. As an example, suppose that each division's personnel 
;; records consist of a single file, which contains a set of records keyed 
;; on employees' names. The structure of the set varies from division to 
;; division. Furthermore, each employee's record is itself a set (structured 
;; differently from division to division) that contains information keyed 
;; under identifiers such as address and salary. In particular:

;; a. Implement for headquarters a get-record procedure that retrieves a 
;; specified employee's record from a specified personnel file. The procedure 
;; should be applicable to any division's file. Explain how the individual 
;; divisions' files should be structured. In particular, what type information 
;; must be supplied?

;; b. Implement for headquarters a get-salary procedure that returns the 
;; salary information from a given employee's record from any division's 
;; personnel file. How should the record be structured in order to make this 
;; operation work?

;;c. Implement for headquarters a find-employee-record procedure. This should 
;; search all the divisions' files for the record of a given employee and 
;; return the record. Assume that this procedure takes as arguments an 
;; employee's name and a list of all the divisions' files.

;; d. When Insatiable takes over a new company, what changes must be made in 
;; order to incorporate the new personnel information into the central 
;; system?


(define table (make-hash))

(define (put op type item)
    (hash-set! table (list op type) item))

(define (get op type)
    (hash-ref table (list op type)))
  
(define usa-empl-records (list  (list 'Eddie 
                                (list 'address 'GreenStreet)
                                (list 'salary '10000USD))
                            (list 'Katherine 
                                (list 'address 'RedStreet) 
                                (list 'salary '12000USD))
                            (list 'Dan 
                                (list 'address 'BlueStreet)
                                (list 'salary '2000USD))))
(define (install-usa-devision-package)  
    (define (find-employee-record file empl)
        (cond   ((null? file) '())
                ((equal? (caar file) empl) (car file))
                (else (find-employee-record (cdr file) empl))))
    (define (get-record rec info)
        (cond   ((null? rec) '())
                ((and (pair? (car rec)) (equal? (caar rec) info)) (cadar rec))
                (else (get-record (cdr rec) info))))
    (define (get-salary file empl)
        (get-record (find-employee-record file empl) 'salary))
    (put 'get-record 'usa get-record)
    (put 'get-salary 'usa get-salary)
    (put 'find-employee-record 'usa find-employee-record)
    'done)

(define belarus-empl-records (list  (cons 'Vasaya 
                                        (list (cons 'address 'LeninStreet)
                                            (cons 'salary '1000BYN)))
                                    (cons 'Sanaya 
                                        (list (cons 'address 'OctoberStreet) 
                                            (cons 'salary '500BYN)))
                                    (cons 'Lyoha 
                                        (list (cons 'address 'WinStreet)
                                            (cons 'salary '1200BYN)))))
(define (install-belarus-devision-package)  
    (define (find-employee-record file empl)
        (cond   ((null? file) '())
                ((equal? (caar file) empl) (car file))
                (else (find-employee-record (cdr file) empl))))
    (define (get-record rec info)
        (cond   ((null? rec) '())
                ((equal? (caar rec) info) (cdar rec))
                (else (get-record (cdr rec) info))))
    (define (get-salary file empl)
        (let    ((rec (find-employee-record file empl)))
            (if (null? rec)
                '()
                (get-record (cdr rec) 'salary))))
    (put 'get-record 'belarus get-record)
    (put 'get-salary 'belarus get-salary)
    (put 'find-employee-record 'belarus find-employee-record)
    'done)

(install-usa-devision-package)
(install-belarus-devision-package)

((get 'find-employee-record 'usa) usa-empl-records 'Dan)                ; '(Dan (address BlueStreet) (salary 2000USD))
((get 'find-employee-record 'belarus) belarus-empl-records 'Lyoha)      ; '(Lyoha (address . WinStreet) (salary . 1200BYN))
((get 'get-salary 'usa) usa-empl-records 'Katherine)                    ; '12000USD
((get 'get-salary 'belarus) belarus-empl-records 'Vasaya)               ; '1000BYN


;; d. When Insatiable takes over a new company, next changes must be made in 
;; order to incorporate the new personnel information into the central 
;; system:
;; install package should be created and run with implementation of 
;; get-record, get-salary, find-employee-record, and put then to table with
;; link to a new type.


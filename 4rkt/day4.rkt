#lang errortrace racket/base

(require racket/file)
(require racket/string)
(require racket/list)

(provide solve)

(define (parse-input filename)
  (let ([lines (file->lines filename)]) (map parse-input-line lines)))

(define (parse-input-line line)
  (let* ([left-numbers (string-split (string-trim (car (regexp-match* #px"(\\d+\\s+)+\\|" line))
                                                  " |"
                                                  #:right? #t))]
         [right-numbers (string-split (string-trim (car (regexp-match* #px"\\|\\s*(\\d+\\s*)+" line))
                                                   "| "
                                                   #:left? #t))])
    (list (map string->number left-numbers) (map string->number right-numbers))))

(define (get-score-for-card card)
  (let ([winning-numbers (car card)] [game-numbers (cadr card)])
    (calculate-score (filter (lambda (n) (member n winning-numbers)) game-numbers))))

(define (calculate-score numbers)
  (if (empty? numbers) 0 (expt 2 (- (length numbers) 1))))

(define (solve part input)
  (if (= part 1) (solve-part-1 input) (solve-part-2 input)))

(define (solve-part-1 input)
  (apply + (map get-score-for-card (parse-input input))))

(define (solve-part-2 input)
  10)

(module+ test
  (require rackunit)

  (check-equal? (parse-input-line "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
                '((41 48 83 86 17) (83 86 6 31 17 9 48 53)))

  (check-equal? (calculate-score '(48 83 17 86)) 8)

  (check-equal? (get-score-for-card '((41 48 83 86 17) (83 86 6 31 17 9 48 53))) 8)

  (check-equal? (solve-part-1 "./sample.txt") 13))

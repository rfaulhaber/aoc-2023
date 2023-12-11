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

(define (get-winning-count card)
  (let ([winning-numbers (car card)] [game-numbers (cadr card)])
    (length (filter (lambda (n) (member n winning-numbers)) game-numbers))))

(define (solve part input)
  (if (= part 1) (solve-part-1 input) (solve-part-2 input)))

(define (solve-part-1 input)
  (apply + (map get-score-for-card (parse-input input))))

(define (solve-part-2 input)
  (let* ([cards (parse-input input)]
         [cards-by-index (map cons (range 0 (length cards)) cards)]
         [new-cards (range 0 (length cards))])

    (for ([card-by-index cards-by-index])
      (let ([card (cdr card-by-index)] [index (car card-by-index)])
        (set! new-cards (append new-cards (range index (+ index (get-winning-count card)))))))
    (length new-cards)))

(module+ test
  (require rackunit)

  (check-equal? (parse-input-line "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
                '((41 48 83 86 17) (83 86 6 31 17 9 48 53)))

  (check-equal? (calculate-score '(48 83 17 86)) 8)

  (check-equal? (get-score-for-card '((41 48 83 86 17) (83 86 6 31 17 9 48 53))) 8)

  (check-equal? (solve-part-1 "./sample.txt") 13)

  (check-equal? (get-winning-count '((41 48 83 86 17) (83 86 6 31 17 9 48 53))) 4)
  (check-equal? (get-winning-count '((13 32 20 16 61) (61 30 68 82 17 32 24 19))) 2)

  (check-equal? (solve-part-2 "./sample.txt") 30))

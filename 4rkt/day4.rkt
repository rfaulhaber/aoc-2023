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

(define (evaluate-card card index)
  (range (+ index 1) (+ 1 index (get-winning-count card))))

(define (solve part input)
  (if (= part 1) (solve-part-1 input) (solve-part-2 input)))

(define (solve-part-1 input)
  (apply + (map get-score-for-card (parse-input input))))

(define (solve-part-2 input)
  (let* ([cards (parse-input input)]
         [cards-by-index (map cons (range 0 (length cards)) cards)]
         [winning-numbers (map (lambda (pair) (evaluate-card (cdr pair) (car pair))) cards-by-index)]
         [new-cards (make-list (length cards) 1)])

    ;; thank you reddit
    ;; this was not very intuitive to me
    (for* ((i (length cards))
           (j (range (+ i 1) (+ i 1 (length (list-ref winning-numbers i))))))

      (set! new-cards (list-set new-cards j (+ (list-ref new-cards i) (list-ref new-cards j)))))

    (apply + new-cards)))

(module+ test
  (require rackunit)

  (check-equal? (parse-input-line "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
                '((41 48 83 86 17) (83 86 6 31 17 9 48 53)))

  (check-equal? (calculate-score '(48 83 17 86)) 8)

  (check-equal? (get-score-for-card '((41 48 83 86 17) (83 86 6 31 17 9 48 53))) 8)

  (check-equal? (solve-part-1 "./sample.txt") 13)

  (check-equal? (get-winning-count '((41 48 83 86 17) (83 86 6 31 17 9 48 53))) 4)
  (check-equal? (get-winning-count '((13 32 20 16 61) (61 30 68 82 17 32 24 19))) 2)

  (check-equal? (evaluate-card '((41 48 83 86 17) (83 86 6 31 17 9 48 53)) 0) '(1 2 3 4))

  (check-equal? (evaluate-card '((13 32 20 16 61)  (61 30 68 82 17 32 24 19)) 1) '(2 3))

  (check-equal? (evaluate-card '((87 83 26 28 32) (88 30 70 12 93 22 82 36)) 4) '())

  (check-equal? (solve-part-2 "./sample.txt") 30))

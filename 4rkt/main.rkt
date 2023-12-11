#lang errortrace racket/base

(module+ main
  ;; (Optional) main submodule. Put code here if you need it to be executed when
  ;; this file is run using DrRacket or the `racket` executable.  The code here
  ;; does not run when this file is required by another module. Documentation:
  ;; http://docs.racket-lang.org/guide/Module_Syntax.html#%28part._main-and-test%29

  (require racket/cmdline)

  (require "./day4.rkt")

  (define input-file (make-parameter null))
  (define part (make-parameter null))

  (define (main)
    (let ([part (part)] [input-file (input-file)])
      (when (null? part)
        (println "No part set")
        (exit 1))

      (when (null? input-file)
        (println "No part set")
        (exit 1))

      (solve (string->number part) input-file)))

  (command-line #:program "day4"
                #:once-each [("-f" "--filename") name "Input file" (input-file name)]
                [("-p" "--part") name "Part" (part name)]
                #:args ()
                (main)))

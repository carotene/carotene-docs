#lang racket/base
(require pollen/tag)
(provide (all-defined-out))
(define headline (make-default-tag-function 'h2))
(define items (make-default-tag-function 'ul))
(define item (make-default-tag-function 'li ))
(define (link url text) `(a [[href ,url]] ,text))
(define (title text) `(h2 [[class ,"title"]] ,text))
(define (subtitle text) `(h2 [[class ,"subtitle"]] ,text))
(define (chapter text) `(h1 [[class ,"chapter"]] ,text))
(define (author text) `(h2 [[class ,"author"]] ,text))
(define (section text) `(h2 [[class ,"section"]] ,text))
(define aside (make-default-tag-function 'aside))

(define (separator . remain) `(div [[class ,"separator"]] ))
(define (def first second) `(aside (strong ,first) ,(string-append ": " second)))

(require pollen/decode txexpr)
(define (root . elements)
   (make-txexpr 'root null (decode-elements elements
     #:txexpr-elements-proc detect-paragraphs
     #:string-proc (compose smart-quotes smart-dashes))))
(provide root)


;; @module roman.nl
;; @description Construct a roman numeral representation from a positive integer.
;; Inspired by Sam Cox's recursion-based solution:
;; @link http://www.newlisp.org/index.cgi?roman_numbers_generator roman.lsp
;; @syntax (roman <n>)
;; @param <n> Positive integer to be converted.
;; @return String representation of a roman numeral.
;; @example
;; (roman 1988)     => "MCMLXXXVIII"
;; (roman 1492)     => "MCDXCII"
;; (roman 0)        => nil
;; (roman -1)       => nil
;; (roman "")       => nil
;; (roman 33939393) ; No stack overflow

(context 'roman)

(setq *roman* '((1000  "M")
                ( 900 "CM")
                ( 500  "D")
                ( 400 "CD")
                ( 100  "C")
                (  90 "XC")
                (  50  "L")
                (  40 "XL")
                (  10  "X")
                (   9 "IX")
                (   5  "V")
                (   4 "IV")
                (   1  "I")))

(define (roman:roman n , res num val rep rem)
  (when (and (integer? n) (> n 0))
    (set 'res "")
    (set 'num n)
    (set 'val (*roman* 0 0))
    (set 'rep (*roman* 0 1))
    (set 'rem (rest *roman*))
    (until (zero? num)
      (if (< num val)
          (begin
            (set 'val (rem 0 0))
            (set 'rep (rem 0 1))
            (set 'rem (rest rem)))
          (begin
            (extend res rep)
            (dec num val))))
    res))

(context MAIN)

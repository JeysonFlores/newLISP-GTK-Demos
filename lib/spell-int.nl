;; @module spell-int.nl
;; @description Spell out an integer in English.
;; Inspired by a PicoLisp-based solution:
;; @link https://rosettacode.org/wiki/Number_names#PicoLisp NumberNames
;; @syntax (spell-int <n>)
;; @param <n> Number to be converted.
;; @return String of english representation.
;; @example
;; (spell-int 55)         => "fifty five"
;; (spell-int 1000000000) => nil ; not supported

(context 'spell-int)

(define (spell-int:spell-int n)
  (cond ((= n 0) "zero")
        ((< n 0) (string "minus " (spell-int:spell-int (- 0 n))))
        (true    (spell n))))

(define (spell n)
  (cond ((= n 0))
        ((< n 14)
         (nth (dec n)
              '("one" "two" "three" "four" "five" "six" "seven"
                "eight" "nine" "ten" "eleven" "twelve" "thirteen")))
        ((= n 15) "fifteen")
        ((= n 18) "eighteen")
        ((< n 20)
         (string (spell (% n 10)) "teen"))
        ((< n 100)
         (let (xs '("twen" "thir" "for" "fif" "six" "seven" "eigh" "nine"))
           (string (nth (- (/ n 10) 2) xs)
                   "ty"
                   (if (= 0 (% n 10))
                       ""
                       (string "-" (spell (% n 10)))))))
        ((< n 1000)
         (string (spell (/ n 100))
                 " hundred "
                 (spell (% n 100))))
        ((< n 1000000)
         (string (spell (/ n 1000))
                 " thousand "
                 (spell (% n 1000))))
        ((< n 1000000000)
         (string (spell (/ n 1000000))
                 " million "
                 (spell (% n 1000000))))))

(context MAIN)

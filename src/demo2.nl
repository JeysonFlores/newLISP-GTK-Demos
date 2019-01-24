#!/usr/bin/env newlisp

(when (not (and ui roman spell-int))
  (load "lib/ui.nl")
  (load "lib/roman.nl")
  (load "lib/spell-int.nl"))

(new Tree 'state)

(define (get-number n)
  (case (state "number-type")
        (arabic (string (* n 11)))
        (roman (roman (* n 11)))))

(define (set-number n)
  (ui:set-label "number" (spell-int n)))

(define (on-btn1) (set-number 11))
(define (on-btn2) (set-number 22))
(define (on-btn3) (set-number 33))
(define (on-btn4) (set-number 44))
(define (on-btn5) (set-number 55))

(define (toggle-number-type)
  (state "number-type"
         (case (state "number-type")
               (arabic 'roman)
               (roman 'arabic))))

(define (on-toggle)
  (toggle-number-type)
  (ui:set-button-label "btn1" (get-number 1))
  (ui:set-button-label "btn2" (get-number 2))
  (ui:set-button-label "btn3" (get-number 3))
  (ui:set-button-label "btn4" (get-number 4))
  (ui:set-button-label "btn5" (get-number 5)))

(define (on-app)
  (ui:window "win" "demo2" "Numerals Demo" 250 250)
  (ui:box "outer"   "win"   "h")
  (ui:box "main"    "outer" "v")
  (ui:box "numbers" "main"  "h")
  (ui:button "btn1" (get-number 1) "main" "on-btn1")
  (ui:button "btn2" (get-number 2) "main" "on-btn2")
  (ui:button "btn3" (get-number 3) "main" "on-btn3")
  (ui:button "btn4" (get-number 4) "main" "on-btn4")
  (ui:button "btn5" (get-number 5) "main" "on-btn5")
  (ui:button "toggle" "Numerals" "main" "on-toggle")
  (ui:label "number" "zero" "numbers")
  (ui:show-all "win"))

(define (demo-2)
  (ui:app "demo2" "on-app")
  (ui:run "demo2")
  (ui:unref "demo2")
  (exit))

(state "number-type" 'arabic)
(state "on-app"      (callback 0 'on-app))
(state "on-btn1"     (callback 1 'on-btn1))
(state "on-btn2"     (callback 2 'on-btn2))
(state "on-btn3"     (callback 3 'on-btn3))
(state "on-btn4"     (callback 4 'on-btn4))
(state "on-btn5"     (callback 5 'on-btn5))
(state "on-toggle"   (callback 6 'on-toggle))

(demo-2)

#!/usr/bin/env newlisp

(when (not (and ui roman))
  (load "lib/ui.nl")
  (load "lib/roman.nl"))

(new Tree 'state)

(define (relabel button n)
  (let (label (ui:get-button-label button))
    (ui:set-button-label
     button
     (if (int label)
         (roman n)
         (string n)))))

(define (on-btn1) (relabel "btn1" 1066))
(define (on-btn2) (relabel "btn2" 1415))
(define (on-btn3) (relabel "btn3" 1492))
(define (on-btn4) (relabel "btn4" 1620))
(define (on-btn5) (relabel "btn5" 1776))

(define (on-app)
  (ui:window "win" "demo3" "Dates Demo" 300 200)
  (ui:box "outer" "win" "h")
  (ui:box "main" "outer" "v")
  (ui:button "btn1" "1066" "main" "on-btn1")
  (ui:button "btn2" "1415" "main" "on-btn2")
  (ui:button "btn3" "1492" "main" "on-btn3")
  (ui:button "btn4" "1620" "main" "on-btn4")
  (ui:button "btn5" "1776" "main" "on-btn5")
  (ui:show-all "win"))

(define (demo-3)
  (ui:app "demo3" "on-app")
  (ui:run "demo3")
  (ui:unref "demo3")
  (exit))

(state "on-app"  (callback 0 'on-app))
(state "on-btn1" (callback 1 'on-btn1))
(state "on-btn2" (callback 2 'on-btn2))
(state "on-btn3" (callback 3 'on-btn3))
(state "on-btn4" (callback 4 'on-btn4))
(state "on-btn5" (callback 5 'on-btn5))

(demo-3)

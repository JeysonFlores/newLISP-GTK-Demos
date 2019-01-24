#!/usr/bin/env newlisp

(when (not (and ui spell-int))
  (load "lib/ui.nl")
  (load "lib/spell-int.nl"))

(new Tree 'state)

(define (set-number n)
  (ui:set-label
   "number"
   (state "selected-number"
          (title-case (spell-int n)))))

(define (on-btn1) (set-number 1))
(define (on-btn2) (set-number 2))
(define (on-btn3) (set-number 3))
(define (on-btn4) (set-number 4))

(define (on-app)
  (ui:window "win" "demo1" "Four Button Demo" 300 150)
  (ui:box "outer"   "win"     "h")
  (ui:box "main"    "outer"   "v")
  (ui:box "buttons" "main"    "h")
  (ui:box "left"    "buttons" "v")
  (ui:box "right"   "buttons" "v")
  (ui:box "numbers" "main"    "h")
  (ui:label "number" (state "selected-number") "numbers")
  (ui:button "btn1" "1" "left"  "on-btn1")
  (ui:button "btn2" "2" "left"  "on-btn2")
  (ui:button "btn3" "3" "right" "on-btn3")
  (ui:button "btn4" "4" "right" "on-btn4")
  (ui:show-all "win"))

(define (demo-1)
  (ui:app "demo1" "on-app")
  (ui:run "demo1")
  (ui:unref "demo1")
  (exit))

(state "selected-number" (title-case (spell-int 0)))
(state "on-app"          (callback 0 'on-app))
(state "on-btn1"         (callback 1 'on-btn1))
(state "on-btn2"         (callback 2 'on-btn2))
(state "on-btn3"         (callback 3 'on-btn3))
(state "on-btn4"         (callback 4 'on-btn4))

(demo-1)

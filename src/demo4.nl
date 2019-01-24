#!/usr/bin/env newlisp

(when (not ui)
  (load "lib/ui.nl"))

(new Tree 'state)

(define (find-demo n)
  (let ((rel (string "./demo" n))
        (src (string "./src/demo" n ".nl")))
    (real-path (if (file-info rel)
                   rel
                   src))))

(define (launch-demo n)
  (fork (exec (find-demo n))))

(define (on-btn1) (launch-demo 1))
(define (on-btn2) (launch-demo 2))
(define (on-btn3) (launch-demo 3))

(define (on-app)
  (ui:window "win" "demo4" "Demos Menu" 300 200)
  (ui:box "outer" "win"   "h")
  (ui:box "main"  "outer" "v")
  (ui:button "btn1" "Four Button Demo" "main" "on-btn1" "left")
  (ui:button "btn2" "Numerals Demo"    "main" "on-btn2" "left")
  (ui:button "btn3" "Dates Demo"       "main" "on-btn3" "left")
  (ui:show-all "win"))

(define (demo-4)
  (ui:app "demo4" "on-app")
  (ui:run "demo4")
  (ui:unref "demo4")
  (exit))

(state "on-app"  (callback 0 'on-app))
(state "on-btn1" (callback 1 'on-btn1))
(state "on-btn2" (callback 2 'on-btn2))
(state "on-btn3" (callback 3 'on-btn3))

(demo-4)

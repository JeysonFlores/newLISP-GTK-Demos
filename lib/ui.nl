;; @module ui.nl
;; @description Thin wrapper around GTK.
;; Functions manage memory addresses through a user-provided dictionary.
;;
;; Initialize a state dictionary prior to calling any module functions:
;; <pre>(context MAIN)
;;(new Tree 'state)</pre>

;; @syntax (ui:app <app> <cb>)
;; @param <app> <string> - Name of the application
;; @param <cb> <string> - Name of the callback function
;;
;; Create a new Gtk application.
;; <br>When the application is activated, the callback function will be executed.

;; @syntax (ui:window <window> <app> <title> <width> <height>)
;; @param <window> <string> - Name of the window
;; @param <app> <string> - Name of the application
;; @param <title> <string> - Title of the window
;; @param <width> <int> - Width of the window
;; @param <height> <int> - Height of the window
;;
;; Create a new Gtk application window with a title and default size.

;; @syntax (ui:box <box> <parent> <orientation>)
;; @param <box> <string> - Name of the button box
;; @param <parent> <string> - Name of the parent container
;; @param <orientation> <string> - Horizontal or vertical content organization
;;
;; Create a new Gtk button box as a child of a parent container.
;; <br>Orientation values are either <"h"> or <"v">.

;; @syntax (ui:button <button> <label> <parent> <cb>)
;; @param <button> <string> - Name of the button
;; @param <label> <string> - Text of the button's label
;; @param <parent> <string> - Name of the parent container
;; @param <cb> <string> - Name of the callback function
;; @param <align> <string> - Horizontal aligment of the label text
;;
;; Create a new Gtk button with a label, as a child of a parent container.
;; <br>When the button is pressed, the callback function will be executed.
;; <br>Align values include "left", "center", and "right".
;; <br>Align argument is optional, and will be "center" by default.

;; @syntax (ui:label <label> <text> <parent>)
;; @param <label> <string> - Name of the label
;; @param <text> <string> - Text content of the label
;; @param <parent> <string> - Name of the parent container
;;
;; Create a new Gtk label, as a child of a parent container.

;; @syntax (ui:set-label <text> <str>)
;; @param <text> <string> - Name of the label
;; @param <str> <string> - New text content of the label
;;
;; Modify the text of a label.

;; @syntax (ui:get-button-label <button>)
;; @param <button> <string> - Name of the button
;; @return <string> - Text content
;; Retrieve a button label's text content.

;; @syntax (ui:set-button-label <button> <label>)
;; @param <button> <string> - Name of the label
;; @param <label> <string> - New text content of the label
;;
;; Modify the text of a button's label.

;; @syntax (ui:unref <object>)
;; @param <object> <string> - Name of the object
;;
;; This is typically used to free an application.
;; <br>Decrease the reference count of the GTK object.
;; <br>If the object count drops to 0, free the memory.

;; @syntax (ui:show-all <widget>)
;; @param <widget> <string> - Name of the widget
;;
;; Recursively show a widget, including any child widgets.

;; @syntax (ui:run <app>)
;; @param <app> <string> - Name of the application
;;
;; Run an application.

(when (not gtk)
  (load "lib/gtk.nl"))

(context 'ui)

(define (ui:app app cb)
  (MAIN:state app (gtk:application-new 0 0))
  (gtk:signal-connect-data (MAIN:state app)
                           "activate"
                           (MAIN:state cb)
                           0
                           0
                           0))

(define (ui:window window app title width height)
  (MAIN:state window (gtk:application-window-new
                       (MAIN:state app)))
  (gtk:window-set-title (MAIN:state window) title)
  (gtk:window-set-default-size (MAIN:state window)
                               width
                               height))

(define (ui:box box parent orientation)
  (MAIN:state box
              (gtk:button-box-new
               (case orientation
                     ("h" 0)
                     ("v" 1))))
  (gtk:container-add (MAIN:state parent)
                     (MAIN:state box)))

(define (ui:button button label parent cb align , btn)
  (set 'btn (MAIN:state button
                        (gtk:button-new-with-label label)))
  (gtk:signal-connect-data btn
                           "clicked"
                           (MAIN:state cb)
                           0
                           0
                           0)
  (gtk:container-add (MAIN:state parent) btn)
  (when align
    (gtk:label-set-xalign (gtk:bin-get-child btn)
                          (case align
                                ("left" 0.0)
                                ("center" 0.5)
                                ("right" 1.0)))))

(define (ui:label label text parent)
  (MAIN:state label (gtk:label-new text))
  (gtk:container-add (MAIN:state parent)
                     (MAIN:state label)))

(define (ui:set-label text str)
  (gtk:label-set-text (MAIN:state text) str))

(define (ui:get-button-label button)
  (get-string (gtk:button-get-label (MAIN:state button))))

(define (ui:set-button-label button label)
  (gtk:button-set-label (MAIN:state button) label))

(define (ui:unref object)
  (gtk:object-unref (MAIN:state object)))

(define (ui:show-all widget)
  (gtk:widget-show-all (MAIN:state widget)))

(define (ui:run app)
  (gtk:application-run (MAIN:state app) 0 0))

(context MAIN)

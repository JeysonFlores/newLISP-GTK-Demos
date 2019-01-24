(context 'gtk)

(set 'files '("/usr/lib/libgtk-3.so.0"))

(set 'gtk3
     (files
       (or (find true (map file? files)))
           (throw-error "cannot find library libgtk")))

(import gtk3 "gtk_application_window_new")
(import gtk3 "gtk_window_set_title")
(import gtk3 "gtk_window_set_default_size")
(import gtk3 "gtk_button_box_new")
(import gtk3 "gtk_size_group_new")
(import gtk3 "gtk_bin_get_child")
(import gtk3 "gtk_label_set_xalign")
(import gtk3 "gtk_container_add")
(import gtk3 "gtk_label_new")
(import gtk3 "gtk_label_set_text")
(import gtk3 "gtk_button_set_label")
(import gtk3 "gtk_button_get_label")
(import gtk3 "gtk_button_new_with_label")
(import gtk3 "gtk_widget_destroy")
(import gtk3 "gtk_application_new")
(import gtk3 "g_application_run")
(import gtk3 "g_object_ref")
(import gtk3 "g_object_unref")
(import gtk3 "gtk_widget_show_all")
(import gtk3 "g_signal_connect_data")

(define (gtk:application-window-new application)
  (gtk_application_window_new application))

(define (gtk:window-set-title window title)
  (gtk_window_set_title window title))

(define (gtk:window-set-default-size window width height)
  (gtk_window_set_default_size window width height))

(define (gtk:button-box-new orientation)
  (gtk_button_box_new orientation))

(define (gtk:size-group-new mode)
  (gtk_size_group_new mode))

(define (gtk:bin-get-child bin)
  (gtk_bin_get_child bin))

(define (gtk:label-set-xalign label xalign)
  (gtk_label_set_xalign label xalign))

(define (gtk:container-add container widget)
  (gtk_container_add container widget))

(define (gtk:label-new str)
  (gtk_label_new str))

(define (gtk:label-set-text label str)
  (gtk_label_set_text label str))

(define (gtk:button-set-label button label)
  (gtk_button_set_label button label))

(define (gtk:button-get-label button)
  (gtk_button_get_label button))

(define (gtk:button-new-with-label label)
  (gtk_button_new_with_label label))

(define (gtk:widget-destroy widget)
  (gtk_widget_destroy widget))

(define (gtk:application-new application-id flags)
  (gtk_application_new application-id flags))

(define (gtk:application-run application argc argv)
  (g_application_run application argc argv))

(define (gtk:object-ref object)
  (g_object_ref object))

(define (gtk:object-unref object)
  (g_object_unref object))

(define (gtk:widget-show-all widget)
  (gtk_widget_show_all widget))


(define (gtk:signal-connect-data instance
                                 detailed-signal
                                 c-handler
                                 data
                                 destroy-data
                                 connect-flags)
  (g_signal_connect_data instance
                         detailed-signal
                         c-handler
                         data
                         destroy-data
                         connect-flags))

(context MAIN)

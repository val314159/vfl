(defpackage :r (:use :cl :p :a :c) (:nicknames :reader)
	    (:shadow #:read-symbol))
(in-package :r)

(defun read-no-tab-ws (_ &optional _2)
  (cl:case (peekc _)
    (#\Tab             (error "NO TABS"))
    ((#\Space
      #\Return)        (:L* (readc _) (read-no-tab-ws _ _2)))
    (#\Newline (if? _2 (:L* (readc _) (read-no-tab-ws _ _2))))
    (t                 (peekc _))))

(defun is-ws (_) (find _ '(#\Space #\Newline #\Tab #\Return eof)))

(defun is-sym (_)
  (mv-bind (macro non-term) (get-macro-character _)
	   (ife macro     non-term
		(is-ws _) nil
		t         t)))

(defun read-symbol (_ &optional _2)
  (ife (null   _2)        (read-symbol (readc _))
       (is-sym _2) (:L* _ (read-symbol (readc _)))
       t           (unread-char _2 _)))

(defun read-col (_)
  (loop :for x = (read-ex-ws _)
	:until {x === eof}
	:do (fmt "[[~A]]~%" x)
	:collect x
	:until {(read-no-tab-ws _) === #\Newline}))


(defpackage :r (:use :cl :p :a :c) (:nicknames :reader)
	    (:shadow #:read-symbol))
(in-package :r)

(defun is-sym (_)
  (not (ife (find _ '(#\Space #\Newline #\Tab eof)) t
	    (get-macro-character _)
	    (:1 (mv-list (get-macro-character _))))))

(defun read-symbol (_ &optional _2)
  (ife (null   _2)         (read-symbol (readc _))
       (is-sym _2) (cons _ (read-symbol (readc _)))
       t           (unread-char _2 _)))

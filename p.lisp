(defpackage :p (:use :cl) (:nicknames :package)
	    (:export #:eof #:undef #:else #:rpws #:λ))
(in-package :p)

(define-symbol-macro readw 'cl:read-preserving-whitespace)
(define-symbol-macro else  'cl:t)
(define-symbol-macro undef 'undef)
(define-symbol-macro eof   'eof)

(defmacro set-fun(_) (list 'cl:setf (list 'cl:symbol-value _)
			   (list 'cl:symbol-function _)))
(defmacro set-mac(_) (list 'cl:setf (list 'cl:symbol-value _)
			   (list 'cl:macro-function _)))
(defmacro rpws (_) (list 'cl:read-preserving-whitespace _))
(defmacro λ (_ &rest _*)
  (cl:list* 'cl:lambda _
       (cl:list 'declare
	   (cl:list* 'ignorable
		(cl:remove-if
		 (cl:lambda(x)
		   (cl:member x '(cl:&optional cl:&rest cl:&body)))
		 _)))
       _*))
(set-macro-character #\* (λ(% %2) 'cl:t) cl:t)
(set-macro-character #\) (λ(% %2) (error ")")))
(set-macro-character #\( (λ(_ %2) (cl:read-delimited-list #\) _)))
(set-macro-character #\𝑭 (λ(s %2) (list 'set-fun (rpws s))))
(set-macro-character #\𝑴 (λ(s %2) (list 'set-mac (rpws s))))
(set-dispatch-macro-character #\# #\L (λ(s c d) (list* 'L(rpws s))))

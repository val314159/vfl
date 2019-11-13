(cl:load "~/quicklisp/setup")
(cl:require (cl:quote asdf))
(cl:push (cl:truename ".") asdf:*central-registry*)
(ql:quickload (cl:quote (:woo :clack)) :silent cl:t)
(cl:require (cl:quote vfl))
(cl:in-package :vu)

(defun run-prog (&rest rest)
  #+sbcl (uiop:wait-process (uiop:launch-program (fmts* "~{~a ~}" rest)))
  #+ecl                     (uiop:launch-program (fmts* "~{~a ~}" rest))
  #+ccl  (ccl:run-program (car rest) (cdr rest)))
(install-macro-chars)
<syntax3>
<load-file "wi">
<launch>
<loop <sleep 60>>

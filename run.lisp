(cl:load "~/quicklisp/setup")
(cl:require (cl:quote asdf))
(cl:push (cl:truename ".") asdf:*central-registry*)
(ql:quickload '(:woo :clack) :silent cl:t)
(cl:require (cl:quote v)) (cl:in-package :vu)
(install-macro-chars)     (syntax2)
[:$ *argv* := [member "--" [uiop:command-line-arguments]
				:test 'equal]]
[:$ *arg0* := [:1  *argv*]]
[:$ *args* := [:2+ *argv*]]
[load-file2 *arg0*]

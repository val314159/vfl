(cl:load "~/quicklisp/setup")
(cl:require (cl:quote asdf))
(cl:push (cl:truename ".") asdf:*central-registry*)
(ql:quickload (cl:quote (:woo :clack)) :silent cl:t)
(cl:require (cl:quote vfl))
(cl:in-package :vu)
(install-macro-chars)
(defun run-program (&rest rest)
  (uiop:wait-process (uiop:launch-program (apply #λconcat-string rest))))
(syntax2)
[load-file "wwi"]
[launch]
[loop [sleep 60]]

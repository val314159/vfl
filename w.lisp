(cl:load "~/quicklisp/setup")
(cl:require (cl:quote asdf))
(cl:push (cl:truename ".") asdf:*central-registry*)
(ql:quickload '(:woo :clack) :silent cl:t)
(cl:require (cl:quote vfl)) (cl:in-package :vu)
(install-macro-chars)
(defun run-program (&rest rest)
  (uiop:wait-process (uiop:launch-program (apply #λconcat-string rest))))
(load-file "wi")

(prn {1, })
(prn {1, 2})
(prn '{1, 2, })
(prn {1, 2, 3})
;(prn (q {1, 2}))
;(prn (q {1, 2}))
;(prn (q {1, 2}))

(launch)
(loop (sleep 60))

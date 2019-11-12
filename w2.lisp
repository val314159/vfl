


(ql:quickload (cl:quote (:woo :clack)) :silent cl:t)
(ql:quickload (cl:quote (:vfl)))
(cl:in-package :vu)
(install-macro-chars)
(defun run-program (&rest rest)
  (uiop:wait-process (uiop:launch-program (apply #λconcat-string rest))))
(load-file "wi")
(launch)
(loop (sleep 60))

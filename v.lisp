(defpackage :v (:use :p :c) (:nicknames :vfl))
(in-package :v)
(cl:do-symbols (s :v) (cl:export s))


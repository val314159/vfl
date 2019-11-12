(defpackage :c (:use :cl))
(defpackage :r (:use :c))
(defpackage :a (:nicknames :v) (:use :c :r))
(defpackage :vu (:use :v))

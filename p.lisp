(defpackage :c  (:use :cl)   (:nicknames :vfl-core))
(defpackage :r  (:use :c)    (:nicknames :vfl-read))
(defpackage :v  (:use :c :r) (:nicknames :vfl-all :vfl))
(defpackage :vu (:use :v)    (:nicknames :vfl-user))

(defpackage :c        (:use :cl))
(defpackage :r        (:use :c))
(defpackage :vfl      (:use :c :r) (:nicknames :v :a))
(defpackage :cfl-user (:use :v)    (:nicknames :vu))

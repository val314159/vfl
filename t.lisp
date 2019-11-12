(require 'asdf) (push (truename ".") asdf:*central-registry*)
(require 'vfl)
(in-package :vu)
(install-macro-chars)
(print '(prn
	 "Hello, world!"))
(print '{ 1 + 2 })
(fmt "Hello, world! ~a~%" { 1 + 2 })

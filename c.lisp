(in-package :c)
(cl:shadow (cl:quote
	    (defvar funcall t nil eq
		    multiple-value-list multiple-value-call
		    multiple-value-list multiple-value-setq
		    get-macro-character get-dispatch-macro-character
		    set-macro-character set-dispatch-macro-character
		    read read-preserving-whitespace read-delimited-list
		    read-line)))
(cl:set-macro-character
 #\λ (cl:lambda (s c) (cl:declare (cl:ignore s c)) (cl:quote cl:lambda)))
(cl:defmacro |λ| (a cl:&body b)
  (cl:list* '|λ| a
	    (cl:list 'cl:declare (cl:list 'cl:ignorable a))
	    b))
(cl:set-dispatch-macro-character
 #\# #\t (cl:lambda (s c d) (cl:declare (cl:ignore s c d)) cl:t))
(cl:set-dispatch-macro-character
 #\# #\f (cl:lambda (s c d) (cl:declare (cl:ignore s c d)) cl:nil))
(cl:defvar quot  (cl:quote cl:quote))
(cl:defvar funct (cl:quote cl:function))
(cl:defvar nl    (cl:elt "
" 0))
(cl:defmacro q (x) (cl:list (cl:quote cl:quote) x))
(cl:defmacro @@ (cl:&body b)         (cl:list* (cl:quote cl:progn) b))
(cl:defmacro @1 (cl:&body b)         (cl:list* (cl:quote cl:prog1) b))
(cl:defmacro @2 (cl:&body b)         (cl:list* (cl:quote cl:prog2) b))
(cl:defmacro mv-bind (cl:&body b)    (cl:list* (cl:quote cl:multiple-value-bind) b))
(cl:defmacro mv-call (cl:&body b)    (cl:list* (cl:quote cl:multiple-value-call) b))
(cl:defmacro mv-list (cl:&body b)    (cl:list* (cl:quote cl:multiple-value-list) b))
(cl:defmacro mv-setq (cl:&body b)    (cl:list* (cl:quote cl:multiple-value-setq) b))
(cl:defmacro get-macroc (cl:&rest r) (cl:list* (cl:quote cl:get-macro-character) r))
(cl:defmacro set-macroc (cl:&rest r) (cl:list* (cl:quote cl:set-macro-character) r))
(cl:defmacro set-disp-macroc (cl:&rest r) (cl:list* (cl:quote cl:set-dispatch-macro-character) r))
(cl:defmacro get-disp-macroc (cl:&rest r) (cl:list* (cl:quote cl:get-dispatch-macro-character) r))
(cl:defmacro if1 (a    )          (cl:list  (cl:quote cl:if)  a () ))
(cl:defmacro if2 (a b  )          (cl:list  (cl:quote cl:if)  a b  ))
(cl:defmacro if3 (a b c)          (cl:list  (cl:quote cl:if)  a b c))
(cl:defmacro if? (cl:&rest r)     (cl:list* (cl:quote cl:when   ) r))
(cl:defmacro if! (cl:&rest r)     (cl:list* (cl:quote cl:unless ) r))
(cl:defmacro iff (cl:&rest r)     (cl:list* (cl:quote cl:when   ) r))
(cl:defmacro ifn (cl:&rest r)     (cl:list* (cl:quote cl:unless ) r))
(cl:defmacro call(cl:&rest r)     (cl:list* (cl:quote cl:funcall) r))
(cl:defmacro ^^  (cl:&rest r)     (cl:list* (cl:quote cl:values ) r))
(cl:defmacro ?   (a  b)           (cl:list  (cl:quote cl:getf   ) a b))
(cl:defmacro :=  (cl:&rest r)     (cl:list* (cl:quote cl:setf   ) r))
(cl:defmacro is  (a  b)           (cl:list  (cl:quote cl:eq     ) a b))
(cl:defmacro isnt(a  b)           (cl:list  (cl:quote cl:not    )
					    (cl:list (cl:quote cl:eq) a b)))
(cl:defun fmt    (cl:&rest r)     (cl:apply (cl:function cl:format) cl:t   r) (cl:terpri) cl:nil)
(cl:defun fmt*   (cl:&rest r)     (cl:apply (cl:function cl:format) cl:t   r))
(cl:defun fmts   (cl:&rest r)     (cl:apply (cl:function cl:format) ()     r) (cl:terpri) cl:nil)
(cl:defun fmts*  (cl:&rest r)     (cl:apply (cl:function cl:format) ()     r))
(cl:defun len           (x)          (cl:length x))
(cl:defun pr            (x)          (cl:prin1 x)              x)
(cl:defun prn           (x)          (cl:prin1 x) (cl:terpri)  x)
(cl:defun readc         (s)          (cl:read-char         s))
(cl:defun peekc         (s)          (cl:peek-char      () s))
(cl:defun eof-p         (s)  (cl:not (cl:peek-char      () s ())))
(cl:defun concat-string (cl:&rest r)
  (cl:apply (cl:function cl:concatenate) (cl:quote string) r))
(cl:defun export-package (cl:&optional (p cl:*package*)) (cl:do-symbols (s p) (cl:export s p)))
(cl:defun :0 (s) (cl:elt s 0))
(cl:defun :1 (s) (cl:elt s 1))
(cl:defun :1+(s) (cl:cdr s))
(cl:defun :1-(s) (cl:cdr s))
(cl:defun :2 (s) (cl:elt s 2))
(cl:defun :2+(s) (cl:cddr s))
(cl:defun :2-(s) (cl:cddr s))
(cl:defun :3 (s) (cl:elt s 3))
(cl:defun :3+(s) (cl:cdddr s))
(cl:defun :3-(s) (cl:cdddr s))
(cl:defun :4 (s) (cl:elt s 4))
(cl:defun :4+(s) (cl:cddddr s))
(cl:defun :4-(s) (cl:cddddr s))
(cl:defun :5 (s) (cl:elt s 5))
(cl:defun :5+(s) (cl:cddddr (cl:cdr s)))
(cl:defun :5-(s) (cl:cddddr (cl:cdr s)))
(cl:defun :6 (s) (cl:elt s 6))
(cl:defun :6+(s) (cl:cddddr (cl:cddr s)))
(cl:defun :6-(s) (cl:cddddr (cl:cddr s)))
(cl:defun :7 (s) (cl:elt s 7))
(cl:defun :7+(s) (cl:cddddr (cl:cdddr s)))
(cl:defun :7-(s) (cl:cddddr (cl:cdddr s)))
(cl:defun :8 (s) (cl:elt s 8))
(cl:defun :8+(s) (cl:cddddr (cl:cddddr s)))
(cl:defun :8-(s) (cl:cddddr (cl:cddddr s)))
(cl:defun :9 (s) (cl:elt s 9))
(cl:defun :9+(s) (cl:cddddr (cl:cddddr (cl:cdr s))))
(cl:defun :9-(s) (cl:cddddr (cl:cddddr (cl:cdr s))))
(cl:defun (cl:setf :%  ) (c a b)  (cl:setf (cl:gethash b a) c))
(cl:defun (cl:setf geth) (c a b)  (cl:setf (cl:gethash b a) c))
(cl:defun          geth  (a b &optional c) (cl:gethash b a c))
(cl:defun          :%    (a b &optional c) (cl:gethash b a c))
(cl:defun       make-ht  ()       (cl:make-hash-table :test (cl:quote cl:equal)))
(cl:defmacro :$ (a b c) (cl:cond ((cl:eq b :=) (cl:list (cl:quote cl:defvar) a c))
				 ( cl:t        (cl:error ":= required"))))
(cl:defun startswith (haystack needle)
  (cl:handler-case
      (cl:string= (cl:subseq haystack 0 (len needle)) needle)
      (cl:error () cl:nil)))
(cl:defun endswith (haystack needle)
  (cl:handler-case
      (cl:string= (cl:subseq haystack (- (len haystack) (len needle))) needle)
      (cl:error () cl:nil)))
(cl:defmacro ← (cl:&rest rest) (cl:list* (q cl:apply) rest))
(cl:defun odds (x)  (cl:if (cl:car x) (cl:cons (cl:car x) (odds (cl:cddr x)))))
(cl:defun evens (_) (odds (cl:cdr _)))
(cl:defun samep (_) (cl:= 1 (cl:length (cl:remove-duplicates _))))
(cl:defun read-next-line (cl:&optional
			  s (eof-error-p cl:t) eof-value add-nl
			  (acc (cl:make-array 256 :fill-pointer 0
						  :adjustable cl:t)))
  (cl:handler-case (cl:progn (cl:loop
				:for c = (readc s)
				:while c
				:until (cl:eq c nl)
				:do (cl:vector-push-extend c acc))
			     (cl:if add-nl (cl:vector-push-extend nl acc))
			     (cl:values (concat-string acc) cl:t))
    (cl:end-of-file ()
      (cl:if eof-error-p (peekc s)
	     (cl:values eof-value ())))))

(cl:defun ls(x) (cl:format () "[~{ ~S, ~} \"\" ]~%"
			   (cl:mapcar (cl:function enough-namestring)
				      (cl:directory x))))

(cl:defun -ls-la(x)
  (cl:mapcar
   (cl:lambda (y)
     (let ((n (cl:enough-namestring y)))
       (cl:if (cl:eq (cl:elt n (cl:1- (cl:length n))) #\/)
	      (cl:apply (cl:function cl:append) (-ls-la (concat-string n "/*")))
	      (list n))))
   (cl:directory x)))

(cl:defun ls-la(x)
  (cl:format () "[~s~{,~S~}]~%"
	     (subseq x 0 (1- (len x)))
	     (cl:apply (cl:function cl:append) (-ls-la x))
	     ))

(export-package)

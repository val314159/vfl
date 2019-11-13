<:$ *routes* := make-ht<>>

<prn <q prn<10095>>>
prn<10096>

;;<eval <q prn<10092>>>

;;<@@ prn<10091>>

<defmacro r <method path expr>
  #[ := #[ #/cl:gethash #[ #/cl:list method path ] #/*routes* ]
  •     #[ #/cl:lambda  #[ #/s ] expr ] ]>

<defun not-found <e>
  <declare <ignore e>>
  #/<404 <:content-type "text/html"> <"<a href=/>not found</a>">>>

<defun serve-path <path>
  <fmt "serve path ~a" path>
  <if3 {probe-file { path subseq 1 } } #t
       <if2 { path endswith ".md.html" }
	    <run-prog    "grip"
			 { path subseq 1 { { len path } - 5 } }
			 "--export"
			 { path subseq 1 } >>>
  <if3 {probe-file { path subseq 1 } } #t
       <if2 { path endswith ".vfl.out" }
	    <run-prog    "sbcl" "--script" "run.lisp" "--"
			 { path subseq 1 { { len path } - 4 } }
			 " >&  "
			 { path subseq 1 } >>>
  <handler-case
      <let* <<fname { path subseq 1 }>
	     <data  { #λconcat-string ← { read-stream { open fname } } }>
	     <heads #[ :content-type "text/html"
		       :content-length { len data } ]>>
	#[ 200 heads #[ data ] ]>
    <error <> <not-found #f>>>>

<defun read-body <e>
  <prn e>
  <concat-string
   <loop :for n :from 0 :below { e ? :content-length }
	 :collect <code-char <read-byte { e ? :raw-body } >>>>>

<defun save-file <e>
  <fmt "save file ~a" { e ? :path-info }>
  <let* <<contents { read-body e }>
	 <path     { e ? :path-info }>
	 <filename {"d/" concat-string { path subseq 3 } }>>
    <fmt "path ~a"     { e ? :path-info }>
    <fmt "filename ~s" filename>
    <fmt "contents ~s" contents>
    <with-open-file <stream filename :direction :output
				     :if-exists :supersede
				     :if-does-not-exist :create>
      <write-line contents stream>>
    #/<200 <:content-type "text/plain"> <"[]">>>>

<defun serve-file <e>
  <serve-path { e ? :path-info }>>

<defun serve-routes <e>
  <call < gethash #[ { e ? :request-method }
		  •  { e ? :path-info      } ]
		  *routes*
		  #λnot-found >
	e>>

<:$ *prefixes* := #[ #t #λserve-routes ]>

<defun serve-request <e &optional
		      <path    { e ? :path-info }>
		      <prefixes *prefixes*>>
  <if2 { prefixes }
       <if3 { { :0 prefixes } is #t }
	    <call <:1 prefixes> e>
	    <if3 { path startswith { :0 prefixes } }
		 <call <:1 prefixes> e>
		 <serve-request e path <:2- prefixes>>>>>>

<defun launch <>
  <clack:clackup #λserve-request
		 :server :woo
		 :use-default-middlewares #f>>

<prn <macroexpand-1 '<r :GET "/favicon.ico"
   #/<200 <:content-type "text/plain"> <"">>>>>

<r :GET "/favicon.ico"
   #/<200 <:content-type "text/plain"> <"">>>

<r :GET "/a"
   #/<301 <:location  "/s/main.html">  <"">>>

<r :GET "/"
   #/<301 <:location  "/s/index.html"> <"">>>

<r :GET "/ls"
   #[ 200 #/<:content-type "application/json"> #[ <ls    "d/*.*"> ] ]>

<r :GET "/ls-la"
   #[ 200 #/<:content-type "application/json"> #[ <ls-la "d/*.*"> ] ]>

{*prefixes* := <list* "/d/" #λserve-file *prefixes*>}
{*prefixes* := <list* "/s/" #λserve-file *prefixes*>}
{*prefixes* := <list* "/u/" #λsave-file  *prefixes*>}

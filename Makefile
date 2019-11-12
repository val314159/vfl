wi: clean d w
all:  ; sbcl --script t.lisp --eval '(quit)'
	ecl    --load t.lisp --eval '(quit)'
	ccl64  --load t.lisp --eval '(quit)'
clean:; rm -fr s u d *~
w: s  ; sbcl --script w.lisp
d:    ; mkdir -p d
s:    ; mkdir -p s
	cd s ; ln ../*.html .
	cd s ; ln ../*.css  .
	cd s ; ln ../*.txt  .
	cd s ; ln ../*.md   .
	cd s ; ln ../*.js   .
asdf.lisp: ; wget https://common-lisp.net/project/asdf/archives/$@

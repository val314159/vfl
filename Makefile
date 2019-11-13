##qq: xyz
qq2: clean d s ; ccl64 --load w.lisp --eval '(quit)'
wi: clean w
qqxyz: s d ; sbcl --noinform --disable-ldb --load ~/quicklisp/setup --script w1.lisp
xyz: s d ; qlot run < w2.lisp
superclean: ; rm -fr ~/.sbcl* ~/quicklisp ~/.quicklisps \
	quicklisp ~/.ros ~/.roswell .qlot qlfile.lock
reinstall: superclean install
install: ; ros install qlot && qlot install
all:  ; sbcl --script t.lisp --eval '(quit)'
	ecl    --load t.lisp --eval '(quit)'
	ccl64  --load t.lisp --eval '(quit)'
clean:; rm -fr s d *~
w: d s; sbcl --script w.lisp
d:    ; mkdir -p d
s:    ; mkdir -p s
	cd s ; ln ../*.html .
	cd s ; ln ../*.css  .
	cd s ; ln ../*.txt  .
	cd s ; ln ../*.md   .
	cd s ; ln ../*.js   .
asdf.lisp: ; wget https://common-lisp.net/project/asdf/archives/$@

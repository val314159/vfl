all:
	sbcl --script test.lisp --eval '(quit)'
	ccl64  --load test.lisp --eval '(quit)'
	ecl    --load test.lisp --eval '(quit)'

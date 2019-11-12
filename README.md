
# a Very Fine Lisp

## Quick Start

### How to install

###### Using ASDF

```
mkdir -p ~/common-lisp
git clone https://gist.github.com/val314159/2aa9a630b872701ee15f51998b11f436
```

###### Using QuickLisp

```
mkdir -p ~/quicklisp/local-projects
git clone https://gist.github.com/val314159/2aa9a630b872701ee15f51998b11f436
```

### How to load

```
(require 'v)
(in-package :vu) ;; vfl-user
(install-macro-chars)

(prn "Hello, world!")
(fmt "Hello, world! ~a~%" { 1 + 2 })
```

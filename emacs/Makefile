EMACS ?= emacs
SANDBOX ?= ./sandbox
CASK = env --unset INSIDE_EMACS cask
PACKAGE := $(shell $(EMACS) -Q --batch -l scripts/package-name.el -f my-package-version)
WRITE_PKG_FILE = $(EMACS) -Q --batch -l scripts/package-name.el -f my-write-pkg-file

all: depends elc

.PHONY: depends elc clean-elc version pkg-file package-contents package clean-package sandbox clean-sandbox test clean all

depends:
	$(CASK) install
	$(CASK) update

elc:
	$(CASK) build

clean-elc:
	$(CASK) clean-elc

version:
	$(CASK) exec $(EMACS) --version

pkg-file:
	$(WRITE_PKG_FILE) .

etc/dafny-docs.html.gz: scripts/rebuild-dafny-docs.py
	python3 ./scripts/rebuild-dafny-docs.py

package-contents: clean-elc elc etc/dafny-docs.html.gz

package: clean-package package-contents
	mkdir -p build/$(PACKAGE)
	cp -R *.el etc/ build/$(PACKAGE)
	$(WRITE_PKG_FILE) build/$(PACKAGE)
	cd build && tar -cf $(PACKAGE).tar $(PACKAGE)

clean-package:
	rm -rf build

sandbox: clean-sandbox package
	mkdir -p $(SANDBOX)
	$(EMACS) -Q --eval '(setq user-emacs-directory "$(SANDBOX)")' -l scripts/sandbox-setup.el \
	            --eval '(package-install-file (expand-file-name (concat my-package-version ".tar") "build"))'

clean-sandbox:
	rm -rf $(SANDBOX)

test: elc
	$(EMACS) -l scripts/testing.el tests.dfy

clean: clean-package clean-elc
	rm -f boogie-friends-pkg.el

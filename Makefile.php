# vim: noexpandtab filetype=make

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	SHELL := /usr/bin/bash
endif
ifeq ($(UNAME_S),Darwin)
	SHELL := /usr/local/bin/bash
endif

BIN ?= ${HOME}/bin
COMPOSER = php ${BIN}/composer.phar

${BIN}/composer.phar:
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar ${BIN}
	echo 'alias composer="php ${BIN}/composer.phar"' >> ~/.bash_local
	source ~/.bash_local

laravel: ${BIN}/composer.phar
	${COMPOSER} global require 'laravel/laravel'

test:
	composer help

.PHONY: laravel

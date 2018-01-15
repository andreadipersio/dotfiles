SHELL := `which bash`

BIN ?= ${HOME}/bin
COMPOSER = php ${BIN}/composer.phar

${BIN}/composer.phar:
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar ${BIN}
	echo 'alias composer="php ${BIN}/composer.phar"' >> ~/.bash_local
	source ~/.bash_local

laravel: ${BIN}/composer.phar
	${COMPOSER} global require 'laravel/laravel'

.PHONY: laravel

.PHONY: install-vim install-base

DOTFILES ?= ${HOME}/.dotfiles
VIMUSR ?= ${HOME}/.vim
BINUSR ?= ${HOME}/bin

${HOME}/.vimrc:
	ln -sF ${DOTFILES}/.vimrc ${HOME}/

${VIMUSR}:
	mkdir $@

${VIMUSR}/bundle:
	mkdir -p ${VIMUSR}/bundle

${VIMUSR}/undo:
	mkdir -p ${VIMUSR}/undo

${VIMUSR}/bundle/Vundle.vim: ${VIMUSR}/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git ${VIMUSR}/bundle/Vundle.vim

${HOME}/.bashrc:
	ln -sF ${DOTFILES}/.bashrc ${HOME}/

${HOME}/.bash_profile:
	ln -sF ${DOTFILES}/.bash_profile ${HOME}/

${HOME}/.locale:
	ln -sF ${DOTFILES}/.locale ${HOME}/

${HOME}/.bash_local:
	touch $@

${BINUSR}/git-prompt.sh:
	mkdir -p ${BINUSR}
	ln -s ${DOTFILES}/bin/git-prompt.sh ${BINUSR}

install-base: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.bash_local ${HOME}/.locale ${BINUSR}/git-prompt.sh

install-vim: ${HOME}/.vimrc ${VIMUSR} ${VIMUSR}/bundle ${VIMUSR}/undo ${VIMUSR}/bundle/Vundle.vim
	vim +PluginInstall +qall

.PHONY: install-vim uninstall-vim

DOTFILES ?= ${HOME}/.dotfiles
VIMUSR ?= ${HOME}/.vim

${HOME}/.vimrc:
	ln -s ${DOTFILES}/.vimrc ${HOME}/

${VIMUSR}:
	mkdir $@

install-vim: ${HOME}/.vimrc ${VIMUSR}
	mkdir -p ${VIMUSR}/{undo,bundle}
	git clone https://github.com/VundleVim/Vundle.vim.git ${VIMUSR}/bundle/Vundle.vim

.PHONY: install-vim install-base

DOTFILES ?= ${HOME}/.dotfiles
VIMUSR ?= ${HOME}/.vim
VIMPKG ?= ${HOME}/.vim/pack/adp
BINUSR ?= ${HOME}/bin

${HOME}/.vimrc:
	ln -sF ${DOTFILES}/.vimrc ${HOME}/

${VIMUSR}:
	mkdir $@

${VIMUSR}/bundle:
	mkdir -p ${VIMUSR}/bundle

${VIMUSR}/undo:
	mkdir -p ${VIMUSR}/undo

${VIMPKG}:
	mkdir -p $@

${VIMPKG}/start/ctrlp.vim: ${VIMPKG}
	git clone https://github.com/ctrlpvim/ctrlp.vim.git $@

${VIMPKG}/start/vim-sensible.vim: ${VIMPKG}
	git clone https://github.com/tpope/vim-sensible.git $@

${VIMPKG}/start/wombat256.vim: ${VIMPKG}
	git clone https://github.com/vim-scripts/wombat256.vim.git $@

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

install-vim: ${HOME}/.vimrc ${VIMUSR} ${VIMUSR}/undo ${VIMPKG}/start/ctrlp.vim ${VIMPKG}/start/vim-sensible.vim ${VIMPKG}/start/wombat256.vim

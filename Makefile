me-install: user-common-install
	@./install user/me ${HOME}

root-install: user-common-install
	@./install user/root ${HOME}

user-common-install:
	@./install user/common ${HOME}

system-install:
	@./install system /etc

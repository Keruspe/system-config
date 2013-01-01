user-install:
	./install user ${HOME}
	ln -sf $(pwd)/systemd ${HOME}/.config/

system-install:
	./install system /etc

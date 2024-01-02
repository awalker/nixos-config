switch:
	git-sync sync
	sudo nixos-rebuild  --flake .#odin switch

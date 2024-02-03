switch: sync
	sudo nixos-rebuild  --flake .#odin switch

sync:
	git-sync sync

update: sync && switch
	sudo nix-channel --update
	sudo nix flake update

sync-switch: sync switch

switch:
	sudo nixos-rebuild  --flake .#odin switch

sync:
	git-sync sync

update: sync && sync-switch
	sudo nix-channel --update
	sudo nix flake update

clean:
	nix-collect-garbage -d

sync-switch: sync switch

ss: sync-switch

switch:
	# sudo nixos-rebuild -j 1 --flake .#odin switch
	sudo nixos-rebuild --flake .#odin switch

boot:
	sudo nixos-rebuild --flake .#odin boot

sync:
	git-sync sync

update: sync && sync-switch
	sudo nix-channel --update
	sudo nix flake update

clean:
	nix-collect-garbage -d

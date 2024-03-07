sync-common:
	cd common ; stow --verbose --restow   --target=$$HOME */  ; cd ..

sync-macos:sync-common
	cd macos ; stow --verbose --restow  --target=$$HOME */ ; cd ..

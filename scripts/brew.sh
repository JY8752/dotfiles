#!/bin/bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

function set_homebrew() {
	check_macos
	check_command "brew"

	print_info "Installing Homebrew packages..."

	brew doctor
	brew update
	brew upgrade

 local force=false
	while [ "$#" -gt 0 ]; do
		case "$1" in
		--force)
			force=true
			;;
		*)
			;;
		esac
		shift
	done

	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	if [ "$force" = true ]; then
		brew bundle --file "$current_dir/.Brewfile" --force
		return
	fi
	brew bundle --file "$current_dir/.Brewfile"
}

set_homebrew
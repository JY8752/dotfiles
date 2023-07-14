#!/bin/bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

function set_homebrew() {
	check_macos
	check_command "brew"

	print_info "Installing Homebrew packages..."

	brew doctor
	brew update
	brew upgrade
	brew cleanup

	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	brew bundle --file "$current_dir/.Brewfile"
}

set_homebrew
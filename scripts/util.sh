#!/bin/bash

function print_info() {
	printf "\033[1;36m%s\033[m\n" "$*" # cyan
}

function print_notice() {
	printf "\033[1;35m%s\033[m\n" "$*" # magenta
}

function print_success() {
	printf "\033[1;32m%s\033[m\n" "$*" # green
}

function print_warning() {
	printf "\033[1;33m%s\033[m\n" "$*" # yellow
}

function print_error() {
	printf "\033[1;31m%s\033[m\n" "$*" # red
}

function print_debug() {
	printf "\033[1;34m%s\033[m\n" "$*" # blue
}

function mkdir_not_exist() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

function check_macos() {
	if [ "$(uname)" != "Darwin" ] ; then
		print_error "Not macOS!"
		exit 1
	fi
}
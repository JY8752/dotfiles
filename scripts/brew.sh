#!/bin/bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

check_macos

brew bundle --file .Brewfile
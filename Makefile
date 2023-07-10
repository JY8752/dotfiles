# Do everything.
all: init link defaults brew

# Set initial preference.
init:
	@scripts/init.sh

# Link dotfiles.
link:
	@scripts/link.sh

# Set macOS system preferences.
defaults:
	@scripts/defaults.sh

# Install macOS applications.
brew:
	@scripts/brew.sh

# update vscode extentions
codeex:
	@code --list-extensions > vscode/extensions

# Set VSCode settings.
code:
	@scripts/code.sh
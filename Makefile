# Do everything.
all: init link brew code 

# Test(skip brew and code)
test: init link 

# Set initial preference.
init:
	@scripts/init.sh

# Link dotfiles.
link:
	@scripts/link.sh

# Install macOS applications.
brew:
	@scripts/brew.sh

brewfile:
	@brew bundle dump --file=scripts/.Brewfile --force --no-vscode

# Set VSCode settings.
code:
	@scripts/code.sh

# Set Cursor settings.
cursor:
	@scripts/cursor.sh
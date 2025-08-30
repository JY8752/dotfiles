# dotfiles

This repository is for managing dotfiles. It covers the following items. Note that these dotfiles **target MacOS** and are designed to set up a development environment on a new Mac machine.

- Initial setup of Mac.
- Installation of modules managed with brew.
- Creation of symbolic links for dotfiles.
- Management of frequently used programming languages.
- Listing and installation of VSCode extensions.

We manually manage globally installed libraries for Node and Go as version management can be challenging in this repository.

## Development Environment

- aws
- GitHub
- vscode
- intelliJ
- zsh
- neovim
- Homebrew

## Installation

```
git clone git@github.com:JY8752/dotfiles.git
```

## Usage

### initialize all setting

By running the make command, the following settings and installations will be made.

- Initial settings for MacOS (installation of xcode command line tools and homebrew).
- Creation of symbolic links for various dotfiles in the home directory.
- Changing the default terminal settings of MacOS itself.
- Installation of packages listed in Homebrew's ```.Brewfile```.
- Installation of VSCode extensions and creation of a symbolic link for ```setting.json``` (extensions to be installed are listed in ```vscode/extensions```).
- Installation of various programming languages via asdf.

```
make 
```

### Mac OS initial setting(xcode command line tool and homebrew install)

```
make init
```

### create symbolic link to home dir

```
make link
```

### install brew package

```
make berw
```

### install vscode extensions

```
make code
```

## Reference

https://github.com/yutkat/dotfiles/tree/main

https://zenn.dev/tsukuboshi/articles/6e82aef942d9af

https://tech.smartcamp.co.jp/entry/setup-by-dotfiles

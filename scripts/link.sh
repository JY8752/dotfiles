#!/bin/bash

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

function link_to_homedir() {
    # backupディレクトリを作成　
    print_notice "backup old dotfiles..."

    local tmp_date
    tmp_date=$(date '+%y%m%d-%H%M%S')

    local backupdir="$HOME/.backup/$tmp_date"
    mkdir_not_exist "$backupdir"
    print_info "create backup directory: $backupdir"

    print_info "Creating symlinks"
    local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	local dotfiles_dir
	dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"

    # 除外ファイルの読み込み
    linkignore=()
    if [[ -e "$dotfiles_dir/.linkignore" ]]; then
        while IFS= read -r line; do
            linkignore+=("$line")
        done <"$dotfiles_dir/.linkignore"
    fi

    # シンボリックリンクの作成
    for f in "$dotfiles_dir"/.??*; do
        local f_filename
        f_filename=$(basename "$f")

        # 除外ファイルの場合はスキップ
        [[ ${linkignore[*]} =~ $f_filename ]] && continue

        # .awsは配下のconfigをシンボリックリンクにする
        if [ "$f_filename" = ".aws" ]; then
            for config in "$f"/*; do
                local config_filename
                config_filename=$(basename "$config")

                # 除外ファイルの場合はスキップ
                [[ ${linkignore[*]} =~ $config_filename ]] && continue

                backup_and_link "$config" "$HOME/.aws" "$backupdir"
            done
            continue
        fi

        # .configは配下のディレクトリをシンボリックリンクにする
        if [ "$f_filename" = ".config" ]; then
            for config in "$f"/*; do
                local config_filename
                config_filename=$(basename "$config")

                # 除外ファイルの場合はスキップ
                [[ ${linkignore[*]} =~ $config_filename ]] && continue

                backup_and_link "$config" "$HOME/.config" "$backupdir"
            done
            continue
        fi

        # それ以外はそのままホームディレクトリにシンボリックリンクを作成
        backup_and_link "$f" "$HOME" "$backupdir"
    done
}

link_to_homedir
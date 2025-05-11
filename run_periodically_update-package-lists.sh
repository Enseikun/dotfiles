#!/bin/zsh
# ~/.local/share/chezmoi/run_periodically_update-package-lists.sh

set -eu

# ソースディレクトリのパスを取得
SOURCE_DIR=$(chezmoi source-path)

# pkglistディレクトリが存在するか確認し、なければ作成
PKGLIST_DIR="${SOURCE_DIR}/pkglist"
mkdir -p "${PKGLIST_DIR}"

# 標準パッケージリストの更新
echo "Updating official package list..."
pacman -Qqen > "${PKGLIST_DIR}/pkglist.txt"

# AURパッケージリストの更新
echo "Updating AUR package list..."
pacman -Qqem > "${PKGLIST_DIR}/pkglist_aur.txt"

# 変更があればchezmoiに通知
chezmoi add "${PKGLIST_DIR}/pkglist.txt" "${PKGLIST_DIR}/pkglist_aur.txt"

echo "Package lists updated successfully at $(date)"
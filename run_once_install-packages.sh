#!/bin/zsh
# ~/.local/share/chezmoi/run_once_install-packages.sh

set -eu

# ソースディレクトリのパスを取得
SOURCE_DIR=$(chezmoi source-path)
PKGLIST_DIR="${SOURCE_DIR}/pkglist"

# 公式パッケージのインストール
if [ -f "${PKGLIST_DIR}/pkglist.txt" ]; then
    echo "Installing official packages..."
    sudo pacman -S --needed - < "${PKGLIST_DIR}/pkglist.txt"
fi

# AURヘルパーの確認（例：yayを使用）
if command -v yay &> /dev/null; then
    # AURパッケージのインストール
    if [ -f "${PKGLIST_DIR}/pkglist_aur.txt" ]; then
        echo "Installing AUR packages..."
        yay -S --needed - < "${PKGLIST_DIR}/pkglist_aur.txt"
    fi
else
    echo "AUR helper not found. Please install yay or another AUR helper manually."
    echo "Then run: yay -S --needed - < ${PKGLIST_DIR}/pkglist_aur.txt"
fi

echo "Package installation completed at $(date)"
#!/bin/zsh
# ~/.local/share/chezmoi/run_once_install-packages.sh

set -eu

# 色の設定
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE}    パッケージインストールスクリプト      ${NC}"
echo -e "${BLUE}=========================================${NC}"

# ソースディレクトリのパスを取得
SOURCE_DIR=$(chezmoi source-path)
PKGLIST_DIR="${SOURCE_DIR}/pkglist"

# 公式パッケージのインストール
if [ -f "${PKGLIST_DIR}/pkglist.txt" ]; then
    echo -e "${GREEN}公式パッケージをインストールしています...${NC}"
    # コメントと空行を除外
    PKGS=$(grep -v "^#" "${PKGLIST_DIR}/pkglist.txt" | grep -v "^$")
    if [ -n "$PKGS" ]; then
        sudo pacman -S --needed --noconfirm $PKGS
    else
        echo -e "${YELLOW}インストールする公式パッケージがありません${NC}"
    fi
fi

# AURヘルパーの確認（例：yayを使用）
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}AURヘルパー(yay)がインストールされていません。インストールを試みます...${NC}"
    
    # 必要な依存関係の確認とインストール
    sudo pacman -S --needed --noconfirm git base-devel
    
    # 一時ディレクトリにyayをクローンしてインストール
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
    
    echo -e "${GREEN}yayのインストールが完了しました${NC}"
fi

# AURパッケージのインストール
if [ -f "${PKGLIST_DIR}/pkglist_aur.txt" ]; then
    echo -e "${GREEN}AURパッケージをインストールしています...${NC}"
    # コメントと空行を除外
    AUR_PKGS=$(grep -v "^#" "${PKGLIST_DIR}/pkglist_aur.txt" | grep -v "^$")
    if [ -n "$AUR_PKGS" ]; then
        yay -S --needed --noconfirm $AUR_PKGS
    else
        echo -e "${YELLOW}インストールするAURパッケージがありません${NC}"
    fi
else
    echo -e "${YELLOW}AURパッケージリストが見つかりませんでした${NC}"
fi

echo -e "${GREEN}パッケージのインストールが $(date) に完了しました${NC}"
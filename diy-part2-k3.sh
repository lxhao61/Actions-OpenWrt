#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改默认 IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile

# 修改主机名
sed -i "s/hostname='.*'/hostname='K3'/g" package/base-files/files/bin/config_generate

# 修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" package/base-files/files/bin/config_generate
sed -i "/.*timezone='CST-8'.*/i\ set system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

# 开启 WiFi
sed -i 's/disabled=.*/disabled=0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#sed -i 's/ssid=.*/ssid=OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

# 修复 exim 依赖
sed -i 's/+USE_GLIBC:libcrypt-compat //' feeds/packages/mail/exim/Makefile

# 删除自带的 golang
rm -rf feeds/packages/lang/golang
# 拉取新的 golang
git clone https://github.com/sbwml/packages_lang_golang.git -b 26.x feeds/packages/lang/golang

# 删除 passwall 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf package/feeds/packages/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
# 拉取新的 passwall-packages
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall-packages
#cd package/passwall-packages
#git checkout bc40fceb0488dfb5a4adb711cc1830a8021ee555
#cd -

# 删除 passwall 过时的 luci
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf package/feeds/luci/luci-app-passwall
# 拉取新的 passwall-luci
git clone https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall-luci
#cd package/passwall-luci
#git checkout ebd3355bdf2fcaa9e0c43ec0704a8d9d8cf9f658
#cd -

# 拉取 easytier、luci-app-easytier
git clone https://github.com/EasyTier/luci-app-easytier.git package/easytier

# 拉取锐捷认证
git clone https://github.com/sbwml/luci-app-mentohust.git package/mentohust

# 拉取 msd_lite、luci-app-msd_lite
git clone https://github.com/gtolog/openwrt-msd_lite.git package/msd_lite
#git clone https://github.com/gw826943555/openwrt_msd_lite.git package/msd_lite

# 拉取 OpenAppFilter、luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# 删除自带 ddns-scripts
rm -rf feeds/packages/net/ddns-scripts
# 删除自带 luci-app-socat
#rm -rf feeds/lienol1/luci-app-socat
# 删除 passwall-packages 中 hysteria
#rm -rf package/passwall-packages/hysteria
# 删除 passwall-packages 中 naiveproxy
#rm -rf package/passwall-packages/naiveproxy
# 删除 passwall-packages 中 dns2socks
#rm -rf package/passwall-packages/dns2socks
# 删除自带的 tailscale
rm -rf feeds/packages/net/tailscale
rm -rf package/feeds/packages/tailscale

# 筛选程序
function merge_package(){
    # 参数1是分支名,参数2是库地址。所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}
# 提取 ddns-scripts
merge_package openwrt-24.10 https://github.com/immortalwrt/packages.git feeds/packages/net net/ddns-scripts
# 提取 luci-app-socat
#merge_package main https://github.com/chenmozhijin/luci-app-socat.git feeds/lienol1 luci-app-socat
# 提取 hysteria
#merge_package v5 https://github.com/sbwml/openwrt_helloworld.git package/passwall-packages hysteria
# 提取 naiveproxy
#merge_package v5 https://github.com/sbwml/openwrt_helloworld.git package/passwall-packages naiveproxy
#merge_package master https://github.com/kenzok8/small.git package/passwall-packages naiveproxy
#merge_package master https://github.com/immortalwrt/packages.git package/passwall-packages net/naiveproxy
# 提取 dns2socks
#merge_package master https://github.com/immortalwrt/packages.git package/passwall-packages net/dns2socks
# 提取 pdnsd-alt、upx、tailscale、luci-app-tailscale
merge_package main https://github.com/kenzok8/small-package.git package/small-package pdnsd-alt upx tailscale luci-app-tailscale
# 提取 luci-theme-argon
merge_package openwrt-24.10 https://github.com/sbwml/luci-theme-argon.git package/luci luci-theme-argon
# 提取 brcmfmac-firmware-4366c0-pcie-k3
merge_package openwrt-24.10 https://github.com/immortalwrt/immortalwrt.git package/k3buding package/firmware/brcmfmac4366c0-firmware-k3
# 提取 phicomm-k3screenctrl
merge_package openwrt-24.10 https://github.com/immortalwrt/packages.git package/k3buding utils/phicomm-k3screenctrl

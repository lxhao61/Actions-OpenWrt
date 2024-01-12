#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 回退源码
#git reset --hard 2db72d69a9eb5971dc4df1402213f5088e425695
#git reset --hard 5242189664191097e284a2f89992a3e675526fa1
git reset --hard bf067e00f58a6bf17b4f26a84a55706ea6eecf1f
#git reset --hard 7c11d3b

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 注释掉lienol大diy1源
#sed -i 's/^\(.*diy1\)/#&/' feeds.conf.default

# 添加xiaorouji大passwall源
#sed -i '$a src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall.git;packages' feeds.conf.default
#sed -i '$a src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;luci' feeds.conf.default

# 注释掉默认的packages源
sed -i 's/^\(.*packages\)/#&/' feeds.conf.default

# 添加修改的packages源
sed -i '$a src-git packages https://github.com/lxhao61/openwrt-packages.git;19.07' feeds.conf.default

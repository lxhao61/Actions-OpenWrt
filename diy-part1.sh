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
#git reset --hard 5242189
#git reset --hard bf067e0
#git reset --hard 7c11d3b

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 注释默认 packages
#sed -i 's/^\(.*packages\)/#&/' feeds.conf.default
# 添加 packages
#sed -i '$a src-git packages https://github.com/lxhao61/openwrt-packages.git;19.07' feeds.conf.default

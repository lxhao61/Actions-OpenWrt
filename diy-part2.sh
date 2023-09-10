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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
#sed -i 's/192.168.1.1/192.168.6.5/g' package/base-files/files/bin/config_generate

# 删除lienol大自带xray-core源码
rm -rf feeds/packages/net/xray-core
rm -rf package/feeds/packages/xray-core

# 拉取PassWall源码
git clone -b packages https://github.com/xiaorouji/openwrt-passwall.git package/xiaorouji/packages
cd package/xiaorouji/packages
git checkout c189a68728d6bb65d9fb4b47fdacea3ba970a624
cd -
#git clone -b packages https://github.com/lxhao61/openwrt-passwall.git package/xiaorouji/packages
git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/xiaorouji/luci
cd package/xiaorouji/luci
git checkout d1e618220a9a0a4b73d536101f452a2f4cf14861
cd -
#git clone -b luci https://github.com/lxhao61/openwrt-passwall.git package/xiaorouji/luci

# 拉取ShadowSocksR Plus+源码
#git clone -b master https://github.com/fw876/helloworld.git package/helloworld

# 拉取phtunnel、pgyvpn源码
git clone https://github.com/OrayOS/OpenOray.git package/net/OpenOray

# 删除原版softethervpn插件
#rm -rf feeds/packages/net/softethervpn

# 拉取lienol大softethervpn插件
#svn co https://github.com/lxhao61/openwrt-packages/trunk/net/softethervpn feeds/packages/net/softethervpn

# 删除原版luci-app-softethervpn插件
#rm -rf feeds/lienol/luci-app-softethervpn

# 拉取修改后的luci-app-softethervpn插件
#svn co https://github.com/lxhao61/openwrt-package/trunk/luci-app-softethervpn feeds/lienol/luci-app-softethervpn

# 拉取phtunnel插件
#svn co https://github.com/coolsnowwolf/packages/trunk/net/phtunnel package/net/phtunnel

# 拉取luci-app-phtunnel插件
#svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-phtunnel package/net/luci-app-phtunnel

# 拉取tailscale插件
svn co https://github.com/coolsnowwolf/packages/trunk/net/tailscale package/net/tailscale

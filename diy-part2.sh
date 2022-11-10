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

# 删除lienol大自带xray-core核心
rm -rf package/feeds/packages/xray-core

# 拉取PassWall源码
git clone -b packages https://github.com/xiaorouji/openwrt-passwall.git package/xiaorouji/packages
#git clone -b packages https://github.com/lxhao61/openwrt-passwall.git package/xiaorouji/packages
git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/xiaorouji/luci
#git clone -b luci https://github.com/lxhao61/openwrt-passwall.git package/xiaorouji/luci

# 拉取ShadowSocksR Plus+源码
#git clone -b master https://github.com/fw876/helloworld.git package/helloworld
git clone -b patch-1 https://github.com/lxhao61/helloworld.git package/helloworld

# 拉取ipsec-vpnd LuCI
#git clone https://github.com/tungnt017/luci-app-ipsec-vpnd package/lean/luci-app-ipsec-vpnd
svn co https://github.com/lxhao61/openwrt-plugin/trunk/package/lean/luci-app-ipsec-vpnd package/lean/luci-app-ipsec-vpnd

# 删除原版softethervpn插件
#rm -rf feeds/packages/net/softethervpn

# 拉取lienol大softethervpn插件
#svn co https://github.com/lxhao61/openwrt-packages/trunk/net/softethervpn feeds/packages/net/softethervpn

# 删除原版luci-app-softethervpn插件
#rm -rf feeds/lienol/luci-app-softethervpn

# 拉取修改后的luci-app-softethervpn插件
#svn co https://github.com/lxhao61/openwrt-package/trunk/luci-app-softethervpn feeds/lienol/luci-app-softethervpn

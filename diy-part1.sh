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
 
 
 ######################修改feeds.conf.default文件###########################
git clone https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
#git clone https://github.com/haiibo/openwrt-packages package/openwrt-packages
cat feeds.conf.default


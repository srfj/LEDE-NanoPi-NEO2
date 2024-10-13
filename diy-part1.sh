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
cd ..
#######################################下载coolsnowwolf lede源码######################################
git clone https://github.com/coolsnowwolf/lede
#复制lean到openwrt/package
cp -r ./lede/package/lean ./openwrt/package
#复制ucl到openwrt/tools##vssr必备插件
#cp -r ./lede/tools/ucl ./openwrt/tools
#复制upx到openwrt/tools##vssr必备插件
#cp -r ./lede/tools/upx ./openwrt/tools
#删除lede源码节省空间
rm -rf ./lede


cd package/lean/  
git clone https://github.com/jerrykuku/lua-maxminddb.git  #git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/luci-app-vssr.git  
ls
cd ..
cd ..

#注释掉include/target.mk第16行
sed -i '16s/^/#/' include/target.mk
#include/target.mk第16行后面添加一行
sed -i '16a \DEFAULT_PACKAGES:=base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd default-settings luci-app-vlmcsd' include/target.mk
#注释掉include/target.mk第21行
sed -i '21s/^/#/' include/target.mk
#include/target.mk第21行后面添加一行
sed -i '21a \DEFAULT_PACKAGES.router:=dnsmasq-full iptables ip6tables firewall odhcpd-ipv6only odhcp6c kmod-ipt-offload' include/target.mk

#修改package/kernel/linux/files/sysctl-nf-conntrack.conf连接数16384为65536
sed -i 's/16384/65536/' package/kernel/linux/files/sysctl-nf-conntrack.conf

# Modify default IP 修改原始IP 【原：lan) ipad=${ipaddr:-"192.168.1.1"}】
sed -i '103s/192.168.1.1/192.168.0.3/g' package/base-files/files/bin/config_generate

#删除02_network文件第142行
sed -i '142d' target/linux/ar71xx/base-files/etc/board.d/02_network
 
 
 ######################修改feeds.conf.default文件###########################
#sed -i '$a src-git kenzsp https\:\/\/github.com\/kenzok8\/small-package' feeds.conf.default
#sed -i '$a src-git small https\:\/\/github.com\/kenzok8\/small' feeds.conf.default
#sed -i '$a src-git kenzop https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
cat feeds.conf.default


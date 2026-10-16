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
#修改为32Mb版本
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk
#修改内核版本
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.15/KERNEL_TESTING_PATCHVER:=5.4/g' target/linux/ramips/Makefile

#sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.4/g' target/linux/ramips/Makefile

# 1. 将所有 luci-app-vsftpd 中的 +vsftpd 依赖强制替换为 +vsftpd-alt（防止 make defconfig 自动勾回 vsftpd）
# find package/ feeds/ -name "Makefile" | grep "vsftpd" | xargs sed -i 's/+vsftpd$/+vsftpd-alt/g'
# find package/ feeds/ -name "Makefile" | grep "vsftpd" | xargs sed -i 's/+vsftpd /+vsftpd-alt /g'

# 2. 在配置文件中禁用基础版 vsftpd，保留 vsftpd-alt
# sed -i 's/CONFIG_PACKAGE_vsftpd=y/# CONFIG_PACKAGE_vsftpd is not set/g' .config
# echo "# CONFIG_PACKAGE_vsftpd is not set" >> .config
# echo "CONFIG_PACKAGE_luci-app-vsftpd=y" >> .config
# echo "CONFIG_PACKAGE_vsftpd-alt=y" >> .config

rm -rf feeds/smpackage/*vsftpd*

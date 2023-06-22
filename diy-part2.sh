#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-openwrt
# File name: diy-part2.sh
# Description: openwrt DIY script part 2 (After Update feeds)
#

#更换默认IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

#密码
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$.rT.cU4J$wyLRZI4h2AaJMCQBZVYX90:19448:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

#更换默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci-ssl-nginx/Makefile

sed -i '/mediaurlbase/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i '/mediaurlbase/d' feeds/luci/themes/luci-theme-material/root/etc/uci-defaults/30_luci-theme-material
sed -i '/mediaurlbase/d' feeds/luci/themes/luci-theme-netgear/root/etc/uci-defaults/30_luci-theme-netgear

sed -i '/mediaurlbase/d' feeds/small8/luci-theme-design/root/etc/uci-defaults/30_luci-theme-design
sed -i '/mediaurlbase/d' feeds/small8/luci-theme-edge/root/etc/uci-defaults/30_luci-theme-edge
sed -i '/mediaurlbase/d' feeds/small8/luci-theme-ifit/files/10_luci-theme-ifit
sed -i '/mediaurlbase/d' feeds/small8/luci-theme-opentopd/root/etc/uci-defaults/30_luci-theme-opentopd
sed -i '/mediaurlbase/d' feeds/small8/luci-theme-tomato/root/etc/uci-defaults/30_luci-theme-tomato

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-argon-mod
rm -rf feeds/luci/themes/luci-theme-design
rm -rf feeds/small8/luci-theme-argon 
rm -rf feeds/small8/luci-app-argon-config

mv feeds/small8/luci-theme-design feeds/luci/themes

#TTYD自动登录
sed -i 's/login/login -f root/g' feeds/packages/utils/ttyd/files/ttyd.config
sed -i '/${interface:+-i $interface}/d' feeds/packages/utils/ttyd/files/ttyd.init

#删除zzz-default-settings的exit 0
sed -i '/exit 0/d' package/lean/default-settings/files/zzz-default-settings

#ntp服务器
echo "uci delete system.ntp.server" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='ntp.ntsc.ac.cn'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='cn.ntp.org.cn'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='time1.aliyun.com'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='time1.cloud.tencent.com'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='pool.ntp.org'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='time.apple.com'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci add_list system.ntp.server='time.cloudflare.com'" >> package/lean/default-settings/files/zzz-default-settings
echo "uci commit system" >> package/lean/default-settings/files/zzz-default-settings
echo "" >> package/lean/default-settings/files/zzz-default-settings

#wifi
echo "uci set wireless.radio0.channel=auto" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.band=2g" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.htmode=HT40" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.disabled=0" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.country=US" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.legacy_rates=1" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio0.mu_beamformer=0" >> package/lean/default-settings/files/zzz-default-settings

echo "uci set wireless.radio1.channel=auto" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.band=5g" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.htmode=VHT80" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.disabled=0" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.country=US" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.legacy_rates=1" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.radio1.mu_beamformer=0" >> package/lean/default-settings/files/zzz-default-settings

echo "uci set wireless.default_radio0=wifi-iface" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.device=radio0" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.network=lan" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.mode=ap" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.ssid=OpenWrt_2.4G" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.encryption=sae-mixed" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio0.key=ueubmbzr" >> package/lean/default-settings/files/zzz-default-settings

echo "uci set wireless.default_radio1=wifi-iface" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.device=radio1" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.network=lan" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.mode=ap" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.ssid=OpenWrt_5G" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.encryption=sae-mixed" >> package/lean/default-settings/files/zzz-default-settings
echo "uci set wireless.default_radio1.key=ueubmbzr" >> package/lean/default-settings/files/zzz-default-settings

echo "uci commit wireless" >> package/lean/default-settings/files/zzz-default-settings
echo "" >> package/lean/default-settings/files/zzz-default-settings

#加回zzz-default-settings的exit 0
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings

#网络
echo "uci set network.lan.ip6assign='64'" >> /home/lxg/lede/package/lean/default-settings/files/zzz-default-settings

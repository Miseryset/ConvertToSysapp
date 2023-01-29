
SKIPUNZIP=1

_core(){

unzip -o "${ZIPFILE}" 'priv_list.conf' 'list.conf' -d ${TMPDIR} >/dev/null 2>&1
unzip -o "${ZIPFILE}" 'module.prop' -d ${MODPATH} >/dev/null 2>&1
sed -i "s/description.*/&，转化的有：/g" ${TMPDIR}/module.prop

work(){
mkdir -p ${dir}
#这句主要是设置 SE上下文 
set_perm_recursive ${dir%/*} 0 0 0755 0644
for app in $(cat ${list} | grep -v '^#')
do
	ui_print "---  转换  ${app}  "
	ui_print ""
	cd /data/app
	target=`find . -maxdepth 2 -name "${app}*"`
	if [[ ${target} != "" ]]; then
		cp -rf "${target}" "${dir}"
		sed -i "s#description.*#&${app}[${tag}]    #g" ${TMPDIR}/module.prop
	else
		ui_print "---  ${app} 未安装 ? "
		ui_print ""
	fi
done
}

if [[ -e ${TMPDIR}/list.conf ]]; then
	dir=${MODPATH}/system/app
	list=${TMPDIR}/list.conf
	tag='/app'
	work
fi
if [[ -e ${TMPDIR}/priv_list.conf ]]; then
	dir=${MODPATH}/system/priv-app
	list=${TMPDIR}/priv_list.conf
	tag='/priv-app'
	work
fi

sed -i "s/description.*/& 刷入时间：$(date +%F) $(date +%T)/g" ${TMPDIR}/module.prop
cp -rf ${TMPDIR}/module.prop ${MODPATH}/module.prop

}

_check_source(){
	if [[ ! -e "${TMPDIR}/_mod" ]]; then
		unzip -o "$ZIPFILE" '_mod/*' -d $TMPDIR >/dev/null 2>&1
		[[ ! -e "${TMPDIR}/_mod" ]] && abort "---  必要资源无法提取"
	fi
}
_sign(){
	source ${TMPDIR}/_mod/_sign.sh
}
_checktools(){
	source ${TMPDIR}/_mod/_check.sh
	[[ "${_ismiui}x" == "Fx" ]] && abort "---  模块只适用于  MIUI  "
	[[ "${_isdevice}x" == "Fx" ]] && abort "---  模块只适用于  $cpd_device  "
	[[ "${_ismatchver}x" == "Fx" ]] && abort "---  模块只适用于系统版本  $cpd_sbv  "
}
_tools(){
	for _tool in $@
	do
		_tool2=${TMPDIR}/_mod/_tools/${_tool}
		set_perm ${_tool2} 0 0 0777
		eval ${_tool}=${_tool2}
		ui_print "---  布置 $_tool  "
	done
}
_choose(){
	source ${TMPDIR}/_mod/_choose.sh
}
_thanks(){
	source ${TMPDIR}/_mod/_thank.sh
}
_display(){
	if [[ -e "${MODPATH}/module.prop" ]]; then
		$display
	fi
}


_check_source
_sign
#_checktools
#工具布置
_tools "display"
#选择工具 点滑选择"_chooseToS 时间 次数";音量键选择"chooseport 时间"
#_choose
_core
_thanks
_display



##########################################################################################
# 默认权限请勿删除
set_perm_recursive $MODPATH 0 0 0755 0644
#set_perm $MODPATH/service.sh 0 0 0777
#set_perm $MODPATH/module.prop 0 0 0644
#set_perm $MODPATH/post-fs-data.sh 0 0 0777
#
#
# 请注意，magisk模块目录中的所有文件/文件夹都有$MODPATH前缀-在所有文件/文件夹中保留此前缀
# 一些例子:
#
# 对于目录(包括文件):
# set_perm_recursive  <目录>                <所有者> <用户组> <目录权限> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
#
# set_perm_recursive $MODPATH/system/lib 0 0 0755 0644
# set_perm_recursive $MODPATH/system/vendor/lib/soundfx 0 0 0755 0644
#
# 对于文件(不包括文件所在目录)
# set_perm  <文件名>                         <所有者> <用户组> <文件权限> <上下文> (默认值是: u:object_r:system_file:s0)
#  
# set_perm $MODPATH/system/lib/libart.so 0 0 0644
# set_perm /data/local/tmp/file.txt 0 0 644
#
##########################################################################################
# 可用变量:
#
# MAGISK_VER (string):当前已安装Magisk的版本的字符串(字符串形式的Magisk版本)
# MAGISK_VER_CODE (int):当前已安装Magisk的版本的代码(整型变量形式的Magisk版本)
# BOOTMODE (bool):如果模块当前安装在Magisk Manager中，则为true。
# MODPATH (path):你的模块应该被安装到的路径
# TMPDIR (path):一个你可以临时存储文件的路径
# ZIPFILE (path):模块的安装包（zip）的路径
# ARCH (string): 设备的体系结构。其值为arm、arm64、x86、x64之一
# IS64BIT (bool):如果$ARCH(上方的ARCH变量)为arm64或x64，则为true。
# API (int):设备的API级别（Android版本）
#
##########################################################################################
# 可用函数:
#
# ui_print <msg>
#     打印(print)<msg>到控制台
#     避免使用'echo'，因为它不会显示在定制recovery的控制台中。
#
# abort <msg>
#     打印错误信息<msg>到控制台并终止安装
#     避免使用'exit'，因为它会跳过终止的清理步骤
#
##########################################################################################

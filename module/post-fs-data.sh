#!/system/bin/sh
MODDIR=${0%/*}
#执行shell脚本
#适合安卓的shell脚本，可以在百度得到
#也可以在酷安大佬复制得到
#注意magisk启动的顺序
#①读取系统的prop值
#②启动Mounting mirrors，挂载系统镜像，初始化magisk环境
#③执行/data/adb/post-fs-data.d文件夹下的脚本
#④启动magiskhide
#⑤执行卸载/升级模块(如果存在)
#⑥执行模块的post-fs-data.sh
#⑦读取并执行模块的system.prop
#⑧挂载模块修改/添加的系统文件
#⑨执行/data/adb/service.d文件夹下的脚本
#⑩执行模块的service.sh
#剩下也不需要了解了
#所以注意你写脚本时，脚本运行的时间，修改的值是否被覆盖

#如果不使用此脚本，请删除它


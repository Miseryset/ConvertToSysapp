#!/system/bin/sh

grep_prop() {
  local findfor="s/^$1=//p"
  cat $2 2>/dev/null | dos2unix | sed -n "$findfor" | head -n 1
}

deco(){
	rnd=$((${RANDOM}%35+1))
	if [ $rnd == 1 ];then
		_deco="🦄"
	elif [ $rnd == 2 ];then
		_deco="🦋"
	elif [ $rnd == 3 ];then
		_deco="🌹"
	elif [ $rnd == 4 ];then
		_deco="🌷"
	elif [ $rnd == 5 ];then
		_deco="💐"
	elif [ $rnd == 6 ];then
		_deco="🌸"
	elif [ $rnd == 7 ];then
		_deco="🌺"
	elif [ $rnd == 8 ];then
		_deco="🌼"
	elif [ $rnd == 9 ];then
		_deco="🍬"
	elif [ $rnd == 10 ];then
		_deco="🍭"
	elif [ $rnd == 11 ];then
		_deco="🍓"
	elif [ $rnd == 12 ];then
		_deco="🍇"
	elif [ $rnd == 13 ];then
		_deco="🍒"
	elif [ $rnd == 14 ];then
		_deco="🎈"
	elif [ $rnd == 15 ];then
		_deco="🎊"
	elif [ $rnd == 16 ];then
		_deco="🎉"
	elif [ $rnd == 17 ];then
		_deco="🎁"
	elif [ $rnd == 18 ];then
		_deco="🎏"
	elif [ $rnd == 19 ];then
		_deco="🎀"
	elif [ $rnd == 20 ];then
		_deco="💮"
	elif [ $rnd == 21 ];then
		_deco="💗"
	elif [ $rnd == 22 ];then
		_deco="❤️"
	elif [ $rnd == 23 ];then
		_deco="💛"
	elif [ $rnd == 24 ];then
		_deco="🧡"
	elif [ $rnd == 25 ];then
		_deco="💚"
	elif [ $rnd == 26 ];then
		_deco="💙"
	elif [ $rnd == 27 ];then
		_deco="💜"
	elif [ $rnd == 28 ];then
		_deco="🖤"
	elif [ $rnd == 29 ];then
		_deco="💕"
	elif [ $rnd == 30 ];then
		_deco="💞"
	elif [ $rnd == 31 ];then
		_deco="💓"
	elif [ $rnd == 32 ];then
		_deco="💖"
	elif [ $rnd == 33 ];then
		_deco="💘"
	elif [ $rnd == 34 ];then
		_deco="💝"
	else
		_deco="🎄"
	fi
}

if [[ $1 == "" ]]; then

	_default=/dev/tmp/module.prop
	_tonew=/data/adb/modules_update
	_tonew2=`ls -dt $_tonew/* | head -n 1` >/dev/null 2>&1
	after='module.prop'
	
elif [[ $1 == "-h" || $1 == "-help" ]]; then
	
	echo ''
	echo '---  _Display by Miseryset'
	echo ''
	echo '---  默认处理显示  module.prop  '
	echo '---  指定处理显示格式  _Display 绝对路径/module.prop 处理后的位置  '
	echo '---  若不指定  处理后的位置  ，则在原路径下生成  exe_module.prop  '
	echo '---  示例：'
	echo '---  _Display /dev/tmp/module.prop'
	echo '---  _Display /dev/tmp/module.prop /data/adb/modules_update/xxx  '
	echo ''
	
	exit
	
elif [[ $2 == "" ]]; then

	_default=$1
	_tonew2=${1%/*}
	after='exe_module.prop'
		
else

	_default=$1
	_tonew2=$2
	if [[ "${1%/*}" == "$2" ]]; then
		after='exe_module.prop'
	else
		after='module.prop'
	fi
	
fi

if [[ ! -e $_default ]]; then
	echo '---  未找到  module.prop  ，请检查  格式错误  或  文件不存在  '
	exit
fi


Mod_id=`grep_prop 'id' $_default`
Mod_name=`grep_prop 'name' $_default`
Mod_version=`grep_prop 'version' $_default`
Mod_versionCode=`grep_prop 'versionCode' $_default`
Mod_author=`grep_prop 'author' $_default`
Mod_description=`grep_prop 'description' $_default`
Mod_updateJson=`grep_prop 'updateJson' $_default`

deco
deco1="$_deco"
deco
deco2="$_deco"

echo "id=${Mod_id}
name=🎀${Mod_name}🎀(${Mod_id})
version=${Mod_version}
versionCode=${Mod_versionCode}
author=🌺${Mod_author}
description=${deco1} ${Mod_description} ${deco2}
updateJson=${Mod_updateJson}" >${_tonew2}/${after}

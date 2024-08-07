#!/system/bin/sh
shdir=${0%/*}

termux_bin="/data/data/com.termux/files/usr/bin"
export PATH=$PATH:"${termux_bin}"

zip -h > /dev/null 2>&1 || err="111"

if [[ ${err} = "111" ]]; then
  echo "zip 不可用"
  zipdir=`dirname $(echo ${0})`
  zip="${zipdir}/module/_mod/_tools/zip"
  cp -rf "${zip}" "/data/adb/zip"
  chmod 0777 "/data/adb/zip"
  export PATH=$PATH:"/data/adb"
fi

get_conf() {
	OLD_IFS="$IFS"
	IFS=$'\n'
	local findfor="s/^$1=//p"
	cat $2 2>/dev/null | dos2unix | sed -n "$findfor" | head -n 1
	IFS="$OLD_IFS"
}

dele="
system.prop
service.sh
post-fs-data.sh
uninstall.sh
"

_zipname=`get_conf 'name' ${shdir}/module/module.prop`
[ "${_zipname}" == "" ] && _zipname="default"

if [[ -e ${shdir}/${_zipname}.zip ]]; then
	mv ${shdir}/${_zipname}.zip ${shdir}/${_zipname}_old.zip
fi

cd $shdir/module
zip -r -9 ${shdir}/${_zipname}.zip *

for i in $dele
do
	zip ${shdir}/${_zipname}.zip -d $i
done

if [[ ${err} = "111" ]]; then
  rm -rf "/data/adb/zip"
fi

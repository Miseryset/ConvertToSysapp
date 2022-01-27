#!/system/bin/sh
shdir=${0%/*}

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

if [[ -e ${shdir}/${_zipname}.zip ]]; then
	mv ${shdir}/${_zipname}.zip ${shdir}/${_zipname}_old.zip
fi

cd $shdir/module
zip -r -9 ${shdir}/${_zipname}.zip *

for i in $dele
do
	zip ${shdir}/${_zipname}.zip -d $i
done


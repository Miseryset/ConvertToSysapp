
get_conf(){
	str=$(cat $2 | grep "$1")
	length=`expr ${#1} + 1`
	eval strr=${str:${length}}
	echo "$strr"
}

conf=${TMPDIR}/_mod/_check_conf.conf

cpd_device=`get_conf 'ro.product.system.device' $conf`
cpd_sbv=`get_conf 'ro.system.build.version.incremental' $conf`
cpd_bv=`get_conf 'ro.build.version.incremental' $conf`


if [[ `getprop ro.miui.ui.version.name` == "" ]]; then
 _ismiui="F"
else
 _ismiui="T"
fi

if [[ `getprop ro.product.system.device` == "$cpd_device" ]]; then
 _isdevice="T"
else
 _isdevice="F"
fi

if [[ `getprop ro.system.build.version.incremental` == "$cpd_sbv" && `getprop ro.build.version.incremental` == "$cpd_bv" ]]; then
 _ismatchver="T"
else
 _ismatchver="F"
fi

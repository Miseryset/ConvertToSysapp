#!/system/bin/sh
sh_dir=${0%/*}
conf="${sh_dir}/_check_conf.conf"

info="
ro.product.system.device
ro.system.build.version.incremental
ro.build.version.incremental
"

echo "" > ${conf}
echo '##############################' >> ${conf}
for i in $info
do
	echo "$i=`getprop $i`" >> ${conf}
done

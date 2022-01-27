#!/system/bin/sh

sh_dir=${TMPDIR}/_mod
upk_dir=${sh_dir}/_sign_source_upk

mkdir -p ${upk_dir}
tar -xf "${sh_dir}/_sign_source.tar.xz" -C "${upk_dir}" >/dev/null 2>&1
toilet=${upk_dir}/toilet
figlet=${upk_dir}/figlet
set_perm ${toilet} 0 0 0777
set_perm ${figlet} 0 0 0777

print_code(){
	ui_print ""
	ui_print ""
	rnd=$((${RANDOM}%8+1))
	if [ ${rnd} == 1 ];then
		${toilet} -t "${1}"
	elif [ ${rnd} == 2 ];then
		${toilet} -t -d ${upk_dir} -f pagga.tlf " ${1} "
	elif [ ${rnd} == 3 ];then
		${toilet} -t -d ${upk_dir} -f letter.tlf " ${1} "
	elif [ ${rnd} == 4 ];then
		${figlet} "          ${1} "
	elif [ ${rnd} == 5 ];then
		${figlet} -d ${upk_dir} -f big.flf "          ${1} "
	elif [ ${rnd} == 6 ];then
		${figlet} -d ${upk_dir} -f lean.flf -w 200 " ${1} "
	elif [ ${rnd} == 7 ];then
		${figlet} -d ${upk_dir} -f block.flf -w 200 " ${1} "
	else
		${figlet} -d ${upk_dir} -f banner.flf " ${1} "
	fi
	ui_print ""
	ui_print ""
}

print_code "Miseryset"

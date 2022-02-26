
sh_dir=${TMPDIR}/_mod

ui_print ""
ui_print "---  致谢："
for _name in $(cat ${sh_dir}/_thank_list.conf | grep -v '^#' ); do
	ui_print "------  $_name"
done
ui_print "---  等..."
ui_print ""

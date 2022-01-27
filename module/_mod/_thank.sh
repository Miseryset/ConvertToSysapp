
sh_dir=${TMPDIR}/_mod

ui_print ""
ui_print "---  Thanks："
for _name in $(cat ${sh_dir}/_thank_list.conf | grep -v '^#' ); do
	ui_print "------  $_name"
done
ui_print "---  etc."
ui_print ""

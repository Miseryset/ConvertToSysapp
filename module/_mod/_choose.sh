
_chooseToS(){
	# Original idea by chainfire and ianmacd @xda-developers
	[ "$1" ] && local delay=$1 || local delay=5
	[ "$2" ] && local trychance=$2 || local trychance=2
	
	ui_print ""
	ui_print "---  在 $delay 秒内选择，共有 $trychance 次机会， $trychance 次均超时则使用默认  否  "
	local count=0
	while true; do
		sleep $delay & timeout $delay /system/bin/getevent -l -q -c 8 2>/dev/null >${TMPDIR}/ToS
		if (`grep -q 'BTN_TOUCH *DOWN' ${TMPDIR}/ToS && grep -q 'BTN_TOUCH *UP' ${TMPDIR}/ToS`); then
			return 0
		elif (`grep -q 'BTN_TOUCH *DOWN' ${TMPDIR}/ToS`); then
			return 1
		fi
		count=$((count + 1))
		[ $count -lt $trychance ] && (ui_print "";ui_print "---  超时了，再试一次")
		[ $count -eq $trychance ] && (ui_print "";ui_print "---  超时次数过多，使用默认值  否  ") && return 1 && break
	done
}

chooseport(){
  # Original idea by chainfire and ianmacd @xda-developers
  [ "$1" ] && local delay=$1 || local delay=3
  while true; do
    local count=0
    while true; do
      timeout $delay /system/bin/getevent -lqc 1 2>&1 > $TMPDIR/events &
      sleep 0.5; count=$((count + 1))
      if (`grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events`); then
        return 1
      elif (`grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events`); then
        return 0
      fi
      [ $count -gt 15 ] && break
    done
  done
}

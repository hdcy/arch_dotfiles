#!/usr/bin/env bash
# close-confirm.sh — foot 终端两步确认关闭
# 第一次 Mod+C 标记待关闭，3秒内第二次才真关
# 无额外依赖，无弹窗
set -u

win=$(niri msg --json focused-window 2>/dev/null)
app_id=$(printf '%s' "$win" | jq -r '.app_id // ""')
pid=$(printf '%s' "$win" | jq -r '.pid // empty')

close() {
    rm -f "/tmp/foot-close-$pid"
    niri msg action close-window
}

[ "$app_id" != "foot" ] || [ -z "$pid" ] && { close; exit 0; }

collect() {
    local p=$1 child
    for child in $(pgrep -P "$p" 2>/dev/null); do
        ps -o comm= -p "$child" 2>/dev/null
        collect "$child"
    done
}
names=$(collect "$pid" | grep -vxE 'zsh|bash|sh|fish|dash|foot' | sort -u)
[ -z "$names" ] && { close; exit 0; }

if [ -f "/tmp/foot-close-$pid" ]; then
    close
else
    touch "/tmp/foot-close-$pid"
    (sleep 3 && rm -f "/tmp/foot-close-$pid") &
fi

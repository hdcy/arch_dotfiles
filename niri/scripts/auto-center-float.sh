#!/bin/bash
# 自动居中 niri 下新打开的浮动窗口
# 监听 event-stream，检测 is_floating: true 的新窗口并 center-window

declare -A seen

niri msg event-stream | while IFS= read -r line; do
    # 只处理 "Window opened or changed" 事件
    if [[ "$line" =~ ^Window\ opened\ or\ changed:\ (.*) ]]; then
        json="${BASH_REMATCH[1]}"

        # 提取 window id 和 is_floating（niri 输出的是 Rust debug 格式，字段名无引号）
        id=$(echo "$json" | grep -oP 'id:\s*\K\d+')
        floating=$(echo "$json" | grep -oP 'is_floating:\s*\K\w+')

        if [[ -n "$id" && "$floating" == "true" && -z "${seen[$id]}" ]]; then
            seen[$id]=1
            niri msg action center-window --id "$id"
        fi
    fi
done

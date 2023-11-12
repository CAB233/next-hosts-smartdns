#!/bin/bash

# 指定 hosts 文件路径（相对于仓库根目录）
hosts_file="next-hosts.txt"

# 指定输出文件路径（相对于仓库根目录）
output_file="next-hosts.conf"

# 读取 hosts 文件
while IFS= read -r line; do
    # 跳过注释和空行
    if [[ $line == \#* ]] || [[ -z $line ]]; then
        continue
    fi

    # 分割域名和IP地址
    parts=($line)
    if [ ${#parts[@]} -ge 2 ]; then
        ip=${parts[0]}
        domain=${parts[1]}

        # 输出 SmartDNS 格式到文件
        smartdns_line="address /$domain/$ip"
        echo $smartdns_line >> "$output_file"
    fi
done < "$hosts_file"

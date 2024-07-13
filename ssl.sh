#!/bin/bash

# 从环境变量中获取参数
chat_id=${TELEGRAM_CHAT_ID}
key=${TELEGRAM_API_KEY}
domain=${DOMAIN}
dns=${DNS_PROVIDER}
DP_Id=${DP_Id}
DP_Key=${DP_Key}

# 发送文本消息
function send_message(){
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot${key}/sendMessage" -d chat_id=${chat_id} -d text="${message}"
}

# 获取当前时间
current_time=$(date +"%Y-%m-%d %H:%M:%S")
message="现在是${current_time}，你的域名(${domain})的ssl证书正在申请"
send_message "---------------------------"
send_message "${message}"

# 使用 acme.sh 申请 SSL 证书
~/.acme.sh/acme.sh --issue --dns $dns -d $domain --keylength 2048 > temp_rsa2048.log
~/.acme.sh/acme.sh --issue --dns $dns -d $domain --keylength ec-256 > temp_ec256.log

# SSL 证书的路径
cert_path="/home/runner/.acme.sh/$domain/$domain.cer"
key_path="/home/runner/.acme.sh/$domain/$domain.key"
ca_cert_path="/home/runner/.acme.sh/$domain/ca.cer"
fullchain_path="/home/runner/.acme.sh/$domain/fullchain.cer"

# SSL 证书的路径(ecc)
cert_path_ecc="/home/runner/.acme.sh/$domain" + "_ecc/$domain.cer"
key_path_ecc="/home/runner/.acme.sh/$domain" + "_ecc/$domain.key"
ca_cert_path_ecc="/home/runner/.acme.sh/$domain" + "_ecc/ca.cer"
fullchain_path_ecc="/home/runner/.acme.sh/$domain" + "_ecc/fullchain.cer"

# 发送证书和密钥
function send_file(){
    local file_path=$1
    curl -F document=@"$file_path" "https://api.telegram.org/bot${key}/sendDocument?chat_id=${chat_id}"
}

# 获取当前时间
current_time=$(date +"%Y-%m-%d %H:%M:%S")
message="现在是${current_time}，你的域名(${domain})的ssl证书已经申请好啦~"
send_message "${message}"
send_message "---以下为RSA2048的---"
send_file $cert_path
send_file $key_path
send_file $ca_cert_path
send_file $fullchain_path

send_message "---以下为ECC256的---"
send_file $cert_path_ecc
send_file $key_path_ecc
send_file $ca_cert_path_ecc
send_file $fullchain_path_ecc

send_message "---以下为申请日志---"
send_file "./temp_rsa2048.log"
send_file "./temp_ec256.log"


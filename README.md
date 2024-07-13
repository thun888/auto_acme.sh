# auto_acme.sh
每7天自动申请证书，并通过telegram机器人下发

## 环境变量配置

在使用之前，你需要在 GitHub 仓库的 "Secrets" 中配置以下环境变量。

### 1. 配置环境变量

- **`TELEGRAM_CHAT_ID`**: 你的 Telegram 聊天 ID，用于接收证书通知。可以从如[getuseridbot](https://t.me/getuseridbot)之类的机器人获取

- **`TELEGRAM_API_KEY`**: 你的 Telegram Bot 的 API 密钥。你可以通过 BotFather 创建一个 Telegram Bot 并获取 API 密钥。

- **`DOMAIN`**: 你要申请 SSL 证书的域名。例如：`example.com` 或 `*.example.com`。

- **`DNS_PROVIDER`**: 你使用的 DNS 服务提供商的名称。例如：`dns_dp`（DNSPod），**目前仅支持DNSPod**，有需要的可以自行修改调用acme.sh的部分

- **`DP_Id`**: 你的 DNSPod 密钥 ID。

- **`DP_Key`**: 你的 DNSPod 密钥 KEY

- **`EMAIL`**: 你的电子邮件地址，用于注册 `acme.sh` 和接收有关证书的通知。

### 2. 示例

- **`TELEGRAM_CHAT_ID`**: `123456789`
- **`TELEGRAM_API_KEY`**: `123456789:ABCDEF_GHIJKL_MNOPQR`
- **`DOMAIN`**: `*.example.com`
- **`DNS_PROVIDER`**: `dns_dp`
- **`DP_Id`**: `123456`
- **`DP_Key`**: `abcdef1234567890abcdef1234567890`
- **`EMAIL`**: `your-email@example.com`


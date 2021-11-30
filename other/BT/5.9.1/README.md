### 宝塔 5.9.1
安装方法（宝塔 5.9.1 开心版面板）
使用SSH连接工具连接到您的Linux服务器后，根据系统执行相应命令开始安装（大约2分钟完成面板安装）：

centos安装脚本:
```
yum install -y wget && wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/sunpma/cdn/master/bt/5.9.1/install-5.9-c.sh && sh install.sh
```
ubuntu安装脚本:
```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/sunpma/cdn/master/bt/5.9.1/install-ubuntu.sh && sudo bash install.sh
```
debian安装脚本：
```
wget --no-check-certificate -O install.sh https://raw.githubusercontent.com/sunpma/cdn/master/bt/5.9.1/install-ubuntu.sh && bash install.sh
```
如果你是免费的5.x宝塔面板可以使用脚本升到最新的开心版5.9.1面板 输入：
```
curl https://raw.githubusercontent.com/sunpma/cdn/master/bt/5.9.1/update_pro.sh | bash 
```
### 恢复免费面板
```
wget -O update.sh http://download.bt.cn/install/update.sh && bash update.sh free
```

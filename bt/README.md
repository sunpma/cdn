### 离线升级步骤：

1、下载离线升级包

2、将升级包上传到服务器中的/root目录

3、解压文件：unzip LinuxPanel-*

4、切换到升级包目录： cd panel

5、执行升级脚本：bash update.sh

6、删除升级包：cd .. && rm -f LinuxPanel-*.zip && rm -rf panel

### 下载
```
wget https://raw.githubusercontent.com/sunpma/cdn/master/bt/LinuxPanel-7.4.5.zip
```
### 全部安装完成后，执行以下内容，避免官方搞小动作
```
echo '127.0.0.1 bt.cn' >>/etc/hosts
```

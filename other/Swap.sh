#!/bin/bash

############################################################
#  虚拟内存设置脚本
#  
#  发布日期：2024-07-05
#  程序版本：1.0
#  脚本作者：SunPma
#  脚本链接：https://suntl.com
############################################################

# 判断系统版本
check_system_os(){
    if cat /etc/issue | grep -q -i "debian"; then
        release="Debian"
    elif cat /etc/issue | grep -q -i "ubuntu"; then
        release="Ubuntu"
    else
        release="Unknown"
        echo -e " "
        echo -e "\n 系统不受支持，安装失败 \n"
        exit 1
    fi
}

# 检查是否是root账户
check_root(){
    if [[ $EUID != 0 ]]; then
        echo -e " 当前非ROOT账号，无法继续操作。\n 请更换ROOT账号登录服务器。 " 
        exit 1
    else
        echo -e " "
        echo -e "\n 管理员权限检查通过 "
        echo -e " "
    fi
}

# 查看当前交换分区
show_swap(){
    echo -e "\033[36m ---------------------------------------------------------------------- \033[0m"
    echo -e " "
    echo -e "\033[34m当前交换分区信息: \033[0m"
    echo -e " "
    swapon --show
    free -h
    echo -e " "
    echo -e "\033[36m ---------------------------------------------------------------------- \033[0m"
}

# 设置新的交换分区
set_swap(){
    read -p "请输入新的交换分区大小（单位MB）:  " swapsize
    read -p "确认要设置新的交换分区吗？这将删除现有的交换分区并创建新的（Y/N）:  " confirm
    if [[ $confirm == "Y" || $confirm == "y" ]]; then
        unset_swap
        mkdir -p /swap
        dd if=/dev/zero of=/swap/swapfile bs=1M count=$swapsize
        chmod 600 /swap/swapfile
        mkswap /swap/swapfile
        swapon /swap/swapfile
        echo -e " "
        echo '/swap/swapfile none swap sw 0 0' | tee -a /etc/fstab
        echo -e " "
        echo -e "\033[34m新的交换分区设置完成 \033[0m"
        echo -e " "
        show_swap
    else
        echo -e " "
        echo -e "\033[34m操作取消 \033[0m"
        echo -e " "
    fi
}

# 取消交换分区
unset_swap(){
    read -p "确认要删除所有交换分区吗？（Y/N）:  " confirm
    if [[ $confirm == "Y" || $confirm == "y" ]]; then
        if [[ -e /swap/swapfile ]] || [[ -e /swap ]] || [[ `free | grep -i swap | awk -F " " '{print $2}'` -ne 0 ]]; then
            swapoff -a
            rm -rf /swap
            sed -i '/swap/d' /etc/fstab
            if [[ -e /swap/swapfile ]] || [[ -e /swap ]] || [[ `free | grep -i swap | awk -F " " '{print $2}'` -ne 0 ]]; then
                echo -e " "
                echo -e "\033[34m删除失败，写保护 \033[0m"
                echo -e " "
            else
                echo -e " "
                echo -e "\033[34m脚本执行完毕，现有交换分区已删除 \033[0m"
                echo -e " "
            fi
        else
            echo -e " "
            echo -e "\033[34m删除失败，没有找到虚拟内存 \033[0m"
            echo -e " "
        fi
    else
        echo -e " "
        echo -e "\033[34m操作取消 \033[0m"
        echo -e " "
    fi
}


# 修改DNS
modify_dns(){
    read -p "请输入新的DNS服务器地址（一个或两个，使用空格分隔）: " dns
    read -p "确认要修改DNS设置吗？（Y/N）: " confirm
    if [[ $confirm == "Y" || $confirm == "y" ]]; then
        if [[ $release == "Debian" ]] || [[ $release == "Ubuntu" ]]; then
            echo -e "nameserver $dns" > /etc/resolv.conf
            echo -e " "
            echo -e "\033[34mDNS设置完成 \033[0m"
            echo -e " "
            cat /etc/resolv.conf
            echo -e " "
        else
            echo -e " "
            echo -e "\033[34m当前系统不支持修改DNS设置 \033[0m"
            echo -e " "
        fi
    else
        echo -e " "
        echo -e "\033[34m操作取消 \033[0m"
        echo -e " "
    fi
}

# 显示菜单
show_menu(){
    echo -e "\033[36m ====================================== \033[0m"
    echo -e "\033[31m  虚拟内存设置脚本 \033[0m"
    echo -e " "
    echo -e "\033[34m  版本：1.0 \033[0m"
    echo -e "\033[34m  时间：2024-07-05 \033[0m"
    echo -e "\033[34m  作者：SunPma \033[0m"
    echo -e "\033[34m  链接：https://suntl.com \033[0m"
    echo -e " "
    echo -e "\033[36m -------------------------------------- \033[0m"
    echo -e "\n  请选择你需要的操作: \n"
    echo -e "\033[33m  1. 查看当前交换空间 \033[0m"
    echo -e "\033[33m  2. 设置新的交换空间 \033[0m"
    echo -e "\033[33m  3. 删除所有交换分区 \033[0m"
    echo -e "\033[33m  4. 修改系统DNS 设置 \033[0m"
    echo -e "\033[33m  5. 退出脚本 \033[0m"
    echo -e "\033[36m ====================================== \033[0m"
    echo -e " "
}

# 主函数
main(){
    check_system_os
    check_root
    show_menu
    read -p "请输入选项 [1-5]: " option
    case $option in
        1)
            show_swap
            ;;
        2)
            set_swap
            ;;
        3)
            unset_swap
            ;;
        4)
            modify_dns
            ;;
        5)
            echo -e " "
            echo -e "\033[34m 退出脚本 \033[0m"
            echo -e " "
            exit 0
            ;;
        *)
            echo -e " "
            echo -e "\033[34m 无效选项，退出脚本 \033[0m"
            echo -e " "
            exit 1
            ;;
    esac
}

# 调用主函数
main
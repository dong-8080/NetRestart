# 使用
# 通过crontab 执行后台定时任务
# crontab -e 查看配置文件，cron不能直接调用GUI程序，需要指定输出位置；修改corn配置文件后需要重启服务service cron restart
# DrClientLinux 相关进程有两个，需要同时杀死才能调用新的DrClient

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

#!/bin/bash
if ping www.baidu.com -c1 >/dev/null 2>&1
        then
	# ping baidu, if sucess do exit
        if [ $? -eq 0 ];then
		exit		
	fi
fi	

# find the drClientLinux process and kill the process
ID=`ps -ef | grep DrClientLinux | grep -v grep | awk '{print $2}'`
echo $ID
for id in $ID
do
kill -15 $id
echo "kill $id"
done

ID=`ps -ef | grep drcomauthsv | grep -v grep | awk '{print $2}'`
echo $ID
for id in $ID
do
kill -15 $id
echo "kill $id"
done

# sleep 5000
sleep 3s

# restart the DrclientLinux
/home/wd/桌面/DrClient-64/DrClient/DrClientLinux

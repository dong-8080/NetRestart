# NetRestart

在Linux平台下，校园网客户端DrClient可能会存在断网问题，导致无服务无法连接，此脚本实现在Linux平台下校园网断网重连。

首先通过ping命令判断是否联通网络，若未联通则杀死DrClient相关进程，在sleep 3秒后重新调用DrClientLinux实现重新连接。同时借助crontab执行定时任务，设置每15分钟执行一次。`crontab -e`命令可以设置定时任务，配置语句如下：
```
*15 * * * * export DISPLAY=:10 && bash path/to/DrClient-64/DrClient/net_restart.sh
```

由于cron 运行于非交互 shell，没有附属的终端，也独立于图形桌面，使用cron执行GUI程序需要引入`export DISPLAY=:0`。

最大的坑是眼睁睁看着脚本把DrClient进程杀死，却无法重新调用DrClient，后来通过进程查看发现DrClient在执行时，不仅只有一个DrClientLinux进程在运行，还有另一进程drcomauthsvr，杀死此进程后才能成功调用DrClient。

对Linux平台不是很熟悉，第一次尝试写脚本，全程靠百度解决。只要思路正确，实现方式通过百度即可解决。

三个臭皮匠顶个诸葛亮，感谢曹洋与孙胤泰陪伴的小半天，虽然三个人什么都不会，最终讨论分析解决了各个问题后成功实现任务也挺有成就感的。

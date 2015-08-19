#!/bin/sh

##############################################
# start_time=`date "+%s"`

# # 有意思，用一对小括号，报语法错误。
# for((i=1;i<=4;i++))
# do
# 	echo success;sleep 2
# done

# end_time=`date "+%s"`

# echo "TIME: `expr $end_time - $start_time`"



##############################################
# start_time=`date "+%s"`

# # 有意思，用一对小括号，报语法错误。
# for((i=1;i<=4;i++))
# do
# 	{
# 		echo success;sleep 2
# 	}&
# done
# wait

# end_time=`date "+%s"`

# echo "TIME: `expr $end_time - $start_time`"




##############################################
# trap: 接受信号 2 （ctrl +C）做的操作
# exec 1000>&-和exec 1000<&- 是关闭fd1000的意思
# > 读的绑定，< 写的绑定, <> 则标识对文件描述符 1000的所有操作等同于对管道文件的操作
trap "exec 1000>&-;exec 1000<&-;exit 0" 2

mkfifo testfifo
# 百度搜索：exec 重定向 了解详情
exec 1000<>testfifo
rm -fr testfifo

for((n=1;n<=10;n++))
do
	# 在fd6中放置了n个回车符
	echo >&1000
done

start_time=`date "+%s"`
for((i=1;i<=30;i++))
do
	read -u 1000
	{
		echo success$i;sleep 2
		echo >&1000
	}&
done
wait
end_time=`date "+%s"`

echo "TIME: `expr $end_time - $start_time`"
exec 1000>&-
exec 1000<&-














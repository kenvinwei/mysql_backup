#/bin/bash
#mysql 备份
mysql_host="host"
mysql_user="root"
mysql_passwd="root"
databases=(db1 db2 db3)
LIMIT_SAVE=2
date=$(date -d '+0 days' +%Y%m%d)  
savepath="/opt/mysqldata/"$date
if [ ! -d $savepath ]; then  
    mkdir -p $savepath  
fi  
cd $savepath
echo "开始备份中......"
for database in "${databases[@]}";do
	mysqldump -u$mysql_user -p$mysql_passwd -h$mysql_host $database > $savepath"/"$database".sql" 
done;
files=`cd /opt/mysqldata && ls | sort`
read -a array <<< $files
length=`expr "${#array[@]}" - $LIMIT_SAVE`
for (( i = 0; i < ${length}; i++ ))
  do
    cmd=`cd /opt/mysqldata && rm -rf ${array[$i]}`
    $cmd
done
echo "备份完成!at:"$savepath;


#/bin/bash
#mysql 备份
selfpath=`dirname $0` 
. $selfpath"/config.sh"
date=$(date -d '+0 days' +%Y%m%d)  
savepath=$path"/"$date
if [ ! -d $savepath ]; then  
    mkdir -p $savepath  
fi  
cd $savepath
echo "开始备份中......"
for database in "${databases[@]}";do
	mysqldump -u$mysql_user -p$mysql_passwd -h$mysql_host $database > $savepath"/"$database".sql" 
done;
files=`cd $path && ls | sort`
read -a array <<< $files
length=`expr "${#array[@]}" - $limit_save`
for (( i = 0; i < ${length}; i++ ))
  do
    cmd=`cd $path && rm -rf ${array[$i]}`
    $cmd
done
echo "备份完成!at:"$savepath;


#!/bin/bash
#@author gholl 翻版随意
echo "-------------垃圾脚本翻版B究------------"
rm -rf ./tmp
json="{\"version\":\"123\",\"list\":["
mark_1="["
mark_2="]"
mark_3="},"
mark_4=","
mark_5="}"
key_pkg="{\"packageName\":"
file="package.json"
key_name="\"appName\":"
key_versionCode="\"versionCode\":"
key_versionName="\"versionName\":"
key_size="\"size\":"
key_laucher="\"laucher_acitivity\":"
echo -n $json>$file
find $1 -name '*.apk' | while read line; do
str=`./aapt dump badging $line`
size=`wc -c $line | awk '{print int($1)}'`
#echo $str
#截取package name后的文字
str_1=${str#*package: name=\'}
#截取application label后的文字
str_2=${str#*application: label=\'}
#截取应用icon后面字符串
str_3=${str#*icon=\'}
#截取versionCode后面的字符串
str_4=${str#* versionCode=\'}
#截取versionName后面的字符串
str_5=${str#* versionName=\'}
str_6=${str#*launchable-activity: name=\'}
#APK重命名字符串
rename=${1}${str_2}.apk
#应用的名字
appName=${str_2%%\'*}
#应用的包名
packageName=${str_1%%\'*}
#应用的版本号
v_code=${str_4%%\'*}
#应用的版本名
v_name=${str_5%%\'*}
#应用入口
laucher_acitivity=${str_6%%\'*}

#应用icon path
icon_path=${str_3%%\'*}
#json 数据拼接
data="${key_pkg}\"${packageName}\"${mark_4}${key_name}\"${appName}\"${mark_4}${key_versionCode}\"${v_code}\"${mark_4}${key_versionName}\"${v_name}\"${mark_4}${key_size}\"${size}\"${mark_4}${key_laucher}\"${laucher_acitivity}\"${mark_3}"
echo -n "${data}">>$file
#echo $json
echo $packageName:$appName
apkName=`echo "$appName"|sed "s/ /_/g"`
unzip -o $line $icon_path -d ./tmp
mv -i ./tmp/${icon_path} ./tmp/${apkName}.png
echo ./tmp/${apkName}.png
mv $line $1/${apkName}.apk
done
sed -i '' '$s/.$//' $file
rm -rf ./tmp/res
echo "--------------------"
json_end="$mark_2$mark_5"
echo -n "${json_end}">>$file
echo "你Gholl哥告诉你脚本跑完了，你给钱了么？"
echo "......................................"
echo "付费地址：http://www.gholl.com/sh_money"
echo "......................................"
echo "数据位置：当前目录package.json"

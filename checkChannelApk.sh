apppath="."
# 如果当前文件夹下没有"runApk"和"errorApk"文件夹，就新建一个
if [ ! -d "./runApk" ]; then
mkdir ./runApk
fi
if [ ! -d "./errorApk" ]; then
mkdir ./errorApk
fi
# 开始遍历文件夹
for file in ${apppath}/*
do
# 抽取后缀名为apk的文件
if [[ $file == *.apk ]] || [[ $file == *.APK ]]
then

#提取apk名  
apkPath=${file#*/}

# 取出包名并截取出渠道号
# 例：PPmoney_WHAN_FF_PPZSCPD_v8.1.6 ==> WHAN_FF_PPZSCPD 
channel=${file#*_}
channel=${channel%_*}

# 命令行获取包渠道号,并截取出渠道号
walleChannel=$(java -jar walle-cli-all.jar show $apkPath)
walleChannel=${walleChannel#*=}
walleChannel=${walleChannel%\}*}

#比较,正确的话输出日志并将已执行的apk移动到run文件夹，错误则打印错误日志
if [ $channel == $walleChannel ]; then
	echo -e "success: "$apkPath", channel:"$channel", realChannel:"$walleChannel'\n' >>checkChannelResult.log
	mv $file ./runApk
else
	echo -e "error: "$apkPath", channel:"$channel", realChannel:"$walleChannel'\n' >>checkChannelResult.log
	mv $file ./errorApk
fi

fi
done

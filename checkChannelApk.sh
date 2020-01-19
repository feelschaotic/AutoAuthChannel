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
channel=${channel%_v*}

# 命令行获取包渠道号,并截取出渠道号
walleChannel=$(java -jar walle-cli-all.jar show $apkPath)
equalSign="="
if [[ $walleChannel =~ $equalSign ]]
then
	walleChannel=${walleChannel#*=}
	walleChannel=${walleChannel%\}*}
else
	walleChannel=''
fi

if [[ $channel != $walleChannel ]]; then
	channel=${file#*_}
	channel=${channel%.apk*}
fi


echo -e $channel
echo -e $walleChannel
	
#比较,正确的话将apk移动到runApk文件夹，错误则移动到errorApk文件夹，并且把过程记录在log文件里
if [[ $channel == $walleChannel ]]; then
	echo -e "success: "$apkPath", channel:"$channel", realChannel:"$walleChannel'\n' >>checkChannelResult.log
	mv $file ./runApk
else
	echo -e "error: "$apkPath", channel:"$channel", realChannel:"$walleChannel'\n' >>checkChannelResult.log
	mv $file ./errorApk
fi

fi
done

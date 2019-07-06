## AutoAuthChanne
Automate the validation of Android channels. 自动化验证Android渠道号脚本

## 一、背景

以往测试验收渠道包，需要开发写个log打印出渠道号 → 测试手工装包 → 查看打印日志 → 然后对比渠道号。

思考写个Android 自动验证渠道号的脚本，减少测试的工作量。找了下网上资源，基本套路都是 apkTool 反编译 → 拿到 AndroidManifest.xml → 解析里面的渠道号。这种方式只能应用于 Gradle Plugin 多渠道打包方案。这种打渠道包方式效率太低，基本已经弃用。

公司采用美团的Walle打包方案，所以本项目用 Walle 做例子说明。

## 二、脚本思路

解析apk名拿到外部渠道号 → 使用打渠道包工具 walle 提供的命令行工具获取 apk 真正的渠道号 → 比对两个渠道号 → 渠道号正确的移入 runApk 文件夹，错误的移入 errorApk 文件夹，并输出过程日志。

## 三、使用方法

1. 将脚本和 `walle-cli-all.jar` 放到渠道包的文件夹目录下，执行 sh 脚本。
2. 执行完成后同目录内会生成 log 日志，查看日志信息。  

> 注：思路通用，如果以后不是用 walle 打渠道包了，可以换 jar 包改改解析规则。


[详细博文介绍](https://www.jianshu.com/p/92d663bf729f)

# WiFi密码查看方法


教程当记录写在这里，虽然平常用得不多，但是要找的时候就很麻烦。
<!--more-->

# OPPO R9无root查看WiFi密码

## 需要的软件
  
  * WiFi万能钥匙
  
  * zarchiver pro文件解压器
  
  * ES文件浏览器

## 步骤

  1. OPPO R9手机里（个人认为这个方法安卓的都可以吧……）点开`备份与恢复`，新建备份，数据为`系统数据/设置`。
  
  2. 在文件解压器中对`Backup/Data/你备份的当天日期文件夹/Setting/wifiConfig.tar`文件进行解压。
  
  3. 解压后的数据在当前文件夹data中，而WiFi密码就在`wpa_supplicant.conf`文件夹里，打开为文本文件即可，其中`psk`即为当前WiFi的密码。
  
# win10查看WiFi密码

  1. `设置`/`网络和internet`/`更改适配器选项`
  
  2. 右键`wifi`-`状态`-`无线属性`-`安全`
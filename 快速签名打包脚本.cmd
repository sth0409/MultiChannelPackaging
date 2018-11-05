@echo off
set outputDir=C:\Users\Administrator\Desktop\加固多渠道打包流程
set inputfile=Ro_legu
set channel=yingyongbao,qihu360,xiaomi,huawei,vivo,oppo,meizu,sougou,leshangdian,baidu,ali
set channelupgrade=appupgrade,testgroup


echo ------------------------------------------ 
echo 当前inputDir=%outputDir%
echo 当前outputDir=%outputDir%\记得改TinkerID啊result
echo 当前channel=%channel%
echo 当前升级渠道包channelupgrade=%channelupgrade%
echo 当前inputfileAPK=%inputfile%
echo ------------------------------------------ 
echo 请确保已经修改了cmd文件中的 outputDir，channel
echo 请确保inputDir下存在%inputfile%.apk
echo ------------------------------------------  
pause 


if exist %outputDir%\记得改TinkerID啊result rd/s/q %outputDir%\记得改TinkerID啊result 

if not exist %outputDir%\%inputfile%.apk echo inputDir下不存在%inputfile%.apk 请检查 
pause
if not exist %outputDir%\%inputfile%.apk exit



if not exist %outputDir%\记得改TinkerID啊result md %outputDir%\记得改TinkerID啊result

%outputDir:~0,2%
cd %outputDir%

zipalign -v 4 %outputDir%\%inputfile%.apk %outputDir%\记得改TinkerID啊result\%inputfile%_no_sign.apk 

echo ------------------------------------------ 
echo 对齐资源已完成 生成文件%inputfile%_no_sign.apk 
echo ------------------------------------------  
pause 

cd %outputDir%
%outputDir:~0,2%

java -jar apksigner.jar sign  --ks key.jks  --ks-key-alias key --ks-pass pass:key12345678  --key-pass pass:key12345678  --out %outputDir%\记得改TinkerID啊result\%inputfile%_sign.apk  %outputDir%\记得改TinkerID啊result\%inputfile%_no_sign.apk  


echo -----------------------------------
echo 签名已完成 生成文件%inputfile%_sign.apk
echo -----------------------------------
pause

java -jar CheckAndroidV2Signature.jar  %outputDir%\记得改TinkerID啊result\%inputfile%_sign.apk

echo ------------------------------------------------------
echo 检查v2签名效果完成 isV2OK: v2签名是否成功 如成功请继续 
echo ------------------------------------------------------
pause


Set /p str=是否生成渠道包？Y 是   N 否


If not %str%==Y If not %str%==y exit

:2
java -jar walle-cli-all.jar batch -c   %channel%  %outputDir%\记得改TinkerID啊result\%inputfile%_sign.apk   %outputDir%\记得改TinkerID啊result\channel记得改TinkerID啊result
java -jar walle-cli-all.jar batch -c   %channelupgrade%  %outputDir%\记得改TinkerID啊result\%inputfile%_sign.apk   %outputDir%\记得改TinkerID啊result\channel记得改TinkerID啊result\channelUpgrade

echo -----------------------------------------------
echo 生成%channel%渠道包完成  
echo 文件目录channel记得改TinkerID啊result
echo -----------
echo 生成%channelupgrade%渠道包完成 
echo 文件目录channel记得改TinkerID啊result\channelUpgrade
echo -----------------------------------------------
pause 

start %outputDir%\记得改TinkerID啊result
@echo off
set outputDir=C:\Users\Administrator\Desktop\�ӹ̶������������
set inputfile=Ro_legu
set channel=yingyongbao,qihu360,xiaomi,huawei,vivo,oppo,meizu,sougou,leshangdian,baidu,ali
set channelupgrade=appupgrade,testgroup


echo ------------------------------------------ 
echo ��ǰinputDir=%outputDir%
echo ��ǰoutputDir=%outputDir%\�ǵø�TinkerID��result
echo ��ǰchannel=%channel%
echo ��ǰ����������channelupgrade=%channelupgrade%
echo ��ǰinputfileAPK=%inputfile%
echo ------------------------------------------ 
echo ��ȷ���Ѿ��޸���cmd�ļ��е� outputDir��channel
echo ��ȷ��inputDir�´���%inputfile%.apk
echo ------------------------------------------  
pause 


if exist %outputDir%\�ǵø�TinkerID��result rd/s/q %outputDir%\�ǵø�TinkerID��result 

if not exist %outputDir%\%inputfile%.apk echo inputDir�²�����%inputfile%.apk ���� 
pause
if not exist %outputDir%\%inputfile%.apk exit



if not exist %outputDir%\�ǵø�TinkerID��result md %outputDir%\�ǵø�TinkerID��result

%outputDir:~0,2%
cd %outputDir%

zipalign -v 4 %outputDir%\%inputfile%.apk %outputDir%\�ǵø�TinkerID��result\%inputfile%_no_sign.apk 

echo ------------------------------------------ 
echo ������Դ����� �����ļ�%inputfile%_no_sign.apk 
echo ------------------------------------------  
pause 

cd %outputDir%
%outputDir:~0,2%

java -jar apksigner.jar sign  --ks key.jks  --ks-key-alias key --ks-pass pass:key12345678  --key-pass pass:key12345678  --out %outputDir%\�ǵø�TinkerID��result\%inputfile%_sign.apk  %outputDir%\�ǵø�TinkerID��result\%inputfile%_no_sign.apk  


echo -----------------------------------
echo ǩ������� �����ļ�%inputfile%_sign.apk
echo -----------------------------------
pause

java -jar CheckAndroidV2Signature.jar  %outputDir%\�ǵø�TinkerID��result\%inputfile%_sign.apk

echo ------------------------------------------------------
echo ���v2ǩ��Ч����� isV2OK: v2ǩ���Ƿ�ɹ� ��ɹ������ 
echo ------------------------------------------------------
pause


Set /p str=�Ƿ�������������Y ��   N ��


If not %str%==Y If not %str%==y exit

:2
java -jar walle-cli-all.jar batch -c   %channel%  %outputDir%\�ǵø�TinkerID��result\%inputfile%_sign.apk   %outputDir%\�ǵø�TinkerID��result\channel�ǵø�TinkerID��result
java -jar walle-cli-all.jar batch -c   %channelupgrade%  %outputDir%\�ǵø�TinkerID��result\%inputfile%_sign.apk   %outputDir%\�ǵø�TinkerID��result\channel�ǵø�TinkerID��result\channelUpgrade

echo -----------------------------------------------
echo ����%channel%���������  
echo �ļ�Ŀ¼channel�ǵø�TinkerID��result
echo -----------
echo ����%channelupgrade%��������� 
echo �ļ�Ŀ¼channel�ǵø�TinkerID��result\channelUpgrade
echo -----------------------------------------------
pause 

start %outputDir%\�ǵø�TinkerID��result
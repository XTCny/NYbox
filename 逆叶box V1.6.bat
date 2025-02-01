@echo off

set version=1.6
title ��Ҷbox V%version% by ��Ҷ

:menu
    cls
    echo ========��Ҷbox V%version%========
    echo 1.��װӦ��
    echo 2.��װmagiskģ��
    echo 3.�߼�����
    echo 4.����
    echo 5.�˳�
    set /p var=���������֣�
    if %var%==1 goto installApk
    if %var%==2 goto installModule
    if %var%==3 goto advanced
    if %var%==4 goto about
    if %var%==5 exit

    :installApk
        cls
        set /p apkpath=������Ӧ��·����
        adb install %apkpath%
        if %errorlevel% equ 0 (
            echo ��ʾsuccess����Ӧ�ð�װ�ɹ�
        ) else (
            echo Ӧ�ð�װʧ�ܣ������룺%errorlevel%
        )
        pause
        goto menu
    :installModule
        cls
        adb push %modulepath% /sdcard/temp_module.zip
        adb shell "echo -e 'chmod 777 /data/adb/magisk/busybox\nDATABIN=\"/data/adb/magisk\"\nBBPATH=\"/data/adb/magisk/busybox\"\nUTIL_FUNCTIONS_SH=\"$DATABIN/util_functions.sh\"\nexport OUTFD=1\nexport ZIPFILE=\"/sdcard/temp_module.zip\"\nexport ASH_STANDALONE=1\n\"$BBPATH\" sh -c \". \\\"$UTIL_FUNCTIONS_SH\\\"; install_module\"' > /sdcard/temp_module_installer.sh"
        adb shell su -c "sh /sdcard/temp_module_installer.sh"
        adb shell rm /sdcard/temp_module.zip
        adb shell rm /sdcard/temp_module_installer.sh
        echo ��װ���
        pause
        goto menu
    :advanced
        cls
        echo ========�߼�����========
        echo 1.�鿴�����豸
        echo 2.�򿪻
        echo 3.�����ļ�
        echo 4.��ȡ�ļ�
        echo 5.�����ֱ���ѡ��ģʽ��
        echo 6.ж��Ӧ��
        echo 7.�޸�dpi
        echo 8.�˳�
        set /p var=���������֣�
        if %var%==1 goto devices
        if %var%==2 goto activity
        if %var%==3 goto push
        if %var%==4 goto pull
        if %var%==5 goto reboot
        if %var%==6 goto uninstall
        if %var%==7 goto dpi
        if %var%==8 goto menu

            :devices
            cls
            adb devices
            pause
            goto advanced
            :activity
                cls
                echo 1.��adb
                echo 2.�Զ���
                echo 3.�˳�
                set /p var=���������֣�
                if %var%==1 goto adb
                if %var%==2 goto customize
                if %var%==3 goto advanced

                :adb
                    cls
                    adb shell am start com.xtc.selftest/com.xtc.selftest.ui.ControllerActivity
                    echo ������ֱ�
                    pause
                    goto advanced

                :customize
                    cls
                    set /p customActivity= �������Զ������ƣ�
                    adb shell am start %customActivity%
                    echo �Ѵ򿪻��%customActivity%
                    pause
                    goto advanced

            :push
                cls
                set /p pushComputerPath=�������ļ��ĵ���·����
                set /p pushWatchPath=�������ļ������ֱ��·����
                adb push %pushComputerPath% %pushWatchPath%
                echo �ļ��ѵ���
                pause
                goto advanced

            :pull
                cls
                set /p pullWatchPath=�������ļ����ֱ�·����
                set /p pullComputerPath=��������ȡ�ļ������Ե�·����
                adb pull %pullWatchPath% %pullComputerPath%
                echo �ļ�����ȡ
                pause
                goto advanced
            
            :reboot
                cls
                echo 1.��ͨ����
                echo 2.������fastbootģʽ
                echo 3.������bootloaderģʽ
                echo 4.������9008ģʽ
                echo 5.�˳�
                set /p var=���������֣�

                if %var%==1(
                    cls
                    adb reboot
                    echo �������
                    pause
                    goto advanced
                )
                if %var%==2(
                    cls
                    adb reboot fastboot
                    echo ������fastbootģʽ���
                    pause
                    goto advanced
                )
                if %var%==3(
                    cls
                    adb reboot bootloader
                    echo ������bootloaderģʽ���
                    pause
                    goto advanced
                )
                if %var%==4(
                    cls
                    adb reboot edl
                    echo ������9008ģʽ���
                    pause
                    goto advanced
                )
            :uninstall
                cls
                set /p packageName=������Ӧ�ð�����
                adb uninstall %packageName%
                echo Ӧ����ж��
                pause
                goto advanced
            :dpi
                cls
                set nowDpi=adb shell wm density
                echo ��ǰdpi��%nowDpi%
                echo 1.�ָ�Ĭ��dpi��
                echo 2.�Զ���dpi��
                set /p var=���������֣�

                if %var%==1(
                    cls
                    adb shell wm density reset
                    echo dpi�ָ����
                    pause
                    goto advanced
                )

                if %var%==2(
                    cls
                    set /p dpi=������dpi��
                    if %dpi%>50 and %dpi%<400(
                        adb shell wm density %dpi%
                        echo dpi�޸����
                        pause
                        goto advanced
                    ) else(
                        echo dpi���ڷ�Χ��
                        pause
                        goto dpi
                    )
                )


        :about
            cls
            echo ��Ҷbox V%version%
            echo ���ߣ���Ҷ
            echo ��������ֹ��ܲο���sky����bat,������Ȩ����ϵɾ����
            echo QQ:3784446092
            echo bilibili:��Ҷ�����ƽ�С���
            pause
            goto menu
        
    
goto menu

    

        

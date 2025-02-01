@echo off

set version=1.6
title 逆叶box V%version% by 逆叶

:menu
    cls
    echo ========逆叶box V%version%========
    echo 1.安装应用
    echo 2.安装magisk模块
    echo 3.高级功能
    echo 4.关于
    echo 5.退出
    set /p var=请输入数字：
    if %var%==1 goto installApk
    if %var%==2 goto installModule
    if %var%==3 goto advanced
    if %var%==4 goto about
    if %var%==5 exit

    :installApk
        cls
        set /p apkpath=请输入应用路径：
        adb install %apkpath%
        if %errorlevel% equ 0 (
            echo 提示success就是应用安装成功
        ) else (
            echo 应用安装失败，错误码：%errorlevel%
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
        echo 安装完成
        pause
        goto menu
    :advanced
        cls
        echo ========高级功能========
        echo 1.查看连接设备
        echo 2.打开活动
        echo 3.导入文件
        echo 4.提取文件
        echo 5.重启手表（可选择模式）
        echo 6.卸载应用
        echo 7.修改dpi
        echo 8.退出
        set /p var=请输入数字：
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
                echo 1.开adb
                echo 2.自定义活动
                echo 3.退出
                set /p var=请输入数字：
                if %var%==1 goto adb
                if %var%==2 goto customize
                if %var%==3 goto advanced

                :adb
                    cls
                    adb shell am start com.xtc.selftest/com.xtc.selftest.ui.ControllerActivity
                    echo 请操作手表
                    pause
                    goto advanced

                :customize
                    cls
                    set /p customActivity= 请输入自定义活动名称：
                    adb shell am start %customActivity%
                    echo 已打开活动：%customActivity%
                    pause
                    goto advanced

            :push
                cls
                set /p pushComputerPath=请输入文件的电脑路径：
                set /p pushWatchPath=请输入文件导入手表的路径：
                adb push %pushComputerPath% %pushWatchPath%
                echo 文件已导入
                pause
                goto advanced

            :pull
                cls
                set /p pullWatchPath=请输入文件的手表路径：
                set /p pullComputerPath=请输入提取文件到电脑的路径：
                adb pull %pullWatchPath% %pullComputerPath%
                echo 文件已提取
                pause
                goto advanced
            
            :reboot
                cls
                echo 1.普通重启
                echo 2.重启到fastboot模式
                echo 3.重启到bootloader模式
                echo 4.重启到9008模式
                echo 5.退出
                set /p var=请输入数字：

                if %var%==1(
                    cls
                    adb reboot
                    echo 重启完成
                    pause
                    goto advanced
                )
                if %var%==2(
                    cls
                    adb reboot fastboot
                    echo 重启到fastboot模式完成
                    pause
                    goto advanced
                )
                if %var%==3(
                    cls
                    adb reboot bootloader
                    echo 重启到bootloader模式完成
                    pause
                    goto advanced
                )
                if %var%==4(
                    cls
                    adb reboot edl
                    echo 重启到9008模式完成
                    pause
                    goto advanced
                )
            :uninstall
                cls
                set /p packageName=请输入应用包名：
                adb uninstall %packageName%
                echo 应用已卸载
                pause
                goto advanced
            :dpi
                cls
                set nowDpi=adb shell wm density
                echo 当前dpi：%nowDpi%
                echo 1.恢复默认dpi：
                echo 2.自定义dpi：
                set /p var=请输入数字：

                if %var%==1(
                    cls
                    adb shell wm density reset
                    echo dpi恢复完成
                    pause
                    goto advanced
                )

                if %var%==2(
                    cls
                    set /p dpi=请输入dpi：
                    if %dpi%>50 and %dpi%<400(
                        adb shell wm density %dpi%
                        echo dpi修改完成
                        pause
                        goto advanced
                    ) else(
                        echo dpi不在范围内
                        pause
                        goto dpi
                    )
                )


        :about
            cls
            echo 逆叶box V%version%
            echo 作者：逆叶
            echo 本软件部分功能参考了sky做的bat,如有侵权请联系删除。
            echo QQ:3784446092
            echo bilibili:逆叶不会破解小天才
            pause
            goto menu
        
    
goto menu

    

        

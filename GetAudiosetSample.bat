::@echo off

set sr=22050
:: ����
set MAXp=30
set max_wav=3

REM ===main

IF {%~1}=={} (
    set "tar=target"
) else (
    set "tar=%~1"
)
echo 6
:: ���x���ꗗ��CSV��ǂ�
cd result
dir ..\%tar%
pause

FOR /F "tokens=1 delims=," %%a IN (..\%tar%\labels.csv) DO ( 

        mkdir %%a
        echo "%%a start"
        FOR /F "tokens=1,2,3" %%x IN (..\%tar%\%%a.csv) DO ( 
            cd %%a
            
            FOR /f "usebackq delims=" %%A IN (`dir^|find /c "wav"`) DO ( 
                
                
            
                if %%A leq %max_wav% ( 
                    
                    start cmd /c ..\..\download_cat.bat %%x %%y %%z
                    call ..\..\wait_loop.bat %MAXp%
                )
            )
            cd ..
            powershell sleep 1
        ) 
        echo "%%a finish"
    )
) 
pause
exit /b

REM ===�֐�



set sr =22050
:: ����
set PARALLEL=10


REM ===main

IF {%~1}=={} (
    set "tar=target"
) else (
    set "tar=%~1"
)
echo 6
:: ���x���ꗗ��CSV��ǂ�
cd result
FOR /F "tokens=1 delims=, " %%a IN (../%tar%/labels.csv) DO (

    mkdir %%a
    echo "%%a start"
    ::���x������
    FOR /F "tokens=1,2,3" %%x IN (../%tar%/%%a.csv) DO (
        cd %%a
        start cmd /c download_cat.bat %%x %%y %%z
        cd ..
        goto :wait_loop
        :end_wait_loop
        
    )
    echo "%%a finish"
)
pause
exit /b

REM ===�֐�
:wait_loop
    
    for /f "usebackq delims=" %%A in (`tasklist^|find /c "cmd"`) do set CMDcount=%%A

    if %CMDcount% leq %PARALLEL% (
        goto :end_wait_loop
    )

    goto :wait_loop
    
exit /B
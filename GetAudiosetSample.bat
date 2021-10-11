

set sr=22050
:: 並列数
set MAXp=30


REM ===main

IF {%~1}=={} (
    set "tar=target"
) else (
    set "tar=%~1"
)
echo 6
:: ラベル一覧のCSVを読む
cd result
dir ..\%tar%
pause
FOR /F "tokens=1 delims=, " %%a IN (..\%tar%\labels.csv) DO (

    mkdir %%a
    echo "%%a start"
    ::ラベル毎に
    FOR /F "tokens=1,2,3" %%x IN (..\%tar%\%%a.csv) DO (
        cd %%a
        start cmd /c download_cat.bat %%x %%y %%z
        cd ..
        call wait_loop.bat %MAXp%
        
    )
    echo "%%a finish"
)
pause
exit /b

REM ===関数

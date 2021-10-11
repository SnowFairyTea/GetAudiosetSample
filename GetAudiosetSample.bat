

set sr=22050
:: •À—ñ”
set MAXp=30


REM ===main

IF {%~1}=={} (
    set "tar=target"
) else (
    set "tar=%~1"
)
echo 6
:: ƒ‰ƒxƒ‹ˆê——‚ÌCSV‚ğ“Ç‚Ş
cd result
dir ..\%tar%

FOR /F "tokens=1 delims=," %%a IN (..\%tar%\labels.csv) DO ( 

    mkdir %%a
    echo "%%a start"
    
    
    FOR /F "tokens=1,2,3" %%x IN (..\%tar%\%%a.csv) DO ( 
        cd %%a
        
        start cmd /c ..\..\download_cat.bat %%x %%y %%z
        call ..\..\wait_loop.bat %MAXp%
        cd ..
        powershell sleep 1
        
    ) 
    echo "%%a finish"
) 
pause
exit /b

REM ===ŠÖ”

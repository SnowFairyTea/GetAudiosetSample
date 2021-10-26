@echo off

set sr=22050
:: •À—ñ”
set MAXp=30
set max_wav=100

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
pause

FOR /F "tokens=1 delims=," %%a IN (..\%tar%\labels.csv) DO ( 

        mkdir %%a
        echo "%%a start"
        FOR /F "tokens=1,2,3" %%x IN (..\%tar%\%%a.csv) DO ( 
            cd %%a
            
            FOR /f "usebackq delims=" %%A IN (`dir^|find /c "wav"`) DO ( 
                set wav_count=%%A 
                ) 
            
            if {%wav_count%} leq {%max_wav%} ( 
                start cmd /c ..\..\download_cat.bat %%x %%y %%z
                call ..\..\wait_loop.bat %MAXp%
            )
            cd ..
            powershell sleep 1
        ) 
        echo "%%a finish"
    )
) 
pause
exit /b

REM ===ŠÖ”

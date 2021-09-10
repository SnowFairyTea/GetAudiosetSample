@echo off

set sr =22050

REM ===main

IF {%~1}=={} (
    set "tar=target"
) else (
    set "tar=%~1"
)
echo 6
:: ƒ‰ƒxƒ‹ˆê——‚ÌCSV‚ğ“Ç‚Ş
cd result
FOR /F "tokens=1 delims=, " %%a IN (../%tar%/labels.csv) DO (

    mkdir %%a
    echo "%%a start"
    ::ƒ‰ƒxƒ‹–ˆ‚É
    FOR /F "tokens=1,2,3" %%x IN (%tar%/%%a.csv) DO (
        cd %%a
        call :download_cat %%x %%y %%z
        cd ..
        echo "sleep 2 second"
        powershell sleep 2

    )
    echo "%%a finish"
)
pause
exit /b

REM ===ŠÖ”
:download_cat

    youtube-dl https://www.youtube.com/watch?v=%1 -x --audio-format wav --id %-x --audio-format wav --id
    ffmpeg -loglevel quiet -i "%1.wav" -ss %2 -to %3 "out_%1.wav"
    move /y "out_%1.wav" "%1.wav"
exit /b

set PARALLEL=10


:b
start cmd /c test_called.bat
goto :aaaa

pause
goto :eof
REM==関数
:aaaa
    
    for /f "usebackq delims=" %%A in (`tasklist^|find /c "cmd"`) do set CMDcount=%%A

    if %CMDcount% leq %PARALLEL% (
        goto :b
    )
    goto :aaaa
    
exit /b
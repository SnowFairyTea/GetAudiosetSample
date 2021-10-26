setlocal
::set PARALLEL=10

for /f "usebackq delims=" %%A in (`dir^|find /c "result"`) do (
    
    if {%%A} gtr {"0"} (
        
        echo 1
        pause
        exit /b
    ) else (
        echo 1
        pause
        exit /b
    )
    pause
)
pause


goto :eof

    
exit /b
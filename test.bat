setlocal
::set PARALLEL=10



for %%i in (1,2,3,4,5) do (
    start cmd /c test_called.bat
    
    call wait_loop.bat 6

    
    pause
)
pause
goto :eof
REM==関数
    
exit /b
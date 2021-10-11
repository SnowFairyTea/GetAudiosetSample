
set MAXp=%1

:wait_loop
    for /f "usebackq delims=" %%A in (`tasklist^|find /c "cmd"`) do ( set CMDcount=%%A)  


    if %CMDcount% leq %MAXp% (

        goto :end_wait_loop
    ) 

    powershell sleep 3
    goto :wait_loop

:end_wait_loop
exit /B
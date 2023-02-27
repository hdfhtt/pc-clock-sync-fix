@echo off
title Synchronizing Clock
goto check_Permissions

:sync_Clock
    echo Syncing clock...
    net stop w32time
    w32tm /unregister
    w32tm /register
    net start w32time
    w32tm /resync

    exit /b

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Administrative permissions confirmed.
	goto sync_Clock
    ) else (
        echo Current permissions inadequate.
        pause
        exit /b
    )

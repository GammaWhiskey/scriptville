@ECHO OFF
SETLOCAL

SET ROBLOX_DIR=%LocalAppData%\Roblox\Versions

IF NOT EXIST "%ROBLOX_DIR%" (
    ECHO Error: Cannot find Roblox directory.
    PAUSE
    GOTO :EOF
)

FOR /f "delims=" %%D IN ('dir "%ROBLOX_DIR%" /a:d /b /o:-d') DO (
    ECHO Searching %%D
    IF EXIST "%ROBLOX_DIR%\%%D\RobloxPlayerBeta.exe" (
        REG ADD "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /V "%ROBLOX_DIR%\%%D\RobloxPlayerBeta.exe" /T REG_SZ /D "~ HIGHDPIAWARE" /F
        IF NOT EXIST "%ROBLOX_DIR%\%%D\ClientSettings" (
            mkdir "%ROBLOX_DIR%\%%D\ClientSettings"
        )

        cd "%ROBLOX_DIR%\%%D\ClientSettings"
        echo {"FFlagClientEnableHiDpi2": false,"FFlagPassDataModelDPIScale": false,"DFFlagDebugOverrideDPIScale": false,"DFFlagDisableDPIScale": false,"DFFlagVariableDPIScale2": false} > ClientAppSettings.json

        echo Done!
        echo With love from SimplestUsername.
        PAUSE
        GOTO :EOF
    )
)

ECHO Error: Cannot find RobloxPlayerBeta.exe.
PAUSE
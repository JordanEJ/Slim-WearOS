@echo off

:menu
cls
set /P "=//////////////////////////////////////////////////////" < NUL & echo/
set /P "=.__ _ _             __    __                 ___  __    " < NUL & echo/
set /P "=/ _\ (_)_ __ ___   / / /\ \ \___  __ _ _ __ /___\/ _\   " < NUL & echo/
set /P "=\ \| | | '_ ` _ \  \ \/  \/ / _ \/ _` | '__//  //\ \    " < NUL & echo/
set /P "=_\ \ | | | | | | |  \  /\  /  __/ (_| | | / \_// _\ \   " < NUL & echo/
set /P "=\__/_|_|_| |_| |_|   \/  \/ \___|\__,_|_| \___/  \__/   " < NUL & echo/
set /P "=//////////////////////////////////// By JordanJ //////" < NUL & echo/
echo:
echo:
echo Main Menu
echo.
echo 1. Connect WearOS Device
echo 2. Enable/Disable Google Fit
echo 3. Enable/Disable Custom Apps
echo 4. Quit
echo.
set /p choice=Enter your choice: 

if %choice%==1 goto connect
if %choice%==2 goto enable_disable_fit
if %choice%==3 goto enable_disable_apps
if %choice%==4 exit
else (
  goto menu

:connect
cls
set /P "=//////////////////////////////////////////////////////" < NUL & echo/
set /P "=.__ _ _             __    __                 ___  __    " < NUL & echo/
set /P "=/ _\ (_)_ __ ___   / / /\ \ \___  __ _ _ __ /___\/ _\   " < NUL & echo/
set /P "=\ \| | | '_ ` _ \  \ \/  \/ / _ \/ _` | '__//  //\ \    " < NUL & echo/
set /P "=_\ \ | | | | | | |  \  /\  /  __/ (_| | | / \_// _\ \   " < NUL & echo/
set /P "=\__/_|_|_| |_| |_|   \/  \/ \___|\__,_|_| \___/  \__/   " < NUL & echo/
set /P "=//////////////////////////////////// By JordanJ //////" < NUL & echo/
echo:
echo:
echo Connect WearOS Device
echo:
echo Make sure:
echo 1. Make sure you WearOS device is connected to the same wifi network.
echo 2. ADB debugging is enabled on your device.
echo 3. You know the IP address of your device.
echo:
set /p ipaddress=Your device's IP address: 
adb connect %ipaddress%
pause
goto menu

:enable_disable_fit
cls
set /P "=//////////////////////////////////////////////////////" < NUL & echo/
set /P "=.__ _ _             __    __                 ___  __    " < NUL & echo/
set /P "=/ _\ (_)_ __ ___   / / /\ \ \___  __ _ _ __ /___\/ _\   " < NUL & echo/
set /P "=\ \| | | '_ ` _ \  \ \/  \/ / _ \/ _` | '__//  //\ \    " < NUL & echo/
set /P "=_\ \ | | | | | | |  \  /\  /  __/ (_| | | / \_// _\ \   " < NUL & echo/
set /P "=\__/_|_|_| |_| |_|   \/  \/ \___|\__,_|_| \___/  \__/   " < NUL & echo/
set /P "=//////////////////////////////////// By JordanJ //////" < NUL & echo/
echo:
echo:
echo Enable/Disable Google Fit 
echo.
echo 1. Disable Google Fit
echo 2. Enable Google Fit
echo 3. Back
echo.
set /p choice=Enter your choice:

if %choice%==1 goto disablefit
if %choice%==2 goto enablefit
if %choice%==3 goto menu
else (
  goto enable_disable_fit

:enable_disable_apps
cls
set /P "=//////////////////////////////////////////////////////" < NUL & echo/
set /P "=.__ _ _             __    __                 ___  __    " < NUL & echo/
set /P "=/ _\ (_)_ __ ___   / / /\ \ \___  __ _ _ __ /___\/ _\   " < NUL & echo/
set /P "=\ \| | | '_ ` _ \  \ \/  \/ / _ \/ _` | '__//  //\ \    " < NUL & echo/
set /P "=_\ \ | | | | | | |  \  /\  /  __/ (_| | | / \_// _\ \   " < NUL & echo/
set /P "=\__/_|_|_| |_| |_|   \/  \/ \___|\__,_|_| \___/  \__/   " < NUL & echo/
set /P "=//////////////////////////////////// By JordanJ //////" < NUL & echo/
echo:
echo:
echo Enable/Disable Custom Apps
echo.
echo 1. List All Apps
echo 2. List Apps Seperatly
echo 3. Change Enable/Disable Preferences
echo 4. Apply Custom Enable/Disable List
echo 5. Back
echo.
set /p choice=Enter your choice:

if %choice%==1 goto listallapps
if %choice%==2 goto listseperatly
if %choice%==3 goto editapps
if %choice%==4 goto apply
if %choice%==5 goto menu

:disablefit
cls
adb shell pm disable-user --user 0 com.google.android.apps.fitness
pause
goto menu

:enablefit
cls
adb shell pm enable --user 0 com.google.android.apps.fitness
pause
goto menu

:listallapps
cls
adb shell pm list packages > apps.txt
setlocal enabledelayedexpansion
set "search=package:"
set "replace="
set "textfile=apps.txt"
set "newfile=applist.txt"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    set "line=!line:%search%=%replace%!"
    echo !line!
))>"%newfile%"
del apps.txt
@echo Apps To Enable:>"Enable.txt"
@echo Apps To Disable>"Disable.txt"
pause
goto menu

:listseperatly
cls
adb shell pm list packages -d > "Packages-List/disabledlist.txt"
adb shell pm list packages -e > "Packages-List/enabledlist.txt"
adb shell pm list packages -s > "Packages-List/systemlist.txt
pause
goto menu

:editapps
cls
echo Two text documents will be automaticly created one after the other. One will be the apps that you want disabled, the other will be the apps you want enabled.
echo:
echo -Each app should be on its own line with no extra characters anywhere.
echo -The package name should be something like ***.******.*****.*** E.g (com.google.android.apps.fitness)
echo -Make sure you save both. (but don't worry about the saved location. It sould already be in the right place)
pause
notepad Disable.txt
notepad Enable.txt
pause
goto menu

:apply
cls
setlocal enabledelayedexpansion
set "prefix=adb shell pm enable --user 0 "
(for /f "delims=" %%a in (Enable.txt) do (
    set "line=%%a"
    echo !prefix!%%a
)) > Enable.txt
setlocal enabledelayedexpansion
set "prefix=adb shell pm disable-user --user 0 "
(for /f "delims=" %%a in (Disable.txt) do (
    set "line=%%a"
    echo !prefix!%%a
)) > Disable.txt

ren "Disable.txt" "Disable.bat"
ren "Disable.txt" "Enable.bat"
start "Disable" "Disable.bat"
start "Enable" "Enable.bat"
pause
goto menu

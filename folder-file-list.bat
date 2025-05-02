@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

REM 🔧 Настройки фильтрации
set "EXCLUDE_PATH_CHARS="       REM Символы, при наличии которых путь файла будет исключён
set "EXCLUDE_NAME_CHARS=__"        REM Символы, при наличии которых имя файла будет исключено

REM 📥 Запрашиваем путь к папке
set /p SOURCE=Вставь путь к папке и нажми Enter:
set "SOURCE=%SOURCE:"=%"

REM 📤 Путь вывода
set "OUTPUT=%USERPROFILE%\Desktop\список_файлов.txt"

REM 🧭 Проверка существования папки
if not exist "%SOURCE%" (
    echo ❌ Путь "%SOURCE%" не существует.
    pause
    exit /b
)

REM 🧽 Удалим старый файл, если он есть
if exist "%OUTPUT%" del "%OUTPUT%"

REM 🚀 PowerShell для сбора всех файлов в список
powershell -NoLogo -NoProfile -Command ^
  "Get-ChildItem -Path '%SOURCE%' -Recurse -File | ForEach-Object { $_.FullName }" > "%TEMP%\__all_files.tmp"

REM 🧹 Фильтруем вручную
(for /f "usebackq delims=" %%F in ("%TEMP%\__all_files.tmp") do (
    set "FULL=%%F"
    set "FNAME=%%~nxF"

    set "SKIP_PATH=0"
    for %%C in (%EXCLUDE_PATH_CHARS%) do (
        echo !FULL! | find "%%C" >nul && set "SKIP_PATH=1"
    )

    set "SKIP_NAME=0"
    for %%C in (%EXCLUDE_NAME_CHARS%) do (
        echo !FNAME! | find "%%C" >nul && set "SKIP_NAME=1"
    )

    if !SKIP_PATH! equ 0 if !SKIP_NAME! equ 0 echo !FULL!
)) > "%OUTPUT%"

del "%TEMP%\__all_files.tmp"

echo ✅ Готово! Отфильтрованный список сохранён:
echo %OUTPUT%
pause

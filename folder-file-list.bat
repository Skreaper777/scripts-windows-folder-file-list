@echo off
chcp 65001 >nul
setlocal

REM ✅ Спрашиваем путь у пользователя
set /p SOURCE=Вставь путь к папке и нажми Enter: 

REM 🧹 Удалим лишние кавычки, если они случайно добавились
set SOURCE=%SOURCE:"=%

REM 📝 Путь для вывода (можно поменять на любой)
set "OUTPUT=%USERPROFILE%\Desktop\список_файлов.txt"

REM 🧭 Проверка пути
if not exist "%SOURCE%" (
    echo ❌ Путь "%SOURCE%" не существует.
    pause
    exit /b
)

REM 🧽 Удалим старый файл, если он есть
if exist "%OUTPUT%" del "%OUTPUT%"

REM ⚙️ Запускаем PowerShell для сбора файлов
powershell -NoLogo -NoProfile -Command ^
  "Get-ChildItem -Path '%SOURCE%' -Recurse -File | ForEach-Object { $_.FullName } | Out-File -FilePath '%OUTPUT%' -Encoding utf8"

echo ✅ Готово! Список сохранён:
echo %OUTPUT%
pause

@echo off
chcp 65001 >nul
setlocal

REM 👉 Укажи путь к нужной папке:
set "SOURCE=c:\Users\stasr\Documents\Obsidian Vault\obsidian-valut\🏷️ Теги\"

REM 👉 Укажи путь, куда сохранить список:
set "OUTPUT=%USERPROFILE%\Desktop\список_файлов.txt"

if not exist "%SOURCE%" (
    echo ❌ Путь "%SOURCE%" не существует.
    pause
    exit /b
)

REM 👉 Получаем только файлы (без папок):
powershell -NoLogo -NoProfile -Command ^
  "Get-ChildItem -Path '%SOURCE%' -Recurse -File | ForEach-Object { $_.FullName } | Out-File -FilePath '%OUTPUT%' -Encoding utf8"

echo ✅ Готово! Только файлы сохранены по пути:
echo %OUTPUT%
pause

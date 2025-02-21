@echo off
where /Q nasm
if errorlevel 1 (
    echo 'nasm' not installed
    pause
    exit /b 1
)
 
where /Q python
if errorlevel 1 (
    echo 'python' not installed
    pause
    exit /b 1
)
 
nasm -f bin snake.asm -o demo\snake.com || (pause && exit /b 1)
python -m http.server -d demo

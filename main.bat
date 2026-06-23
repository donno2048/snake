@echo off
where /Q nasm
if errorlevel 1 (
    echo 'nasm' not installed
    pause
    exit /b 1
)
 
where /Q curl
if errorlevel 1 (
    echo 'curl' not installed
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
curl -O https://v8.js-dos.com/latest/js-dos.js -s --output-dir demo -C -
curl -O https://v8.js-dos.com/latest/emulators/emulators.js -s --output-dir demo -C -
curl -O https://v8.js-dos.com/latest/emulators/wdosbox.wasm -s --output-dir demo -C -
curl -O https://v8.js-dos.com/latest/emulators/wdosbox.js -s --output-dir demo -C -
python -m http.server -d demo

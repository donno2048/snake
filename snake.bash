sudo apt update
sudo apt install dosbox nasm -y
nasm snake.asm -o snake.com -f bin
dosbox -c "mount c ." -c "c:" -c "cls" -c "snake"

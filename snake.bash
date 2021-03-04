sudo apt update
sudo apt install dosbox nasm -y
nasm snake.s -o snake.com -f bin
sudo bash /usr/bin/dosbox -c "mount c ." -c "c:" -c "snake"

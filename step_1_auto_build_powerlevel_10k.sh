#echo "Please enter your sudo password:"
sudo_pwd=1130
wget -O MesloLGS_NF.zip https://github.com/jet-c-21/MyFonts/releases/download/1.0.0/MesloLGS_NF.zip
unzip -q MesloLGS_NF.zip
rm -rf MesloLGS_NF.zip
echo "$sudo_pwd" | sudo -S mv MesloLGS_NF /usr/share/fonts/truetype/
echo "$sudo_pwd" | sudo -S fc-cache -f -v
clear
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
echo "prepare to use zsh"
zsh
echo "start using zsh"


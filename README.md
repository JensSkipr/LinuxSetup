# Ubuntu Setup
Setup Ubuntu for working at Skipr

## 1. Setup Ubuntu
Once Ubuntu is installed, run following commands
```bash
# Upgrade system
sudo apt update
sudo apt -y dist-upgrade

# Install additional software
sudo snap install gitkraken postman
sudo snap install --classic slack
sudo snap install --classic go
sudo snap install --classic code # VS Code
sudo snap install --edge odrive # OpenDrive: Google Drive client
sudo apt -y install git gnome-tweak-tool vim htop

# Install protobuf
sudo snap install --classic protobuf
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/protoc-gen-micro/v2
go get github.com/vektra/mockery/.../

# Workaround to fix ./generate_protos.sh
mkdir ~/go/src
echo -e "\nexport GOPATH=~/go" >> ~/.bashrc

# Install KeepassXC
# https://keepassxc.org/download/#linux
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc

# Setup webcam settings at login
echo -e "\nv4l2-ctl -d 0 -c brightness=50,backlight_compensation=1" >> ~/.profile
```

1. Add following startup applications in Tweak Tool: KeepassXC, OpenDrive
2. Replace VS Code settings with
```json
{
    "workbench.startupEditor": "newUntitledFile",
    "go.toolsGopath": "~/go",
    "git.confirmSync": false,
    "git.autofetch": true
}
```

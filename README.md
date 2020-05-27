# Ubuntu Setup
Setup Ubuntu for working at Skipr

## 1. Setup Ubuntu
Once Ubuntu is installed, run following commands
```bash
# Upgrade system
sudo apt update
sudo apt -y dist-upgrade

# Install additional software
sudo apt -y install git gnome-tweak-tool vim htop
sudo snap install postman
sudo snap install --classic slack
sudo snap install --classic code # VS Code
sudo snap install --edge odrive # OpenDrive: Google Drive client

# Install Go
sudo apt -y install golang

# Install protobuf
sudo snap install --classic protobuf
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/protoc-gen-micro/v2
go get github.com/vektra/mockery/.../

# Workaround to fix ./generate_protos.sh
mkdir -p ~/go/src

# Set Go env variables
tee -a ~/.bashrc <<EOF

# Skipr
export PATH=$PATH:~/go/bin
export GOPATH=~/go
export GO111MODULE=on
EOF

# Install KeepassXC
# https://keepassxc.org/download/#linux
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc

# Setup webcam settings at login
echo -e "\nv4l2-ctl -d 0 -c brightness=50,backlight_compensation=1" >> ~/.profile
```

1. Add following startup applications in Tweak Tool: KeepassXC, OpenDrive, Slack
2. Replace VS Code settings with
```json
{
    "workbench.startupEditor": "newUntitledFile",
    "go.toolsGopath": "~/go",
    "git.confirmSync": false,
    "git.autofetch": true
}
```

3. Replace VS Code keyboard bindings with
```json
[
    {
        // Set CapsLock to backspace (Colemak fix)
        "key": "capslock",
        "command": "deleteLeft",
        "when": "editorTextFocus && !editorReadonly"
    }
]
```

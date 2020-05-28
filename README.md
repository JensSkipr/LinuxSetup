# Ubuntu Setup
Setup Ubuntu for working at Skipr

## 1. Setup Ubuntu
Once Ubuntu is installed, run following commands
```bash
# Upgrade system
sudo apt update
sudo apt -y dist-upgrade

# Install additional software
sudo apt -y install git gnome-tweak-tool vim htop alacarte
sudo snap install postman
sudo snap install --classic slack
sudo snap install --classic code # VS Code
sudo snap install --edge odrive # OpenDrive: Google Drive client

# Set Go env variables
tee -a ~/.bashrc <<EOF

# Skipr
export PATH=$PATH:~/go/bin
export GOPATH=~/go
export GO111MODULE=on
EOF

# Install docker
# See https://docs.docker.com/engine/install/ubuntu/

# Add users to Docker group
sudo adduser skipr docker
sudo adduser ...   docker

# Install Docker Compose
# See https://docs.docker.com/compose/install/

# ==============
# Restart system
# ==============

# Install Go
sudo apt -y install golang

# Install protobuf
sudo snap install --classic protobuf
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/protoc-gen-micro/v2
go get github.com/vektra/mockery/.../

# Workaround to fix ./generate_protos.sh
mkdir -p ~/go/src

# Install KeepassXC
# https://keepassxc.org/download/#linux
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc

# Install Yarn
# See https://classic.yarnpkg.com/en/docs/install/#debian-stable

# Install Ungit
sudo yarn global add ungit

# Create application icon for Ungit
#   Category: Programming
#   Name: Ungit background
#   Command: ungit --no-launchBrowser

# Setup webcam settings at login
echo -e "\nv4l2-ctl -d 0 -c brightness=50,backlight_compensation=1" >> ~/.profile
```

## 2. Finish setup
### 2.1 Startup applications
Add following startup applications in Tweak Tool
- KeepassXC
- OpenDrive
- Slack
- Ungit background

### 2.2 VS Code
Replace settings with
```js
{
    "workbench.startupEditor": "newUntitledFile",
    "go.toolsGopath": "~/go",
    "git.confirmSync": false,
    "git.autofetch": true
}
```

Replace keyboard bindings with
```js
[
    {
        // Set CapsLock to backspace (Colemak fix)
        "key": "capslock",
        "command": "deleteLeft",
        "when": "editorTextFocus && !editorReadonly"
    }
]
```

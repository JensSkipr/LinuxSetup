# Ubuntu Setup
Setup Ubuntu for working at Skipr

## 1. Setup Ubuntu
Once Ubuntu is installed, run following commands
```bash
# Upgrade system
sudo apt update
sudo apt -y dist-upgrade

# Workaround for wifi bug
echo "options iwlwifi bt_coex_active=N swcrypto=1 11n_disable=1" | sudo tee /etc/modprobe.d/x-fix-iwlwifi.conf

# Install additional software
sudo apt -y install git gnome-tweak-tool vim htop alacarte
sudo snap install postman
sudo snap install robo3t-snap
sudo snap install --classic slack
sudo snap install --classic code # VS Code

# Install Keybase
# See https://keybase.io/docs/the_app/install_linux
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase

# Install Go
# Based on https://golang.org/doc/install
# Copy link to wanted go1.Y.Z.linux-amd64.tar.gz from https://golang.org/dl/
GO_URL="https://golang.org/dl/go1.15.7.linux-amd64.tar.gz"
wget ${GO_URL}
sudo tar -C /usr/local -xzf go1.*.tar.gz
echo 'export PATH="${PATH}:/usr/local/go/bin"' | sudo tee /etc/profile.d/add_go_to_path.sh
source /etc/profile.d/add_go_to_path.sh

# Set Go env variables
tee -a ~/.bashrc <<EOF

# Skipr
export PATH=\$PATH:~/go/bin
export GOPATH=~/go
export GO111MODULE=on
EOF

# Install protobuf
sudo snap install --classic protobuf
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/protoc-gen-micro/v2
go get github.com/vektra/mockery/.../

# Workaround to fix ./generate_protos.sh
mkdir -p ~/go/src

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

# Install KeepassXC
# https://keepassxc.org/download/#linux
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc

# Install Yarn
# See https://classic.yarnpkg.com/en/docs/install/#debian-stable

# Install Ungit
sudo yarn global add ungit

# Create application icon for Ungit and add as startup application
sudo tee /usr/share/applications/ungit.desktop <<EOF
[Desktop Entry]
Name=Ungit background
Exec=ungit --no-launchBrowser
Comment=
Terminal=false
Icon=gnome-panel-launcher
Type=Application
EOF

# Setup webcam settings at login
echo -e "\nv4l2-ctl -d 0 -c focus_auto=0,power_line_frequency=1" >> ~/.profile
```

## 2. Finish setup
### 2.1 Startup applications
Add following startup applications in Tweak Tool
- KeepassXC
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

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
sudo apt -y install \
chromium-browser \
curl \
flameshot
git \
gnome-tweak-tool \
htop \
libpq-dev \
paprefs \
pavucontrol \
python3-dev \
v4l-utils \
vim

# Install VS Code
# See https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions

# Install Slack
# See https://slack.com/intl/en-be/downloads/linux

# Install Postman
# See https://learning.postman.com/docs/getting-started/installation-and-updates/#installing-postman-on-linux
wget "https://dl.pstmn.io/download/latest/linux64" -O postman.tar.gz
sudo tar -C /opt -xf postman.tar.gz
tee ~/.local/share/applications/Postman.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF

# Install Mongo Compass
# See https://docs.mongodb.com/compass/master/install
wget https://downloads.mongodb.com/compass/mongodb-compass_1.25.0_amd64.deb
sudo dpkg -i mongodb-compass_*_amd64.deb

# Install Keybase
# See https://keybase.io/docs/the_app/install_linux
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase

# Install Go
# Based on https://golang.org/doc/install
# Copy link to wanted go1.Y.Z.linux-amd64.tar.gz from https://golang.org/dl/
GO_URL="https://golang.org/dl/go1.15.8.linux-amd64.tar.gz"
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
sudo apt install protobuf-compiler
go get github.com/golang/protobuf/protoc-gen-go@v1.4.3
go get github.com/asim/go-micro/cmd/protoc-gen-micro/v3
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

# Setup directories
# See https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#mapped-files-and-directories
mkdir -p ~/.config/pgadmin
sudo chown -R 5050:5050 ~/.config/pgadmin

# Install helper scripts and configs
chmod 755 *.sh
sudo ln -fs $(pwd)/clip_uuid.sh /usr/local/bin/clip_uuid
sudo ln -fs $(pwd)/go_cover.sh /usr/local/bin/go_cover
sudo ln -fs $(pwd)/go_test_all.sh /usr/local/bin/go_test_all
sudo ln -fs $(pwd)/go_tidy_all.sh /usr/local/bin/go_tidy_all
sudo ln -fs $(pwd)/kube_connect.sh /usr/local/bin/kube_connect
ln -fs $(pwd)/docker-compose.yml ~/docker-compose.yml

# Install Firefox configs
# 1. Go to url "about:config"
# 2. Search and enable "toolkit.legacyUserProfileCustomizations.stylesheets"
# 3. Go to url "about:support"
# 4. Click "Open Directory" next to "Profile Directory"
# 5. Update below variable
FF_PROFILE_DIR="/home/skipr/.mozilla/firefox/ec3sg7nh.default-release"
ln -fs $(pwd)/firefox/chrome "${FF_PROFILE_DIR}/chrome"

# Install KeepassXC
# https://keepassxc.org/download/#linux
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc

# Install Node
# See https://github.com/nodesource/distributions/blob/master/README.md#debinstall
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Ungit
sudo npm install -g ungit

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
tee -a ~/.profile <<EOF

v4l2-ctl -d 0 -c focus_auto=0,power_line_frequency=1
v4l2-ctl -d 0 -c focus_absolute=0
v4l2-ctl -d 0 -c brightness=185
EOF
```

## 2. Finish setup

### 2.1 Startup applications

Add following startup applications in Tweak Tool

- KeepassXC
- Slack
- Ungit background

### 2.2 VS Code

```bash
ln -fs "$(pwd)/vscode/settings.jsonc" ~/.config/Code/User/settings.json
ln -fs "$(pwd)/vscode/keybindings.jsonc" ~/.config/Code/User/keybindings.json
mkdir -p ~/.config/Code/User/snippets
ln -fs "$(pwd)/vscode/snippets/go.jsonc" ~/.config/Code/User/snippets/go.json
```

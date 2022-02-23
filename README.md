# Ubuntu Setup

Setup Ubuntu for working at Skipr.
This guide assumes you have an existing system with Full Disk Encryption. You can easily enable this during install or see https://github.com/jenswbe/hercules for an example of a custom setup.

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
git \
gnome-tweak-tool \
htop \
libpq-dev \
paprefs \
pavucontrol \
python3-dev \
v4l-utils \
vim \
apt-transport-https

# Install Anti-virus and anti-malware
# See https://packages.cisofy.com/community/#debian-ubuntu
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 013baa07180c50a7101097ef9de922f1c2fde6c4
echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
sudo apt update
sudo apt install clamtk-gnome chkrootkit lynis

# Useful commands to resolve Lynis suggestions
# Purge all deleted packages. See https://askubuntu.com/a/687304
dpkg --get-selections | awk '$2 == "deinstall" {print $1}' | xargs sudo apt-get purge --dry-run

# Install VS Code
# See https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions

# Install Slack
# See https://slack.com/intl/en-be/downloads/linux

# Install Postman
# See https://learning.postman.com/docs/getting-started/installation-and-updates/#installing-postman-on-linux
wget "https://dl.pstmn.io/download/latest/linux64" -O postman.tar.gz
sudo tar -C /opt -xf postman.tar.gz
rm postman.tar.gz
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

# Install Flameshot
# Could be installed using apt, but this is likely an old version
# See https://github.com/flameshot-org/flameshot/releases

# Install CPU Power Manager for Gnome Shell
# See https://github.com/deinstapel/cpupower
sudo add-apt-repository ppa:fin1ger/cpupower
sudo apt-get update
sudo apt-get install gnome-shell-extension-cpupower
# Logout - Login (Required!!!)
gnome-extensions enable cpupower@mko-sl.de

# Install Mongo Compass
# See https://docs.mongodb.com/compass/master/install
wget https://downloads.mongodb.com/compass/mongodb-compass_1.26.1_amd64.deb -O mongodb-compass.deb
sudo dpkg -i mongodb-compass.deb
sudo apt install -f
rm mongodb-compass.deb

# Install Keybase
# See https://keybase.io/docs/the_app/install_linux
wget https://prerelease.keybase.io/keybase_amd64.deb -O keybase.deb
sudo dpkg -i keybase.deb
sudo apt install -f
rm keybase.deb
run_keybase

# Install Google Cloud SDK
# See https://cloud.google.com/sdk/docs/install#deb
sudo apt-get install google-cloud-sdk kubectl
gcloud init

# Enable kubectl auto-complete
# See https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/#enable-kubectl-autocompletion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl

# Install Go
# Based on https://golang.org/doc/install
# Copy link to wanted go1.Y.Z.linux-amd64.tar.gz from https://golang.org/dl/
GO_URL="https://golang.org/dl/go1.16.7.linux-amd64.tar.gz"
wget ${GO_URL} -O go.tar.gz
sudo tar -C /usr/local -xzf go.tar.gz
echo 'export PATH="${PATH}:/usr/local/go/bin"' | sudo tee /etc/profile.d/add_go_to_path.sh
source /etc/profile.d/add_go_to_path.sh
rm go.tar.gz

# Set Go env variables
tee -a ~/.bashrc <<EOF

# Skipr
export PATH=\$PATH:~/go/bin
export GOPATH=~/go
export GO111MODULE=on
EOF

# Install protobuf
sudo apt -y install protobuf-compiler
# See README of https://github.com/skiprco/booking-api (go install ...)

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

# Install Docker Compose file
ln -fs $(pwd)/docker-compose.yml ~/docker-compose.yml

# Install Firefox configs
# 1. Go to url "about:config"
# 2. Search and enable "toolkit.legacyUserProfileCustomizations.stylesheets"
# 3. Go to url "about:support"
# 4. Click "Open Directory" next to "Profile Directory"
# 5. Update below variable
FF_PROFILE_DIR="/home/skipr/.mozilla/firefox/n79tm659.default-release"
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

Extensions

```
ext install 42crunch.vscode-openapi
ext install bierner.markdown-mermaid
ext install eamodio.gitlens
ext install esbenp.prettier-vscode
ext install golang.go
ext install jebbs.plantuml
ext install petli-full.jq-vscode
ext install zoellner.openapi-preview
ext install zxh404.vscode-proto3
```

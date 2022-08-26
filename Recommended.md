# Recommended setup

Follow setup is highly recommended, but not strictly required.
Feel free to swap out recommended software with another alternative.

## Software

- Docker: https://docs.docker.com/engine/install/ubuntu/
- Docker Compose: https://docs.docker.com/compose/install/compose-plugin/#install-using-the-repository
- gcloud CLI and `kubectl`: https://cloud.google.com/sdk/docs/install#deb (install `google-cloud-cli-gke-gcloud-auth-plugin`, not `google-cloud-sdk-*`)
- Keybase: https://keybase.io/docs/the_app/install_linux
- Lynis (System hardening): https://packages.cisofy.com/community/#debian-ubuntu
- Mongo Compass (Official GUI for MongoDB): https://docs.mongodb.com/compass/master/install
- Postman: https://learning.postman.com/docs/getting-started/installation-and-updates/#installing-postman-on-linux
- ProtoBuf Compiler: See https://github.com/skiprco/booking-api/#install-protobuf-compiler
- Slack: https://slack.com/intl/en-be/downloads/linux
- Skipr Tools: https://github.com/skiprco/tools
- VS Code (IDE): https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions

## Setup

Follow code is not a script! Please run the commands manually.

### Generic

```bash
# Enable kubectl auto-complete
# See https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/#enable-kubectl-autocompletion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl

# Install Go
# Below instructions assume you already installed Go using your package manager:
#   - Ubuntu: sudo apt install -y golang
#   - Fedora: sudo dnf install -y golang
# Based on https://go.dev/doc/manage-install
echo 'export PATH="${PATH}:/usr/local/go/bin:${HOME}/go/bin"' | sudo tee /etc/profile.d/add_go_to_path.sh
source /etc/profile.d/add_go_to_path.sh

GO_VERSION=1.16.7
go install golang.org/dl/go${GO_VERSION:?}@latest
go${GO_VERSION:?} download

tee -a ~/.bashrc <<EOF

# Skipr
export GOPATH=~/go
export GO111MODULE=on
EOF

# Setup directories for pgAdmin
# See https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#mapped-files-and-directories
mkdir -p ~/.config/pgadmin ~/Documents/pgAdmin
sudo chown -R 5050:5050 ~/.config/pgadmin ~/Documents/pgAdmin

# Install Docker Compose file
ln -fs $(pwd)/docker-compose.yml ~/docker-compose.yml
```

### Ubuntu

```bash
# Install L2TP support
# Required to connect to office VPN
sudo apt -y install network-manager-l2tp-gnome

# Useful commands to resolve Lynis suggestions
# Purge all deleted packages. See https://askubuntu.com/a/687304
dpkg --get-selections | awk '$2 == "deinstall" {print $1}' | xargs sudo apt-get purge --dry-run
```

### Fedora

```bash
# Install L2TP support
# Required to connect to office VPN
sudo dnf install -y NetworkManager-l2tp-gnome
```

### VS Code extensions

```
ext install 42crunch.vscode-openapi
ext install bierner.markdown-mermaid
ext install eamodio.gitlens
ext install esbenp.prettier-vscode
ext install golang.go
ext install zoellner.openapi-preview
ext install zxh404.vscode-proto3
```

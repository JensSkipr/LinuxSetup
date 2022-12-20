# End-of-Year VM

Ensure `visudo` group `%sudo` ends with `NOPASSWD:ALL`

Only required for initial setup:

```bash
# Setup SSH
sudo apt update
sudo apt install -y git openssh-server

# Update to latest software
sudo apt dist-upgrade -y
sudo reboot

# Generate SSH keypair => Set as readonly deployment keys on GitHub
ssh-keygen -N '' -f /home/skipr/.ssh/booking-api
cat /home/skipr/.ssh/booking-api.pub
ssh-keygen -N '' -f /home/skipr/.ssh/booking-api-doc
cat /home/skipr/.ssh/booking-api-doc.pub
ssh-keygen -N '' -f /home/skipr/.ssh/web-mobility
cat /home/skipr/.ssh/web-mobility.pub

# Checkout repo's
# Based on https://superuser.com/a/912281
mkdir ~/Dev
cd ~/Dev
git clone -c "core.sshCommand=ssh -i ~/.ssh/booking-api -F /dev/null" git@github.com:skiprco/booking-api.git
cd booking-api
git config core.sshCommand "ssh -i ~/.ssh/booking-api -F /dev/null"
cd -
git clone -c "core.sshCommand=ssh -i ~/.ssh/booking-api-doc -F /dev/null" git@github.com:skiprco/booking-api-doc.git
cd booking-api-doc
git config core.sshCommand "ssh -i ~/.ssh/booking-api-doc -F /dev/null"
cd -
git clone -c "core.sshCommand=ssh -i ~/.ssh/web-mobility -F /dev/null" git@github.com:skiprco/web-mobility.git
cd web-mobility
git config core.sshCommand "ssh -i ~/.ssh/web-mobility -F /dev/null"
cd -

# Install Docker
# Based on https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -a -G docker skipr # Add skipr to docker group (for use of docker command without sudo)

# Install Golang
GOLANG_URL="https://go.dev/dl/go1.18.9.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
wget -O ~/Downloads/golang.tar.gz ${GOLANG_URL:?}
sudo tar -C /usr/local -xzf ~/Downloads/golang.tar.gz
rm ~/Downloads/golang.tar.gz
sudo tee /etc/profile.d/set-golang-path.sh <<< 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin'
source /etc/profile.d/set-golang-path.sh

# Install NodeJS
cd
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install -y nodejs

# Install VS Code => Install Go extension with all analysis tools
sudo apt install -y software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install -y code

# Install protobuf compiler (protoc)
PROTOC_VERSION=3.20.1
PROTOC_URL=https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION:?}/protoc-${PROTOC_VERSION:?}-linux-x86_64.zip
sudo echo # Allow usage of sudo later in the commands
mkdir protoc
cd protoc
curl -o protoc.zip -L ${PROTOC_URL:?}
unzip protoc.zip
rm -rf ~/.protobuf-skipr
mv ./include ~/.protobuf-skipr
sudo mv bin/protoc /usr/local/bin/
cd ..
rm -rf protoc
go install go-micro.dev/v4/cmd/protoc-gen-micro@v4.7.0
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.0

# Install mockery
curl -o mockery.tar.gz -L https://github.com/vektra/mockery/releases/download/v2.14.0/mockery_2.14.0_Linux_x86_64.tar.gz
sudo tar -C /usr/local/bin -xvf mockery.tar.gz mockery # Only extract executable
rm mockery.tar.gz

# Ensure proto's are generated
cd ~/Dev/booking-api
go run ./tools/ms_dependency/

# Install Yarn
sudo npm install --global yarn
cd ~/Dev/web-mobility
yarn # Installs dependencies
```

On HOST:

```bash
VBoxManage list vms
VM_NAME=""
VBoxManage setextradata "${VM_NAME}" "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled" "1"
```

On Ubuntu GUEST:
Settings => Date & Time => Disable "Automatic Date & Time"

Required for each run:

```bash
# Start dependencies
cd ~/Dev/booking-api/deployment/local/
sudo docker compose up -d

# Start Booking API

# Start WebMobility

```

eoy-test-fm@skipr.co

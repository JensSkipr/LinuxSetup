# Optional setup

This pages mainly contains personal recommendations and fixes for issues I hit.
So, please only follow the instructions which seem usefull.

## Software

- Flameshot (screenshot tool): https://github.com/flameshot-org/flameshot/releases
- Nativefier (Create Electron/SSB app for website): https://github.com/nativefier/nativefier
- Terraform: https://www.terraform.io/downloads (Run `terraform -install-autocomplete` afterwards)

## Setup

Follow code is not a script! Please run the commands manually.

### Generic

```bash
# Use proposed VS Code settings
ln -fs "$(pwd)/vscode/settings.jsonc" ~/.config/Code/User/settings.json
mkdir -p ~/.config/Code/User/snippets
ln -fs "$(pwd)/vscode/snippets/go.jsonc" ~/.config/Code/User/snippets/go.json

# Setup Nativefier env
mkdir -p ~/.local/nativefier
nativefier https://app.slack.com/client/T6Y6W6JRY ~/.local/nativefier/ # Creates an app
nativefier --upgrade ~/.local/nativefier/Slack-linux-x64/ # Upgrades existing app
tee "${HOME:?}/.local/share/applications/slack.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=${HOME:?}/.local/nativefier/Slack-linux-x64/Slack
Name=Slack
Icon=${HOME:?}/.local/nativefier/Slack-linux-x64/resources/app/icon.png
EOF

# Install Firefox configs
# 1. Go to url "about:config"
# 2. Search and enable "toolkit.legacyUserProfileCustomizations.stylesheets"
# 3. Go to url "about:support"
# 4. Click "Open Directory" next to "Profile Directory"
# 5. Update below variable
FF_PROFILE_DIR="/home/skipr/.mozilla/firefox/n79tm659.default-release"
ln -fs $(pwd)/firefox/chrome "${FF_PROFILE_DIR}/chrome"
```

### Ubuntu

```bash
# Install Node
# See https://github.com/nodesource/distributions/blob/master/README.md#debinstall
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Ungit
sudo npm install -g ungit
sudo cp ungit.desktop /usr/share/applications/ungit.desktop

# Install CPU Power Manager for GNOME Shell
# See https://github.com/deinstapel/cpupower
sudo add-apt-repository ppa:fin1ger/cpupower
sudo apt-get update
sudo apt-get install gnome-shell-extension-cpupower
# Logout - Login (Required!!!)
gnome-extensions enable cpupower@mko-sl.de
```

### Fedora

```bash
# Install Node
# See https://github.com/nodesource/distributions/blob/master/README.md#enterprise-linux-based-distributions
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
sudo dnf install -y nodejs

# Install Ungit
sudo npm install --location=global ungit
sudo cp ungit.desktop /usr/share/applications/ungit.desktop
```

#!/bin/bash
#
# Launch without `sudo`: `bash ./post-install-pop24.sh`.

ROS_DISTRO=jazzy
ROS_WORKSPACE=$HOME/robocon_jazzy_ws
SOURCES=$HOME/04-sources  # Place for software built from source.

if [ $USER = root ]; then
  while true; do
    echo "Do not run as root"
    sleep 1
    # Cannot use `return 1`
  done
fi

# Extra software.

sudo apt update && sudo apt upgrade --yes

## Extra generic software
sudo apt install \
  7zip \
  7zip-rar \
  apt-file \
  atool \
  atril \
  audacity \
  autofs \
  bat \
  beep \
  blender \
  brightnessctl \
  calibre \
  cheese \
  curl \
  cutecom \
  digikam \
  dunst \
  fd-find \
  ffmpegthumbnailer \
  fzf \
  gimp \
  grimshot \
  gsimplecal \
  gucharmap \
  htop \
  hunspell-cs \
  hunspell-de-de \
  hunspell-es \
  hunspell-fr \
  i3blocks \
  imagemagick \
  iw \
  jabref \
  jq \
  kdeconnect \
  kdenlive \
  keepassxc \
  kitty \
  libimage-exiftool-perl \
  librecad \
  libreoffice \
  librsvg2-bin \
  lua5.4 \
  mako-notifier \
  mate-calc \
  meshlab \
  mpv \
  musescore3 \
  nodejs \
  npm \
  obs-studio \
  openscad \
  openssh-server \
  pavucontrol \
  pdfgrep \
  pipx \
  playerctl \
  plocate \
  poppler-utils \
  pulseaudio-utils \
  python3-argcomplete \
  python3-convertdate \
  python3-i3ipc \
  python3-lunardate \
  python3-pip \
  python3-pyluach  \
  python3-pymeeus \
  qalc \
  retext \
  ripgrep \
  rofi \
  sd \
  snapd \
  sway \
  texlive-extra-utils \
  texlive-xetex \
  timg \
  trash-cli \
  tree \
  tree-sitter-cli \
  udiskie \
  ueberzug \
  viking \
  vlc \
  waybar \
  wdisplays \
  wev \
  wget \
  wl-clipboard \
  wofi \
  xclip \
  xdg-desktop-portal-wlr \
  xinput \
  xournalpp \
  zathura \
  zenity \
  zoxide \
  zsh

sudo snap install \
  ascii-draw \
  freetube \
  slack \
  telegram-desktop

pip install --break-system-packages \
  calendra \
  ranger-fm

## Development software.
sudo apt install \
  ccache \
  clangd \
  cmake-curses-gui \
  colorized-logs \
  exuberant-ctags \
  gdb \
  git \
  git-delta \
  git-lfs \
  gitk \
  golang-go \
  grc \
  heaptrack-gui \
  ipython3 \
  jupyter-console \
  jupyter-core \
  jupyter-notebook \
  luarocks \
  liblua5.4-dev \
  libpython3.12-dev \
  lld \
  mold \
  python3-numpy \
  python3-opengl \
  python3-pandas \
  python3-pickleshare \
  python3-rocker \
  python3-wxgtk4.0 \
  tig \
  vcstool \
  wireshark
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*') \
  && mkdir --parents /tmp/lazygit \
  && pushd /tmp/lazygit >/dev/null \
  && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
  && tar xf lazygit.tar.gz lazygit \
  && install lazygit -D -t $HOME/.local/bin/ \
  && rm -f /tmp/lazygit/lazygit.tar.gz /tmp/lazygit/lazygit \
  && popd >/dev/null \
  && rmdir /tmp/lazygit
pip install --break-system-packages jupytext

## Docker and plugins. Plus nvidia-container-toolkit.
sudo curl -fsSL 'https://download.docker.com/linux/ubuntu/gpg' -o /etc/apt/keyrings/docker.asc \
  && sudo chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null \
  && sudo apt-get update \
  && sudo apt install \
    docker-buildx \
    docker-compose-plugin \
    docker.io \
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list >/dev/null \
  && sudo apt-get update \
  && sudo apt install nvidia-container-toolkit \
  && sudo nvidia-ctk runtime configure --runtime=docker
mkdir --parents $HOME/.local/share/git-credential-forwarder \
  && mkdir --parents /tmp/git-credential-forwarder \
  && pushd /tmp/git-credential-forwarder >/dev/null \
  && curl -LO https://github.com/sam-mfb/git-credential-forwarder/releases/download/v1.1.1/git-credential-forwarder.zip \
  && unzip git-credential-forwarder.zip \
  && install -Dm664 /tmp/git-credential-forwarder/gcf-client.js $HOME/.local/share/git-credential-forwarder/ \
  && install -Dm664 /tmp/git-credential-forwarder/gcf-server.js $HOME/.local/share/git-credential-forwarder/ \
  && popd >/dev/null \
  && rm -f /tmp/git-credential-forwarder/

## Rust and rust-written software
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer
cargo install cargo-quickinstall
cargo quickinstall \
  allmytoes \
  bkt \
  cargo-generate \
  code-minimap \
  difftastic \
  rew \
  starship \
  sway-scratchpad \
  television \
  yazi-cli \
  yazi-fm \
  ytop

## Modular, Mojo, Max
curl -ssL https://magic.modular.com/323df2a4-4427-473a-a54a-088efcd6205c | bash

## Neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim python3-neovim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 10

## Visual Studio Code.
curl -Lo /tmp/code.deb 'https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/code_1.95.3-1731513102_amd64.deb' \
  && sudo apt install /tmp/code.deb \
  && sudo apt update \
  && sudo apt install code \
  && rm -f /tmp/code.deb

## Git Credential Manager.
#https://github.com/git-ecosystem/git-credential-manager.
mkdir /tmp/gcm \
  && pushd /tmp/gcm >/dev/null \
  && curl -Lo /tmp/gcm/gcm.deb 'https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.6.0/gcm-linux_amd64.2.6.0.deb' \
  && sudo apt install /tmp/gcm/gcm.deb \
  && popd >/dev/null \
  && rm -rf /tmp/gcm \
  && git-credential-manager configure

## ROS.
sudo apt update \
  && sudo apt install curl -y \
  && sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
  && sudo apt update \
  && sudo apt install \
    'python3-colcon*' \
    python3-colcon-cd \
    python3-rosdep \
    python3-streamz \
    python3-watchdog \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-desktop \
    ros-${ROS_DISTRO}-rmf-utils \
    ros-${ROS_DISTRO}-topic-tools \
    ros-${ROS_DISTRO}-warehouse-ros-sqlite \
  && pip install --break-system-packages rotop \
  && pip install --break-system-packages 'python-json-logger@https://github.com/nhairs/python-json-logger/releases/download/v3.1.0/python_json_logger-3.1.0-py3-none-any.whl' \
  && colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml \
  && colcon mixin show \
  && colcon mixin update default \
  && sudo rosdep init \
  && rosdep update
mkdir --parents $HOME/04-sources/ros \
  && git clone --recursive https://github.com/Martin-Oehler/ros2cd.git $HOME/04-sources/ros/ros2cd

## Mounch (https://github.com/chmouel/mounch).
mkdir --parents $SOURCES \
  && git clone --recursive https://github.com/chmouel/mounch $SOURCES/mounch-rofi_replacement \
  && ln -s $SOURCES/mounch-rofi_replacement/mounch.py $HOME/.local/bin/mounch

## Webots 2023a.
mkdir /tmp/webots \
  && pushd /tmp/webots >/dev/null \
  && curl -Lo /tmp/webots/webots.deb 'https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb' \
  && sudo apt install /tmp/webots/webots.deb \
  && popd >/dev/null \
  && rm -rf /tmp/webots

## FreeCAD.
sudo apt install python3-git
sudo add-apt-repository ppa:freecad-maintainers/freecad-daily \
  && sudo apt-get install freecad-daily

## i3blocks-pomodoro.
mkdir --parents $HOME/04-sources/i3 \
  && git clone https://github.com/rkashapov/i3blocks-pomodoro.git $HOME/04-sources/i3/i3blocks-pomodoro \
  && ln -s $HOME/04-sources/i3/i3blocks-pomodoro/pomodoro $HOME/.local/bin

## bato, battery-state notifier (https://github.com/doums/bato).
curl -Lo $HOME/.local/bin/bato https://github.com/doums/bato/releases/download/v0.1.7/bato \
  && chmod ug+x $HOME/.local/bin/bato

## Brave browser.
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null \
  && sudo apt update \
  && sudo apt install brave-browser

## Zotero.
mkdir --parents /tmp/zotero \
  && push /tmp/zotero >/dev/null \
  && curl -Lo /tmp/zotero/zotero.tar.bz2 'https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=7.0.9' \
  && sudo tar xjf zotero.tar.bz2 \
  && sudo mv Zotero_linux-x86_64 /opt/zotero \
  && popd >/dev/null \
  && rm -rf /opt/zotero

## Prusa Slicer.
mkdir --parents $HOME/08-apps \
  && mkdir --parents /tmp/prusa \
  && push /tmp/prusa >/dev/null \
  && curl -Lo /tmp/prusa/prusa.zip 'https://cdn.prusa3d.com/downloads/drivers/prusa3d_linux_2_8_1.zip' \
  && unzip prusa.zip \
  && mv PrusaSlicer-2.8.1+linux-x64-newer-distros-GTK3-202409181416.AppImage $HOME/08-apps \
  && pushd $HOME/08-apps >/dev/null \
  && chmod ug+x PrusaSlicer-2.8.1+linux-x64-newer-distros-GTK3-202409181416.AppImage \
  && ln -s PrusaSlicer-2.8.1+linux-x64-newer-distros-GTK3-202409181416.AppImage PrusaSlicer.AppImage \
  && popd >/dev/null \
  && popd >/dev/null \
  && rm -rf /tmp/prusa

## Swtchr, window switch for Sway (https://github.com/lostatc/swtchr).
sudo apt install libgtk-4-dev gtk4-layer-shell \
  cargo quickinstall swtchr

## Sway-easyfocus, switch between windows (https://github.com/edzdez/sway-easyfocus).
sudo apt install libgtk-3-dev libei-dev libgtk-layer-shell-dev

## Inkscape and extensions.
#https://github.com/galou/inkscape_generator.
sudo add-apt-repository ppa:inkscape.dev/stable \
  && sudo apt install inkscape
mkdir --parents $HOME/04-sources/inkscape \
  && git clone git@github.com:galou/inkscape_generator.git $HOME/04-sources/inkscape/inkscape_generator \
  && mkdir --parents $HOME/.config/inkscape/extensions \
  && pushd $HOME/.config/inkscape/extensions >/dev/null \
  && ln -s $HOME/04-sources/inkscape/inkscape_generator \
  && popd >/dev/null

## Glow, markdown viewer (https://github.com/charmbracelet/glow).
sudo mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list \
  && sudo apt update \
  && sudo apt install glow

## dragon, drag-and-drop for the command line (ttps://github.com/mwh/dragon).
sudo apt install libgtk-3-dev \
  && mkdir --parents $HOME/04-sources \
  && git clone --recursive https://github.com/mwh/dragon.git $HOME/04-sources/dragon-drag_and_drop \
  && pushd $HOME/04-sources/dragon-drag_and_drop >/dev/null \
  && make \
  && make install \
  && popd >/dev/null

## Pidgin and plugins.
sudo apt install pidgin
#WhatsApp plugin.
#https://github.com/hoehermann/purple-gowhatsapp/
sudo apt install golang libgdk-pixbuf2.0-dev libopusfile-dev libpurple-dev \
  && mkdir --parents $HOME/04-sources/pidgin \
  && git clone --recursive --depth 1 https://github.com/hoehermann/purple-gowhatsapp.git $HOME/04-sources/pidgin/purple-gowhatsapp \
  && mkdir --parents $HOME/80-build/pidgin-purple-gowhatsapp \
  && pushd $HOME/80-build/pidgin-purple-gowhatsapp >/dev/null \
  && cmake $HOME/04-sources/pidgin/purple-gowhatsapp \
  && cmake --build . \
  && sudo make install/strip \
  && popd >/dev/null
#Slack plugin.
#https://github.com/dylex/slack-libpurple/
# git clone https://github.com/dylex/slack-libpurple.git, run cd slack-libpurple, then run sudo make install or make install-user.
sudo apt install libpurple-dev \
  && mkdir --parents $HOME/04-sources/pidgin \
  && git clone --recursive --depth 1 https://github.com/dylex/slack-libpurple.git $HOME/04-sources/pidgin/slack-libpurple \
  && pushd $HOME/04-sources/pidgin/slack-libpurple >/dev/null \
  && make \
  && sudo make install \
  && popd >/dev/null

## Pixi, package manager ()
curl -fsSL https://pixi.sh/install.sh | zsh \
  && mv $HOME/.pixi/bin/pixi $HOME/.local/bin \
  && rmdir $HOME/.pixi/bin

## Cookiecutter, create projects from templates (https://cookiecutter.readthedocs.io/en/stable/index.html).
pipx install cookiecutter

## O3DE from source (https://o3de.org/).
mkdir --parents $HOME/04-sources/o3de \
  && pushd $HOME/04-sources/o3de >/dev/null \
  && git clone --recursive --depth 1 https://github.com/o3de/o3de.git \
  && cd o3de \
  && git remote rename origin upstream \
  && git lfs pull \
  && python/get_python.sh \
  && sudo apt install libunwind-dev libxcb-xkb-dev libxcb-xfixes0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinput-dev \
  && scripts/o3de.sh register --this-engine
  #&& cmake -B build/linux -S . -G "Ninja Multi-Config" \

## Zerotier, network virtualization (https://www.zerotier.com/).
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg' | gpg --import && \
  if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi

## LabelStudio, data labeling (https://labelstud.io/).
pip install --break-system-packages label-studio

## Meshroom, photogrammetry (https://alicevision.org/).
wget -O /tmp/meshroom.tar.gz 'https://download.fosshub.com/Protected/expiretime=1738614793;badurl=aHR0cHM6Ly93d3cuZm9zc2h1Yi5jb20vTWVzaHJvb20uaHRtbA==/2dd0387018c77e006d408434ec214ff022e9a3ac26dc495f319b852941ff08b7/5c6fe99776dd983e3dec2213/6568cbfc22a91d967c92b86e/Meshroom-2023.3.0-linux.tar.gz' \
  && sudo tar xf /tmp/meshroom.tar.gz -C /opt \
  && rm -f /tmp/meshroom.tar.gz
mkdir --parents $HOME/.local/share/meshroom/lib/nodes \
  && echo '#!/bin/bash\nMESHROOM_NODES_PATH=$HOME/.local/share/meshroom/lib/nodes\nexec /opt/Meshroom-2023.3.0-linux/Meshroom $@' > $HOME/.local/bin/meshroom \
  && chmod ug+x $HOME/.local/bin/meshroom

## Node.js 20 (otherwise 18 is installed).
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

## Platform IO.
echo "Installing Platform IO" \
  && curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules \
  && sudo service udev restart \
  && pushd /tmp >/dev/null \
  && curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py \
  && python3 get-platformio.py \
  && popd >/dev/null \
  && echo

# Configuration.

echo -n pcgael3 | sudo tee /etc/hostname >/dev/null
sudo usermod --groups=dialout,syslog,docker,wireshark --append $USER
rfkill unblock all

# Configure timezone
sudo ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime

# Sway with NVIDIA.
pushd /tmp >/dev/null \
  && git clone https://github.com/crispyricepc/sway-nvidia \
  && sudo install -Dm755 sway-nvidia/sway-nvidia.sh "/usr/local/bin/sway-nvidia" \
  && sudo install -Dm644 sway-nvidia/sway-nvidia.desktop "/usr/share/wayland-sessions/sway-nvidia.desktop" \
  && sudo install -Dm644 sway-nvidia/wlroots-env-nvidia.sh "/usr/local/share/wlroots-nvidia/wlroots-env-nvidia.sh" \
  && popd >/dev/null \
  && rm -rf /tmp/sway-nvidia

## Chezmoi (https://www.chezmoi.io/).
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply galou \
  && mkdir --parents $HOME/.local/bin \
  && mv $HOME/bin/chezmoi $HOME/.local/bin \
  && rmdir $HOME/bin

# Keyboard layouts (from https://github/galou/dotfiles).
sudo install -Dm644 $HOME/.local/share/chezmoi/usr/share/X11/xkb/symbols/us_cz /usr/share/X11/xkb/symbols/
sudo install -Dm644 $HOME/.local/share/chezmoi/usr/share/X11/xkb/symbols/gael /usr/share/X11/xkb/symbols/

## Zsh.
chsh --shell /usr/bin/zsh

## Neovim
mkdir --parents $HOME/.config \
  && pushd $HOME/.config >/dev/null \
  && git clone https://github.com/galou/dotvim.git nvim \
  && popd >/dev/null

## Fonts.
# mkdir --parents $HOME/.local/share/fonts \
#   && pushd $HOME/.local/share/fonts >/dev/null \
#   && wget 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf' \
#   && wget 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf' \
#   && wget 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf' \
#   && wget 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf' \
#   && wget 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf' \
#   && popd >/dev/null
mkdir --parents /tmp/fontawesome \
  && pushd /tmp/fontawesome >/dev/null \
  && curl -Lo fontawesome.zip 'https://use.fontawesome.com/releases/v6.6.0/fontawesome-free-6.6.0-desktop.zip?_gl=1*2tjanw*_ga*MTY1Njg0MTkuMTczMTgzNTk5NQ..*_ga_BPMS41FJD2*MTczMTgzNTk5NS4xLjEuMTczMTgzNjAyMC4zNS4wLjA.' \
  && aunpack fontawesome.zip \
  && cp **/otfs/*.otf $HOME/.local/share/fonts \
  && popd >/dev/null \
  && rm -rd /tmp/fontawesome \
  && fc-cache
mkdir --parents $HOME/.local/share/fonts/VictorMonoNerd \
  && mkdir /tmp/victormononerd \
  && pushd  /tmp/victormononerd >/dev/null \
  && curl -Lo victormononerd.zip 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/VictorMono.zip' \
  && unzip victormononerd.zip \
  && rm -f victormononerd.zip \
  && mv * $HOME/.local/share/fonts/VictorMonoNerd \
  && popd >/dev/null \
  && rmdir /tmp/victormononerd \
  && fc-cache
# https://fonts.google.com/specimen/Parisienne
mkdir --parents $HOME/.local/share/fonts/GoogleFonts/Parisienne \
  && pushd $HOME/.local/share/fonts/GoogleFonts/Parisienne >/dev/null \
  && wget 'https://github.com/google/fonts/raw/refs/heads/main/ofl/parisienne/Parisienne-Regular.ttf' \
  && wget 'https://github.com/google/fonts/raw/refs/heads/main/ofl/parisienne/OFL.txt' \
  && popd >/dev/null \
  && fc-cache

## Yazi.
ya pack --add KKV9/command
ya pack --add Sonico98/allmytoes
ya pack --add dedukun/bookmarks
ya pack --add pirafrank/what-size
ya pack --add yazi-rs/plugins:chmod
ya pack --add yazi-rs/plugins:jump-to-char
ya pack --add yazi-rs/plugins:smart-enter

## Miscellaneous
ln -s /usr/bin/batcat $HOME/.local/bin/bat
ln -s /usr/bin/fdfind $HOME/.local/bin/fd
git lfs install

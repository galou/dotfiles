Configuration files managed by chezmoi (https://github.com/twpayne/chezmoi).

Additionaly machine-specific configuration can be written in ~/.config/chezmoi/chezmoi.yaml:

.. code:: yaml

  data:
    eth_device: etho0
    wifi_device: wlan0
    ros_distro: melodic

Irrelevant fields can be removed.

Repository should be cloned into `~/.local/share/chezmoi`, e.g. with `git clone https://github.com/galou/dotfiles.git ~/.local/share/chezmoi`.

Example of uses:

- `chezmoi diff`
- `chezmoi apply`
- `chezmoi edit ~/.zshrc`
- `chezmoi source status`
- `chezmoi chattr executable ~/.zshrc`

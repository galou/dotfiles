Configuration files managed by chezmoi (https://github.com/twpayne/chezmoi).

Additionaly machine-specific configuration can be written in ~/.config/chezmoi/chezmoi.yaml:

.. code:: yaml

  data:
    main_monitor: eDP-1
    second_monitor: eDP-1
    second_monitor_position: right
    eth_device: eth0
    wifi_device: wlan0
    ros_distro: melodic
    i3_use_fontawesome: true
    pulseaudio_sink: 0

Irrelevant fields can be removed.

Repository should be cloned into `~/.local/share/chezmoi`, e.g. with `git clone https://github.com/galou/dotfiles.git ~/.local/share/chezmoi`.

Example of uses:

- `chezmoi diff`
- `chezmoi apply`
- `chezmoi edit ~/.zshrc`
- `chezmoi source status`
- `chezmoi chattr executable ~/.zshrc`

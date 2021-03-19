Configuration files managed by chezmoi (https://github.com/twpayne/chezmoi).

Additionaly machine-specific configuration can be written in ~/.config/chezmoi/chezmoi.yaml:

.. code:: yaml

  data:
    main_monitor: eDP-1
    second_monitor: HDMI-1
    second_monitor_position: left
    second_monitor_rotation: right
    eth_device: eth0
    wifi_device: wlan0
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

Licenses:

Unless otherwise specified the files are available under the `CC0 license <https://creativecommons.org/share-your-work/public-domain/cc0/>`_.

The icons `input-touchpad-symbolic.svg`, `touchpad-disabled-symbolic.svg`, `microphone-sensitivity-muted-symbolic.svg` and `microphone-sensitivity-medium-symbolic.svg` are part of the Adwaita icon theme and are licensed under the `is licenced under the terms of either the GNU LGPL v3 or
Creative Commons Attribution-Share Alike 3.0 United States License <http://creativecommons.org/licenses/by-sa/3.0/>`_.
The icons `toggle-on-solid.svg` and `toggle-off-solid.svg` are part of the Font Awesome project and licensed under the `Creative Commons Attribution 4.0 International <https://fontawesome.com/license>`_.


#!/usr/bin/bash

sudo install -m 644 etc/auto.master.d/nas.autofs /etc/auto.master.d/nas.autofs
sudo install -m 644 etc/auto.nas /etc/auto.nas
sudo systemctl restart autofs


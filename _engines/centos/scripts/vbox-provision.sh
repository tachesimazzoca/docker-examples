#!/usr/bin/env bash

# Reset network.service
nmcli connection reload
systemctl restart network.service

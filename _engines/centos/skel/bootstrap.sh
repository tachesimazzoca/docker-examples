#!/usr/bin/env bash

nmcli connection reload
systemctl restart network.service


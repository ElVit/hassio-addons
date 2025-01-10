# Home Assistant Add-on: Samba server

![Supports aarch64 Architecture](https://img.shields.io/badge/aarch64-yes-green.svg)
![Supports amd64 Architecture](https://img.shields.io/badge/amd64-yes-green.svg)
![Supports armhf Architecture](https://img.shields.io/badge/armhf-yes-green.svg)
![Supports armv7 Architecture](https://img.shields.io/badge/armv7-yes-green.svg)
![Supports i386 Architecture](https://img.shields.io/badge/i386-yes-green.svg)

![Build and test samba addon](https://github.com/elvit/hassio-addons/actions/workflows/build_samba.yml/badge.svg?branch=main)

## About

A simple add-on which sets up a samba server.  
It allows you to share files in your local network over the SMB protocol.  

The special about this addon is that it exposes the config file so you can adapt it to your needs.  
That means your are able to define multiple users and share only specific directories for specific users.  

This addon is for advanced users and requires knowledge of how to write a smb.conf file.  
[Click here to see the smb.conf documentation](https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html)  

# Changelog

## 1.3.5

* ⚠️ Removed armv7 support

## 1.3.4

* 📈 Updated hassio-addons/base to v18.0.3
  
## 1.3.3

* 📈 Updated hassio-addons/base to v17.2.5

## 1.3.2

* 📈 Updated hassio-addons/base to v17.0.2
* 📈 Updated samba to v4.20.6-r1

## 1.3.1

* 🧰 Code refactoring

## 1.3.0

* 📈 Updated addon_base to 15.0.7
* 🆕 Added codenotary signing

## 1.2.1

* 🐛 Fixed `config_dir` path
* 📚 Updated documentation

## 1.2.0

* 🆕 Use the new Home Assistant directory "addon_configs" for storing the smb.conf
* 💥 BREAKING CHANGE:  
     Option `config_dir` was removed since the smb.conf will now be copied to the `addon_configs` directory  
     !!! Please copy your custom smb.conf to `/addon_configs/bb4914d7_samba/` if you want keep your changes !!!  
* 📈 Updated addon_base to 14.3.2

## 1.1.0

* 📈 Updated addon_base to 12.2.7

## 1.0.0

* 🎉 Initial release (forked from https://github.com/home-assistant/addons/tree/master/samba)  

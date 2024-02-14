# Changelog

## 1.3.0

* 📈 Updated addon_base to 15.0.7  

* 🆕 Added codenotary signing

## 1.2.1

* 🐛 Fixed `config_dir` path  

* 📚 Updated documentation  

## 1.2.0

* 🆕 Use the new Home Assistant directory "addon_configs" for storing the smb.conf  

* 💥 BREAKING CHANGE:
     Option `config_dir` was removed since the smb.conf will now be copied to the `addons_config` directory  
     !!! Please copy your custom smb.conf to `/addons_config/bb4914d7_samba/` if you want keep your changes !!!  

* 📈 Updated addon_base to 14.3.2  

## 1.1.0

* 📈 Updated addon_base to 12.2.7  

## 1.0.0

* 🎉 Initial release (forked from https://github.com/home-assistant/addons/tree/master/samba)  

# Changelog

## 1.3.2

* 📈 Updated hassio-addons/base to v17.0.2
* 📈 Updated traefik to v3.1.7-r0
* 📈 Updated nginx to v1.26.2-r4

## 1.3.1

* 🧰 Code refactoring  
     User tempio instead of gomplate.  
* 💥 BREAKING CHANGE:  
     Renamed option "custom_static_config" to "custom_config"  

## 1.3.0

* 📈 Updated addon_base to 15.0.7
* 🆕 Use alpine package instead of wget from github to install traefik
* 🆕 Added codenotary signing

## 1.2.0

* 🆕 Use the new Home Assistant directory `addon_configs` for storing the `dynamic.yaml` (dynamic config) and 'traefik.yaml' (static config)
* 💥 BREAKING CHANGE:  
     Options `dir_of_static_config` and `dir_of_dynamic_config` are removed since the config files will now be copied to the `addons_config` directory.  
     !!! Please copy your custom config files to `/addons_config/xxxxxxxx_traefik/` if you want keep your changes !!!  
* 📈 Updated addon_base to 14.3.2
* 📈 Updated traefik to 2.10.5
* 📚 Updated documentation

## 1.1.0

* 📈 Updated traefik to 2.9.5
* 📈 Updated addon_base to 12.2.7

## 1.0.0

* 🎉 Initial release (forked from https://github.com/alex3305/home-assistant-addons)

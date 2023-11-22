# Changelog

## 1.2.0

* 🆕 Use the new Home Assistant directory `addon_configs` for storing the `dynamic.yaml` (dynamic config) and 'traefik.yaml' (static config)  

* 💥 BREAKING CHANGE:  
     Options `dir_of_static_config` and `dir_of_dynamic_config` are removed since the config files will now be copied to the `addons_config` directory.  
     !!! Please copy your custom config files to `/addons_config/bb4914d7_traefik/` if you want keep your changes !!!  

* 📈 Updated addon_base to 14.3.2  

* 📈 Updated traefik to 2.10.5  

* 📚 Updated documentation  

## 1.1.0

* 📈 Updated traefik to 2.9.5  

* 📈 Updated addon_base to 12.2.7  

## 1.0.0

* 🎉 Initial release (forked from https://github.com/alex3305/home-assistant-addons)  
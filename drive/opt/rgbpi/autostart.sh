#!/bin/bash
cd /opt/rgbpi/ui 2> /dev/null
rm -rf /opt/rgbpi/ui/temp/* 2> /dev/null
CRT_TYPE=$(grep '^crt_type' /opt/rgbpi/ui/config.ini 2> /dev/null | cut -d'=' -f2 | tr -d ' ')
if [[ "$CRT_TYPE" == "arcade_15_25_31" || "$CRT_TYPE" == "ms2930" || "$CRT_TYPE" == "arcade_31" ]]; then
  sed -i 's/reicast_internal_resolution = ".*"/reicast_internal_resolution = "640x480"/' /opt/rgbpi/ui/data/cores.cfg 2> /dev/null
elif [[ "$CRT_TYPE" == "generic_15" || "$CRT_TYPE" == "arcade_15" || "$CRT_TYPE" == "arcade_15_25" ]]; then
  sed -i 's/reicast_internal_resolution = ".*"/reicast_internal_resolution = "320x240"/' /opt/rgbpi/ui/data/cores.cfg 2> /dev/null
fi
/usr/bin/python3.9 /opt/rgbpi/ui/rgbpiui.pyc 2> /opt/rgbpi/ui/logs/error.log
#!/bin/bash
cd /opt/rgbpi/ui 2> /dev/null
rm -rf /opt/rgbpi/ui/temp/* 2> /dev/null
#/usr/bin/python3 /opt/rgbpi/ui/rgbpiui.pyc 2> /dev/null
/usr/bin/python3 /opt/rgbpi/ui/rgbpiui.pyc 2> /opt/rgbpi/ui/logs/error.log

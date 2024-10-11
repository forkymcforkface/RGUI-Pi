V1:
RGUI-Pi launches directly to RGUI for those that want a raw gaming experience and ALL the options

V2: 
Created OS4 Migration Utility that moves over the rgbpi application from an OS4 burned USB Drive
    Modified autostart script to launch different versions of retroarch depending on your CRT Type
        15khz retroarch dynares now halves the height of any game over 380 so it does not require interlacing (480i)
        15/31Khz is normal retroarch as calamity/dynares will choose 240p or 480p
    Retroarch overrides are done directly within retroarch.c and utilize /media/sd/gameconfig/sys_override 
        audio settings overrides were applied to optimize USB audio.
Optimized cores.cfg for pi5 usage by disabling threaded video in cores that supported it

V3: 
Refactored image as kernel headers had been removed somwewhere along the way causing issues with compiling drivers

V4:
Added support for lotek dpi24 (vga888) hat, install driver in via OS4 UI in /media/sd/ports/GPIO_Device
Added VGA Monitor scritps to /media/sd/ports that allows the use of VGA Monitors.
  

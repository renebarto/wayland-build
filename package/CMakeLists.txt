include(package)

add_subdirectory(x11proto-bigreqs)
add_subdirectory(x11proto-composite)
add_subdirectory(x11proto-damage)
add_subdirectory(x11proto-dmx)
add_subdirectory(x11proto-dri2)
add_subdirectory(x11proto-dri3)
add_subdirectory(x11proto-fixes)
add_subdirectory(x11proto-fonts)
add_subdirectory(x11proto-gl)
add_subdirectory(x11proto-input)
add_subdirectory(x11proto-kb)
add_subdirectory(x11proto-present)
add_subdirectory(x11proto-randr)
add_subdirectory(x11proto-record)
add_subdirectory(x11proto-render)
add_subdirectory(x11proto-resource)
add_subdirectory(x11proto-scrnsaver)
add_subdirectory(x11proto-video)
add_subdirectory(x11proto-x)
add_subdirectory(x11proto-xcmisc)
add_subdirectory(x11proto-xext)
add_subdirectory(x11proto-xf86bigfont)
add_subdirectory(x11proto-xf86dga)
add_subdirectory(x11proto-xf86dri)
add_subdirectory(x11proto-xf86vidmode)
add_subdirectory(x11proto-xinerama)
add_subdirectory(zlib)
add_subdirectory(libpng)
add_subdirectory(libevdev)
add_subdirectory(pixman)
add_subdirectory(freetype)
add_subdirectory(libxml2)
add_subdirectory(expat)
add_subdirectory(fontconfig)
add_subdirectory(libffi)
add_subdirectory(wayland)
add_subdirectory(wayland-protocols)
add_subdirectory(mtdev)
add_subdirectory(libxdmcp)
add_subdirectory(xcb-proto)
add_subdirectory(libxau)
add_subdirectory(libxcb)
add_subdirectory(libinput)
add_subdirectory(libxkbcommon)
add_subdirectory(libjpegturbo)
add_subdirectory(libx11)
add_subdirectory(libxfixes)
add_subdirectory(libxdamage)
add_subdirectory(libxext)
add_subdirectory(libxrender)
add_subdirectory(libxcursor)
add_subdirectory(mesa)
add_subdirectory(cairo)
add_subdirectory(Linux-PAM)
add_subdirectory(weston)

# libglew-dev libglu1-mesa-dev libxxf86vm-dev

# weston 1.12.0 ->
#     Cairo-1.14.8                              OK
#     libinput-1.7.0                            OK
#     libjpeg-turbo-1.5.1                       OK
#     libxkbcommon-0.7.1                        OK
#     Mesa-17.0.4 (built with Wayland support)  OK
#     mtdev-1.1.5                               OK
#     Wayland-1.13.0                            OK
#     wayland-protocols-1.7                     OK
#     Linux-PAM-1.3.0
# Cairo-1.14.8 ->                               OK
#     libpng-1.6.29                             OK
#     Pixman-0.34.0                             OK
#     Fontconfig-2.12.1                         OK
# libinput-1.7.0 ->                             OK
#     libevdev-1.5.6                            OK
#     mtdev-1.1.5                               OK
# libjpeg-turbo-1.5.1 ->                        OK
#     # NASM-2.11.08 #
# libxkbcommon-0.7.1                            OK
# Mesa-17.0.4 (built with Wayland support) ->   OK
#     Xorg Libraries                            OK
#     libdrm-2.4.78                             OK
#     # Python-2.7.13 #
# libdrm-2.4.78 ->                              OK
#     Xorg Libraries                            OK
# Xorg libraries ->                             OK
#     Fontconfig-2.12.1                         OK
#     libxcb-1.12                               OK
#     libX11-1.6.4                              OK
#     libXext-1.3.3                             OK
#     libXrender-0.9.10                         OK
#     libXcursor-1.1.14                         OK
#     libXdamage-1.1.4                          OK
#     libXfixes-5.0.3                           OK
# libxcb-1.12 ->                                OK
#     libXau-1.0.8                              OK
#     xcb-proto-1.12                            OK
#     libXdmcp-1.1.2                            OK
#     Xorg Protocol Headers                     OK
# xcb-proto-1.12                                OK
# libXdmcp-1.1.2                                OK
#     Xorg Protocol Headers                     OK
# libX11-1.6.4                                  OK
# libXext-1.3.3                                 OK
# libXcursor-1.1.14                             OK
#     libXrender-0.9.10                         OK
# libXrender-0.9.10                             OK
# libXdamage-1.1.4                              OK
# libXfixes-5.0.3                               OK
# libXau-1.0.8                                  OK
# mtdev-1.1.5                                   OK
# wayland-protocols-1.7 ->                      OK
#     Wayland-1.13.0                            OK
# Wayland-1.13.0 ->                             OK
#     libffi-3.2.1                              OK
#     expat-2.2.0                               OK
#     libxml2-2.9.4                             OK
# libffi-3.2.1                                  OK
# Fontconfig-2.12.1 ->                          OK
#     FreeType-2.7.1                            OK
#     libxml2-2.9.4                             OK
#     expat-2.2.0                               OK
# expat-2.2.0                                   OK
# libxml2-2.9.4                                 OK
# FreeType-2.7.1 ->                             OK
#     libpng-1.6.29                             OK
# Pixman-0.34.0 ->                              OK
#     libpng-1.6.29                             OK
# libevdev-1.5.6 ->                             OK
#     # Eudev-3.2.1 # : libudev-dev
# libpng-1.6.29 ->                              OK
#     zlib-1.2.11                               OK
# zlib-1.2.11                                   OK
# Xorg Protocol Headers                         OK

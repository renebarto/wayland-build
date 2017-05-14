export XDG_RUNTIME_DIR=/tmp/westeros
export LD_LIBRARY_PATH=/home/rene/sysroot/usr/lib
export LD_PRELOAD=/home/rene/sysroot/usr/lib/libEGL.so
sudo -E mkdir -p /tmp/westeros
sudo -E chmod 644 /tmp/westeros
sudo -E /home/rene/sysroot/usr/bin/westeros --renderer /home/rene/sysroot/usr/lib/libwesteros_render_gl.so --display wayland-0

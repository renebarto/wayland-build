export XDG_RUNTIME_DIR=/tmp/westeros
export LD_LIBRARY_PATH=/home/rene/sysroot/usr/lib
sudo mkdir -p /tmp/westeros
sudo chmod 644 /tmp/westeros
sudo -E gdb --args /home/rene/sysroot/usr/bin/westeros --renderer /home/rene/sysroot/usr/lib/libwesteros_render_gl.so --display wayland-0

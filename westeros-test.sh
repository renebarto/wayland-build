export XDG_RUNTIME_DIR=/tmp/westeros
export LD_LIBRARY_PATH=/home/rene/sysroot/usr/lib
mkdir -p /tmp/westeros
chmod 644 /tmp/westeros
/home/rene/sysroot/usr/bin/westeros_test --renderer /home/rene/sysroot/usr/lib/libwesteros_render_gl.so --display wayland-0

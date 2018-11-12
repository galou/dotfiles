git clone --recursive https://github.com/svenstaro/rofi-calc.git
autoreconf -i
mkdir build
cd build
../configure
make
mv .libs/calc.so ~/.local/lib/rofi

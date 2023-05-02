gh repo clone gustawho/okular-backend-mupdf
okular-backend-mupdf/

sudo apt install liblcms2-dev libjbig2dec0-dev libjpeg8-dev libopenjp2-7-dev libgumbo-dev libssl-dev libmupdf-dev libmujs-dev okular-dev extra-cmake-modules

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -B build -S .
cmake --build build --config RelWithDebInfo
sudo cmake --install build --config RelWithDebInfo

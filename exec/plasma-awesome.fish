#!/usr/bin/fish

set -gx KDEWM /usr/bin/awesome
xhost +local: # 允许docker运行图形程序
/usr/bin/startplasma-x11

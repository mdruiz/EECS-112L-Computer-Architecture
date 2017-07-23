
cd $sim
rm -rf so_libs
mkdir so_libs
gcc -shared -m64 -fPIC -O3 $model/test.c \
                           -I$QUESTA_HOME/include \
                           -o $sim/so_libs/TEST.so


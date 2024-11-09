cd Indigo
mkdir build
cd build
yay -S --noconfirm --needed ninja docker maven emsdk oracle-instantclient-basic
cmake .. -DBUILD_INDIGO=ON -DBUILD_INDIGO_WRAPPERS=ON -DBUILD_INDIGO_UTILS=ON
cmake --build . --config Release --target indigo-java indigo-python indigo-utils-linux-x86_64 bingo-oracle
sudo make install

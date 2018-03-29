#!/bin/bash
echo ============================
echo FastPlaz Initialize

cd /app

#3.0.2
tar -ixf fpc-3.0.2.x86_64-linux.tar > /dev/null
cp fpc-install.sh fpc-3.0.2.x86_64-linux
cd fpc-3.0.2.x86_64-linux

#3.0.4
#tar -xf fpc-3.0.4.x86_64-linux.tar
#cp fpc-install.sh fpc-3.0.4.x86_64-linux/
#cd fpc-3.0.4.x86_64-linux

./fpc-install.sh
cd /app
rm -rf fpc-3.0.2.x86_64-linux
rm -rf fpc-3.0.2.x86_64-linux.tar

cd /projects/vendors/
git clone -b development https://github.com/fastplaz/fastplaz.git
echo -- init done


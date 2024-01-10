#!/bin/bash

declare -a arches

arches=("386" "amd64" "arm" "arm64")

for arch in "${arches[@]}"; do
  if [ "$1" == "$arch" ]; then
    ARCH=$1
    printf "Proceeding with %s-compatible installation.\n" "$ARCH"
  fi
done

if [ -z "$ARCH" ]; then
  printf "Please select from the following architectures.\n"
  printf "\n\t1) 386\n\t2) amd64\n\t3) arm\n\t4) arm64\n"
  arch_index=0
  read -r -n 1 -p "Select your architecture: " arch_index
  ARCH="${arches[$arch_index]}"
  printf "\nProceeding with %s-compatibile installation.\n" "$ARCH"
fi

wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.24.0/op_linux_${ARCH}_v2.24.0.zip" -O /tmp/op.zip 
cd /tmp || exit
unzip -d op op.zip 
sudo mv op/op /usr/local/bin 
rm -r op.zip op 

sudo groupadd -f onepassword-cli 
sudo chgrp onepassword-cli /usr/local/bin/op
sudo chmod g+s /usr/local/bin/op

exit 0

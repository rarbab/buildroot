#!/bin/bash

CRAFF=$HOME/simics/p10/bin/craff

if [ -z "${BINARIES_DIR}" ]; then
        echo "BINARIES_DIR not defined"
        exit 1
fi

cat >${BINARIES_DIR}/grub.cfg <<EOF
menuentry 'Buildroot' {
	linux /vmlinux
	initrd /rootfs.cpio
}
EOF

tar -cf /tmp/buildroot.tar -C ${BINARIES_DIR} \
	grub.cfg \
	rootfs.cpio \
	vmlinux

virt-make-fs /tmp/buildroot.tar /tmp/buildroot.img
${CRAFF} -o ${BINARIES_DIR}/buildroot.craff /tmp/buildroot.img
rm -f /tmp/buildroot.img

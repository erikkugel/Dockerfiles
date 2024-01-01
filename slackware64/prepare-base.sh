#!/bin/bash

set -e

SLACKWARE_MIRROR=${SLACKWARE_MIRROR:-https://mirrors.slackware.com/slackware/slackware64-15.0/}

if [ -d build ]; then
	rm --force --recursive build
fi
mkdir --verbose build
if [ ! -d tar ]; then
	mkdir --verbose tar
fi

echo 'Preparing packages...'
slackpkg -batch=on -default_answer=y update
slackpkg -batch=on -default_answer=y download ./packages
while IFS= read -r package; do
	find /var/cache/packages/slackware64 -name "${package}-*.txz" -exec installpkg --root build {} \;
	find /var/cache/packages/patches/packages -name "${package}-*.txz" -exec ROOT=build upgradepkg {} \;
done < packages
ldconfig -r build

echo 'Configuring Slackpkg...'
cp slackpkg.conf build/etc/slackpkg/slackpkg.conf
echo ${SLACKWARE_MIRROR} > build/etc/slackpkg/mirrors
wget "${SLACKWARE_MIRROR}GPG-KEY" -O build/GPG-KEY
cat << EOF | chroot build
	update-ca-certificates -v -f
	( cat GPG-KEY | gpg --import ) && rm GPG-KEY
EOF

echo 'Archiving filesystem...'
pushd build
tar --numeric-owner \
	--exclude=dev \
	--exclude=proc \
	--exclude=sys \
	--create \
	--file ../tar/slackware64.tar *
popd

echo 'Done.'
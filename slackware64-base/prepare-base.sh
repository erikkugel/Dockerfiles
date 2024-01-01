#!/bin/bash

set -e

SLACKWARE_MIRROR=${SLACKWARE_MIRROR:-https://mirrors.slackware.com/slackware/slackware64-15.0/}

rm --verbose --force --recursive build

echo 'Preparing packages...'
slackpkg -batch=on -default_answer=y download ./packages
while IFS= read -r package; do
	find /var/cache/packages -name "${package}-*.txz" -exec installpkg --root base {} \;
done < packages
ldconfig -r base

echo 'Configuring Slackpkg...'
cp slackpkg.conf base/etc/slackpkg/slackpkg.conf
echo ${SLACKWARE_MIRROR} > base/etc/slackpkg/mirrors
wget "${SLACKWARE_MIRROR}GPG-KEY" -O base/GPG-KEY
cat << EOF | chroot base
	update-ca-certificates -v -f
	( cat GPG-KEY | gpg --import ) && rm GPG-KEY
EOF

echo 'Archiving filesystem...'
pushd base
tar --numeric-owner \
	--exclude=dev \
	--exclude=proc \
	--exclude=sys \
	--create \
	--file ../slackware64-base.tar *
popd

echo 'Done.'


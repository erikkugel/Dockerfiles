# Creating a Docker image from a base installation of Slackware64 

1. Create a tar archive from a base Slackware64 installation (assumes only packages from series _**-a-**_ were installed with all default settings).

    This can be done in a virtual machine, with the virtual drive later mounted on the local filesystem to fetch the archive.
    ```
    tar --numeric-owner --exclude=/dev --exclude=/proc --exclude=/sys -cvf slackware64.tar /
    ```

1. Create a Docker image from an archive.
    ```
    cat slackware64.tar | docker import - slackware64-tar
    ```

1. Prepare base image dependecies:
    1. Copy the following packages from a Slackware64 mirror into this directory:
        * ap/slackpkg-_<version>_-noarch-1.txz
        * n/gnupg-_<version>_-x86_64-4.txz
        * n/wget-_<version>_-x86_64-1.txz
        * l/libunistring-_<version>_-x86_64-3.txz
        * n/ca-certificates-_<version>_-noarch-1.txz
        * n/openssl-_<version>_-x86_64-1.txz
        * d/perl-_<version>_-x86_64-1.txz
        * ap/diffutils-_<version>_-x86_64-1.txz

    1. Build the image, optionally overriding the default Slackware mirror:
        ```
        docker build . -t slackware64-base --build-arg MIRROR='https://mirrors.slackware.com/slackware/slackware64-15.0/'
        ```
     

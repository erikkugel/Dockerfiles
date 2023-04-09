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
    1. Copy the following package files from a Slackware64 mirror into this directory:
        * ap/slackpkg
        * n/gnupg
        * n/wget
        * l/libunistring
        * n/ca-certificates
        * n/openssl
        * d/perl
        * ap/diffutils

    1. Build the image, optionally overriding the default Slackware mirror:
        ```
        docker build . -t slackware64-base --build-arg MIRROR='https://mirrors.slackware.com/slackware/slackware64-15.0/'
        ```
     

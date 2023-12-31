# Create a Docker base image for Slackware64

## Prerequisites

* Functional Slackware installation with the same architecture and version as the target base image to perform the build. While this script should be safe, further isolating it on a virtual machine or a Docker container is encouraged.
* Configured and working instance of _Slackpkg_ and its dependencies to fetch packages for the base image.
* Packages providing the following alongside any dependecies they might have:
    * bash
    * findutils (for `find`)
    * pkgtools (for `installpkg`, `removepkg`)
    * aaa_glibc-solibs (for `ldconfig`)
    * wget
    * coreutils (for `chroot`)
    * tar
* Ability to fetch the generated _tar_ archive and import it into a running Docker instance to create the image.

## Usage

1. Clone or otherwise make the repository available on the build system.
1. Change directory to where the [prepare-base.sh](prepare-base.sh) script is located.
1. Optionally, override the `SLACKWARE_MIRROR` environment variable to use a different mirror:

        export SLACKWARE_MIRROR=http://mirror.csclub.uwaterloo.ca/slackware/slackware64-15.0/

1. If any additional packages are required, they may be added in the [packages](packages) file.
1. Execute the [prepare-base.sh](prepare-base.sh) Bash script as root from the directory: 

        bash ./prepare-base.sh

1. Import the archive into a running instance of Docker to get an image:

        cat slackware64.tar | docker import - slackware64:$(date +%Y%m%d)

1. Test the image:

        docker run slackware64:$(date +%Y%m%d) slackpkg update

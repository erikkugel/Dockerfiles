# Create a Docker base image for Slackware64

## Prerequisites

* Functional Slackware installation with the same architecture and version as the target base image to perform the build. While this script should be safe, further isolating it on a virtual machine or a Docker container is encouraged.
* Configured and working instance of _Slackpkg_ and its dependencies to fetch packages for the base image.
* A local copy of a Slackware64 mirror which _Slackpkg_ is configured to use, or a working network connection for downloading packages from an external mirror.
* Packages providing the following alongside any dependecies they might have, in addition to _Slackpkg_:
    * bash
    * findutils (for `find`)
    * pkgtools (for `installpkg`, `removepkg`)
    * aaa_glibc-solibs (for `ldconfig`)
    * wget
    * coreutils (for `chroot`)
    * tar

    A Slackpkg template with the full _a_ series and any additional packages needed or considered useful for the build environment is available at [slackware64-build-base.template](slackware64-build-base.template) and can be install with slackpkg:

        cp slackware64-build-base.template /etc/slackpkg/templates/slackware64-build-base.template
        slackpkg install-template slackware64-build-base.template

* Ability to fetch the generated _tar_ archive and import it into a running Docker instance to create the image.

## Usage

1. Clone or otherwise make the repository available on the build system.
1. Change directory to where the [prepare-base](prepare-base) script is located.
1. Optionally, override the `SLACKWARE_MIRROR` environment variable to use a different mirror:

        export SLACKWARE_MIRROR=http://mirror.csclub.uwaterloo.ca/slackware/slackware64-15.0/

1. If any additional packages are required, they may be added in the [packages](packages) file.
1. Execute the [prepare-base](prepare-base) Bash script as root from the directory: 

        ./prepare-base

1. Import the archive into a running instance of Docker to get an image:

        cat slackware64.tar | docker import - slackware64:$(date +%Y%m%d)

1. Test the image:

        docker run slackware64:$(date +%Y%m%d) slackpkg update

### Build in Docker

You can use a Slackware Docker base image to build base images from scratch:

1. Build a new image using the [Dockerfile](Dockerfile), optionally specifying an external or local mirror:

        docker build . -t slackware64-build:latest

    or, for a custom external mirror:

        docker build --build-arg SLACKWARE_MIRROR=https://mirrors.slackware.com/slackware/slackware64-15.0/ . -t slackware64-build:latest

    or, to use a local mirror, use the `/mirror` path where a local mirror can be mounted as a volume:

        docker build --build-arg SLACKWARE_MIRROR=file://mirror/ . -t slackware64-build:latest

1. Create a directory named `tar` to mount the output directory:

        mkdir tar

1. Run a container with a volume mounted for the resulting archive under `tar`:

        docker run -v ./tar:/tar slackware64-build:latest

    or, if a local mirror was specified in the build, mount it as `mirror`:

        docker run -v ./tar:/tar -v ./slackware64-15.0:/mirror slackware64-build:latest

1. The resulting archive will be available in the `tar` folder and can be imported with `docker import` and tested:

        cat tar/slackware64.tar | docker import - slackware64:$(date +%Y%m%d)
        docker run slackware64:$(date +%Y%m%d) slackpkg update

### Build with GitHub Actions

A GitHub Actions pipeline can be used for build with the [action.yml](action.yml) Action definition.

An example working Workflow is located at [slackware-base-image-update.yml](.github/workflows/slackware-base-image-update.yml)
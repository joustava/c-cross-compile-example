# Docker image to run https://lede-project.org/start
# sources:
#         http://gbraad.nl/blog/non-root-user-inside-a-docker-container.html
#
# For building omega https://wiki.onion.io/Tutorials/Cross-Compile/dc3e6b3a8c3d8e2445c620c04ad218b9d4e1e483
# and Omega2(+) https://docs.onion.io/omega2-docs/cross-compiling.html

# build:
#       $ docker build -t onion-omega-xc .
# run:
#       $ docker run -it --rm onion-omega-xc /bin/bash
#       $ cd lede
#       $ make menuconfig
#
# for onion select these options:
#   Target System is Atheros AR7xxx/AR9xxx
#   Subtarget is Generic
#   Target Profile is Onion Omega
#   Target Images is squashfs
#
#       $ make
#
#
FROM debian:jessie-slim

ENV TZ Europe/Berlin

RUN apt-get update && apt-get install -y \
    tzdata \
    git \
    wget \
    subversion \
    build-essential \
    libncurses5-dev \
    zlib1g-dev \
    gawk \
    flex \
    quilt \
    git-core \
    unzip \
    libssl-dev \
    python-dev \
    python-pip \
    vim \
    libxml-parser-perl && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

RUN adduser engineer

USER engineer

WORKDIR /home/engineer

RUN git clone https://git.lede-project.org/source.git lede
RUN git clone https://github.com/joustava/c-cross-compile-example.git tmp/c-cross-compile-example
RUN mv tmp/c-cross-compile-example/bin /home/engineer/ && \
    mv tmp/c-cross-compile-example/workspace workspace && \
    mv tmp/c-cross-compile-example/lede/.config lede/.config && \
    rm -rf tmp && \
    echo "alias xc='sh ~/bin/xCompile.sh -buildroot ~/lede'" > .bash_aliases \

CMD ["/bin/bash"]


# TODO: make this https://www.linux.com/learn/put-talking-cow-your-linux-message-day
# TODO: make help cmd
#
# TOOLCHAIN #
#
# The toolchain is in
# ./staging_dir/toolchain-mips_24kc_gcc-5.4.0_musl/
#
# The compilation tools are in
# ./staging_dir/toolchain-mips_24kc_gcc-5.4.0_musl/bin
#
# Headers for standard C library
# ./staging_dir/toolchain-mipsel_24kc_gcc-5.4.0_musl/include/
#
# The standard C shared objects
# ./staging_dir/toolchain-mipsel_24kc_gcc-5.4.0_musl/lib
#
# TARGET #
#
# Target files
# ./staging_dir/target-mips_24kc_musl/
#
# Header files of libraries added as packages (our code will likely use header files from this location)
# ./staging_dir/target-mipsel_24kc_musl/usr/include/
#
# Shared objects for the libraries added as packages (code that uses these libraries needs to be linked to these shared objects during compilation)
# ./staging_dir/target-mipsel_24kc_musl/usr/lib

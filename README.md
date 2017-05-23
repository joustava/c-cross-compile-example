# c-cross-compile-example

Example of a C program for the Omega that needs to be cross-compiled.

## Purpose

Demonstration project for cross-compiling C programs for the Omega using the LEDE build system
with relatively easy setup using Docker.

## Getting started

Make sure you have [docker](https://docs.docker.com/engine/installation/) installed for you platform.
Then, to get the box running:

    $ git clone https://github.com/joustava/c-cross-compile-example.git
    $ docker-compose build lede
    $ docker-compose run lede

In the container configure your cross compilation environment

    $ make menuconfig


## Companion Example

See the [Cross Compiling for the Omega](https://docs.onion.io/omega2-docs/cross-compiling.html) article in the [Onion Docs](https://docs.onion.io).

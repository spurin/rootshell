# Root Shell Docker Image

## Overview

This repository contains a Dockerfile for creating a container image with a custom `rootshell` binary. This binary, when executed, provides a shell with root privileges. The Dockerfile uses a multi-stage build process to create the `rootshell` binary and then copies it into a standard Ubuntu image.

**Warning:** This container image is designed for educational and testing purposes only. It should not be used in production environments or exposed to any network, as it poses a significant security risk.

## Dockerfile Explanation

- **Stage 1**: Compiles a custom C program into a binary named `rootshell`. This program, when executed, spawns a shell with root privileges.
- **Stage 2**: Sets up a standard Ubuntu image, adds a nonprivileged user, and copies the `rootshell` binary from the first stage.

## Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```sh
docker build -t my-custom-image:latest .
```

## Alternative use

The image is also prebuilt on Docker Hub and can be used as `spurin/rootshell:latest` - see build.sh for the multiarch build process

## Demonstrating root escalation with Docker

```sh
% docker run -it --rm --user 1000:1000 spurin/rootshell:latest
nonpriv@00eac4da6562:/$ 
nonpriv@00eac4da6562:/$ id
uid=1000(nonpriv) gid=1000(nonpriv) groups=1000(nonpriv)
nonpriv@00eac4da6562:/$ /rootshell
root@00eac4da6562:/#
root@00eac4da6562:/# id
uid=0(root) gid=1000(nonpriv) groups=1000(nonpriv)
```

## Security Notice

This image includes a binary that allows any user to gain root privileges. Therefore, it is crucial to handle this image carefully and ensure it is never used in a sensitive or production environment.

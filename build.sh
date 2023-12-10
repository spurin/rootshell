docker buildx build --no-cache --platform linux/amd64,linux/arm64/v8,linux/arm/v7,linux/ppc64le,linux/s390x . -t spurin/rootshell:latest --push

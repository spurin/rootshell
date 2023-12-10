# Stage 1: Build the rootshell binary
FROM ubuntu:latest as build_rootshell

## Install gcc
RUN apt-get update && apt-get install -y build-essential

## C code that initiates a setuid to root and runs the /bin/bash shell as root
### 
#### #include <unistd.h>
#### int main() {
####    setuid(0); // Set the user ID to root
####    system("/bin/bash"); // Execute the shell
####    return 0;
#### }
RUN echo '#include <unistd.h>\nint main() {\n   setuid(0); // Set the user ID to root\n   system("/bin/bash"); // Execute the shell\n   return 0;\n}' > /rootshell.c

## Compile and enable setuid
RUN gcc /rootshell.c -o /rootshell
RUN chmod u+s /rootshell

# Stage 2: Create the final image
FROM ubuntu:latest

## Create a new user 'nonpriv' (uid 1000) without a password
## and a corresponding group, use the bash shell
RUN groupadd -g 1000 nonpriv && \
    useradd -m -u 1000 -g nonpriv -s /bin/bash nonpriv

## Copy the rootshell binary from the build stage
COPY --from=build_rootshell /rootshell /rootshell

## Set the default command to the regular bash shell
CMD ["/bin/bash"]

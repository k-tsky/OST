= Week 3
== Key takeaways
=== What is the difference of VM / Container?
A VM runs like a real computer with its own guest OS on a hypervisor. A container is an isolated user-space instance that shares the host OS/kernel.

=== How does docker work (container implementation)?
Docker packages software into containers. Containers are isolated with Linux mechanisms like network namespaces, cgroups, OverlayFS, seccomp profiles, and Linux capabilities.

==== Best practices
Keep images small and up to date, scan for vulnerabilities, do not expose the Docker daemon socket, do not run as root, limit capabilities/resources, and use read-only filesystems/volumes where possible.

=== What is docker-compose, and how to run multiple services
Docker Compose runs multiple containers together, for example services, clients, databases, or load balancers.

Define the services in a `docker-compose.yml`, then Docker Compose starts and connects them as one application setup.

== Containers and VMs
=== Virtualization
Creation of a virtual machine that acts like a real computer with an operating system. 

- *Host Machine:* machine where the virtualization software runs
- *Guest machine:* Virtual machine
- *Hypervisor:* Runs virtual machine
    - Type 1: bare metal e.g VMware ESXi
    - Type 2: hosted e.g VirtualBox
- Run a modified OS with Intel VT-x and AMD-V, or paravirtualized if not present (VM should not access memory directly)
- Needs to be the same architecture (otherwise needs to be emulated)
- Virtual Desktop Infrastructure (VDI)
- Containers
    - Isolated user-space instances
    - OS support: isolations

#align(center, image("img/virtualization.png", width: 80%))

=== VM vs Container
#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    `+` Reduced size of snapshots 2MB vs 67MB\
    `+` Quicker spinning up apps\
    `+/-` Available memory is shared\
    `+/-` Process-based isolation (share same kernel)

    Use Case: complex application setup, with container less complex configuration
    Providers: ECS, Google Cloud Run, Digital Ocean App Platform

  ],
  [
    `+` App can access all OS resources\
    `+` Live migrations\
    `+/-` Pre allocates memory\
    `+/-` Full isolation\

    Use Case: better hardware utilization / resource sharing
    Providers: EC2, Virtual Machines, Computer Engine, Droplets
  ],
)

=== Prices
Cloud VM pricing has several models:
- On-demand: Pay as you go for the VM plus related costs like data transfer and IP addresses.
- Spot instances: Cheaper, discounted compute capacity when providers have unused resources, but availability is less reliable.
- Reserved instances: Lower prices in exchange for committing to usage over a longer period.

Main takeaway: VM cost optimization requires regularly comparing providers and pricing models, since costs and resource bundles differ and can change over time.

=== Firecracker vs VirtualBox
Firecracker is a lightweight MicroVM with minimal devices, no BIOS/UEFI boot, very fast startup and low memory overhead.

VirtualBox is a full type 2 VM with broad device emulation, a normal BIOS/UEFI boot chain, slower startup and pre-allocated memory.

Main takeaway: Firecracker is optimized for speed and efficiency, VirtualBox is optimized for full VM functionality.

== Docker
=== Container Introduction
- *LXC (Linux Containers):* Lower abstraction level and direct use of Linux kernel features
- *systemd-nspawn:* Part of the systemd project, minimalist container manager
- *Solaris Zones:* Oracle/Sun-specific container technology
- *Linux-VServer:* Kernel patch for Linux, older virtualization technology
- *OpenVz:* Operating system-level virtualization, popular hosting tool
- *Singularity:* Scientifically oriented container solution, HPC-friendly
- *Podman:* Docker alternative / replacement
- *Docker:* / docker-compose for software development

=== Docker Introduction
- Docker is a containerization platform that packages software into containers (existing images can be found on docker hub)
- Containers are isolated from each other with linux-based isolation mechanisms, they only communicate over well-defined channels
    - Network namespaces
        - Each container gets its own network environment (e.g IP, port, interfaces)
    - Cgroups
        - Control how many resources a container can use (e.g CPU, RAM, disk I/O)
    - OverlayFS
        - Lets docker build images in layers
        - Container can share read-only image layers and add a small writable layer on top
    - Security
        - seccomp profiles
            - Restrict which linux system calls a container is allowed to use
        - Linux capabilities
            - Split root privileges into smaller permissions
- Docker can be used on macOS or Windows
    - WSL2 runs a lightweight linux VM, has better isolation than bare metal linux but I/O is slower

=== Docker Examples
- If no image version is specified, Docker uses the `latest` tag.
- Docker Hub is the main repository for container images.
- GUIs like Docker Desktop or Podman Desktop can also manage Docker.
\

- Install Docker and test it:
  - `docker run hello-world`

- List installed images:
  - `docker images`
  - `docker images -a`

- Remove an image:
  - `docker rmi hello-world`
  - `docker rmi <image-id>`

- Save and inspect an image:
  - `docker save hello-world -o test.tar`
  - `tar xf test.tar`
  - `tar xf <layer-id>/layer.tar`

- Run extracted program:
  - `./hello`

- List containers:
  - `docker ps -a`

- Remove a container:
  - `docker rm <container-id>`

=== Details
- Docker images use filesystem layers (FS Virtualization).
- OverlayFS combines multiple layers into one visible filesystem.

- Example Dockerfile:
  ```dockerfile
  FROM alpine
  ADD hello.sh .
  ENTRYPOINT ["sh", "hello.sh"]            
  ```

- Example script (hello.sh):
  ```sh
  #!/bin/sh
  echo "Hallo"
  ```

- Meaning:
  - `FROM alpine`: use Alpine Linux as the base image.
  - `ADD hello.sh .`: copy `hello.sh` into the image.
  - `ENTRYPOINT ["sh", "hello.sh"]`: run the script when the container starts.

- Example commands:
  - `docker build . -t test`
  - `docker run test`
  - `docker save test:latest > test.tar`

- The image has at least two layers:
  - Alpine base layer, including BusyBox, musl libc, crypto/ssl, etc.
  - New layer containing `hello.sh`.

- If the input does not change, Docker reuses the cached layer.

=== OverlayFS

OverlayFS is a Linux filesystem that shows multiple directories as one combined directory.

It has three main parts:

- *lowerdir:* the base layer. Usually read-only. In Docker, this is like the image layer.
- *upperdir:* the writable layer. New or changed files are stored here.
- *workdir:* a temporary working directory OverlayFS uses internally when moving or updating files.
- *overlay mount:* the final merged view that the user/container sees.

Example:
```sh
cd /tmp
mkdir lower upper workdir overlay

sudo mount -t overlay -o \
lowerdir=/tmp/lower,\
upperdir=/tmp/upper,\
workdir=/tmp/workdir \
none /tmp/overlay
```

`/tmp/overlay` becomes the mount point and shows the combined contents of lower and upper

If a file exists in lowerdir and you edit it, OverlayFS does not modify the read-only lower layer. Instead, it copies the file into upperdir and changes it there.

If you delete a file that exists only in lowerdir, OverlayFS cannot really delete it from the read-only layer. So it creates a marker in upperdir saying “this file is deleted.” The file then disappears from the merged overlay view.

You can also have multiple lower layers:\
`lowerdir=/tmp/lower1:/tmp/lower2 /tmp/overlay`

Main idea: OverlayFS lets Docker keep image layers read-only while storing container changes separately in a writable upper layer.

=== Cgroups
*Control Groups:* limits, isolates, prioritization of CPU, memory, disk I/O, network

Docker uses cgroups internally for container resource control.

- Example: create two CPU groups:
  ```sh
  cgcreate -g cpu:red
  cgcreate -g cpu:blue
  ```

- Assign different CPU weights:
  ```sh
  echo -n "20" > /sys/fs/cgroup/blue/cpu.weight
  echo -n "80" > /sys/fs/cgroup/red/cpu.weight
  ```

- Run shells inside the groups:
  ```sh
  cgexec -g cpu:blue bash
  cgexec -g cpu:red bash
  ```

- Test CPU competition on one core:
  ```sh
  taskset -c 0 sha256sum /dev/urandom
  ```

- Docker example:
  ```sh
  docker run --name=low_prio --cpuset-cpus=0 --cpu-shares=20 alpine sha256sum /dev/urandom
  docker run --name=high_prio --cpuset-cpus=0 --cpu-shares=80 alpine sha256sum /dev/urandom
  ```

Main idea: cgroups let Linux and Docker isolate, limit, and prioritize resources between processes or containers.

=== Separate networks
Linux network namespaces provide isolation of the system resources associated with networking.

Create a namespace:
```sh
ip netns add testnet
ip netns list
```

Create a virtual Ethernet pair between host and namespace:
```sh
ip link add veth0 type veth peer name veth1 netns testnet
ip link list
```
Run commands inside the namespace:
```sh
ip netns exec testnet <cmd>
```

Configure IP addresses and enable interfaces:
```sh
ip addr add 10.1.1.1/24 dev veth0
ip netns exec testnet ip addr add 10.1.1.2/24 dev veth1
ip link set dev veth0 up
ip netns exec testnet ip link set dev veth1 up
```

Run a server inside the namespace:
```sh
ip netns exec testnet nc -l -p 8000
```

Connect the namespace to the outside network:
```sh
echo 1 > /proc/sys/net/ipv4/ip_forward
ip netns exec testnet ip route add default via 10.1.1.1 dev veth1
iptables -t nat -A POSTROUTING -s 10.1.1.0/24 -o enp6s0 -j MASQUERADE
iptables -A FORWARD -j ACCEPT
```
Main idea: network namespaces give containers separate network environments while still allowing controlled communication with the host or internet.

=== Connectivity, Security and Robustness
- *NAT (Network Address Translation):* Multiple devices share one public IP -> devices are not directly reachable
- *Hole punching:* Two peers behind NAT send coordinated packets to create NAT mappings, enabling a direct connection
    - P2P / Hole Punching development (in the old days)
    - Currently: network namespaces

==== P2P System
- *veth*: Virtual Ethernet Device, like a virtual network cable between namespaces.
- Used to build a local P2P testbed with peers that are reachable or hidden behind NAT.
- Example setup: global namespace `10.0.2.15`, router/NAT `10.0.2.16` and `172.20.0.1`, unreachable peers `172.20.0.2` and `172.20.0.3`.

- Create namespace, veth pair, and router interface:
  - `unr` is the isolated network namespace for the unreachable peer side.
  - `nat_lan` and `nat_wan` are two ends of one virtual Ethernet cable.
  - `nat_lan` is moved into `unr`, while `nat_wan` stays in the global namespace.

#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    ```sh
    ip netns add unr
    ip netns list

    ip link add nat_lan type veth peer name nat_wan
    ip link set nat_lan netns unr

    ip address add 10.0.2.16/24 dev nat_wan
    ip link set nat_wan up

    ifconfig
    ping <ip>

    ip netns exec unr ip address add 172.20.0.1/24 dev nat_lan
    ip netns exec unr ip link set nat_lan up
    ```
  ],
  [
    #align(center, image("img/p2p.png", width: 100%))
  ],
)
\



#grid(
  columns: (auto, auto),
  gutter: 2em,
  [
    - Add unreachable peer interface and routes:
    - `unr1` is a dummy interface that represents an unreachable peer inside the namespace.
    - `172.20.0.2` is the peer IP, while `172.20.0.1` is the router/gateway inside `unr`.
    - The loopback interface `lo` is enabled because many programs expect localhost to exist.
    - The route commands tell traffic how to leave the namespace and how the host can reach the namespace network.
    ```sh
    ip netns exec unr ip link add unr1 type dummy
    ip netns exec unr ip address add 172.20.0.2/24 dev unr1
    ip netns exec unr ip link set unr1 up

    ip netns exec unr ifconfig

    ip netns exec unr ip link set lo up
    ip netns exec unr route add default gw 172.20.0.1

    ip route add 172.20.0.1 dev nat_wan
    ```
  ],
  [
    #align(center, image("img/unreachable-peers.png", width: 100%))
  ],
)

Main idea: network namespaces and veth pairs can simulate real P2P/NAT situations on one machine.

=== Docker Compose
Dockerfiles build individual container images. Docker Compose runs multiple containers together as one application setup.

- Dockerfile:
  - Used to build your own image.
  - Keep images small by only copying required files.
  - Docker caches layers aggressively, so unchanged steps are reused.
  - Squash images: `COPY --from=initial / /`

- Example multi-stage Dockerfile:
  ```dockerfile
  FROM golang:alpine AS builder
  WORKDIR /build
  COPY server.go .
  RUN go build server.go

  FROM alpine
  WORKDIR /app
  COPY --from=builder /build/server .
  ENTRYPOINT ["./server"]
  ```

- Meaning:
  - First stage `builder`: contains Go and builds the binary.
  - Second stage `alpine`: small final runtime image.
  - `COPY --from=builder`: copies only the compiled binary into the final image.

- Docker Compose:
  - Used to deploy multiple containers, e.g. server, client, database, load balancer.
  - Configures services in one `docker-compose.yml`.
  - Provides lightweight orchestration, e.g. starting services that depend on others.

- Example `docker-compose.yml`:
  ```yaml
  services:
    server1:
      build: .
    client:
      image: alpine
      entrypoint: >
        sh -c "sleep 3 && echo hallo | nc server1 8081"
  ```

- Meaning:
  - `server1` is built from the local Dockerfile.
  - `client` uses the Alpine image.
  - The client waits briefly, then sends `hallo` to `server1` on port `8081`.

Main idea: Dockerfiles define images. Docker Compose defines how multiple containers are started and connected.

=== Docker Security
Best Practices:
- Keep images small, up to date / attack surface
  - *alpine / distroless:* Alpine is preferred because it creates very small, minimal Docker images that are faster to transfer, have fewer unnecessary packages and usually a smaller security surface.
- Check your image for vulnerabilities, snyk, trivy
- Do not expose the Docker daemon socket (even to containers)
- Set a user - do not run as root
  - Needs more configuration but good advice
- Limit capabilities (grant only what is needed by a container) -> seems overkill
- Limit resources (memory, CPU, file descriptors, processes, restarts)
  - Good for production -> docker does not have a hard memory limit. Docker kills process that goes over limit, no pressure for GC if not docker aware
- Set file system and volumes to read-only

=== How to debug
What is your base image:
  + Ubuntu, Debian, Alpine, distroless etc.
  + GNU libc (e.g distroless) vs. musl (e.g alpine)
    - Glibc (GNU C library): wide adaptation, many distros use it, larger binary
    - Musl (small C standard library): less used, smaller binary
    - If glibc is needed in alpine then a compatible busybox docker image or installing gcompat can help
    - Building outside docker container might fail because of missing libraries etc.
\
Alpine Tools:
- Busybox: nc, ping, sha256sum, wget, netstat
- Reach other container: ping containername
- Service bound to localhost? Cannot run outside docker, use 0.0.0.0

Other stuff:
- docker system prune -a (attention)
  - Deletes unused docker data to free disk space (stopped containers, unused networks, unused images, build cache)
- Check logfiles
- Performance: multi-stage, .dockerignore
- Docker: aggressive caching - wget is cached, use version numbers



#!/usr/bin/env sh

### https://www.redhat.com/sysadmin/podman-inside-container

set -xe

rootfulPodman_rootfulPodman_privilege() {
sudo podman run \
  --privileged \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8 \
      echo hello
}
#rootfulPodman_rootfulPodman_privilege

rootfulPodman_rootlessPodman_privilege() {
sudo podman run \
  --user podman \
  --privileged \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8 \
      echo hello
}
#rootfulPodman_rootlessPodman_privilege

rootfulDocker_rootlessPodman_privilege() {
sudo docker run \
  --privileged \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8 \
      echo hello
}
#rootfulDocker_rootlessPodman_privilege

rootlessDocker_rootlessPodman_privilege() {
sudo docker run \
  --user podman \
  --privileged \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8 \
      echo hello
}
#rootlessDocker_rootlessPodman_privilege



rootfulPodman_rootfulPodman_noPrivilege() {
	### NOTE
	### Error: OCI runtime error: crun: mount_setattr `/sys`: Function not implemented
sudo podman run \
  --cap-add=sys_admin,mknod \
  --device=/dev/fuse \
  --security-opt label=disable \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8-minimal \
      echo hello
}
#rootfulPodman_rootfulPodman_noPrivilege

rootfulDocker_rootfulPodman_noPrivilege() {
	### NOTE
	### Error: mount /home/podman/.local/share/containers/storage/overlay:/home/podman/.local/share/containers/storage/overlay, flags: 0x1000: permission denied
sudo docker run \
  --cap-add=sys_admin \
  --cap-add mknod \
  --device=/dev/fuse \
  --security-opt seccomp=unconfined \
  --security-opt label=disable \
  -v ./mycontainers:/var/lib/containers \
  quay.io/podman/stable \
    podman run ubi8-minimal \
      echo hello
#  --security-opt seccomp=/usr/share/containers/seccomp.json
}
#rootfulDocker_rootfulPodman_noPrivilege

rootfulPodman_rootlessPodman_noPrivilege() {
	### NOTE
	### Error: mount /home/podman/.local/share/containers/storage/overlay:/home/podman/.local/share/containers/storage/overlay, flags: 0x1000: permission denied
sudo podman run \
  --user podman \
  --security-opt label=disable \
  --security-opt unmask=ALL \
  --device /dev/fuse \
  -ti \
  quay.io/podman/stable \
    podman run -ti docker.io/busybox \
      echo hello
}
#rootfulPodman_rootlessPodman_noPrivilege



podman_leaked_socket() {
	### NOTE ???
#sudo podman run -v /run:/run --security-opt label=disable quay.io/podman/stable podman --remote run busybox echo hi

sudo /bin/podman run \
  --security-opt=label=disable \
  -v /run/podman:/run/podman \
  quay.io/podman/stable \
    podman --remote run alpine \
      echo hi
}
#podman_leaked_socket

docker_leaked_socket() {
	### NOTE ???
sudo docker run \
  -v /run:/run \
  --security-opt label=disable \
  quay.io/podman/stable \
    podman --remote run busybox \
      echo hi
}
#docker_leaked_socket




rootlessPodman_rootfulPodman_Privilege() {
podman run \
  --privileged \
  quay.io/podman/stable \
    podman run ubi8 \
      echo hello
}
#rootlessPodman_rootfulPodman_Privilege

rootlessPodman_rootlessPodman_noPrivilege() {
podman run \
  --security-opt label=disable \
  --user podman \
  --device /dev/fuse \
  quay.io/podman/stable \
    podman run alpine \
      echo hello
}
rootlessPodman_rootlessPodman_noPrivilege


# inception

## Useful resources

### Docker

#### Volumes

- https://devopsheaven.com/docker/docker-compose/volumes/2018/01/16/volumes-in-docker-compose.html

- https://docs.docker.com/storage/volumes/#use-a-volume-with-docker-compose

- https://docs.docker.com/compose/compose-file/compose-file-v3/#volume-configuration-reference

#### Healthcheck

- https://stackoverflow.com/questions/42737957/how-to-view-docker-compose-healthcheck-logs

### SSL

- https://stackoverflow.com/questions/10175812/how-to-generate-a-self-signed-ssl-certificate-using-openssl

- https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm#Usingthe-subjSwitch

- https://www.shellhacks.com/create-csr-openssl-without-prompt-non-interactive/

### Alpine

- [Official repository](https://pkgs.alpinelinux.org/packages)

### Debian

- [Official repository](https://www.debian.org/distrib/packages#search_packages)

## Things to know

### Debian

---

### ⚠️ This section is deprecated ⚠️

You should use `docker compose` over `docker-compose`. See [here](https://github.com/docker/compose#about-update-and-backward-compatibility) for more information.

---

If you are running Debian on your host machine, be aware that the version of docker-compose available in the official repository is incredibly outdated (v1.25.0-rc1, may 2019). You can however download a more recent release at their [GitHub repository](https://github.com/docker/compose/releases). For example:

```sh
# as root
# for dependencies and stuff like shell completion
apt install --reinstall docker-compose

# as root
# download docker-compose v2.6.1 for Linux on amd64 hardware
curl -fL -o /usr/bin/docker-compose 'https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64'

# as root
# make binary executable
chmod +x /usr/bin/docker-compose
```

### Docker

The `HEALTHCHECK` instruction checks whether a container is healthy (e.g. ready to operate) every x time.
However, it does **not** stop once the container is healthy, and continues to check as long as it is alive.

### VirtualBox

Kernel >= 5.18 is currently not supported. However a patch is available for
5.18 and 5.19. Happy compilation.

https://www.virtualbox.org/ticket/20914

https://www.virtualbox.org/ticket/20930

### Busybox (maybe not)

When executing a file with a relative or absolute path and the return code is
127, with a message saying that the file does not exist even though it exists
(i.e. `sh: ./cadvisor: not found`), that means you are probably missing a
dynamic library. To display the binary's dynamic dependencies, you need the
`readelf` command (alpine: `apk add binutils`, debian: `apt install binutils-common`).
Then, run `readelf -d <binary>`. The result should look like this:

```
Dynamic section at offset 0x19c3df8 contains 26 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x000000000000000c (INIT)               0x403000
 0x000000000000000d (FINI)               0x10ce8f4
 0x0000000000000019 (INIT_ARRAY)         0x1dc4de8
 0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
 0x000000000000001a (FINI_ARRAY)         0x1dc4df0
 0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
 0x000000006ffffef5 (GNU_HASH)           0x4003a8
 0x0000000000000005 (STRTAB)             0x4015e0
 0x0000000000000006 (SYMTAB)             0x400758
 0x000000000000000a (STRSZ)              2700 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000000000015 (DEBUG)              0x0
 0x0000000000000003 (PLTGOT)             0x1dc5000
 0x0000000000000002 (PLTRELSZ)           1152 (bytes)
 0x0000000000000014 (PLTREL)             RELA
 0x0000000000000017 (JMPREL)             0x402270
 0x0000000000000007 (RELA)               0x402228
 0x0000000000000008 (RELASZ)             72 (bytes)
 0x0000000000000009 (RELAENT)            24 (bytes)
 0x000000006ffffffe (VERNEED)            0x4021a8
 0x000000006fffffff (VERNEEDNUM)         3
 0x000000006ffffff0 (VERSYM)             0x40206c
 0x0000000000000000 (NULL)               0x0
```

What we are looking for is at the beginning of the output:
```
 0x0000000000000001 (NEEDED)             Shared library: [libdl.so.2]
 0x0000000000000001 (NEEDED)             Shared library: [libpthread.so.0]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
```

Then, search for the missing files at your distribution's package repository
([here](https://pkgs.alpinelinux.org/contents) for alpine, [here](https://www.debian.org/distrib/packages#search_contents) for debian. In this example, the package `libc6-compat` (alpine) was missing.

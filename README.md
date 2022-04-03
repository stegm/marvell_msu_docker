# Marvell RAID MSU Utility docker 

Docker environment for running Marvell MSU Utility for RAID controllers on none rpm-based distros.

Supports the following controllers:
* Marvell Technology Group Ltd. 88SE9230 PCIe SATA 6Gb/s Controller (HPE ProLiant Microserver Gen10)

## Getting Started

## Prerequisites

* Docker
* Docker Compose
* [Marvell Storage Utility for Linux 4.1.10.2046](https://support.lenovo.com/ca/en/downloads/ds539334-marvell-storage-utility-for-linux-for-linux) - place it in the same directory as the `Dockerfile`.

TIP: build will try to automatically download from Lenovo, if something goes wrong (see above)
```
wget https://download.lenovo.com/servers/mig/2019/04/11/19912/mrvl_utl_msu_4.1.10.2046_linux_x86-64.tgz
```

## Installing

```sh
cd <repository root>
docker-compose build
docker-compose up -d
```

After the container is started you can access the web UI on port 8845. The default user and password is *root*.

Alternatively the CLI can be startet with

```sh
docker-compose run --rm msu cli
CLI Version: 4.1.0.30   RaidAPI Version: 5.0.0.1067
Welcome to RAID Command Line Interface.

> info -o vd
```



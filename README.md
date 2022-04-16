# Marvell RAID MSU Utility docker 

Docker environment for running Marvell MSU Utility for RAID controllers on none rpm-based distros.

Supports the following controllers:
* Marvell Technology Group Ltd. 88SE9230 PCIe SATA 6Gb/s Controller (HPE ProLiant Microserver Gen10)

## Getting Started

## Prerequisites

* Docker
* Docker Compose

Build will try to automatically download Marvell package from Lenovo, if you prefer to download it on your own, place the file from 
[Marvell Storage Utility for Linux 4.1.10.2046](https://support.lenovo.com/ca/en/downloads/ds539334-marvell-storage-utility-for-linux-for-linux) 
in the same directory as the `Dockerfile`. You also have to change the Dockerfile (see comments).

Example: 

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

SG driver version 3.5.36.
CLI Version: 4.1.10.42   RaidAPI Version: 2.3.10.1088
Welcome to RAID Command Line Interface.

> info -o vd
```



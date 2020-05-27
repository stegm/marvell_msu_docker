# Marvell RAID MSU Utility docker 

Docker environment for running Marvell MSU Utility for RAID controllers on none rpm-based distros.

Supports the following controllers:
* Marvell Technology Group Ltd. 88SE9230 PCIe SATA 6Gb/s Controller (HPE ProLiant Microserver Gen10)

## Getting Started

## Prerequisites

* Docker
* Docker Compose
* [Marvell_MSU_Linux_v4.1.0.2032.zip](https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_3ce9cf24154740bba3095eecff) - place it in the same directory as the `Dockerfile`.

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



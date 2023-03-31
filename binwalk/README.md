# Binwalk from [ReFirmLabs](https://github.com/ReFirmLabs/binwalk)

## Build
```
docker build . -t binwalk:2.3.4
```

## Run

Specify the folder containing the binary as the volume mountpoint and the binary filename as an argument for binwalk.

In this example, a folder under `~/bins` contains the file `Encrypted.tar.xz.gpg` which will be scanned for entropy, logged in CSV format, and graphed:

```
docker run -v ~/bins:/bins binwalk:2.3.4 "-E" "-J" "-f=binwalk.csv" "-c" "Encrypted.tar.xz.gpg"
```

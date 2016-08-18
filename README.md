# mtneug/timemachine

[![](https://images.microbadger.com/badges/version/mtneug/timemachine.svg)](https://hub.docker.com/r/mtneug/timemachine/) [![](https://images.microbadger.com/badges/image/mtneug/timemachine.svg)](http://microbadger.com/images/mtneug/timemachine)

A docker container to compile the latest version of Netatalk in order to run a Time Machine server.

## Installation

To download the docker container and execute it, simply run:

```sh
$ docker run \
    -d \
    --name timemachine \
    -h timemachine \
    -p 548:548 \
    -p 636:636 \
    -e AFP_LOGIN=<YOUR_USER> \
    -e AFP_PASSWORD=<YOUR_PASS> \
    -e AFP_NAME=<TIME_MACHINE_NAME> \
    -e AFP_SIZE_LIMIT=<MAX_SIZE_IN_MB> \
    -v /route/to/your/timemachine:/timemachine \
    mtneug/timemachine
```

If you don't want to specify the maximum volume size (and use all the space available), you can omit the `-e AFP_SIZE_LIMIT=<MAX_SIZE_IN_MB>` variable.

## Contributors

* Óscar de Arriba (odarriba@gmail.com)
* Daniel Iñigo (demil133@gmail.com)
* Josef Friedrich ([@Josef-Friedrich](https://github.com/Josef-Friedrich))
* Matthias Neugebauer

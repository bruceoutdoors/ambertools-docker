FROM debian:10 as builder

# take https://ambermd.org/InstDebian.php
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
                       tcsh make lbzip2 cmake \
                       gcc gfortran g++ \
                       flex bison patch bc \
                       libbz2-dev libzip-dev \
                       xorg-dev ca-certificates wget \
                       mpich openssh-client && \
    apt-get clean

COPY ./AmberTools21.tar.bz2 .

RUN tar -xf "AmberTools21".tar.bz2 && \
    rm "AmberTools21".tar.bz2 && \
    cd /amber20_src/build && \
    ./run_cmake && \
    make install && \
    rm -rf /amber20_src/

FROM debian:10
COPY --from=builder /amber20 /amber20

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                       tcsh bc xorg mpich && \
    apt-get clean


CMD ["bin/bash", "-c", "source /amber20/amber.sh && cd /md && /bin/bash"]

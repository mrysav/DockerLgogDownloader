FROM debian:latest

RUN apt-get update && apt-get install -y build-essential libcurl4-openssl-dev libboost-regex-dev \
libjsoncpp-dev librhash-dev libtinyxml2-dev libhtmlcxx-dev \
libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
libboost-date-time-dev libboost-iostreams-dev help2man cmake libssl-dev \
pkg-config zlib1g-dev qtwebengine5-dev

COPY lgogdownloader/ /lgogdownloader/
WORKDIR /lgogdownloader/build

RUN cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=. -DCMAKE_BUILD_TYPE=Release
RUN make

FROM debian:latest
WORKDIR /lgogdownloader
COPY --from=0 /lgogdownloader/build/lgogdownloader .
CMD ["./lgogdownloader"]
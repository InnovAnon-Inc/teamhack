FROM kalilinux/kali-rolling as build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt full-upgrade -y            \
    --no-install-recommends

RUN apt install      -y            \
    --no-install-recommends        \
    autoconf                       \
    automake                       \
    autotools-dev                  \
    build-essential                \
    ca-certificates                \
    ethtool                        \
    git                            \
    hostapd                        \
    iw                             \
    libcmocka-dev                  \
    libhwloc-dev                   \
    libnl-3-dev                    \
    libnl-genl-3-dev               \
    libpcap-dev                    \
    libpcre2-dev                   \
    libsqlite3-dev                 \
    libssl-dev                     \
    libtool                        \
    pkg-config                     \
    rfkill                         \
    screen                         \
    shtool                         \
    tcpdump                        \
    usbutils                       \
    wpasupplicant                  \
    zlib1g-dev

RUN apt autoremove   -y            \
    --purge                        \
&&  apt clean        -y            \
&&  rm -rf /var/lib/apt/lists/*

RUN git clone                                      \
    --depth=1                                      \
    --recursive                                    \
    https://github.com/aircrack-ng/aircrack-ng.git

WORKDIR /aircrack-ng

#RUN find . -type f -exec sed -i 's@-O3@-Ofast@g' '{}' +

ENV CFLAGS="-fprofile-generate=/var/teamhack/prof/aircrack-ng.prof -fprofile-abs-path -fuse-linker-plugin -flto -march=native -mfpmath=sse+387 -momit-leaf-frame-pointer -mtune=native -Ofast -g0 -fmerge-all-constants -fomit-frame-pointer"

ENV LDFLAGS="-fprofile-generate=/var/teamhack/prof/aircrack-ng.prof -fprofile-abs-path -fuse-linker-plugin -flto -lgcov"

RUN autoreconf -fi
RUN ./configure    \
  --without-opt    \
  --disable-shared \
  --enable-static  \
  --with-static-simd=x86-avx
#x86-sse2
#x86-avx2
#x86-avx512
RUN make
RUN make install-strip

FROM scratch
COPY --from=build /usr/bin/aircrack-ng /usr/bin/
COPY --from=build                                  \
  /lib/x86_64-linux-gnu/libaircrack-osdep-1.7.0.so \
  /lib/x86_64-linux-gnu/libcrypto.so.3             \
  /lib/x86_64-linux-gnu/libbsd.so.0                \
  /lib/x86_64-linux-gnu/libstdc++.so.6             \
  /lib/x86_64-linux-gnu/libgcc_s.so.1              \
  /lib/x86_64-linux-gnu/libc.so.6                  \
  /lib/x86_64-linux-gnu/libnl-3.so.200             \
  /lib/x86_64-linux-gnu/libnl-genl-3.so.200        \
  /lib/x86_64-linux-gnu/libmd.so.0A                \
  /lib/x86_64-linux-gnu/libm.so.6                  \
  /lib/x86_64-linux-gnu/
COPY --from=build                                  \
  /lib64/ld-linux-x86-64.so.2                      \
  /lib64/

WORKDIR  /var/teamhack
VOLUME ["/var/teamhack/caps"]
VOLUME ["/var/teamhack/prof"]
VOLUME ["/var/teamhack/psks"]
VOLUME ["/var/teamhack/wordlists"]
ENTRYPOINT [                                        \
  "/usr/bin/aircrack-ng"                            \
]


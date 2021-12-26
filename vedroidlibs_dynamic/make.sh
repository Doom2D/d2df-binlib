#!/bin/sh

set -e
base="$(cd "$(dirname "$0")"; pwd)"

# armeabi-v7a-hard removed since NDK r12
# but builds it and Crystax NDK such code into armeabi-v7a -_-

if ! [ -d "$base/SDL2" ]; then
  echo "!!! Directory 'SDL2' not found."
  echo "!!! Download SDL2 2.0.7 and unpack it."
  echo "!!! http://libsdl.org/release/SDL2-2.0.7.tar.gz"
  exit 1
fi

if ! [ -d "$base/SDL2_mixer" ]; then
  echo "!!! Directory 'SDL2_mixer' not found."
  echo "!!! Download SDL2_mixer 2.0.4 and unpack it."
  echo "!!! http://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz"
  exit 1
fi

if ! [ -d "$base/enet" ]; then
  echo "!!! Directory 'enet' not found."
  echo "!!! Download enet 1.3.17 and unpack it."
  echo "!!! http://enet.bespin.org/download/enet-1.3.17.tar.gz"
  exit 1
fi

if ! [ -d "$base/miniupnpc" ]; then
  echo "!!! Directory 'miniupnpc' not found."
  echo "!!! Download miniupnpc 2.2.3 and unpack it."
  echo "!!! http://miniupnp.free.fr/files/download.php?file=miniupnpc-2.2.3.tar.gz"
  exit 1
fi

if ! command -v ndk-build 2>&1 >/dev/null; then
  echo "!!! Command 'ndk-build' not found"
  echo "!!! Download Crystax NDK 10.3.2 and install it."
  echo "!!! https://www.crystax.net/download/crystax-ndk-10.3.2-linux-x86.tar.xz"
  echo "!!! https://www.crystax.net/download/crystax-ndk-10.3.2-linux-x86_64.tar.xz"
  exit 1
fi

cp AndroidEnet.mk enet/Android.mk
cp AndroidUPNP.mk miniupnpc/Android.mk
mkdir -p miniupnpc/android
cat <<'END' > miniupnpc/android/miniupnpcstrings.h
#ifndef MINIUPNPCSTRINGS_H_INCLUDED
#define MINIUPNPCSTRINGS_H_INCLUDED
#define OS_STRING "Android"
#define MINIUPNPC_VERSION_STRING "2.2.3"
#define UPNP_VERSION_STRING "UPnP/1.1"
#endif
END

# APP_ABI="armeabi armeabi-v7a arm64-v8a mips mips64 x86 x86_64" \

# -DHAVE_STDINT_H fixes modplug
ndk-build -j12 clean all \
  APP_BUILD_SCRIPT=Android.mk \
  NDK_PROJECT_PATH=. \
  APP_CFLAGS=-DHAVE_STDINT_H \
  APP_STL=gnustl_static \
  APP_ABI="armeabi armeabi-v7a arm64-v8a mips x86 x86_64" \
  APP_PLATFORM=android-14 \
  NDK_TOOLCHAIN_VERSION=5 "$@"

rm -f enet/Android.mk miniupnpc/Android.mk miniupnpc/android/miniupnpcstrings.h 
rm -rf miniupnpc/android

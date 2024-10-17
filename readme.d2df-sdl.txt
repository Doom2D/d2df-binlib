Static Linking
--------------

See ( http://repo.or.cz/d2df-binlib.git ) repo for prebuilt dynamic and static
libraries.

It is now possible to link windoze LibJIT and ENet as static libs.

First, you need to clone ( http://repo.or.cz/d2df-binlib.git ).
Then, you can use:
  -dLIBJIT_WINDOZE_STATIC       -- static LibJIT
  -dLIBENET_WINDOZE_STATIC      -- static ENet
  -dLIBMINIUPNPC_WINDOZE_STATIC -- static MiniUPNPC
  -dVORBIS_WINDOZE_STATIC       -- static libogg/libvorbis (only in AL builds)
  -dOPUS_WINDOZE_STATIC         -- static libogg/libopus (only in AL builds)

Don't forget to specify lib*.a location with -Fi<...>

I (ketmar) used mingw-gcc 7.1.0 to build static libs; some other .a libs were
taken directly from mingw. building libs is easy: just fire msys, install all
dependencies, and do:

  ./configure --enable-static --disable-shared && make

This should produce working .a library suitable for static linking.

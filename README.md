# cmake-haskell

A simple skeleton for building Haskell files using CMake. Original version by
[arrowdodger](https://github.com/arrowdodger), but since rewritten several times.

## Examples

Preliminary for building out of tree:
```
$ cd /path/to/repo
$ rm -rf build
$ mkdir build
$ cd build/
```

Using `make` makefiles:
```
$ cmake -G"Unix Makefiles" ..
-- Check for working Haskell compiler: C:/Program Files (x86)/Haskell Platform/2013.2.0.0/bin/ghc.exe
-- Check for working Haskell compiler: C:/Program Files (x86)/Haskell Platform/2013.2.0.0/bin/ghc.exe -- works
-- Configuring done
-- Generating done
-- Build files have been written to: Z:/git/cmake-haskell/build
$ make
Scanning dependencies of target Hello
[100%] Building Haskell object CMakeFiles/Hello.dir/Main.hs.o
Linking Haskell executable Hello.exe
[100%] Built target Hello
```

Using `ninja` makefiles:
```
$ cmake -G"Ninja" ..
-- Check for working Haskell compiler using: Ninja
-- Check for working Haskell compiler using: Ninja -- works
-- Configuring done
-- Generating done
-- Build files have been written to: Z:/git/cmake-haskell/build
$ ninja
[1/2] Building Haskell object CMakeFiles\Hello.dir\Main.hs.o
[2/2] Linking Haskell executable Hello.exe
```

## License

Licensed under BSD3. See `LICENSE` for more information.


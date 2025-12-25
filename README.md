# DSnake
An overly complicated snake made in D programming language using bindbc-sdl library with SDL2!

## Controls
- WASD/Arrows to move
- Enter to select
- Esc to quit

## Compilation

NOTE: I use MSYS2 with make and dub to build the game. MSYS2 and make are not necessary but run the commands I need and makes it a little easier to compile. The project uses the latest SDL2 DLLs available from UCRT64 packages.

You could as well just get precompiled DLLs in SDL2 releases.

### Prerequisites:
- D compiler (DMD, LDC, or GDC)
- DUB
- SDL2 libraries

### Build using Make: 
- Run `make all` to compile
- Run `make clean` to clear the cache
- Run `make test` to compile and run the game

If you are not using MSYS2, you'd also like to get the DLLs and put them into bin/.

Though, if you are using MSYS2 then:
Install following packages:
- `pacman -S mingw-w64-ucrt-x86_64-SDL2`
- `pacman -S mingw-w64-ucrt-x86_64-SDL2_image`
- `pacman -S mingw-w64-ucrt-x86_64-SDL2_mixer`
- `pacman -S mingw-w64-ucrt-x86_64-SDL2_ttf`

### Build using DUB: 
- Run `dub build --cache=local` to compile
- Run `dub clean` to clear the cache
- Don't forget to put the DLLs in!

Compiled game files will appear in bin/. Put the DLLs there.

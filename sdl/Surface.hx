package sdl;

@:native("SDL_Surface")
@:include('./linc_sdl.h')
extern private class SDL_Surface {}
typedef Surface = cpp.Pointer<SDL_Surface>;

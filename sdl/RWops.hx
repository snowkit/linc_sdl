package sdl;

@:native("SDL_RWops")
@:include('linc_sdl.h')
extern private class SDL_RWops {}
typedef RWops = cpp.Pointer<SDL_RWops>;

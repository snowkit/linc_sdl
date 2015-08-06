package sdl;

@:native("SDL_Window")
@:include('linc_sdl.h')
extern private class SDL_Window {}
typedef Window = cpp.Pointer<SDL_Window>;

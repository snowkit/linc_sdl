package sdl;

@:native("SDL_Window")
@:include('./snowkit_sdl.h')
extern private class SDL_Window {}
typedef Window = cpp.Pointer<SDL_Window>;

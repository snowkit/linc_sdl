package sdl;

@:native("SDL_Renderer")
@:include('./native_sdl.h')
extern private class SDL_Renderer {}
typedef Renderer = cpp.Pointer<SDL_Renderer>;

package sdl;

@:native("SDL_Renderer")
@:include('linc_sdl.h')
extern private class SDL_Renderer {}
typedef Renderer = cpp.RawPointer<SDL_Renderer>;

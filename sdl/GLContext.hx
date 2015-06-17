package sdl;

@:native("SDL_GLContext")
@:include('./native_sdl.h')
extern private class SDL_GLContext {}
typedef GLContext = cpp.Pointer<SDL_GLContext>;

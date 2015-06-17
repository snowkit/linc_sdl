package sdl;

@:native("SDL_Cursor")
@:include('./native_sdl.h')
extern private class SDL_Cursor {}
typedef Cursor = cpp.Pointer<SDL_Cursor>;

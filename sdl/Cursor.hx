package sdl;

@:native("SDL_Cursor")
@:include('./linc_sdl.h')
extern private class SDL_Cursor {}
typedef Cursor = cpp.Pointer<SDL_Cursor>;

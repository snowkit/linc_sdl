package sdl;

@:native("SDL_RWops")
@:include('linc_sdl.h')
private extern class SDLRWops {}
typedef RWops = cpp.Pointer<SDLRWops>;

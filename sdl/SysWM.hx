package sdl;

@:keep
@:include('linc_sdl_aux.h')
@:native("SDL_SysWMinfo")
private extern class SDLSysWMinfo {}
typedef SysWMinfo = cpp.Pointer<SDLSysWMinfo>;

@:keep
private extern class SysWM {}
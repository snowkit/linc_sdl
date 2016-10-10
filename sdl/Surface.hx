package sdl;

@:native("SDL_Surface")
@:include('linc_sdl.h')
@:structAccess
extern private class SDL_Surface {
    var w : Int;
    var h : Int;
    var pitch : Int;
}
typedef Surface = cpp.Pointer<SDL_Surface>;

package sdl;

@:unreflective
@:native("SDL_GLContext")
@:include('linc_sdl.h')
extern class GLContext {
    inline function isnull():Bool return this == untyped 0;
}

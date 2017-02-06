# linc/SDL
Haxe/hxcpp @:native bindings for [SDL](https://wiki.libsdl.org/).

This is a [linc](http://snowkit.github.io/linc/) library.

---

This library works with the Haxe cpp target only.

---
### Install

`haxelib git linc_sdl https://github.com/snowkit/linc_sdl.git`

If you run into SDL build errors first try:

- Get the path of the library `haxelib path linc_sdl`
- Change directory to that path `cd <path to linc_sdl>`
- `git submodule update --init`

### Example usage

See test/Test.hx

Be sure to read the SDL documentation
https://wiki.libsdl.org/

```haxe
import sdl.SDL;
import sdl.Window;
import sdl.Renderer;

class Example {

    static var state : { window:Window, renderer:Renderer };

    //Haxe entry point
    static function main() {

        SDL.init(SDL_INIT_VIDEO | SDL_INIT_EVENTS);
        state = SDL.createWindowAndRenderer(320, 320, SDL_WINDOW_RESIZABLE);
 
        while(update()) {
            SDL.delay(4);
        }
    }

    static function update() {
        while(SDL.hasAnEvent()) {

            var e = SDL.pollEvent();
            if(e.type == SDL_QUIT) return false;

            SDL.setRenderDrawColor(state.renderer, 255, 255, 255, 255);
            SDL.renderClear(state.renderer);
            SDL.renderPresent(state.renderer);
        }
        
        return true;
    }

}
```

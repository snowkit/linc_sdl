
import sdl.SDL;

class Test {

    var s = '1'; //ignore

    static var state : { window:Window, renderer:Renderer };

    static function main() {

        init();
        versions();

            SDL.setRenderDrawColor(state.renderer, 255,255,255,255);

            SDL.renderClear(state.renderer);

            SDL.setRenderDrawColor(state.renderer, 246, 0, 123, 255);

            SDL.renderDrawLine(state.renderer, 0, 0, 320, 320);

            SDL.renderPresent(state.renderer);

            Sys.sleep(3);

        cleanup();

    }

    static function init() {
        SDL.init(SDL_INIT_VIDEO);
        state = SDL.createWindowAndRenderer(320, 320, SDL_WINDOW_RESIZABLE);

        //note this doesn't land in stdout specifically,
        //so in some apps this is delivered when closing
        //rather than "inline". If run from a terminal or with
        //mixed/redirected std io, it would be ordered.
        SDL.log('init');
    }

    static function versions() {
        //https://wiki.libsdl.org/SDL_GetVersion#Code_Examples

        var compiled = SDL.VERSION();
        var linked = SDL.getVersion();

        trace('We compiled against SDL version ${compiled.major}.${compiled.minor}.${compiled.patch} ...');
        trace('But we are linking against SDL version ${linked.major}.${linked.minor}.${linked.patch}');

        trace('Compile revision : ' + SDL.REVISION() );
        trace('Link revision: ' + SDL.getRevision() );

    } //versions

    static function cleanup() {
        SDL.destroyWindow(state.window);
        SDL.destroyRenderer(state.renderer);
        SDL.quit();
    }

}
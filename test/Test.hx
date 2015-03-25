
import sdl.SDL;

class Test {

    var s = '1'; //ignore

    static var state : { window:Window, renderer:Renderer };

    static function main() {

        init();

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
    }

    static function cleanup() {
        SDL.destroyWindow(state.window);
        SDL.destroyRenderer(state.renderer);
        SDL.quit();
    }

}
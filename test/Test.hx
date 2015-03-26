
import sdl.SDL;
import sdl.Window;
import sdl.Renderer;


class Test {

    static var state : { window:Window, renderer:Renderer };
    static var cursor : sdl.Cursor;

    static function main() {

        init();
        versions();
        renderinfo();
        blends();

        cursor = SDL.createSystemCursor(SDL_SYSTEM_CURSOR_HAND);
        SDL.setCursor(cursor);

        //clear to white
            SDL.setRenderDrawColor(state.renderer, 255,255,255,255);
            SDL.renderClear(state.renderer);

        //fetch and change color
            rendercolor('expect 255 255 255 255');

                SDL.setRenderDrawColor(state.renderer, 246, 0, 123, 255);

            rendercolor('expect 246 0 123 255');

        //draw some stuff

                //a diagonal line
            SDL.renderDrawLine(state.renderer, 0, 0, 320, 320);

                //some horizontal lines
            SDL.renderDrawLines(state.renderer, [
                { x:40, y:65  },{ x:280, y:65  },
                { x:40, y:85  },{ x:280, y:85  },
                { x:40, y:105 },{ x:280, y:105 },
                { x:40, y:125 },{ x:280, y:125 }
            ]);

                //a wide grid of dots
            for(x in 0 ... 8)
                for(y in 0 ... 8)
                    SDL.renderDrawPoint(state.renderer, x*40, y*40);

                //a smaller grid of points
            var points = [];
            for(x in 0 ... 32)
                for(y in 0 ... 16)
                    points.push({x:x*10, y:160+(y*10)});

            SDL.setRenderDrawColor(state.renderer, 0, 0, 0, 255);
            SDL.renderDrawPoints(state.renderer, points);

                //some descending rectangles
            SDL.renderDrawRect(state.renderer, { x:10, y:10, w:300, h:300 });

            SDL.setRenderDrawColor(state.renderer, 6, 180, 251, 128);
            SDL.renderDrawRect(state.renderer, { x:20, y:20, w:280, h:280 });

            SDL.setRenderDrawColor(state.renderer, 6, 180, 251, 96);
            SDL.renderDrawRect(state.renderer, { x:30, y:30, w:260, h:260 });

            SDL.setRenderDrawColor(state.renderer, 6, 180, 251, 32);
            SDL.renderDrawRect(state.renderer, { x:40, y:40, w:240, h:240 });

                //a middle block
            SDL.setRenderDrawColor(state.renderer, 6, 180, 251, 255);
            SDL.renderFillRect(state.renderer, { x:150, y:150, w:20, h:20 });

                //list of blocks
            SDL.renderDrawRects(state.renderer, [
                { x:120, y:120, w:5, h:20 },
                { x:200, y:120, w:5, h:20 },
            ]);

                //list of blocks
            SDL.renderFillRects(state.renderer, [
                { x:120, y:140, w:5, h:20 },
                { x:200, y:140, w:5, h:20 },
            ]);

        //finalize

            SDL.renderPresent(state.renderer);

        //I know

            trace('errors: `' + SDL.getError() + '`');

        //give us time to see it

            loop();

        //get out while we still can

            cleanup();

    }

    static function init() {
        SDL.init(SDL_INIT_VIDEO);
        state = SDL.createWindowAndRenderer(320, 320, SDL_WINDOW_RESIZABLE);

        trace('State:');
        trace('    - $state');
        trace('    - platform: ' + SDL.getPlatform());
        trace('    - base path: ' + SDL.getBasePath());
        trace('    - pref path: ' + SDL.getPrefPath('org.snowkit','sdl_test'));
        trace('    - timer ticks: ' + SDL.getTicks());

            //:todo: This breaks on hxcpp cos
            //error: conversion from '::cpp::UInt64' (aka 'unsigned long long') to 'Dynamic' is ambiguous
        // trace('    - perf counter: ' + SDL.getPerformanceCounter());
        // trace('    - perf freq: ' + SDL.getPerformanceFrequency());

        //note this doesn't land in stdout specifically,
        //so in some apps this is delivered when closing
        //rather than "inline". If run from a terminal or with
        //mixed/redirected std io, it would be ordered.
        //Also, -Wformat-security is complaining because the fmt string is used.
        // SDL.log('init');
    }

    static function loop() {

        while(true) {
            var e = SDL.pollEvent();
            if(e.type == SDL_QUIT) {
                trace("Program quit after ticks: " + SDL.getTicks());
                break;
            }
            Sys.sleep(0.25/60);
        }
    }

    static function versions() {
        //https://wiki.libsdl.org/SDL_GetVersion#Code_Examples

        var compiled = SDL.VERSION();
        var linked = SDL.getVersion();

        trace("Versions:");
        trace('    - We compiled against SDL version ${compiled.major}.${compiled.minor}.${compiled.patch} ...');
        trace('    - But we are linking against SDL version ${linked.major}.${linked.minor}.${linked.patch}');

        trace('    - Compile revision : ' + SDL.REVISION() );
        trace('    - Link revision: ' + SDL.getRevision() );

    } //versions

    static function renderinfo() {

        var count = SDL.getNumRenderDrivers();
        trace( 'Render Driver Info :');
        trace('    - Number of render drivers: ' + count );
        for(i in 0 ... count) {
            trace( '    - '+SDL.getRenderDriverInfo(i) );
        }

        trace('Renderer Info :');
        trace('    - ' + SDL.getRendererInfo(state.renderer));
        trace('    - Output Size: ' + SDL.getRendererOutputSize(state.renderer, {w:0, h:0}));
        trace('    - Render target support: ' + SDL.renderTargetSupported(state.renderer));

    } //renderinfo

    static function rendercolor(v) {

        var into = { r:0, g:0, b:0, a:0 };
        trace('Color: $v');
        trace('    ' + SDL.getRenderDrawColor(state.renderer, into));

    } //rendercolor

    static function blends() {

        inline function printmode(e:String, m:SDLBlendMode) {
            trace('    expect $e, got: ' + switch(m) {
                case SDL_BLENDMODE_MOD:'mod';
                case SDL_BLENDMODE_ADD:'add';
                case SDL_BLENDMODE_BLEND:'blend';
                case SDL_BLENDMODE_NONE:'none';
            });
        }

        trace('Blends:');

        printmode('none', SDL.getRenderDrawBlendMode(state.renderer));

        SDL.setRenderDrawBlendMode(state.renderer, SDL_BLENDMODE_ADD);

        printmode('add', SDL.getRenderDrawBlendMode(state.renderer));

        SDL.setRenderDrawBlendMode(state.renderer, SDL_BLENDMODE_BLEND);

        printmode('blend', SDL.getRenderDrawBlendMode(state.renderer));

    } //blends

    static function cleanup() {

        SDL.destroyWindow(state.window);
        SDL.destroyRenderer(state.renderer);
        SDL.quit();

    } //cleanup


        //a simple macro to force compilation each time
        //allowing faster iteration
    static inline var forcer:String = Forcer.get();

}
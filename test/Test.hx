
import sdl.SDL;
import sdl.Window;
import sdl.Renderer;


class Test {

    static var state : { window:Window, renderer:Renderer };
    static var cursor : sdl.Cursor;
    static var reason : String = '';

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


            //draw an image
            var file:sdl.RWops = SDL.RWFromFile("test.bmp", "rb");
            var image:sdl.Surface = SDL.loadBMP_RW(file, 1);
            var texture:sdl.Texture = SDL.createTextureFromSurface(state.renderer, image);

            SDL.freeSurface(image);
            image = null;

            trace('image load errors: `' + SDL.getError() + '`');

            SDL.renderCopy(state.renderer, texture, null, { x:160-48, y:160+32, w:96, h:96 });

            trace('render copy errors: `' + SDL.getError() + '`');

            SDL.addEventWatch( eventfilter, {id:1} );
            SDL.addEventWatch( eventfilter2, {id:2} );

            trace('Displays:');
            var num_displays = SDL.getNumVideoDisplays();
            for(display_index in 0 ... num_displays) {
                var num_modes = SDL.getNumDisplayModes(display_index);
                var name = SDL.getDisplayName(display_index);
                trace('\tDisplay $display_index: $name');
                var desktop_mode = SDL.getDesktopDisplayMode(display_index);
                trace('\t Desktop Mode: ${desktop_mode.w}x${desktop_mode.h} @ ${desktop_mode.refresh_rate}Hz format:${pixel_format_to_string(desktop_mode.format)}');
                var current_mode = SDL.getCurrentDisplayMode(display_index);
                trace('\t Current Mode: ${current_mode.w}x${current_mode.h} @ ${current_mode.refresh_rate}Hz format:${pixel_format_to_string(current_mode.format)}');
                for(display_mode in 0 ... num_modes) {
                    var mode = SDL.getDisplayMode(display_index, display_mode);
                    trace('\t\t mode:$display_mode ${mode.w}x${mode.h} @ ${mode.refresh_rate}Hz format:${pixel_format_to_string(mode.format)}');
                }
            }


        //finalize

            SDL.renderPresent(state.renderer);

        //I know

            trace('errors: `' + SDL.getError() + '`');

        //give us time to see it

            loop();

        //get out while we still can

            cleanup();

    }

    static function pixel_format_to_string(format:SDLPixelFormat) {
        return switch(format) {
            case SDL_PIXELFORMAT_UNKNOWN     :'UNKNOWN';
            case SDL_PIXELFORMAT_INDEX1LSB   :'INDEX1LSB';
            case SDL_PIXELFORMAT_INDEX1MSB   :'INDEX1MSB';
            case SDL_PIXELFORMAT_INDEX4LSB   :'INDEX4LSB';
            case SDL_PIXELFORMAT_INDEX4MSB   :'INDEX4MSB';
            case SDL_PIXELFORMAT_INDEX8      :'INDEX8';
            case SDL_PIXELFORMAT_RGB332      :'RGB332';
            case SDL_PIXELFORMAT_RGB444      :'RGB444';
            case SDL_PIXELFORMAT_RGB555      :'RGB555';
            case SDL_PIXELFORMAT_BGR555      :'BGR555';
            case SDL_PIXELFORMAT_ARGB4444    :'ARGB4444';
            case SDL_PIXELFORMAT_RGBA4444    :'RGBA4444';
            case SDL_PIXELFORMAT_ABGR4444    :'ABGR4444';
            case SDL_PIXELFORMAT_BGRA4444    :'BGRA4444';
            case SDL_PIXELFORMAT_ARGB1555    :'ARGB1555';
            case SDL_PIXELFORMAT_RGBA5551    :'RGBA5551';
            case SDL_PIXELFORMAT_ABGR1555    :'ABGR1555';
            case SDL_PIXELFORMAT_BGRA5551    :'BGRA5551';
            case SDL_PIXELFORMAT_RGB565      :'RGB565';
            case SDL_PIXELFORMAT_BGR565      :'BGR565';
            case SDL_PIXELFORMAT_RGB24       :'RGB24';
            case SDL_PIXELFORMAT_BGR24       :'BGR24';
            case SDL_PIXELFORMAT_RGB888      :'RGB888';
            case SDL_PIXELFORMAT_RGBX8888    :'RGBX8888';
            case SDL_PIXELFORMAT_BGR888      :'BGR888';
            case SDL_PIXELFORMAT_BGRX8888    :'BGRX8888';
            case SDL_PIXELFORMAT_ARGB8888    :'ARGB8888';
            case SDL_PIXELFORMAT_RGBA8888    :'RGBA8888';
            case SDL_PIXELFORMAT_ABGR8888    :'ABGR8888';
            case SDL_PIXELFORMAT_BGRA8888    :'BGRA8888';
            case SDL_PIXELFORMAT_ARGB2101010 :'ARGB2101010';
            case SDL_PIXELFORMAT_YV12        :'YV12';
            case SDL_PIXELFORMAT_IYUV        :'IYUV';
            case SDL_PIXELFORMAT_YUY2        :'YUY2';
            case SDL_PIXELFORMAT_UYVY        :'UYVY';
            case SDL_PIXELFORMAT_YVYU        :'YVYU';
            case SDL_PIXELFORMAT_NV12        :'NV12';
            case SDL_PIXELFORMAT_NV21        :'NV21';
        }
    }

    static function eventfilter(userdata:{id:Int}, e:sdl.Event) {
        if(e.type == SDLEventType.SDL_MOUSEBUTTONDOWN) {
            trace('event filter 1 mouse down :' + userdata);
        }
    }

    static function eventfilter2(userdata:{id:Int}, e:sdl.Event) {
        if(e.type == SDLEventType.SDL_MOUSEBUTTONUP) {
            trace('event filter 2 mouse up :' + userdata);
            SDL.delEventWatch(eventfilter2);
        }
    }

    static function init() {
        SDL.init(SDL_INIT_VIDEO | SDL_INIT_EVENTS);
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

    static function process_events() {

        while(SDL.hasAnEvent()) {

            var e = SDL.pollEvent();

            if(e.type == SDL_QUIT) {
                reason = 'quit event';
                return false;
            }

            if(e.type == SDL_KEYDOWN) {

                var ctrlormetadown = (SDL.getModState() == (KMOD_GUI | KMOD_CTRL));

                if(e.key.keysym.sym == 27) {
                    reason = 'escape key';
                    return false;
                }

                if(e.key.keysym.sym == 32) {
                    var a = SDL.waitEvent();
                    trace('next event was SDL_TEXTINPUT:' + (a.type == SDL_TEXTINPUT));
                }
            }

            if(e.type == SDLEventType.SDL_MOUSEMOTION) trace('motion ' + e.motion.x + ',' + e.motion.y);
            if(e.type == SDLEventType.SDL_MOUSEBUTTONDOWN) trace('mouse button down: ' + e.button.button);
            if(e.type == SDLEventType.SDL_MOUSEBUTTONUP) trace('mouse button up: ' + e.button.button);

        } //has an event

        return true;

    } //process_events

    static function loop() {

        var updating = true;

        while(updating) {

            updating = process_events();

            //give os time
            SDL.delay(4);

        } //while(updating)

    } //loop

    static function versions() {
        //https://wiki.libsdl.org/SDL_GetVersion#Code_Examples

        var compiled = SDL.VERSION();
        var linked = SDL.getVersion();

        var compiled_rev = SDL.REVISION();
        var linked_rev = SDL.getRevision();

        trace("Versions:");
        trace('    - We compiled against SDL version ${compiled.major}.${compiled.minor}.${compiled.patch} ...');
        trace('    - And linked against SDL version ${linked.major}.${linked.minor}.${linked.patch}');

        trace('    - Compile revision : ' + compiled_rev );
        trace('    - Link revision: ' + linked_rev );
        trace('    - clipboard change to compile revision');

        SDL.setClipboardText(compiled_rev);

        trace('    - clipboard after: ' + SDL.getClipboardText());

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

        trace('quit($reason), elapsed(${SDL.getTicks()})');

        SDL.destroyWindow(state.window);
        SDL.destroyRenderer(state.renderer);
        SDL.quit();

    } //cleanup

}
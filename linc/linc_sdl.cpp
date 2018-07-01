//hxcpp include should be first
#include <hxcpp.h>
#include "./linc_sdl.h"

#include "../lib/sdl/include/SDL_revision.h"
#include <vector>
#include <map>

#if defined(LINC_SDL_WITH_SDL_MAIN)

    extern "C" { void hxcpp_main(); }
    int SDL_main(int argc, char *argv[]) {
        
        #if !defined(LINC_SDL_NO_HXCPP_MAIN_CALL) 
            SDL_Log("Calling hxcpp_main() from SDL_main!");
            hxcpp_main();
        #endif

        #if !defined(LINC_SDL_NO_EXIT_CALL)
            SDL_Log("Calling exit() from SDL_main!");
            exit(0);
        #endif 

        return 0;
    }

#endif

namespace linc {

    namespace sdl {

            // return { window:cpp.Pointer<SDL_Window>, renderer:cpp.Pointer<SDL_Renderer> }
        Dynamic createWindowAndRenderer(int x, int y, int flags) {

            SDL_Window* window = 0;
            SDL_Renderer* renderer = 0;

            int res = SDL_CreateWindowAndRenderer(x, y, flags, &window, &renderer );
            if(res == 0) {

                ::cpp::Pointer<SDL_Window> window_p(window);
                ::cpp::Pointer<SDL_Renderer> renderer_p(renderer);

                hx::Anon out = hx::Anon_obj::Create();

                    out->Add(HX_CSTRING("window"), window_p);
                    out->Add(HX_CSTRING("renderer"), renderer_p);

                return out;

            } //res == 0

            return null();

        } //createWindowAndRenderer

            //needed because the macro has no ()
        ::String REVISION() {

            return ::String(SDL_REVISION);

        } //REVISION


            // return { major:UInt, minor:UInt, patch:UInt }
        Dynamic VERSION() {

                SDL_version ver;
                SDL_VERSION(&ver);

            hx::Anon out = hx::Anon_obj::Create();

                out->Add(HX_CSTRING("major"), ver.major);
                out->Add(HX_CSTRING("minor"), ver.minor);
                out->Add(HX_CSTRING("patch"), ver.patch);

            return out;

        } //VERSION

            //return { major:UInt, minor:UInt, patch:UInt }
        Dynamic getVersion() {

                SDL_version ver;
                SDL_GetVersion(&ver);

            hx::Anon out = hx::Anon_obj::Create();
                out->Add(HX_CSTRING("major"), ver.major);
                out->Add(HX_CSTRING("minor"), ver.minor);
                out->Add(HX_CSTRING("patch"), ver.patch);
            return out;

        } //getVersion

        ::cpp::Struct<SDL_Event> pollEvent() {

            SDL_Event event;
            SDL_PollEvent(&event);
            return event;

        } //pollEvent

        ::cpp::Struct<SDL_Event> waitEvent() {

            SDL_Event event;
            SDL_WaitEvent(&event);
            return event;

        } //waitEvent

        ::cpp::Struct<SDL_Event> waitEventTimeout(int _timeout) {

            SDL_Event event;
            SDL_WaitEventTimeout(&event, _timeout);
            return event;

        } //waitEventTimeout

        ::String getBasePath() {

            char *base_path = SDL_GetBasePath();

            if (base_path) {
                ::String res(base_path);
                SDL_free(base_path);
                return res;
            }

            return null();

        } //getBasePath

        ::String getPrefPath(::String org, ::String app) {

            char *pref_path = SDL_GetPrefPath(org.c_str(), app.c_str());

            if (pref_path) {
                ::String res(pref_path);
                SDL_free(pref_path);
                return res;
            }

            return null();

        } //getPrefPath


            //return { texw:Float, texh:Float }
        Dynamic GL_BindTexture(SDL_Texture* texture) {

            float texw, texh;
            SDL_GL_BindTexture(texture, &texw, &texh);

            printf("%f %f\n", texw, texh);

            hx::Anon out = hx::Anon_obj::Create();

                out->Add(HX_CSTRING("texw"), texw);
                out->Add(HX_CSTRING("texh"), texh);

            return out;

        } //GL_BindTexture

        int GL_GetAttribute(int attr) {

            int result = -1;
            SDL_GL_GetAttribute((SDL_GLattr)attr, &result);
            return result;

        } //GL_GetAttribute

        int setRenderDrawBlendMode(SDL_Renderer* renderer, int blend) {

            return SDL_SetRenderDrawBlendMode(renderer, (SDL_BlendMode)blend );

        } //setRenderDrawBlendMode


        int getRenderDrawBlendMode(SDL_Renderer* renderer) {

            SDL_BlendMode mode;
            SDL_GetRenderDrawBlendMode(renderer, &mode);

            return (int)mode;

        } //getRenderDrawBlendMode

        Dynamic getRenderDrawColor(SDL_Renderer* renderer, Dynamic into) {

            Uint8 r, g, b, a;

            SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a);

            return convert::set_color_into(into, r, g, b, a);

        } //getRenderDrawColor

        Dynamic getRenderDriverInfo(int index) {

            SDL_RendererInfo info;
            SDL_GetRenderDriverInfo(index, &info);

            return convert::render_info_to_hx(info);

        } //getRenderDriverInfo

        Dynamic getRendererInfo(SDL_Renderer* renderer) {

            SDL_RendererInfo info;
            SDL_GetRendererInfo(renderer, &info);

            return convert::render_info_to_hx(info);

        } //getRendererInfo

        Dynamic getRendererOutputSize(SDL_Renderer* renderer, Dynamic into) {

            int w, h;
            SDL_GetRendererOutputSize(renderer, &w, &h);

            return convert::set_size_into(into, w, h);

        } //getRendererOutputSize

        Uint8 getTextureAlphaMod(SDL_Texture* texture) {

            Uint8 alpha;
            SDL_GetTextureAlphaMod(texture, &alpha);

            return alpha;

        } //getTextureAlphaMod

        int getTextureBlendMode(SDL_Texture* texture) {

            SDL_BlendMode blend;
            SDL_GetTextureBlendMode(texture, &blend);

            return (int)blend;

        } //getTextureBlendMode

        int setTextureBlendMode(SDL_Texture* texture, int blend) {

            return SDL_SetTextureBlendMode(texture, (SDL_BlendMode)blend);

        } //setTextureBlendMode

        Dynamic getTextureColorMod(SDL_Texture* texture, Dynamic into) {

            Uint8 r, g, b;
            SDL_GetTextureColorMod(texture, &r, &g, &b);

            return convert::set_color_into(into, r, g, b, 0);

        } //getTextureColorMod

        int lockTexture(SDL_Texture* texture, Dynamic rect, Array<unsigned char> dest) {

            int pitch = -1;

            if(rect != null()) {
                SDL_Rect _rect = convert::get_rect_from(rect);
                SDL_LockTexture(texture, &_rect, (void**)&dest[0], &pitch);
            }

            return pitch;

        } //lockTexture

        Dynamic queryTexture(SDL_Texture* texture, Dynamic into) {

            Uint32 format;
            int access, w, h;

            SDL_QueryTexture(texture, &format, &access, &w, &h);

            return convert::set_texture_query_into(into, format, access, w, h);

        } //queryTexture

        int updateTexture(SDL_Texture* texture, Dynamic rect, Array<unsigned char> pixels, int pitch) {

            if(rect != null()) {
                SDL_Rect _rect = convert::get_rect_from(rect);
                return SDL_UpdateTexture(texture, &_rect, (const void*)&pixels[0], pitch);
            } else {
                return SDL_UpdateTexture(texture, NULL, (const void*)&pixels[0], pitch);
            }

        } //updateTexture

        int updateYUVTexture(SDL_Texture* texture, Dynamic rect,
                             Array<unsigned char> Yplane, int Ypitch,
                             Array<unsigned char> Uplane, int Upitch,
                             Array<unsigned char> Vplane, int Vpitch)
        {

            if(rect != null()) {
                SDL_Rect _rect = convert::get_rect_from(rect);
                return SDL_UpdateYUVTexture( texture, &_rect,
                                             (const Uint8*)&Yplane[0], Ypitch,
                                             (const Uint8*)&Uplane[0], Upitch,
                                             (const Uint8*)&Vplane[0], Vpitch );

            } else {
                return SDL_UpdateYUVTexture( texture, NULL,
                                             (const Uint8*)&Yplane[0], Ypitch,
                                             (const Uint8*)&Uplane[0], Upitch,
                                             (const Uint8*)&Vplane[0], Vpitch );
            }

        } //updateYUVTexture


        int renderDrawRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderDrawRect(renderer, &_rect);

        } //renderDrawRect

        int renderFillRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderFillRect(renderer, &_rect);

        } //renderFillRect

        Dynamic renderGetClipRect(SDL_Renderer* renderer, Dynamic into) {

            SDL_Rect from;
            SDL_RenderGetClipRect(renderer, &from);

            return convert::set_rect_into(into, from);

        } //renderGetClipRect

        Dynamic renderGetLogicalSize(SDL_Renderer* renderer, Dynamic into) {

            int w, h;
            SDL_RenderGetLogicalSize(renderer, &w, &h);

            return convert::set_size_into(into, w, h);

        } //renderGetLogicalSize

        Dynamic renderGetScale(SDL_Renderer* renderer, Dynamic into) {

            float x, y;
            SDL_RenderGetScale(renderer, &x, &y);

            return convert::set_scale_into(into, x, y);

        } //renderGetLogicalSize

        Dynamic renderGetViewport(SDL_Renderer* renderer, Dynamic into) {

            SDL_Rect from;
            SDL_RenderGetViewport(renderer, &from);

            return convert::set_rect_into(into, from);

        } //renderGetViewport

        int renderReadPixels(SDL_Renderer* renderer, Dynamic rect, int format, Array<unsigned char> dest, int pitch) {

            if(rect != null()) {
                SDL_Rect _rect = convert::get_rect_from(rect);
                return SDL_RenderReadPixels(renderer, &_rect, format, (void*)&dest[0], pitch);
            } else {
                return SDL_RenderReadPixels(renderer, NULL, format, (void*)&dest[0], pitch);
            }

        } //renderReadPixels

        int renderSetClipRect(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderSetClipRect(renderer, &_rect);

        } //renderSetClipRect

        int renderSetViewport(SDL_Renderer* renderer, Dynamic rect) {

            SDL_Rect _rect = convert::get_rect_from(rect);

            return SDL_RenderSetViewport(renderer, &_rect);

        } //renderSetViewport

        SDL_Surface* createRGBSurfaceFrom(Array<unsigned char> pixels, 
            int width, int height, int depth, int pitch, 
            int Rmask, int Gmask, int Bmask, int Amask) {

            return SDL_CreateRGBSurfaceFrom((void*)&pixels[0], width, height, depth, pitch, Rmask, Gmask, Bmask, Amask);

        } //createRGBSurfaceFrom

        int blitSurface(SDL_Surface* src, Dynamic srcrect, SDL_Surface* dst, Dynamic dstrect) {

            bool has_src = srcrect != null();
            bool has_dst = dstrect != null();

                //neither?
            if(!has_src && !has_dst) {
                return SDL_BlitSurface(src, NULL, dst, NULL);
            }

                //just src?
            if(has_src && !has_dst) {
                SDL_Rect _srcrect = convert::get_rect_from(srcrect);
                return SDL_BlitSurface(src, &_srcrect, dst, NULL);
            }

                //just dst?
            if(has_dst && !has_src) {
                SDL_Rect _dstrect = convert::get_rect_from(dstrect);
                return SDL_BlitSurface(src, NULL, dst, &_dstrect);
            }

            SDL_Rect _srcrect = convert::get_rect_from(srcrect);
            SDL_Rect _dstrect = convert::get_rect_from(dstrect);

            return SDL_BlitSurface(src, &_srcrect, dst, &_dstrect);

        } //blitSurface

        SDL_Cursor* createSystemCursor(int id) {

            return SDL_CreateSystemCursor((SDL_SystemCursor)id);

        } //createSystemCursor

        Dynamic joystickGetBall(SDL_Joystick* joystick, int ball, Dynamic into) {

            int dx,dy;
            SDL_JoystickGetBall(joystick, ball, &dx, &dy);

            return convert::set_point_into(into, dx, dy);

        } //joystickGetBall

        ::String joystickGetGUIDString(Array<unsigned char> guid) {

            return ::String("not done");

        } //joystickGetGUIDString

        void setModState(int modstate) {

            SDL_SetModState((SDL_Keymod)modstate);

        } //setModState

        void setTextInputRect(int x, int y, int w, int h) {

            SDL_Rect _rect;

                _rect.x = x;
                _rect.y = y;
                _rect.w = w;
                _rect.h = h;

            SDL_SetTextInputRect(&_rect);

        } //setTextInputRect

        Dynamic getWindowSize(SDL_Window* window, Dynamic into) {

            int w, h;
            SDL_GetWindowSize(window, &w, &h);

            return convert::set_size_into(into, w, h);

        } //getWindowSize

        Dynamic getWindowPosition(SDL_Window* window, Dynamic into) {

            int x, y;
            SDL_GetWindowPosition(window, &x, &y);

            return convert::set_point_into(into, x, y);

        } //getWindowPosition


        Dynamic GL_GetDrawableSize(SDL_Window* window, Dynamic into) {

            int w, h;
            SDL_GL_GetDrawableSize(window, &w, &h);

            return convert::set_size_into(into, w, h);

        } //GL_GetDrawableSize


        Dynamic getDisplayBounds(int display_index, Dynamic into) {

            SDL_Rect from;
            SDL_GetDisplayBounds(display_index, &from);

            return convert::set_rect_into(into, from);

        } //getDisplayBounds

        int renderCopy(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect) {

            bool has_src = srcrect != null();
            bool has_dst = dstrect != null();

                //neither?
            if(!has_src && !has_dst) {
                return SDL_RenderCopy(renderer, texture, NULL, NULL);
            }

                //just src?
            if(has_src && !has_dst) {
                SDL_Rect _src = convert::get_rect_from(srcrect);
                return SDL_RenderCopy(renderer, texture, &_src, NULL);
            }

                //just dst?
            if(has_dst && !has_src) {
                SDL_Rect _dst = convert::get_rect_from(dstrect);
                return SDL_RenderCopy(renderer, texture, NULL, &_dst);
            }

            SDL_Rect _src = convert::get_rect_from(srcrect);
            SDL_Rect _dst = convert::get_rect_from(dstrect);

            return SDL_RenderCopy(renderer, texture, &_src, &_dst);

        } //renderCopy

            //:note: silly structs and nulls, these conditions...
        int renderCopyEx(SDL_Renderer* renderer, SDL_Texture* texture,
                         Dynamic srcrect, Dynamic dstrect, Float angle,
                         Dynamic center, int flip )
        {
            bool has_src = srcrect != null();
            bool has_dst = dstrect != null();
            bool has_center = center != null();

            SDL_RendererFlip _flip = (SDL_RendererFlip)flip;

                //none
            if(!has_src && !has_dst && !has_center) {
                return SDL_RenderCopyEx(renderer, texture, NULL, NULL, angle, NULL, _flip);
            }


                //src dst
            if(has_src && has_dst && !has_center) {
                SDL_Rect _src = convert::get_rect_from(srcrect);
                SDL_Rect _dst = convert::get_rect_from(dstrect);
                return SDL_RenderCopyEx(renderer, texture, &_src, &_dst, angle, NULL, _flip);
            }

                //src
            if(has_src && !has_dst && !has_center) {
                SDL_Rect _src = convert::get_rect_from(srcrect);
                return SDL_RenderCopyEx(renderer, texture, &_src, NULL, angle, NULL, _flip);
            }

                //dst
            if(!has_src && has_dst && !has_center) {
                SDL_Rect _dst = convert::get_rect_from(dstrect);
                return SDL_RenderCopyEx(renderer, texture, NULL, &_dst, angle, NULL, _flip);
            }

                //center
            if(!has_src && !has_dst && has_center) {
                SDL_Point _center = convert::get_point_from(center);
                return SDL_RenderCopyEx(renderer, texture, NULL, NULL, angle, &_center, _flip);
            }

                //src center
            if(has_src && !has_dst && has_center) {
                SDL_Rect _src = convert::get_rect_from(srcrect);
                SDL_Point _center = convert::get_point_from(center);
                return SDL_RenderCopyEx(renderer, texture, &_src, NULL, angle, &_center, _flip);
            }

                //dst center
            if(!has_src && has_dst && has_center) {
                SDL_Rect _dst = convert::get_rect_from(dstrect);
                SDL_Point _center = convert::get_point_from(center);
                return SDL_RenderCopyEx(renderer, texture, NULL, &_dst, angle, &_center, _flip);
            }

            SDL_Rect _src = convert::get_rect_from(srcrect);
            SDL_Rect _dst = convert::get_rect_from(dstrect);
            SDL_Point _center = convert::get_point_from(center);

            return SDL_RenderCopyEx(renderer, texture, &_src, &_dst, angle, &_center, _flip);

        } //renderCopyEx

        Dynamic getDisplayMode(int display_index, int mode_index) {

            SDL_DisplayMode mode;
            int res = SDL_GetDisplayMode(display_index, mode_index, &mode);

            if(res != 0) return null();

            return convert::display_mode_to_hx(mode);

        } //getDisplayMode

        Dynamic getDesktopDisplayMode(int display_index) {

            SDL_DisplayMode mode;
            int res = SDL_GetDesktopDisplayMode(display_index, &mode);

            if(res != 0) return null();

            return convert::display_mode_to_hx(mode);

        } //getDesktopDisplayMode

        Dynamic getCurrentDisplayMode(int display_index) {

            SDL_DisplayMode mode;
            int res = SDL_GetCurrentDisplayMode(display_index, &mode);

            if(res != 0) return null();

            return convert::display_mode_to_hx(mode);

        } //getCurrentDisplayMode

        Dynamic getGlobalMouseState(Dynamic into) {

            int x, y;
            Uint32 buttons = SDL_GetGlobalMouseState(&x, &y);

            return convert::set_mouse_state_into(into, x, y, buttons);

        } //getGlobalMouseState

        Dynamic getMouseState(Dynamic into) {

            int x, y;
            Uint32 buttons = SDL_GetMouseState(&x, &y);

            return convert::set_mouse_state_into(into, x, y, buttons);

        } //getMouseState

        Dynamic getRelativeMouseState(Dynamic into) {

            int x, y;
            Uint32 buttons = SDL_GetRelativeMouseState(&x, &y);

            return convert::set_mouse_state_into(into, x, y, buttons);

        } //getMouseState

        int waitThread(SDL_Thread* thread) {

            int result = -1;

            SDL_WaitThread(thread, &result);

            return result;

        } //waitThread

    //internal

        //event watches
            static InternalEventFilterFN event_watch_fn = 0;
            static std::map<int, int*> event_watch_list;
            static unsigned long long event_watch_seq = 0;

            void init_event_watch( InternalEventFilterFN fn ) {

                event_watch_fn = fn;                    

            } //init_event_watch

            static int InternalEventWatch(void* userdata, SDL_Event* event) {

                    //:todo:
                unsigned int type = event->type;
                if(
                    type != SDL_APP_TERMINATING         &&
                    type != SDL_APP_LOWMEMORY           &&
                    type != SDL_APP_WILLENTERBACKGROUND &&
                    type != SDL_APP_DIDENTERBACKGROUND  &&
                    type != SDL_APP_WILLENTERFOREGROUND &&
                    type != SDL_APP_DIDENTERFOREGROUND
                ) {
                    return 1;
                }

                #if defined(ANDROID) 
                    AutoHaxe haxe("linc::sdl::InternalEventWatch");
                #endif

                int* watch_id = (int*)userdata;
                return event_watch_fn(*watch_id, event);

            } //InternalEventWatch

            int addEventWatch() {
                
                int watch_id = event_watch_seq;
                int* watch_userdata = new int;
                *watch_userdata = watch_id;

                event_watch_seq++;

                SDL_AddEventWatch(InternalEventWatch, watch_userdata);

                event_watch_list[watch_id] = watch_userdata;

                return watch_id;

            } //addEventWatch

            void delEventWatch( int watchID ) {

                int* watch_userdata = event_watch_list[watchID];
                    
                    //in our case removing a null pointer 
                    //event watch callback doesn't match our expectation
                if(watch_userdata) {

                    SDL_DelEventWatch(InternalEventWatch, watch_userdata);

                    delete watch_userdata; 
                    watch_userdata = 0;

                }

            } //delEventWatch

        //timer callbacks

            static InternalTimerCallbackFN timer_fn = 0;
            static std::map<int, int*> timer_list;

            void init_timer( InternalTimerCallbackFN fn ) {

                timer_fn = fn;

            } //init_timer

            static Uint32 InternalTimerCallback(Uint32 interval, void *param) {

                #if defined(ANDROID) 
                    AutoHaxe haxe("linc::sdl::InternalTimerCallback");
                #endif

                int* timer_id = (int*)param;

                int result = timer_fn(*timer_id);

                return result;

            } //InternalTimerCallback

            int addTimer( int interval ) {

                int* timer_userdata = new int;
                int timer_id = SDL_AddTimer(interval, InternalTimerCallback, timer_userdata);
                *timer_userdata = timer_id;

                timer_list[timer_id] = timer_userdata;

                return timer_id;

            } //add_timer

            bool removeTimer( int timerID ) {

                int* timer_userdata = timer_list[timerID];
                
                if(timer_userdata) {
                    delete timer_userdata; 
                    timer_userdata = 0;
                }

                return SDL_RemoveTimer(timerID);

            } //remove_timer


        int RWread(SDL_RWops* context, Array<unsigned char> ptr, size_t size, size_t maxnum) {
            return SDL_RWread(context, (void*)&ptr[0], size, maxnum);
        }

        int RWwrite(SDL_RWops* context, Array<unsigned char> ptr, size_t size, size_t num) {
            return SDL_RWwrite(context, (void*)&ptr[0], size, num);
        }

        int RWseek(SDL_RWops* context, int64_t offset, int whence) {
            return SDL_RWseek(context, offset, whence);
        }

        int64_t RWsize(SDL_RWops* context) {
            return SDL_RWsize(context);
        }

        int64_t RWtell(SDL_RWops* context) {
            return SDL_RWtell(context);
        }

        int RWclose(SDL_RWops* context) {
            return SDL_RWclose(context);
        }

        SDL_RWops* RWFromMem(Array<unsigned char> source, size_t size) {
            return SDL_RWFromMem((void*)&source[0], size);
        }

    #if defined(__IPHONEOS__) || defined(IPHONE)

        //iOS callback

            static InternaliOSCallbackFN ios_fn;

            static void InternaliOSCallback(void* userdata) {

                ios_fn();

            } //InternaliOSCallback

            void init_ios_callback( SDL_Window* window, int interval, InternaliOSCallbackFN fn ) {
                
                ios_fn = fn;
                SDL_iPhoneSetAnimationCallback(window, interval, InternaliOSCallback, NULL);

            } //init_ios_callback

    #endif //iOS

    //conversions

        namespace convert {

            Dynamic render_info_to_hx(SDL_RendererInfo info) {

                hx::Anon out = hx::Anon_obj::Create();

                    //array of texture formats
                Array< int > arr = Array_obj< int >::__new();

                for(int i = 0; i < (int)info.num_texture_formats; ++i) {
                    arr.Add( (int)info.texture_formats[i] );
                }

                //fill the object

                    out->Add(HX_CSTRING("name"), ::String(info.name));
                    out->Add(HX_CSTRING("flags"), (int)info.flags);
                    out->Add(HX_CSTRING("num_texture_formats"), (int)info.num_texture_formats);
                    out->Add(HX_CSTRING("texture_formats"), arr);
                    out->Add(HX_CSTRING("max_texture_width"), info.max_texture_width);
                    out->Add(HX_CSTRING("max_texture_height"), info.max_texture_height);

                return out;

                // returns {
                //     var name:String;
                //     var flags:UInt;
                //     var num_texture_formats:UInt;
                //     var texture_formats:Array<UInt>;
                //     var max_texture_width:Int;
                //     var max_texture_height:Int;
                // }

            } //render_info_to_hx

            Dynamic display_mode_to_hx(SDL_DisplayMode mode) {

                hx::Anon out = hx::Anon_obj::Create();

                    out->Add(HX_CSTRING("w"), mode.w);
                    out->Add(HX_CSTRING("h"), mode.h);
                        //:note: this was UInt32, but the ranges appear to fit in int and Dynamic hates unsigned int
                    out->Add(HX_CSTRING("format"), (int)mode.format);
                    out->Add(HX_CSTRING("refresh_rate"), mode.refresh_rate);

                return out;

            } //display_mode_to_hx

            Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a) {

                    into->__FieldRef(HX_CSTRING("r")) = r;
                    into->__FieldRef(HX_CSTRING("g")) = g;
                    into->__FieldRef(HX_CSTRING("b")) = b;
                    into->__FieldRef(HX_CSTRING("a")) = a;

                return into;

            } //set_color_into

            Dynamic set_texture_query_into(Dynamic into, Uint32 format, int access, int w, int h) {

                    into->__FieldRef(HX_CSTRING("format")) = (int)format;
                    into->__FieldRef(HX_CSTRING("access")) = access;
                    into->__FieldRef(HX_CSTRING("w")) = w;
                    into->__FieldRef(HX_CSTRING("h")) = h;

                return into;

            } //set_texture_query_into

            Dynamic set_size_into(Dynamic into, int w, int h) {

                    into->__FieldRef(HX_CSTRING("w")) = w;
                    into->__FieldRef(HX_CSTRING("h")) = h;

                return into;

            } //set_size_into

            Dynamic set_scale_into(Dynamic into, float x, float y) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;

                return into;

            } //set_scale_into

            Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;
                    into->__FieldRef(HX_CSTRING("w")) = w;
                    into->__FieldRef(HX_CSTRING("h")) = h;

                return into;

            } //set_rect_into

            Dynamic set_point_into(Dynamic into, int x, int y) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;

                return into;

            } //set_point_into

            Dynamic set_mouse_state_into(Dynamic into, int x, int y, Uint32 buttons) {

                    into->__FieldRef(HX_CSTRING("x")) = x;
                    into->__FieldRef(HX_CSTRING("y")) = y;
                    into->__FieldRef(HX_CSTRING("buttons")) = (int)buttons;

                return into;

            } //set_mouse_state_into

            Dynamic set_rect_into(Dynamic into, SDL_Rect from) {

                    into->__FieldRef(HX_CSTRING("x")) = from.x;
                    into->__FieldRef(HX_CSTRING("y")) = from.y;
                    into->__FieldRef(HX_CSTRING("w")) = from.w;
                    into->__FieldRef(HX_CSTRING("h")) = from.h;

                return into;

            } //set_rect_into

            SDL_Rect get_rect_from(Dynamic from) {

                SDL_Rect r;

                    r.x = from->__FieldRef(HX_CSTRING("x"));
                    r.y = from->__FieldRef(HX_CSTRING("y"));
                    r.w = from->__FieldRef(HX_CSTRING("w"));
                    r.h = from->__FieldRef(HX_CSTRING("h"));

                return r;

            } //get_rect_from

            SDL_Point get_point_from(Dynamic from) {

                SDL_Point p;

                    p.x = from->__FieldRef(HX_CSTRING("x"));
                    p.y = from->__FieldRef(HX_CSTRING("y"));

                return p;

            } //get_point_from

        } //convert namespace


    } //sdl namespace

} //linc namespace

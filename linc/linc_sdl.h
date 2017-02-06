#pragma once

#include <hxcpp.h>

#define SDL_MAIN_HANDLED 1
#include "../lib/sdl/include/SDL.h"

namespace linc {

        namespace sdl {

                //forward declarations
            namespace convert {

                extern  Dynamic render_info_to_hx(SDL_RendererInfo info);
                extern  Dynamic display_mode_to_hx(SDL_DisplayMode mode);
                extern  Dynamic set_color_into(Dynamic into, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
                extern  Dynamic set_texture_query_into(Dynamic into, Uint32 format, int access, int w, int h);
                extern  Dynamic set_size_into(Dynamic into, int w, int h);
                extern  Dynamic set_scale_into(Dynamic into, float x, float y);
                extern  Dynamic set_point_into(Dynamic into, int x, int y);
                extern  Dynamic set_mouse_state_into(Dynamic into, int x, int y, Uint32 buttons);
                extern  Dynamic set_rect_into(Dynamic into, int x, int y, int w, int h);
                extern  Dynamic set_rect_into(Dynamic into, SDL_Rect from);
                extern SDL_Rect get_rect_from(Dynamic from);
                extern SDL_Point get_point_from(Dynamic from);

            } //convert

            extern Dynamic createWindowAndRenderer(int x, int y, int flags);
            extern ::String REVISION();
            extern Dynamic VERSION();
            extern Dynamic getVersion();
            extern ::cpp::Struct<SDL_Event> pollEvent();
            extern ::cpp::Struct<SDL_Event> waitEvent();
            extern ::cpp::Struct<SDL_Event> waitEventTimeout(int _timeout);
            extern ::String getBasePath();
            extern ::String getPrefPath(::String org, ::String app);
            extern Dynamic GL_BindTexture(SDL_Texture* texture);
            extern int GL_GetAttribute(int attr);
            extern int setRenderDrawBlendMode(SDL_Renderer* renderer, int blend);
            extern int getRenderDrawBlendMode(SDL_Renderer* renderer);
            extern Dynamic getRenderDrawColor(SDL_Renderer* renderer, Dynamic into);
            extern Dynamic getRenderDriverInfo(int index);
            extern Dynamic getRendererInfo(SDL_Renderer* renderer);
            extern Dynamic getRendererOutputSize(SDL_Renderer* renderer, Dynamic into);
            extern Uint8 getTextureAlphaMod(SDL_Texture* texture);
            extern int setTextureBlendMode(SDL_Texture* texture, int blend);
            extern int getTextureBlendMode(SDL_Texture* texture);
            extern Dynamic getTextureColorMod(SDL_Texture* texture, Dynamic into);
            extern int lockTexture(SDL_Texture* texture, Dynamic rect, Array<unsigned char> dest);
            extern Dynamic queryTexture(SDL_Texture* texture, Dynamic into);
            extern int updateTexture(SDL_Texture* texture, Dynamic rect, Array<unsigned char> pixels, int pitch);
            extern int updateYUVTexture(SDL_Texture* texture, Dynamic rect,
                                        Array<unsigned char> Yplane, int Ypitch,
                                        Array<unsigned char> Uplane, int Upitch,
                                        Array<unsigned char> Vplane, int Vpitch);
            extern int renderDrawRect(SDL_Renderer* renderer, Dynamic rect);
            extern int renderFillRect(SDL_Renderer* renderer, Dynamic rect);
            extern Dynamic renderGetClipRect(SDL_Renderer* renderer, Dynamic into);
            extern Dynamic renderGetLogicalSize(SDL_Renderer* renderer, Dynamic into);
            extern Dynamic renderGetScale(SDL_Renderer* renderer, Dynamic into);
            extern Dynamic renderGetViewport(SDL_Renderer* renderer, Dynamic into);
            extern int renderReadPixels(SDL_Renderer* renderer, Dynamic rect, int format, Array<unsigned char> dest, int pitch);
            extern int renderSetClipRect(SDL_Renderer* renderer, Dynamic rect);
            extern int renderSetViewport(SDL_Renderer* renderer, Dynamic rect);
            extern SDL_Surface* createRGBSurfaceFrom(Array<unsigned char> pixels, int width, int height, int depth, int pitch, int Rmask, int Gmask, int Bmask, int Amask);
            extern int blitSurface(SDL_Surface* src, Dynamic srcrect, SDL_Surface* dst, Dynamic dstrect);
            extern SDL_Cursor* createSystemCursor(int id);
            extern Dynamic joystickGetBall(SDL_Joystick* joystick, int ball, Dynamic into);
            extern ::String joystickGetGUIDString(Array<unsigned char> guid);
            extern void setModState(int modstate);
            extern void setTextInputRect(int x,int y, int w, int h);
            extern Dynamic getWindowSize(SDL_Window* window, Dynamic into);
            extern Dynamic getWindowPosition(SDL_Window* window, Dynamic into);
            extern Dynamic GL_GetDrawableSize(SDL_Window* window, Dynamic into);
            extern Dynamic getDisplayBounds(int display_index, Dynamic into);
            extern int renderCopy(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect);
            extern int renderCopyEx(SDL_Renderer* renderer, SDL_Texture* texture, Dynamic srcrect, Dynamic dstrect, Float angle, Dynamic center, int flip);
            extern Dynamic getDisplayMode(int display_index, int mode_index);
            extern Dynamic getDesktopDisplayMode(int display_index);
            extern Dynamic getCurrentDisplayMode(int display_index);
            extern Dynamic getGlobalMouseState(Dynamic into);
            extern Dynamic getMouseState(Dynamic into);
            extern Dynamic getRelativeMouseState(Dynamic into);
            extern int waitThread(SDL_Thread* thread);
            extern int addTimer(int interval);
            extern bool removeTimer(int timerID);
            extern int addEventWatch();
            extern void delEventWatch(int watchID);

            extern SDL_RWops* RWFromMem(Array<unsigned char> source, size_t size);
            extern int RWread(SDL_RWops* context, Array<unsigned char> ptr, size_t size, size_t maxnum);
            extern int RWwrite(SDL_RWops* context, Array<unsigned char> ptr, size_t size, size_t num);
            extern int RWseek(SDL_RWops* context, int64_t offset, int whence);
            extern int64_t RWsize(SDL_RWops* context);
            extern int64_t RWtell(SDL_RWops* context);
            extern int RWclose(SDL_RWops* context);


        //internal

            //event watches
            typedef ::cpp::Function < int(int, ::cpp::Reference<SDL_Event>) > InternalEventFilterFN;
            extern void init_event_watch( InternalEventFilterFN fn );

            //timers
            typedef ::cpp::Function < int(int) > InternalTimerCallbackFN;
            extern void init_timer( InternalTimerCallbackFN fn );

            //iOS callbacks
            #if defined(__IPHONEOS__) || defined(IPHONE)

            #if (HXCPP_API_LEVEL>=330)
                typedef void LincSDLVoid;
            #else
                typedef Void LincSDLVoid;
            #endif

                typedef ::cpp::Function < LincSDLVoid() > InternaliOSCallbackFN;
                extern void init_ios_callback( SDL_Window* window, int interval, InternaliOSCallbackFN fn );
            #endif

        //android helpers

            #if defined(ANDROID)

                    //Thanks to Hugh for pointing me to this helper in NME
                    //https://github.com/haxenme/nme/blob/b91b507a94f07d64ea7bea78dbe9092180317870/project/src/android/AndroidCommon.h#L19
                struct AutoHaxe {

                   int base;
                   const char *message;
                   AutoHaxe(const char *inMessage) {
                      base = 0;
                      message = inMessage;
                      ::hx::SetTopOfStack(&base, true);
                      // SDL_Log("AutoHaxe / enter %s %p", message, pthread_self());
                   }

                   ~AutoHaxe()
                   {
                      // SDL_Log("AutoHaxe / leave %s %p", message, pthread_self());
                      ::hx::SetTopOfStack((int*)0, true);
                   }
                };

            #endif

    } //sdl

} //linc

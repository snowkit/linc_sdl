package sdl;

@:keep @:include('linc_sdl.h') @:native("SDL_AudioSpec")
extern class SDL_AudioSpec {
	
}
typedef AudioSpec = cpp.Pointer<SDL_AudioSpec>;


@:enum
abstract SDLAudioFormat(UInt)
from UInt to UInt {
	inline function MASK_BITSIZE() 				return 0xFF;
	inline function MASK_DATATYPE()				return 1<<8;
	inline function MASK_ENDIAN() 				return 1<<12;
	inline function MASK_SIGNED() 				return 1 << 15;
	
	public inline function BITSIZE() 			return this & MASK_BITSIZE();
	public inline function ISFLOAT() 			return this & MASK_DATATYPE();
	public inline function ISBIGENDIAN()		return this & MASK_ENDIAN();
	public inline function ISSIGNED()			return this & MASK_SIGNED();
	public inline function ISINT()				return 0!=ISFLOAT();
	public inline function ISLITTLEENDIAN()		return 0!=ISBIGENDIAN();
	public inline function ISUNSIGNED()			return 0!=ISSIGNED();
} //SDLAudioFormat


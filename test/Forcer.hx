import haxe.macro.Expr;
import haxe.macro.Context;

class Forcer {

    macro public static function get() return macro $v{ Std.string(Date.now().getTime()) };

}
package linc;

import haxe.macro.Expr;
import haxe.macro.Context;

/** Adds a private internal inline static variable called __touch,
    which sets the value to the current time so that builds are always
    updated by the code, and native changes are dragged in automatically (except for header only changes) */
class Touch {

    macro public static function apply() : Array<Field> {

        var _fields = Context.getBuildFields();

        _fields.push({
            name: '__touch', pos: Context.currentPos(),
            doc: null, meta: [], access: [APrivate, AStatic, AInline],
            kind: FVar(macro : String, macro $v{ Std.string(Date.now().getTime()) }),
        });

        return _fields;

    } //apply

} //Touch
package tink.macro.tools;

import haxe.macro.Expr;

using tink.macro.tools.ExprTools;

class FunctionTools {
	static public inline function asExpr(f:Function, ?name, ?pos) {
		return EFunction(name, f).at(pos);
	}
	static public function toExpr(f:Function, ?name:String, ?pos:Position, ?at:haxe.PosInfos) {
		return MacroTools.deprecate(at, 'asExpr', asExpr(f, name, pos));
	}
	static public inline function toArg(name:String, ?t, ?opt = false, ?value = null):FunctionArg {
		return {
			name: name,
			opt: opt,
			type: t,
			value: value
		};
	}
	static public inline function func(e:Expr, ?args:Array<FunctionArg>, ?ret:ComplexType, ?params, ?makeReturn = true):Function {
		return {
			args: args == null ? [] : args,
			ret: ret,
			params: params == null ? [] : params,
			expr: if (makeReturn) EReturn(e).at(e.pos) else e
		}		
	}
	static public function getArgIdents(f:Function):Array<Expr> {
		var ret = [];
		for (arg in f.args)
			ret.push(arg.name.resolve());
		return ret;
	}
}

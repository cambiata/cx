package tink.core;

import tink.core.Callback;
import tink.core.Noise;

abstract Signal<T>(Callback<T>->CallbackLink) {
	
	public #if !as3 inline #end function new(f:Callback<T>->CallbackLink) this = f;	
	
	public #if !as3 inline #end function handle(handler:Callback<T>):CallbackLink 
		return (this)(handler);
	
	public function map<A>(f:T->A, ?gather = true):Signal<A> {
		var ret = new Signal(function (cb) return handle(this, function (result) cb.invoke(f(result))));
		return
			if (gather) ret.gather();
			else ret;
	}
	
	public function flatMap<A>(f:T->Future<A>, ?gather = true):Signal<A> {
		var ret = new Signal(function (cb) return handle(this, function (result) f(result).handle(cb)));
		return 
			if (gather) ret.gather() 
			else ret;
	}
	
	public function filter(f:T->Bool, ?gather = true):Signal<T> {
		var ret = new Signal(function (cb) return handle(this, function (result) if (f(result)) cb.invoke(result)));
		return
			if (gather) ret.gather();
			else ret;
	}
	
	public function join(other:Signal<T>, ?gather = true):Signal<T> {
		var ret = new Signal(
			function (cb:Callback<T>):CallbackLink 
				return [
					handle(this, cb),
					other.handle(cb)
				]
		);
		return
			if (gather) ret.gather();
			else ret;
	}
	
	public function next():Future<T> {
		var ret = Future.trigger();
		handle(handle(ret.trigger));
		return ret.asFuture();
	}
	
	public function noise():Signal<Noise>
		return map(function (_) return Noise);
	
	public function gather():Signal<T> {
		var ret = trigger();
		handle(ret.trigger);
		return ret.asSignal();
	}
	
	static public function trigger<T>():SignalTrigger<T>
		return new SignalTrigger();
		
	static public function ofClassical<A>(add:(A->Void)->Void, remove:(A->Void)->Void, ?gather = true) {
		var ret = new Signal(function (cb:Callback<A>) {
			var f = function (a) cb.invoke(a);
			add(f);
			return remove.bind(f);
		});
		return
			if (gather) ret.gather();
			else ret;
	}
}

abstract SignalTrigger<T>(CallbackList<T>) from CallbackList<T> {
	public #if !as3 inline #end function new() this = new CallbackList();
	public #if !as3 inline #end function trigger(event:T)
		this.invoke(event);
	public inline function getLength()
		return this.length;
	@:to public function asSignal():Signal<T> 
		return new Signal(this.add);
}
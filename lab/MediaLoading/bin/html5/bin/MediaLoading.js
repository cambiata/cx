(function () { "use strict";
var $hxClasses = {},$estr = function() { return js.Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function inherit() {}; inherit.prototype = from; var proto = new inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var ApplicationMain = function() { }
$hxClasses["ApplicationMain"] = ApplicationMain;
ApplicationMain.__name__ = ["ApplicationMain"];
ApplicationMain.main = function() {
	ApplicationMain.completed = 0;
	ApplicationMain.loaders = new haxe.ds.StringMap();
	ApplicationMain.urlLoaders = new haxe.ds.StringMap();
	ApplicationMain.total = 0;
	flash.Lib.get_current().loaderInfo = flash.display.LoaderInfo.create(null);
	try {
		if(Reflect.hasField(js.Browser.window,"winParameters")) flash.Lib.get_current().loaderInfo.parameters = (Reflect.field(js.Browser.window,"winParameters"))();
		flash.Lib.get_current().get_stage().loaderInfo = flash.Lib.get_current().loaderInfo;
	} catch( e ) {
	}
	ApplicationMain.preloader = new NMEPreloader();
	flash.Lib.get_current().addChild(ApplicationMain.preloader);
	ApplicationMain.preloader.onInit();
	var loader = new flash.display.Loader();
	ApplicationMain.loaders.set("img/test.png",loader);
	ApplicationMain.total++;
	var resourcePrefix = "NME_:bitmap_";
	var _g = 0, _g1 = haxe.Resource.listNames();
	while(_g < _g1.length) {
		var resourceName = _g1[_g];
		++_g;
		if(StringTools.startsWith(resourceName,resourcePrefix)) {
			var type = Type.resolveClass(StringTools.replace(resourceName.substring(resourcePrefix.length),"_","."));
			if(type != null) {
				ApplicationMain.total++;
				var instance = Type.createInstance(type,[0,0,true,16777215,ApplicationMain.bitmapClass_onComplete]);
			}
		}
	}
	if(ApplicationMain.total == 0) ApplicationMain.begin(); else {
		var $it0 = ApplicationMain.loaders.keys();
		while( $it0.hasNext() ) {
			var path = $it0.next();
			var loader1 = ApplicationMain.loaders.get(path);
			loader1.contentLoaderInfo.addEventListener("complete",ApplicationMain.loader_onComplete);
			loader1.load(new flash.net.URLRequest(path));
		}
		var $it1 = ApplicationMain.urlLoaders.keys();
		while( $it1.hasNext() ) {
			var path = $it1.next();
			var urlLoader = ApplicationMain.urlLoaders.get(path);
			urlLoader.addEventListener("complete",ApplicationMain.loader_onComplete);
			urlLoader.load(new flash.net.URLRequest(path));
		}
	}
}
ApplicationMain.begin = function() {
	ApplicationMain.preloader.addEventListener(flash.events.Event.COMPLETE,ApplicationMain.preloader_onComplete);
	ApplicationMain.preloader.onLoaded();
}
ApplicationMain.bitmapClass_onComplete = function(instance) {
	ApplicationMain.completed++;
	var classType = Type.getClass(instance);
	classType.preload = instance;
	if(ApplicationMain.completed == ApplicationMain.total) ApplicationMain.begin();
}
ApplicationMain.loader_onComplete = function(event) {
	ApplicationMain.completed++;
	ApplicationMain.preloader.onUpdate(ApplicationMain.completed,ApplicationMain.total);
	if(ApplicationMain.completed == ApplicationMain.total) ApplicationMain.begin();
}
ApplicationMain.preloader_onComplete = function(event) {
	ApplicationMain.preloader.removeEventListener(flash.events.Event.COMPLETE,ApplicationMain.preloader_onComplete);
	flash.Lib.get_current().removeChild(ApplicationMain.preloader);
	ApplicationMain.preloader = null;
	if(Reflect.field(scorx.media.main.test.Main,"main") == null) {
		var mainDisplayObj = Type.createInstance(DocumentClass,[]);
		if(js.Boot.__instanceof(mainDisplayObj,flash.display.DisplayObject)) flash.Lib.get_current().addChild(mainDisplayObj);
	} else Reflect.field(scorx.media.main.test.Main,"main").apply(scorx.media.main.test.Main,[]);
}
var scorx = {}
scorx.media = {}
scorx.media.main = {}
scorx.media.main.test = {}
scorx.media.main.test.Main = function() {
	new scorx.setup.InitApp();
	flash.Lib.get_current().addChild(new scorx.setup.UITest());
};
$hxClasses["scorx.media.main.test.Main"] = scorx.media.main.test.Main;
scorx.media.main.test.Main.__name__ = ["scorx","media","main","test","Main"];
scorx.media.main.test.Main.main = function() {
	flash.Lib.get_current().get_stage().align = flash.display.StageAlign.TOP_LEFT;
	flash.Lib.get_current().get_stage().scaleMode = flash.display.StageScaleMode.NO_SCALE;
	new scorx.media.main.test.Main();
}
scorx.media.main.test.Main.prototype = {
	__class__: scorx.media.main.test.Main
}
var DocumentClass = function() {
	scorx.media.main.test.Main.call(this);
};
$hxClasses["DocumentClass"] = DocumentClass;
DocumentClass.__name__ = ["DocumentClass"];
DocumentClass.__super__ = scorx.media.main.test.Main;
DocumentClass.prototype = $extend(scorx.media.main.test.Main.prototype,{
	__class__: DocumentClass
});
var Config = function() { }
$hxClasses["Config"] = Config;
Config.__name__ = ["Config"];
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
$hxClasses["EReg"] = EReg;
EReg.__name__ = ["EReg"];
EReg.prototype = {
	replace: function(s,by) {
		return s.replace(this.r,by);
	}
	,matchedPos: function() {
		if(this.r.m == null) throw "No string matched";
		return { pos : this.r.m.index, len : this.r.m[0].length};
	}
	,matchedRight: function() {
		if(this.r.m == null) throw "No string matched";
		var sz = this.r.m.index + this.r.m[0].length;
		return this.r.s.substr(sz,this.r.s.length - sz);
	}
	,matched: function(n) {
		return this.r.m != null && n >= 0 && n < this.r.m.length?this.r.m[n]:(function($this) {
			var $r;
			throw "EReg::matched";
			return $r;
		}(this));
	}
	,match: function(s) {
		if(this.r.global) this.r.lastIndex = 0;
		this.r.m = this.r.exec(s);
		this.r.s = s;
		return this.r.m != null;
	}
	,r: null
	,__class__: EReg
}
var HxOverrides = function() { }
$hxClasses["HxOverrides"] = HxOverrides;
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.strDate = function(s) {
	switch(s.length) {
	case 8:
		var k = s.split(":");
		var d = new Date();
		d.setTime(0);
		d.setUTCHours(k[0]);
		d.setUTCMinutes(k[1]);
		d.setUTCSeconds(k[2]);
		return d;
	case 10:
		var k = s.split("-");
		return new Date(k[0],k[1] - 1,k[2],0,0,0);
	case 19:
		var k = s.split(" ");
		var y = k[0].split("-");
		var t = k[1].split(":");
		return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
	default:
		throw "Invalid date format : " + s;
	}
}
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
}
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
}
HxOverrides.remove = function(a,obj) {
	var i = 0;
	var l = a.length;
	while(i < l) {
		if(a[i] == obj) {
			a.splice(i,1);
			return true;
		}
		i++;
	}
	return false;
}
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
}
var Lambda = function() { }
$hxClasses["Lambda"] = Lambda;
Lambda.__name__ = ["Lambda"];
Lambda.has = function(it,elt) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(x == elt) return true;
	}
	return false;
}
var List = function() {
	this.length = 0;
};
$hxClasses["List"] = List;
List.__name__ = ["List"];
List.prototype = {
	iterator: function() {
		return { h : this.h, hasNext : function() {
			return this.h != null;
		}, next : function() {
			if(this.h == null) return null;
			var x = this.h[0];
			this.h = this.h[1];
			return x;
		}};
	}
	,remove: function(v) {
		var prev = null;
		var l = this.h;
		while(l != null) {
			if(l[0] == v) {
				if(prev == null) this.h = l[1]; else prev[1] = l[1];
				if(this.q == l) this.q = prev;
				this.length--;
				return true;
			}
			prev = l;
			l = l[1];
		}
		return false;
	}
	,isEmpty: function() {
		return this.h == null;
	}
	,pop: function() {
		if(this.h == null) return null;
		var x = this.h[0];
		this.h = this.h[1];
		if(this.h == null) this.q = null;
		this.length--;
		return x;
	}
	,first: function() {
		return this.h == null?null:this.h[0];
	}
	,push: function(item) {
		var x = [item,this.h];
		this.h = x;
		if(this.q == null) this.q = x;
		this.length++;
	}
	,add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,length: null
	,q: null
	,h: null
	,__class__: List
}
var IMap = function() { }
$hxClasses["IMap"] = IMap;
IMap.__name__ = ["IMap"];
var flash = {}
flash.events = {}
flash.events.IEventDispatcher = function() { }
$hxClasses["flash.events.IEventDispatcher"] = flash.events.IEventDispatcher;
flash.events.IEventDispatcher.__name__ = ["flash","events","IEventDispatcher"];
flash.events.IEventDispatcher.prototype = {
	willTrigger: null
	,removeEventListener: null
	,hasEventListener: null
	,dispatchEvent: null
	,addEventListener: null
	,__class__: flash.events.IEventDispatcher
}
flash.events.EventDispatcher = function(target) {
	if(target != null) this.nmeTarget = target; else this.nmeTarget = this;
	this.nmeEventMap = [];
};
$hxClasses["flash.events.EventDispatcher"] = flash.events.EventDispatcher;
flash.events.EventDispatcher.__name__ = ["flash","events","EventDispatcher"];
flash.events.EventDispatcher.__interfaces__ = [flash.events.IEventDispatcher];
flash.events.EventDispatcher.compareListeners = function(l1,l2) {
	return l1.mPriority == l2.mPriority?0:l1.mPriority > l2.mPriority?-1:1;
}
flash.events.EventDispatcher.prototype = {
	willTrigger: function(type) {
		return this.hasEventListener(type);
	}
	,toString: function() {
		return "[ " + this.__name__ + " ]";
	}
	,setList: function(type,list) {
		this.nmeEventMap[type] = list;
	}
	,removeEventListener: function(type,listener,inCapture) {
		if(inCapture == null) inCapture = false;
		if(!this.existList(type)) return;
		var list = this.getList(type);
		var capture = inCapture == null?false:inCapture;
		var _g1 = 0, _g = list.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(list[i].Is(listener,capture)) {
				list.splice(i,1);
				return;
			}
		}
	}
	,hasEventListener: function(type) {
		return this.existList(type);
	}
	,getList: function(type) {
		return this.nmeEventMap[type];
	}
	,existList: function(type) {
		return this.nmeEventMap != null && this.nmeEventMap[type] != undefined;
	}
	,dispatchEvent: function(event) {
		if(event.target == null) event.target = this.nmeTarget;
		var capture = event.eventPhase == flash.events.EventPhase.CAPTURING_PHASE;
		if(this.existList(event.type)) {
			var list = this.getList(event.type);
			var idx = 0;
			while(idx < list.length) {
				var listener = list[idx];
				if(listener.mUseCapture == capture) {
					listener.dispatchEvent(event);
					if(event.nmeGetIsCancelledNow()) return true;
				}
				if(idx < list.length && listener != list[idx]) {
				} else idx++;
			}
			return true;
		}
		return false;
	}
	,addEventListener: function(type,inListener,useCapture,inPriority,useWeakReference) {
		if(useWeakReference == null) useWeakReference = false;
		if(inPriority == null) inPriority = 0;
		if(useCapture == null) useCapture = false;
		var capture = useCapture == null?false:useCapture;
		var priority = inPriority == null?0:inPriority;
		var list = this.getList(type);
		if(!this.existList(type)) {
			list = [];
			this.setList(type,list);
		}
		list.push(new flash.events.Listener(inListener,capture,priority));
		list.sort(flash.events.EventDispatcher.compareListeners);
	}
	,nmeEventMap: null
	,nmeTarget: null
	,__class__: flash.events.EventDispatcher
}
flash.display = {}
flash.display.IBitmapDrawable = function() { }
$hxClasses["flash.display.IBitmapDrawable"] = flash.display.IBitmapDrawable;
flash.display.IBitmapDrawable.__name__ = ["flash","display","IBitmapDrawable"];
flash.display.IBitmapDrawable.prototype = {
	drawToSurface: null
	,__class__: flash.display.IBitmapDrawable
}
flash.display.DisplayObject = function() {
	flash.events.EventDispatcher.call(this,null);
	this._nmeId = flash.utils.Uuid.uuid();
	this.set_parent(null);
	this.set_transform(new flash.geom.Transform(this));
	this.nmeX = 0.0;
	this.nmeY = 0.0;
	this.nmeScaleX = 1.0;
	this.nmeScaleY = 1.0;
	this.nmeRotation = 0.0;
	this.nmeWidth = 0.0;
	this.nmeHeight = 0.0;
	this.set_visible(true);
	this.alpha = 1.0;
	this.nmeFilters = new Array();
	this.nmeBoundsRect = new flash.geom.Rectangle();
	this.nmeScrollRect = null;
	this.nmeMask = null;
	this.nmeMaskingObj = null;
	this.set_nmeCombinedVisible(this.get_visible());
};
$hxClasses["flash.display.DisplayObject"] = flash.display.DisplayObject;
flash.display.DisplayObject.__name__ = ["flash","display","DisplayObject"];
flash.display.DisplayObject.__interfaces__ = [flash.display.IBitmapDrawable];
flash.display.DisplayObject.__super__ = flash.events.EventDispatcher;
flash.display.DisplayObject.prototype = $extend(flash.events.EventDispatcher.prototype,{
	nmeSrUpdateDivs: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx == null || this.parent == null) return;
		if(this.nmeScrollRect == null) {
			if(this._srAxes != null && gfx.nmeSurface.parentNode == this._srAxes && this._srWindow.parentNode != null) this._srWindow.parentNode.replaceChild(gfx.nmeSurface,this._srWindow);
			return;
		}
		if(this._srWindow == null) {
			this._srWindow = js.Browser.document.createElement("div");
			this._srAxes = js.Browser.document.createElement("div");
			this._srWindow.style.setProperty("position","absolute","");
			this._srWindow.style.setProperty("left","0px","");
			this._srWindow.style.setProperty("top","0px","");
			this._srWindow.style.setProperty("width","0px","");
			this._srWindow.style.setProperty("height","0px","");
			this._srWindow.style.setProperty("overflow","hidden","");
			this._srAxes.style.setProperty("position","absolute","");
			this._srAxes.style.setProperty("left","0px","");
			this._srAxes.style.setProperty("top","0px","");
			this._srWindow.appendChild(this._srAxes);
		}
		var pnt = this.parent.localToGlobal(new flash.geom.Point(this.get_x(),this.get_y()));
		this._srWindow.style.left = pnt.x + "px";
		this._srWindow.style.top = pnt.y + "px";
		this._srWindow.style.width = this.nmeScrollRect.width + "px";
		this._srWindow.style.height = this.nmeScrollRect.height + "px";
		this._srAxes.style.left = -pnt.x - this.nmeScrollRect.x + "px";
		this._srAxes.style.top = -pnt.y - this.nmeScrollRect.y + "px";
		if(gfx.nmeSurface.parentNode != this._srAxes && gfx.nmeSurface.parentNode != null) {
			gfx.nmeSurface.parentNode.insertBefore(this._srWindow,gfx.nmeSurface);
			flash.Lib.nmeRemoveSurface(gfx.nmeSurface);
			this._srAxes.appendChild(gfx.nmeSurface);
		}
	}
	,nmeGetSrWindow: function() {
		return this._srWindow;
	}
	,set_width: function(inValue) {
		if(this.get__boundsInvalid()) this.validateBounds();
		var w = this.nmeBoundsRect.width;
		if(this.nmeScaleX * w != inValue) {
			if(w == 0) {
				this.nmeScaleX = 1;
				this.nmeInvalidateMatrix(true);
				this._nmeRenderFlags |= 64;
				if(this.parent != null) this.parent._nmeRenderFlags |= 64;
				w = this.nmeBoundsRect.width;
			}
			if(w <= 0) return 0;
			this.nmeScaleX = inValue / w;
			this.nmeInvalidateMatrix(true);
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		}
		return inValue;
	}
	,get_width: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.nmeWidth;
	}
	,set_y: function(inValue) {
		if(this.nmeY != inValue) {
			this.nmeY = inValue;
			this.nmeInvalidateMatrix(true);
			if(this.parent != null) this.parent.nmeInvalidateBounds();
		}
		return inValue;
	}
	,get_y: function() {
		return this.nmeY;
	}
	,set_x: function(inValue) {
		if(this.nmeX != inValue) {
			this.nmeX = inValue;
			this.nmeInvalidateMatrix(true);
			if(this.parent != null) this.parent.nmeInvalidateBounds();
		}
		return inValue;
	}
	,get_x: function() {
		return this.nmeX;
	}
	,set_visible: function(inValue) {
		if(this.nmeVisible != inValue) {
			this.nmeVisible = inValue;
			this.setSurfaceVisible(inValue);
		}
		return this.nmeVisible;
	}
	,get_visible: function() {
		return this.nmeVisible;
	}
	,set_transform: function(inValue) {
		this.transform = inValue;
		this.nmeX = this.transform.get_matrix().tx;
		this.nmeY = this.transform.get_matrix().ty;
		this.nmeInvalidateMatrix(true);
		return inValue;
	}
	,get__topmostSurface: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null) return gfx.nmeSurface;
		return null;
	}
	,get_stage: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null) return flash.Lib.nmeGetStage();
		return null;
	}
	,set_scrollRect: function(inValue) {
		this.nmeScrollRect = inValue;
		this.nmeSrUpdateDivs();
		return inValue;
	}
	,get_scrollRect: function() {
		if(this.nmeScrollRect == null) return null;
		return this.nmeScrollRect.clone();
	}
	,set_scaleY: function(inValue) {
		if(this.nmeScaleY != inValue) {
			this.nmeScaleY = inValue;
			this.nmeInvalidateMatrix(true);
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		}
		return inValue;
	}
	,get_scaleY: function() {
		return this.nmeScaleY;
	}
	,set_scaleX: function(inValue) {
		if(this.nmeScaleX != inValue) {
			this.nmeScaleX = inValue;
			this.nmeInvalidateMatrix(true);
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		}
		return inValue;
	}
	,get_scaleX: function() {
		return this.nmeScaleX;
	}
	,set_rotation: function(inValue) {
		if(this.nmeRotation != inValue) {
			this.nmeRotation = inValue;
			this.nmeInvalidateMatrix(true);
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		}
		return inValue;
	}
	,get_rotation: function() {
		return this.nmeRotation;
	}
	,set_parent: function(inValue) {
		if(inValue == this.parent) return inValue;
		this.nmeInvalidateMatrix();
		if(this.parent != null) {
			HxOverrides.remove(this.parent.nmeChildren,this);
			this.parent.nmeInvalidateBounds();
		}
		if(inValue != null) {
			inValue._nmeRenderFlags |= 64;
			if(inValue.parent != null) inValue.parent._nmeRenderFlags |= 64;
		}
		if(this.parent == null && inValue != null) {
			this.parent = inValue;
			var evt = new flash.events.Event(flash.events.Event.ADDED,true,false);
			this.dispatchEvent(evt);
		} else if(this.parent != null && inValue == null) {
			this.parent = inValue;
			var evt = new flash.events.Event(flash.events.Event.REMOVED,true,false);
			this.dispatchEvent(evt);
		} else this.parent = inValue;
		return inValue;
	}
	,set_nmeCombinedVisible: function(inValue) {
		if(this.nmeCombinedVisible != inValue) {
			this.nmeCombinedVisible = inValue;
			this.setSurfaceVisible(inValue);
		}
		return this.nmeCombinedVisible;
	}
	,get_mouseY: function() {
		return this.globalToLocal(new flash.geom.Point(0,this.get_stage().get_mouseY())).y;
	}
	,get_mouseX: function() {
		return this.globalToLocal(new flash.geom.Point(this.get_stage().get_mouseX(),0)).x;
	}
	,get__matrixInvalid: function() {
		return (this._nmeRenderFlags & 4) != 0;
	}
	,get__matrixChainInvalid: function() {
		return (this._nmeRenderFlags & 8) != 0;
	}
	,set_mask: function(inValue) {
		if(this.nmeMask != null) this.nmeMask.nmeMaskingObj = null;
		this.nmeMask = inValue;
		if(this.nmeMask != null) this.nmeMask.nmeMaskingObj = this;
		return this.nmeMask;
	}
	,get_mask: function() {
		return this.nmeMask;
	}
	,set_height: function(inValue) {
		if(this.get__boundsInvalid()) this.validateBounds();
		var h = this.nmeBoundsRect.height;
		if(this.nmeScaleY * h != inValue) {
			if(h == 0) {
				this.nmeScaleY = 1;
				this.nmeInvalidateMatrix(true);
				this._nmeRenderFlags |= 64;
				if(this.parent != null) this.parent._nmeRenderFlags |= 64;
				h = this.nmeBoundsRect.height;
			}
			if(h <= 0) return 0;
			this.nmeScaleY = inValue / h;
			this.nmeInvalidateMatrix(true);
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		}
		return inValue;
	}
	,get_height: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.nmeHeight;
	}
	,set_filters: function(filters) {
		var oldFilterCount = this.nmeFilters == null?0:this.nmeFilters.length;
		if(filters == null) {
			this.nmeFilters = null;
			if(oldFilterCount > 0) this.invalidateGraphics();
		} else {
			this.nmeFilters = new Array();
			var _g = 0;
			while(_g < filters.length) {
				var filter = filters[_g];
				++_g;
				this.nmeFilters.push(filter.clone());
			}
			this.invalidateGraphics();
		}
		return filters;
	}
	,get__boundsInvalid: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx == null) return (this._nmeRenderFlags & 64) != 0; else return (this._nmeRenderFlags & 64) != 0 || gfx.boundsDirty;
	}
	,get_filters: function() {
		if(this.nmeFilters == null) return [];
		var result = new Array();
		var _g = 0, _g1 = this.nmeFilters;
		while(_g < _g1.length) {
			var filter = _g1[_g];
			++_g;
			result.push(filter.clone());
		}
		return result;
	}
	,get__bottommostSurface: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null) return gfx.nmeSurface;
		return null;
	}
	,__contains: function(child) {
		return false;
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			var gfx = this.nmeGetGraphics();
			if(gfx == null) {
				this.nmeBoundsRect.x = this.get_x();
				this.nmeBoundsRect.y = this.get_y();
				this.nmeBoundsRect.width = 0;
				this.nmeBoundsRect.height = 0;
			} else {
				this.nmeBoundsRect = gfx.nmeExtent.clone();
				if(this.scale9Grid != null) {
					this.nmeBoundsRect.width *= this.nmeScaleX;
					this.nmeBoundsRect.height *= this.nmeScaleY;
					this.nmeWidth = this.nmeBoundsRect.width;
					this.nmeHeight = this.nmeBoundsRect.height;
				} else {
					this.nmeWidth = this.nmeBoundsRect.width * this.nmeScaleX;
					this.nmeHeight = this.nmeBoundsRect.height * this.nmeScaleY;
				}
				gfx.boundsDirty = false;
			}
			this._nmeRenderFlags &= -65;
		}
	}
	,toString: function() {
		return "[DisplayObject name=" + this.name + " id=" + this._nmeId + "]";
	}
	,setSurfaceVisible: function(inValue) {
		var gfx = this.nmeGetGraphics();
		if(gfx != null && gfx.nmeSurface != null) flash.Lib.nmeSetSurfaceVisible(gfx.nmeSurface,inValue);
	}
	,nmeValidateMatrix: function() {
		var parentMatrixInvalid = (this._nmeRenderFlags & 8) != 0 && this.parent != null;
		if((this._nmeRenderFlags & 4) != 0 || parentMatrixInvalid) {
			if(parentMatrixInvalid) this.parent.nmeValidateMatrix();
			var m = this.transform.get_matrix();
			if((this._nmeRenderFlags & 16) != 0) this._nmeRenderFlags &= -5;
			if((this._nmeRenderFlags & 4) != 0) {
				m.identity();
				m.scale(this.nmeScaleX,this.nmeScaleY);
				var rad = this.nmeRotation * flash.geom.Transform.DEG_TO_RAD;
				if(rad != 0.0) m.rotate(rad);
				m.translate(this.nmeX,this.nmeY);
				this.transform._matrix.copy(m);
				m;
			}
			var cm = this.transform.nmeGetFullMatrix(null);
			var fm = this.parent == null?m:this.parent.transform.nmeGetFullMatrix(m);
			this._fullScaleX = fm._sx;
			this._fullScaleY = fm._sy;
			if(cm.a != fm.a || cm.b != fm.b || cm.c != fm.c || cm.d != fm.d || cm.tx != fm.tx || cm.ty != fm.ty) {
				this.transform.nmeSetFullMatrix(fm);
				this._nmeRenderFlags |= 32;
			}
			this._nmeRenderFlags &= -29;
		}
	}
	,nmeUnifyChildrenWithDOM: function(lastMoveObj) {
		var gfx = this.nmeGetGraphics();
		if(gfx != null && lastMoveObj != null && this != lastMoveObj) {
			var ogfx = lastMoveObj.nmeGetGraphics();
			if(ogfx != null) flash.Lib.nmeSetSurfaceZIndexAfter(this.nmeScrollRect == null?gfx.nmeSurface:this._srWindow,lastMoveObj.nmeScrollRect == null?ogfx.nmeSurface:lastMoveObj == this.parent?ogfx.nmeSurface:lastMoveObj._srWindow);
		}
		if(gfx == null) return lastMoveObj; else return this;
	}
	,nmeTestFlag: function(mask) {
		return (this._nmeRenderFlags & mask) != 0;
	}
	,nmeSetMatrix: function(inValue) {
		this.transform._matrix.copy(inValue);
		return inValue;
	}
	,nmeSetFullMatrix: function(inValue) {
		return this.transform.nmeSetFullMatrix(inValue);
	}
	,nmeSetFlagToValue: function(mask,value) {
		if(value) this._nmeRenderFlags |= mask; else this._nmeRenderFlags &= ~mask;
	}
	,nmeSetFlag: function(mask) {
		this._nmeRenderFlags |= mask;
	}
	,nmeSetDimensions: function() {
		if(this.scale9Grid != null) {
			this.nmeBoundsRect.width *= this.nmeScaleX;
			this.nmeBoundsRect.height *= this.nmeScaleY;
			this.nmeWidth = this.nmeBoundsRect.width;
			this.nmeHeight = this.nmeBoundsRect.height;
		} else {
			this.nmeWidth = this.nmeBoundsRect.width * this.nmeScaleX;
			this.nmeHeight = this.nmeBoundsRect.height * this.nmeScaleY;
		}
	}
	,nmeRender: function(inMask,clipRect) {
		if(!this.nmeCombinedVisible) return;
		var gfx = this.nmeGetGraphics();
		if(gfx == null) return;
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		if(gfx.nmeRender(inMask,this.nmeFilters,1,1)) {
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
			this.nmeApplyFilters(gfx.nmeSurface);
			this._nmeRenderFlags |= 32;
		}
		var fullAlpha = (this.parent != null?this.parent.nmeCombinedAlpha:1) * this.alpha;
		if(inMask != null) {
			var m = this.getSurfaceTransform(gfx);
			flash.Lib.nmeDrawToSurface(gfx.nmeSurface,inMask,m,fullAlpha,clipRect);
		} else {
			if((this._nmeRenderFlags & 32) != 0) {
				var m = this.getSurfaceTransform(gfx);
				flash.Lib.nmeSetSurfaceTransform(gfx.nmeSurface,m);
				this._nmeRenderFlags &= -33;
				this.nmeSrUpdateDivs();
			}
			flash.Lib.nmeSetSurfaceOpacity(gfx.nmeSurface,fullAlpha);
		}
	}
	,nmeRemoveFromStage: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null && flash.Lib.nmeIsOnStage(gfx.nmeSurface)) {
			flash.Lib.nmeRemoveSurface(gfx.nmeSurface);
			var evt = new flash.events.Event(flash.events.Event.REMOVED_FROM_STAGE,false,false);
			this.dispatchEvent(evt);
		}
	}
	,nmeMatrixOverridden: function() {
		this.nmeX = this.transform.get_matrix().tx;
		this.nmeY = this.transform.get_matrix().ty;
		this._nmeRenderFlags |= 16;
		this._nmeRenderFlags |= 4;
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
	}
	,nmeIsOnStage: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null && flash.Lib.nmeIsOnStage(gfx.nmeSurface)) return true;
		return false;
	}
	,nmeInvalidateMatrix: function(local) {
		if(local == null) local = false;
		if(local) this._nmeRenderFlags |= 4; else this._nmeRenderFlags |= 8;
	}
	,nmeInvalidateBounds: function() {
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
	}
	,nmeGetSurface: function() {
		var gfx = this.nmeGetGraphics();
		var surface = null;
		if(gfx != null) surface = gfx.nmeSurface;
		return surface;
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null;
		var gfx = this.nmeGetGraphics();
		if(gfx != null) {
			gfx.nmeRender();
			var extX = gfx.nmeExtent.x;
			var extY = gfx.nmeExtent.y;
			var local = this.globalToLocal(point);
			if(local.x - extX <= 0 || local.y - extY <= 0 || (local.x - extX) * this.get_scaleX() > this.get_width() || (local.y - extY) * this.get_scaleY() > this.get_height()) return null;
			if(gfx.nmeHitTest(local.x,local.y)) return this;
		}
		return null;
	}
	,nmeGetMatrix: function() {
		return this.transform.get_matrix();
	}
	,nmeGetInteractiveObjectStack: function(outStack) {
		var io = this;
		if(io != null) outStack.push(io);
		if(this.parent != null) this.parent.nmeGetInteractiveObjectStack(outStack);
	}
	,nmeGetGraphics: function() {
		return null;
	}
	,nmeGetFullMatrix: function(localMatrix) {
		return this.transform.nmeGetFullMatrix(localMatrix);
	}
	,nmeFireEvent: function(event) {
		var stack = [];
		if(this.parent != null) this.parent.nmeGetInteractiveObjectStack(stack);
		var l = stack.length;
		if(l > 0) {
			event.nmeSetPhase(flash.events.EventPhase.CAPTURING_PHASE);
			stack.reverse();
			var _g = 0;
			while(_g < stack.length) {
				var obj = stack[_g];
				++_g;
				event.currentTarget = obj;
				obj.nmeDispatchEvent(event);
				if(event.nmeGetIsCancelled()) return;
			}
		}
		event.nmeSetPhase(flash.events.EventPhase.AT_TARGET);
		event.currentTarget = this;
		this.nmeDispatchEvent(event);
		if(event.nmeGetIsCancelled()) return;
		if(event.bubbles) {
			event.nmeSetPhase(flash.events.EventPhase.BUBBLING_PHASE);
			stack.reverse();
			var _g = 0;
			while(_g < stack.length) {
				var obj = stack[_g];
				++_g;
				event.currentTarget = obj;
				obj.nmeDispatchEvent(event);
				if(event.nmeGetIsCancelled()) return;
			}
		}
	}
	,nmeDispatchEvent: function(event) {
		if(event.target == null) event.target = this;
		event.currentTarget = this;
		return flash.events.EventDispatcher.prototype.dispatchEvent.call(this,event);
	}
	,nmeClearFlag: function(mask) {
		this._nmeRenderFlags &= ~mask;
	}
	,nmeBroadcast: function(event) {
		this.nmeDispatchEvent(event);
	}
	,nmeApplyFilters: function(surface) {
		if(this.nmeFilters != null) {
			var _g = 0, _g1 = this.nmeFilters;
			while(_g < _g1.length) {
				var filter = _g1[_g];
				++_g;
				filter.nmeApplyFilter(surface);
			}
		}
	}
	,nmeAddToStage: function(newParent,beforeSibling) {
		var gfx = this.nmeGetGraphics();
		if(gfx == null) return;
		if(newParent.nmeGetGraphics() != null) {
			flash.Lib.nmeSetSurfaceId(gfx.nmeSurface,this._nmeId);
			if(beforeSibling != null && beforeSibling.nmeGetGraphics() != null) flash.Lib.nmeAppendSurface(gfx.nmeSurface,beforeSibling.get__bottommostSurface()); else {
				var stageChildren = [];
				var _g = 0, _g1 = newParent.nmeChildren;
				while(_g < _g1.length) {
					var child = _g1[_g];
					++_g;
					if(child.get_stage() != null) stageChildren.push(child);
				}
				if(stageChildren.length < 1) flash.Lib.nmeAppendSurface(gfx.nmeSurface,null,newParent.get__topmostSurface()); else {
					var nextSibling = stageChildren[stageChildren.length - 1];
					var container;
					while(js.Boot.__instanceof(nextSibling,flash.display.DisplayObjectContainer)) {
						container = js.Boot.__cast(nextSibling , flash.display.DisplayObjectContainer);
						if(container.nmeChildren.length > 0) nextSibling = container.nmeChildren[container.nmeChildren.length - 1]; else break;
					}
					if(nextSibling.nmeGetGraphics() != gfx) flash.Lib.nmeAppendSurface(gfx.nmeSurface,null,nextSibling.get__topmostSurface()); else flash.Lib.nmeAppendSurface(gfx.nmeSurface);
				}
			}
			flash.Lib.nmeSetSurfaceTransform(gfx.nmeSurface,this.getSurfaceTransform(gfx));
		} else if(newParent.name == "Stage") flash.Lib.nmeAppendSurface(gfx.nmeSurface);
		if(this.nmeIsOnStage()) {
			this.nmeSrUpdateDivs();
			var evt = new flash.events.Event(flash.events.Event.ADDED_TO_STAGE,false,false);
			this.dispatchEvent(evt);
		}
	}
	,localToGlobal: function(point) {
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		return this.transform.nmeGetFullMatrix(null).transformPoint(point);
	}
	,invalidateGraphics: function() {
		var gfx = this.nmeGetGraphics();
		if(gfx != null) {
			gfx.nmeChanged = true;
			gfx.nmeClearNextCycle = true;
		}
	}
	,hitTestPoint: function(x,y,shapeFlag) {
		if(shapeFlag == null) shapeFlag = false;
		var boundingBox = shapeFlag == null?true:!shapeFlag;
		if(!boundingBox) return this.nmeGetObjectUnderPoint(new flash.geom.Point(x,y)) != null; else {
			var gfx = this.nmeGetGraphics();
			if(gfx != null) {
				var extX = gfx.nmeExtent.x;
				var extY = gfx.nmeExtent.y;
				var local = this.globalToLocal(new flash.geom.Point(x,y));
				if(local.x - extX < 0 || local.y - extY < 0 || (local.x - extX) * this.get_scaleX() > this.get_width() || (local.y - extY) * this.get_scaleY() > this.get_height()) return false; else return true;
			}
			return false;
		}
	}
	,hitTestObject: function(obj) {
		if(obj != null && obj.parent != null && this.parent != null) {
			var currentBounds = this.getBounds(this);
			var targetBounds = obj.getBounds(this);
			return currentBounds.intersects(targetBounds);
		}
		return false;
	}
	,handleGraphicsUpdated: function(gfx) {
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		this.nmeApplyFilters(gfx.nmeSurface);
		this._nmeRenderFlags |= 32;
	}
	,globalToLocal: function(inPos) {
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		return this.transform.nmeGetFullMatrix(null).invert().transformPoint(inPos);
	}
	,getSurfaceTransform: function(gfx) {
		var extent = gfx.nmeExtentWithFilters;
		var fm = this.transform.nmeGetFullMatrix(null);
		fm.nmeTranslateTransformed(extent.get_topLeft());
		return fm;
	}
	,getScreenBounds: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.nmeBoundsRect.clone();
	}
	,getRect: function(targetCoordinateSpace) {
		return this.getBounds(targetCoordinateSpace);
	}
	,getBounds: function(targetCoordinateSpace) {
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		if(this.get__boundsInvalid()) this.validateBounds();
		var m = this.transform.nmeGetFullMatrix(null);
		if(targetCoordinateSpace != null) m.concat(targetCoordinateSpace.transform.nmeGetFullMatrix(null).invert());
		var rect = this.nmeBoundsRect.transform(m);
		return rect;
	}
	,drawToSurface: function(inSurface,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		var oldAlpha = this.alpha;
		this.alpha = 1;
		this.nmeRender(inSurface,clipRect);
		this.alpha = oldAlpha;
	}
	,dispatchEvent: function(event) {
		var result = this.nmeDispatchEvent(event);
		if(event.nmeGetIsCancelled()) return true;
		if(event.bubbles && this.parent != null) this.parent.dispatchEvent(event);
		return result;
	}
	,_srAxes: null
	,_srWindow: null
	,_topmostSurface: null
	,_nmeRenderFlags: null
	,_nmeId: null
	,_fullScaleY: null
	,_fullScaleX: null
	,_bottommostSurface: null
	,nmeY: null
	,nmeX: null
	,nmeWidth: null
	,nmeVisible: null
	,nmeScrollRect: null
	,nmeScaleY: null
	,nmeScaleX: null
	,nmeRotation: null
	,nmeMaskingObj: null
	,nmeMask: null
	,nmeHeight: null
	,nmeFilters: null
	,nmeBoundsRect: null
	,transform: null
	,scale9Grid: null
	,parent: null
	,nmeCombinedVisible: null
	,name: null
	,loaderInfo: null
	,cacheAsBitmap: null
	,blendMode: null
	,alpha: null
	,accessibilityProperties: null
	,__class__: flash.display.DisplayObject
	,__properties__: {set_filters:"set_filters",get_filters:"get_filters",set_height:"set_height",get_height:"get_height",set_mask:"set_mask",get_mask:"get_mask",get_mouseX:"get_mouseX",get_mouseY:"get_mouseY",set_nmeCombinedVisible:"set_nmeCombinedVisible",set_parent:"set_parent",set_rotation:"set_rotation",get_rotation:"get_rotation",set_scaleX:"set_scaleX",get_scaleX:"get_scaleX",set_scaleY:"set_scaleY",get_scaleY:"get_scaleY",set_scrollRect:"set_scrollRect",get_scrollRect:"get_scrollRect",get_stage:"get_stage",set_transform:"set_transform",set_visible:"set_visible",get_visible:"get_visible",set_width:"set_width",get_width:"get_width",set_x:"set_x",get_x:"get_x",set_y:"set_y",get_y:"get_y",get__bottommostSurface:"get__bottommostSurface",get__boundsInvalid:"get__boundsInvalid",get__matrixChainInvalid:"get__matrixChainInvalid",get__matrixInvalid:"get__matrixInvalid",get__topmostSurface:"get__topmostSurface"}
});
flash.display.InteractiveObject = function() {
	flash.display.DisplayObject.call(this);
	this.tabEnabled = false;
	this.mouseEnabled = true;
	this.doubleClickEnabled = true;
	this.set_tabIndex(0);
};
$hxClasses["flash.display.InteractiveObject"] = flash.display.InteractiveObject;
flash.display.InteractiveObject.__name__ = ["flash","display","InteractiveObject"];
flash.display.InteractiveObject.__super__ = flash.display.DisplayObject;
flash.display.InteractiveObject.prototype = $extend(flash.display.DisplayObject.prototype,{
	set_tabIndex: function(inIndex) {
		return this.nmeTabIndex = inIndex;
	}
	,get_tabIndex: function() {
		return this.nmeTabIndex;
	}
	,toString: function() {
		return "[InteractiveObject name=" + this.name + " id=" + this._nmeId + "]";
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(!this.mouseEnabled) return null; else return flash.display.DisplayObject.prototype.nmeGetObjectUnderPoint.call(this,point);
	}
	,nmeTabIndex: null
	,nmeDoubleClickEnabled: null
	,tabEnabled: null
	,mouseEnabled: null
	,focusRect: null
	,doubleClickEnabled: null
	,__class__: flash.display.InteractiveObject
	,__properties__: $extend(flash.display.DisplayObject.prototype.__properties__,{set_tabIndex:"set_tabIndex",get_tabIndex:"get_tabIndex"})
});
flash.display.DisplayObjectContainer = function() {
	this.nmeChildren = new Array();
	this.mouseChildren = true;
	this.tabChildren = true;
	flash.display.InteractiveObject.call(this);
	this.nmeCombinedAlpha = this.alpha;
};
$hxClasses["flash.display.DisplayObjectContainer"] = flash.display.DisplayObjectContainer;
flash.display.DisplayObjectContainer.__name__ = ["flash","display","DisplayObjectContainer"];
flash.display.DisplayObjectContainer.__super__ = flash.display.InteractiveObject;
flash.display.DisplayObjectContainer.prototype = $extend(flash.display.InteractiveObject.prototype,{
	set_scrollRect: function(inValue) {
		inValue = flash.display.InteractiveObject.prototype.set_scrollRect.call(this,inValue);
		this.nmeUnifyChildrenWithDOM();
		return inValue;
	}
	,set_visible: function(inVal) {
		this.set_nmeCombinedVisible(inVal);
		return flash.display.InteractiveObject.prototype.set_visible.call(this,inVal);
	}
	,get_numChildren: function() {
		return this.nmeChildren.length;
	}
	,set_nmeCombinedVisible: function(inVal) {
		if(inVal != this.nmeCombinedVisible) {
			var _g = 0, _g1 = this.nmeChildren;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				child.set_nmeCombinedVisible(child.get_visible() && inVal);
			}
		}
		return flash.display.InteractiveObject.prototype.set_nmeCombinedVisible.call(this,inVal);
	}
	,set_filters: function(filters) {
		flash.display.InteractiveObject.prototype.set_filters.call(this,filters);
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.set_filters(filters);
		}
		return filters;
	}
	,__contains: function(child) {
		if(child == null) return false;
		if(this == child) return true;
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c == child || c.__contains(child)) return true;
		}
		return false;
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.InteractiveObject.prototype.validateBounds.call(this);
			var _g = 0, _g1 = this.nmeChildren;
			while(_g < _g1.length) {
				var obj = _g1[_g];
				++_g;
				if(obj.get_visible()) {
					var r = obj.getBounds(this);
					if(r.width != 0 || r.height != 0) {
						if(this.nmeBoundsRect.width == 0 && this.nmeBoundsRect.height == 0) this.nmeBoundsRect = r.clone(); else this.nmeBoundsRect.extendBounds(r);
					}
				}
			}
			if(this.scale9Grid != null) {
				this.nmeBoundsRect.width *= this.nmeScaleX;
				this.nmeBoundsRect.height *= this.nmeScaleY;
				this.nmeWidth = this.nmeBoundsRect.width;
				this.nmeHeight = this.nmeBoundsRect.height;
			} else {
				this.nmeWidth = this.nmeBoundsRect.width * this.nmeScaleX;
				this.nmeHeight = this.nmeBoundsRect.height * this.nmeScaleY;
			}
		}
	}
	,toString: function() {
		return "[DisplayObjectContainer name=" + this.name + " id=" + this._nmeId + "]";
	}
	,swapChildrenAt: function(child1,child2) {
		var swap = this.nmeChildren[child1];
		this.nmeChildren[child1] = this.nmeChildren[child2];
		this.nmeChildren[child2] = swap;
		swap = null;
	}
	,swapChildren: function(child1,child2) {
		var c1 = -1;
		var c2 = -1;
		var swap;
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.nmeChildren[i] == child1) c1 = i; else if(this.nmeChildren[i] == child2) c2 = i;
		}
		if(c1 != -1 && c2 != -1) {
			swap = this.nmeChildren[c1];
			this.nmeChildren[c1] = this.nmeChildren[c2];
			this.nmeChildren[c2] = swap;
			swap = null;
			this.nmeSwapSurface(c1,c2);
			child1.nmeUnifyChildrenWithDOM();
			child2.nmeUnifyChildrenWithDOM();
		}
	}
	,setChildIndex: function(child,index) {
		if(index > this.nmeChildren.length) throw "Invalid index position " + index;
		var oldIndex = this.getChildIndex(child);
		if(oldIndex < 0) {
			var msg = "setChildIndex : object " + child.name + " not found.";
			if(child.parent == this) {
				var realindex = -1;
				var _g1 = 0, _g = this.nmeChildren.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(this.nmeChildren[i] == child) {
						realindex = i;
						break;
					}
				}
				if(realindex != -1) msg += "Internal error: Real child index was " + Std.string(realindex); else msg += "Internal error: Child was not in nmeChildren array!";
			}
			throw msg;
		}
		if(index < oldIndex) {
			var i = oldIndex;
			while(i > index) {
				this.swapChildren(this.nmeChildren[i],this.nmeChildren[i - 1]);
				i--;
			}
		} else if(oldIndex < index) {
			var i = oldIndex;
			while(i < index) {
				this.swapChildren(this.nmeChildren[i],this.nmeChildren[i + 1]);
				i++;
			}
		}
	}
	,removeChildAt: function(index) {
		if(index >= 0 && index < this.nmeChildren.length) return this.nmeRemoveChild(this.nmeChildren[index]);
		throw "removeChildAt(" + index + ") : none found?";
	}
	,removeChild: function(inChild) {
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child == inChild) return (function($this) {
				var $r;
				child.nmeRemoveFromStage();
				child.set_parent(null);
				$r = child;
				return $r;
			}(this));
		}
		throw "removeChild : none found?";
	}
	,nmeUnifyChildrenWithDOM: function(lastMoveObj) {
		var obj = flash.display.InteractiveObject.prototype.nmeUnifyChildrenWithDOM.call(this,lastMoveObj);
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			obj = child.nmeUnifyChildrenWithDOM(obj);
			if(child.get_scrollRect() != null) obj = child;
		}
		return obj;
	}
	,nmeSwapSurface: function(c1,c2) {
		if(this.nmeChildren[c1] == null) throw "Null element at index " + c1 + " length " + this.nmeChildren.length;
		if(this.nmeChildren[c2] == null) throw "Null element at index " + c2 + " length " + this.nmeChildren.length;
		var gfx1 = this.nmeChildren[c1].nmeGetGraphics();
		var gfx2 = this.nmeChildren[c2].nmeGetGraphics();
		if(gfx1 != null && gfx2 != null) flash.Lib.nmeSwapSurface(this.nmeChildren[c1].nmeScrollRect == null?gfx1.nmeSurface:this.nmeChildren[c1].nmeGetSrWindow(),this.nmeChildren[c2].nmeScrollRect == null?gfx2.nmeSurface:this.nmeChildren[c2].nmeGetSrWindow());
	}
	,nmeRender: function(inMask,clipRect) {
		if(!this.nmeVisible) return;
		if(clipRect == null && this.nmeScrollRect != null) clipRect = this.nmeScrollRect;
		flash.display.InteractiveObject.prototype.nmeRender.call(this,inMask,clipRect);
		this.nmeCombinedAlpha = this.parent != null?this.parent.nmeCombinedAlpha * this.alpha:this.alpha;
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.nmeVisible) {
				if(clipRect != null) {
					if((child._nmeRenderFlags & 4) != 0 || (child._nmeRenderFlags & 8) != 0) child.nmeValidateMatrix();
				}
				child.nmeRender(inMask,clipRect);
			}
		}
		if(this.nmeAddedChildren) {
			this.nmeUnifyChildrenWithDOM();
			this.nmeAddedChildren = false;
		}
	}
	,nmeRemoveFromStage: function() {
		flash.display.InteractiveObject.prototype.nmeRemoveFromStage.call(this);
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.nmeRemoveFromStage();
		}
	}
	,nmeRemoveChild: function(child) {
		child.nmeRemoveFromStage();
		child.set_parent(null);
		return child;
	}
	,nmeInvalidateMatrix: function(local) {
		if(local == null) local = false;
		if(!((this._nmeRenderFlags & 8) != 0) && !((this._nmeRenderFlags & 4) != 0)) {
			var _g = 0, _g1 = this.nmeChildren;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				child.nmeInvalidateMatrix();
			}
		}
		flash.display.InteractiveObject.prototype.nmeInvalidateMatrix.call(this,local);
	}
	,nmeGetObjectsUnderPoint: function(point,stack) {
		var l = this.nmeChildren.length - 1;
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = this.nmeChildren[l - i].nmeGetObjectUnderPoint(point);
			if(result != null) stack.push(result);
		}
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null;
		var l = this.nmeChildren.length - 1;
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = null;
			if(this.mouseEnabled) result = this.nmeChildren[l - i].nmeGetObjectUnderPoint(point);
			if(result != null) return this.mouseChildren?result:this;
		}
		return flash.display.InteractiveObject.prototype.nmeGetObjectUnderPoint.call(this,point);
	}
	,nmeBroadcast: function(event) {
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.nmeBroadcast(event);
		}
		this.dispatchEvent(event);
	}
	,nmeAddToStage: function(newParent,beforeSibling) {
		flash.display.InteractiveObject.prototype.nmeAddToStage.call(this,newParent,beforeSibling);
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.nmeGetGraphics() == null || !child.nmeIsOnStage()) child.nmeAddToStage(this);
		}
	}
	,getObjectsUnderPoint: function(point) {
		var result = new Array();
		this.nmeGetObjectsUnderPoint(point,result);
		return result;
	}
	,getChildIndex: function(inChild) {
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.nmeChildren[i] == inChild) return i;
		}
		return -1;
	}
	,getChildByName: function(inName) {
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.name == inName) return child;
		}
		return null;
	}
	,getChildAt: function(index) {
		if(index >= 0 && index < this.nmeChildren.length) return this.nmeChildren[index];
		throw "getChildAt : index out of bounds " + index + "/" + this.nmeChildren.length;
		return null;
	}
	,contains: function(child) {
		return this.__contains(child);
	}
	,addChildAt: function(object,index) {
		if(index > this.nmeChildren.length || index < 0) throw "Invalid index position " + index;
		this.nmeAddedChildren = true;
		if(object.parent == this) {
			this.setChildIndex(object,index);
			return object;
		}
		if(index == this.nmeChildren.length) return this.addChild(object); else {
			if(this.nmeIsOnStage()) object.nmeAddToStage(this,this.nmeChildren[index]);
			this.nmeChildren.splice(index,0,object);
			object.set_parent(this);
		}
		return object;
	}
	,addChild: function(object) {
		if(object == null) throw "DisplayObjectContainer asked to add null child object";
		if(object == this) throw "Adding to self";
		this.nmeAddedChildren = true;
		if(object.parent == this) {
			this.setChildIndex(object,this.nmeChildren.length - 1);
			return object;
		}
		object.set_parent(this);
		if(this.nmeIsOnStage()) object.nmeAddToStage(this);
		if(this.nmeChildren == null) this.nmeChildren = new Array();
		this.nmeChildren.push(object);
		return object;
	}
	,__removeChild: function(child) {
		HxOverrides.remove(this.nmeChildren,child);
	}
	,nmeAddedChildren: null
	,tabChildren: null
	,nmeCombinedAlpha: null
	,nmeChildren: null
	,mouseChildren: null
	,__class__: flash.display.DisplayObjectContainer
	,__properties__: $extend(flash.display.InteractiveObject.prototype.__properties__,{get_numChildren:"get_numChildren"})
});
flash.display.Sprite = function() {
	flash.display.DisplayObjectContainer.call(this);
	this.nmeGraphics = new flash.display.Graphics();
	this.buttonMode = false;
};
$hxClasses["flash.display.Sprite"] = flash.display.Sprite;
flash.display.Sprite.__name__ = ["flash","display","Sprite"];
flash.display.Sprite.__super__ = flash.display.DisplayObjectContainer;
flash.display.Sprite.prototype = $extend(flash.display.DisplayObjectContainer.prototype,{
	set_useHandCursor: function(cursor) {
		if(cursor == this.useHandCursor) return cursor;
		if(this.nmeCursorCallbackOver != null) this.removeEventListener(flash.events.MouseEvent.ROLL_OVER,this.nmeCursorCallbackOver);
		if(this.nmeCursorCallbackOut != null) this.removeEventListener(flash.events.MouseEvent.ROLL_OUT,this.nmeCursorCallbackOut);
		if(!cursor) flash.Lib.nmeSetCursor(flash._Lib.CursorType.Default); else {
			this.nmeCursorCallbackOver = function(_) {
				flash.Lib.nmeSetCursor(flash._Lib.CursorType.Pointer);
			};
			this.nmeCursorCallbackOut = function(_) {
				flash.Lib.nmeSetCursor(flash._Lib.CursorType.Default);
			};
			this.addEventListener(flash.events.MouseEvent.ROLL_OVER,this.nmeCursorCallbackOver);
			this.addEventListener(flash.events.MouseEvent.ROLL_OUT,this.nmeCursorCallbackOut);
		}
		this.useHandCursor = cursor;
		return cursor;
	}
	,get_graphics: function() {
		return this.nmeGraphics;
	}
	,get_dropTarget: function() {
		return this.nmeDropTarget;
	}
	,toString: function() {
		return "[Sprite name=" + this.name + " id=" + this._nmeId + "]";
	}
	,stopDrag: function() {
		if(this.nmeIsOnStage()) {
			this.get_stage().nmeStopDrag(this);
			var l = this.parent.nmeChildren.length - 1;
			var obj = this.get_stage();
			var _g1 = 0, _g = this.parent.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				var result = this.parent.nmeChildren[l - i].nmeGetObjectUnderPoint(new flash.geom.Point(this.get_stage().get_mouseX(),this.get_stage().get_mouseY()));
				if(result != null) obj = result;
			}
			if(obj != this) this.nmeDropTarget = obj; else this.nmeDropTarget = this.get_stage();
		}
	}
	,startDrag: function(lockCenter,bounds) {
		if(lockCenter == null) lockCenter = false;
		if(this.nmeIsOnStage()) this.get_stage().nmeStartDrag(this,lockCenter,bounds);
	}
	,nmeGetGraphics: function() {
		return this.nmeGraphics;
	}
	,nmeGraphics: null
	,nmeDropTarget: null
	,nmeCursorCallbackOver: null
	,nmeCursorCallbackOut: null
	,useHandCursor: null
	,buttonMode: null
	,__class__: flash.display.Sprite
	,__properties__: $extend(flash.display.DisplayObjectContainer.prototype.__properties__,{get_dropTarget:"get_dropTarget",get_graphics:"get_graphics",set_useHandCursor:"set_useHandCursor"})
});
var NMEPreloader = function() {
	flash.display.Sprite.call(this);
	var backgroundColor = this.getBackgroundColor();
	var r = backgroundColor >> 16 & 255;
	var g = backgroundColor >> 8 & 255;
	var b = backgroundColor & 255;
	var perceivedLuminosity = 0.299 * r + 0.587 * g + 0.114 * b;
	var color = 0;
	if(perceivedLuminosity < 70) color = 16777215;
	var x = 30;
	var height = 9;
	var y = this.getHeight() / 2 - height / 2;
	var width = this.getWidth() - x * 2;
	var padding = 3;
	this.outline = new flash.display.Sprite();
	this.outline.get_graphics().lineStyle(1,color,0.15,true);
	this.outline.get_graphics().drawRoundRect(0,0,width,height,padding * 2,padding * 2);
	this.outline.set_x(x);
	this.outline.set_y(y);
	this.addChild(this.outline);
	this.progress = new flash.display.Sprite();
	this.progress.get_graphics().beginFill(color,0.35);
	this.progress.get_graphics().drawRect(0,0,width - padding * 2,height - padding * 2);
	this.progress.set_x(x + padding);
	this.progress.set_y(y + padding);
	this.progress.set_scaleX(0);
	this.addChild(this.progress);
};
$hxClasses["NMEPreloader"] = NMEPreloader;
NMEPreloader.__name__ = ["NMEPreloader"];
NMEPreloader.__super__ = flash.display.Sprite;
NMEPreloader.prototype = $extend(flash.display.Sprite.prototype,{
	onUpdate: function(bytesLoaded,bytesTotal) {
		var percentLoaded = bytesLoaded / bytesTotal;
		if(percentLoaded > 1) percentLoaded == 1;
		this.progress.set_scaleX(percentLoaded);
	}
	,onLoaded: function() {
		this.dispatchEvent(new flash.events.Event(flash.events.Event.COMPLETE));
	}
	,onInit: function() {
	}
	,getWidth: function() {
		var width = 720;
		if(width > 0) return width; else return flash.Lib.get_current().get_stage().get_stageWidth();
	}
	,getHeight: function() {
		var height = 600;
		if(height > 0) return height; else return flash.Lib.get_current().get_stage().get_stageHeight();
	}
	,getBackgroundColor: function() {
		return 16777215;
	}
	,progress: null
	,outline: null
	,__class__: NMEPreloader
});
var Reflect = function() { }
$hxClasses["Reflect"] = Reflect;
Reflect.__name__ = ["Reflect"];
Reflect.hasField = function(o,field) {
	return Object.prototype.hasOwnProperty.call(o,field);
}
Reflect.field = function(o,field) {
	var v = null;
	try {
		v = o[field];
	} catch( e ) {
	}
	return v;
}
Reflect.setField = function(o,field,value) {
	o[field] = value;
}
Reflect.getProperty = function(o,field) {
	var tmp;
	return o == null?null:o.__properties__ && (tmp = o.__properties__["get_" + field])?o[tmp]():o[field];
}
Reflect.setProperty = function(o,field,value) {
	var tmp;
	if(o.__properties__ && (tmp = o.__properties__["set_" + field])) o[tmp](value); else o[field] = value;
}
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
}
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
}
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
}
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
}
Reflect.isObject = function(v) {
	if(v == null) return false;
	var t = typeof(v);
	return t == "string" || t == "object" && v.__enum__ == null || t == "function" && (v.__name__ || v.__ename__) != null;
}
Reflect.deleteField = function(o,field) {
	if(!Reflect.hasField(o,field)) return false;
	delete(o[field]);
	return true;
}
var Std = function() { }
$hxClasses["Std"] = Std;
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
var StringBuf = function() {
	this.b = "";
};
$hxClasses["StringBuf"] = StringBuf;
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype = {
	b: null
	,__class__: StringBuf
}
var StringTools = function() { }
$hxClasses["StringTools"] = StringTools;
StringTools.__name__ = ["StringTools"];
StringTools.urlEncode = function(s) {
	return encodeURIComponent(s);
}
StringTools.urlDecode = function(s) {
	return decodeURIComponent(s.split("+").join(" "));
}
StringTools.startsWith = function(s,start) {
	return s.length >= start.length && HxOverrides.substr(s,0,start.length) == start;
}
StringTools.isSpace = function(s,pos) {
	var c = HxOverrides.cca(s,pos);
	return c > 8 && c < 14 || c == 32;
}
StringTools.ltrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,r)) r++;
	if(r > 0) return HxOverrides.substr(s,r,l - r); else return s;
}
StringTools.rtrim = function(s) {
	var l = s.length;
	var r = 0;
	while(r < l && StringTools.isSpace(s,l - r - 1)) r++;
	if(r > 0) return HxOverrides.substr(s,0,l - r); else return s;
}
StringTools.trim = function(s) {
	return StringTools.ltrim(StringTools.rtrim(s));
}
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
}
StringTools.hex = function(n,digits) {
	var s = "";
	var hexChars = "0123456789ABCDEF";
	do {
		s = hexChars.charAt(n & 15) + s;
		n >>>= 4;
	} while(n > 0);
	if(digits != null) while(s.length < digits) s = "0" + s;
	return s;
}
var ValueType = $hxClasses["ValueType"] = { __ename__ : true, __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] }
ValueType.TNull = ["TNull",0];
ValueType.TNull.toString = $estr;
ValueType.TNull.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.toString = $estr;
ValueType.TInt.__enum__ = ValueType;
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.toString = $estr;
ValueType.TFloat.__enum__ = ValueType;
ValueType.TBool = ["TBool",3];
ValueType.TBool.toString = $estr;
ValueType.TBool.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.toString = $estr;
ValueType.TObject.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.toString = $estr;
ValueType.TFunction.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.toString = $estr;
ValueType.TUnknown.__enum__ = ValueType;
var Type = function() { }
$hxClasses["Type"] = Type;
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	return o.__class__;
}
Type.getEnum = function(o) {
	if(o == null) return null;
	return o.__enum__;
}
Type.getClassName = function(c) {
	var a = c.__name__;
	return a.join(".");
}
Type.resolveClass = function(name) {
	var cl = $hxClasses[name];
	if(cl == null || !cl.__name__) return null;
	return cl;
}
Type.resolveEnum = function(name) {
	var e = $hxClasses[name];
	if(e == null || !e.__ename__) return null;
	return e;
}
Type.createInstance = function(cl,args) {
	switch(args.length) {
	case 0:
		return new cl();
	case 1:
		return new cl(args[0]);
	case 2:
		return new cl(args[0],args[1]);
	case 3:
		return new cl(args[0],args[1],args[2]);
	case 4:
		return new cl(args[0],args[1],args[2],args[3]);
	case 5:
		return new cl(args[0],args[1],args[2],args[3],args[4]);
	case 6:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5]);
	case 7:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
	case 8:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
	default:
		throw "Too many arguments";
	}
	return null;
}
Type.createEmptyInstance = function(cl) {
	function empty() {}; empty.prototype = cl.prototype;
	return new empty();
}
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw "No such constructor " + constr;
	if(Reflect.isFunction(f)) {
		if(params == null) throw "Constructor " + constr + " need parameters";
		return f.apply(e,params);
	}
	if(params != null && params.length != 0) throw "Constructor " + constr + " does not need parameters";
	return f;
}
Type.getInstanceFields = function(c) {
	var a = [];
	for(var i in c.prototype) a.push(i);
	HxOverrides.remove(a,"__class__");
	HxOverrides.remove(a,"__properties__");
	return a;
}
Type.getEnumConstructs = function(e) {
	var a = e.__constructs__;
	return a.slice();
}
Type["typeof"] = function(v) {
	var _g = typeof(v);
	switch(_g) {
	case "boolean":
		return ValueType.TBool;
	case "string":
		return ValueType.TClass(String);
	case "number":
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	case "object":
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c = v.__class__;
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	case "function":
		if(v.__name__ || v.__ename__) return ValueType.TObject;
		return ValueType.TFunction;
	case "undefined":
		return ValueType.TNull;
	default:
		return ValueType.TUnknown;
	}
}
Type.enumIndex = function(e) {
	return e[1];
}
var XmlType = $hxClasses["XmlType"] = { __ename__ : true, __constructs__ : [] }
var Xml = function() { }
$hxClasses["Xml"] = Xml;
Xml.__name__ = ["Xml"];
var cx = {}
cx.ConfigTools = function() { }
$hxClasses["cx.ConfigTools"] = cx.ConfigTools;
cx.ConfigTools.__name__ = ["cx","ConfigTools"];
cx.ConfigTools.loadFlashVars = function(configObject) {
	var paramObject = flash.Lib.get_current().loaderInfo.parameters;
	var fields = cx.ReflectTools.getObjectFields(paramObject);
	var _g = 0;
	while(_g < fields.length) {
		var field = fields[_g];
		++_g;
		var value = Reflect.getProperty(paramObject,field);
		configObject[field] = value;
	}
}
cx.ConfigTools.getFlashVars = function() {
	return flash.Lib.get_current().loaderInfo.parameters;
}
cx.ConfigTools.setFieldValue = function(configObject,field,value) {
	configObject[field] = value;
	return;
}
cx.ConfigTools.initField = function(configObject,field,valueString,arrayDelimiter) {
	if(arrayDelimiter == null) arrayDelimiter = ",";
	if(!Reflect.hasField(configObject,field)) {
		cx.ConfigTools.missingFields.push(field);
		return;
	}
	var f = Reflect.field(configObject,field);
	if(js.Boot.__instanceof(f,String)) cx.ConfigTools.setFieldValue(configObject,field,StringTools.trim(valueString));
	if(js.Boot.__instanceof(f,Int)) cx.ConfigTools.setFieldValue(configObject,field,Std.parseInt(StringTools.trim(valueString)));
	if(js.Boot.__instanceof(f,Float)) cx.ConfigTools.setFieldValue(configObject,field,Std.parseFloat(StringTools.trim(valueString)));
	if(js.Boot.__instanceof(f,Array)) {
		var values = valueString.split(arrayDelimiter);
		var arrItem = f.shift();
		if(js.Boot.__instanceof(arrItem,String)) {
			var values1 = cx.StrTools.splitTrim(valueString,arrayDelimiter);
			cx.ConfigTools.setFieldValue(configObject,field,values1);
		}
		if(js.Boot.__instanceof(arrItem,Int)) {
			var strings = valueString.split(arrayDelimiter);
			var values1 = new Array();
			var _g = 0;
			while(_g < strings.length) {
				var string = strings[_g];
				++_g;
				values1.push(Std.parseInt(string));
			}
			cx.ConfigTools.setFieldValue(configObject,field,values1);
		}
		if(js.Boot.__instanceof(arrItem,Float)) {
			var strings = valueString.split(arrayDelimiter);
			var values1 = new Array();
			var _g = 0;
			while(_g < strings.length) {
				var string = strings[_g];
				++_g;
				values1.push(Std.parseFloat(string));
			}
			cx.ConfigTools.setFieldValue(configObject,field,values1);
		}
	}
}
cx.ReflectTools = function() { }
$hxClasses["cx.ReflectTools"] = cx.ReflectTools;
cx.ReflectTools.__name__ = ["cx","ReflectTools"];
cx.ReflectTools.getMethods = function(object) {
	var result = [];
	var fields = Type.getInstanceFields(Type.getClass(object));
	var _g = 0;
	while(_g < fields.length) {
		var field = fields[_g];
		++_g;
		var f = Reflect.field(object,field);
		if(Reflect.isFunction(f)) result.push(field);
	}
	return result;
}
cx.ReflectTools.callMethod = function(object,methodName,args) {
	if(args == null) args = [];
	try {
		return Reflect.field(object,methodName).apply(object,args);
	} catch( e ) {
		throw "Error on ReflectTools.callMethod: " + methodName + " > " + Std.string(e);
	}
}
cx.ReflectTools.hasMethod = function(object,methodName) {
	return Lambda.has(cx.ReflectTools.getMethods(object),methodName);
}
cx.ReflectTools.getClass = function(object) {
	return Type.getClass(object);
}
cx.ReflectTools.getClassName = function(object) {
	return Type.getClassName(cx.ReflectTools.getClass(object));
}
cx.ReflectTools.getStaticFields = function(object) {
	return Reflect.fields(cx.ReflectTools.getClass(object));
}
cx.ReflectTools.getObjectFields = function(object) {
	return Reflect.fields(object);
}
cx.ReflectTools.getStaticField = function(object,fieldName) {
	return Reflect.field(cx.ReflectTools.getClass(object),fieldName);
}
cx.StrTools = function() { }
$hxClasses["cx.StrTools"] = cx.StrTools;
cx.StrTools.__name__ = ["cx","StrTools"];
cx.StrTools.until = function(str,until) {
	return str.substring(0,str.indexOf(until));
}
cx.StrTools.tab = function(str) {
	return str + "\t";
}
cx.StrTools.newline = function(str) {
	return str + "\n";
}
cx.StrTools.repeat = function(repeatString,count) {
	var result = "";
	var _g = 0;
	while(_g < count) {
		var i = _g++;
		result += repeatString;
	}
	return result;
}
cx.StrTools.fill = function(str,toLength,$with,replaceNull) {
	if(replaceNull == null) replaceNull = "-";
	if($with == null) $with = " ";
	if(toLength == null) toLength = 32;
	if(str == null) str = replaceNull;
	do str += $with; while(str.length < toLength);
	return HxOverrides.substr(str,0,toLength);
}
cx.StrTools.splitTrim = function(str,delimiter) {
	if(delimiter == null) delimiter = ",";
	if(str == null) return [];
	var a = str.split(delimiter);
	var a2 = new Array();
	var _g = 0;
	while(_g < a.length) {
		var part = a[_g];
		++_g;
		var part2 = StringTools.trim(part);
		if(part2.length > 0) a2.push(part2);
	}
	return a2;
}
cx.StrTools.replaceNull = function(str,$with) {
	if($with == null) $with = "-";
	return str == null?$with:str;
}
cx.StrTools.firstUpperCase = function(str,restToLowercase) {
	if(restToLowercase == null) restToLowercase = true;
	var rest = restToLowercase?HxOverrides.substr(str,1,null).toLowerCase():HxOverrides.substr(str,1,null);
	return HxOverrides.substr(str,0,1).toUpperCase() + rest;
}
cx.StrTools.afterLast = function(str,$char,includeChar) {
	if(includeChar == null) includeChar = false;
	var idx = str.lastIndexOf($char);
	if(!includeChar) idx += $char.length;
	return HxOverrides.substr(str,idx,null);
}
cx.StrTools.similarityCaseIgnore = function(strA,strB) {
	return cx.StrTools.similarity(strA.toLowerCase(),strB.toLowerCase());
}
cx.StrTools.similarityCaseBalance = function(strA,strB) {
	return (cx.StrTools.similarity(strA,strB) + cx.StrTools.similarity(strA.toLowerCase(),strB.toLowerCase())) / 2;
}
cx.StrTools.similarity = function(strA,strB) {
	if(strA == strB) return 1;
	var sim = function(strA1,strB1) {
		var score = cx.StrTools._similarity(strA1,strB1);
		if(strA1.length != strB1.length) score = (score + cx.StrTools._similarity(strB1,strA1)) / 2;
		return score;
	};
	return sim(strA,strB);
}
cx.StrTools.similarityAssymetric = function(strShorter,strLonger) {
	if(strShorter == strLonger) return 1;
	return cx.StrTools._similarity(strShorter,strShorter);
}
cx.StrTools._similarity = function(strA,strB) {
	var lengthA = strA.length;
	var lengthB = strB.length;
	var i = 0;
	var segmentCount = 0;
	var segmentsInfos = new Array();
	var segment = "";
	while(i < lengthA) {
		var $char = strA.charAt(i);
		if(strB.indexOf($char) > -1) {
			segment += $char;
			if(strB.indexOf(segment) > -1) {
				var segmentPosA = i - segment.length + 1;
				var segmentPosB = strB.indexOf(segment);
				var positionDiff = Math.abs(segmentPosA - segmentPosB);
				var posFactor = (lengthA - positionDiff) / lengthB;
				var lengthFactor = segment.length / lengthA;
				segmentsInfos[segmentCount] = { segment : segment, score : posFactor * lengthFactor};
			} else {
				segment = "";
				segmentCount++;
				i--;
			}
		} else {
			segment = "";
			segmentCount++;
		}
		i++;
	}
	var usedSegmentsCount = -2;
	var totalScore = 0.0;
	var _g = 0;
	while(_g < segmentsInfos.length) {
		var si = segmentsInfos[_g];
		++_g;
		if(si != null) {
			totalScore += si.score;
			usedSegmentsCount++;
		}
	}
	totalScore = totalScore - Math.max(usedSegmentsCount,0) * 0.02;
	return Math.max(0,Math.min(totalScore,1));
}
cx.StrTools.has = function(str,substr) {
	return str.indexOf(substr) > -1;
}
cx.StrTools.reverse = function(string) {
	var result = "";
	var _g1 = 0, _g = string.length;
	while(_g1 < _g) {
		var i = _g1++;
		result = string.charAt(i) + result;
	}
	return result;
}
cx.StrTools.intToChar = function($int,offset) {
	if(offset == null) offset = 65;
	if($int > 9) throw "int to char error";
	if($int < 0) throw "int to char error";
	var c = $int + offset;
	var $char = String.fromCharCode(c);
	return $char;
}
cx.StrTools.charToInt = function($char,offset) {
	if(offset == null) offset = 65;
	if($char.length > 1) throw "char to int error";
	return HxOverrides.cca($char,0) - offset;
}
cx.StrTools.numToStr = function(numStr,offset) {
	if(offset == null) offset = 65;
	var testParse = Std.parseInt(numStr);
	var result = "";
	var _g1 = 0, _g = numStr.length;
	while(_g1 < _g) {
		var i = _g1++;
		var $int = Std.parseInt(numStr.charAt(i));
		var $char = cx.StrTools.intToChar($int,offset);
		result += $char;
	}
	return result;
}
cx.StrTools.strToNum = function(str,offset) {
	if(offset == null) offset = 65;
	var result = "";
	var _g1 = 0, _g = str.length;
	while(_g1 < _g) {
		var i = _g1++;
		var $char = str.charAt(i);
		var $int = cx.StrTools.charToInt($char,offset);
		result += Std.string($int);
	}
	return result;
}
cx.StrTools.rotate = function(str,positions) {
	if(positions == null) positions = 1;
	var result = str;
	var _g = 0;
	while(_g < positions) {
		var i = _g++;
		result = HxOverrides.substr(result,1,result.length) + HxOverrides.substr(result,0,1);
	}
	return result;
}
cx.StrTools.rotateBack = function(str,positions) {
	if(positions == null) positions = 1;
	var result = str;
	var _g = 0;
	while(_g < positions) {
		var i = _g++;
		result = HxOverrides.substr(result,-1,null) + HxOverrides.substr(result,0,result.length - 1);
	}
	return result;
}
cx.StrTools.toLatin1 = function(str) {
	return haxe.Utf8.decode(str);
	return str;
}
cx.StrTools.lastIdxOf = function(str,search,lastPos) {
	if(lastPos == null) lastPos = 0;
	if(lastPos == 0) return str.lastIndexOf(search);
	var _g = 0;
	while(_g < lastPos) {
		var i = _g++;
		str = HxOverrides.substr(str,0,str.lastIndexOf(search));
	}
	return str.lastIndexOf(search);
}
cx.TimerTools = function() { }
$hxClasses["cx.TimerTools"] = cx.TimerTools;
cx.TimerTools.__name__ = ["cx","TimerTools"];
cx.TimerTools.timeout = function(func,milliSeconds) {
	if(milliSeconds == null) milliSeconds = 500;
	if(cx.TimerTools._timer != null) cx.TimerTools._timer.stop();
	cx.TimerTools._timer = haxe.Timer.delay(func,milliSeconds);
}
cx.TimerTools.delay = function(func,milliSeconds) {
	if(milliSeconds == null) milliSeconds = 500;
	haxe.Timer.delay(func,milliSeconds);
}
cx.TimerTools.timer = function(func,milliSeconds) {
	if(milliSeconds == null) milliSeconds = 500;
	var timer = new haxe.Timer(milliSeconds);
	timer.run = func;
	return timer;
}
cx.flash = {}
cx.flash.graphic = {}
cx.flash.graphic.GraphicTools = function() { }
$hxClasses["cx.flash.graphic.GraphicTools"] = cx.flash.graphic.GraphicTools;
cx.flash.graphic.GraphicTools.__name__ = ["cx","flash","graphic","GraphicTools"];
cx.flash.graphic.GraphicTools.drawCircleSegment = function(graphics,center,start,end,r,h_ratio,v_ratio,new_drawing) {
	if(new_drawing == null) new_drawing = true;
	if(v_ratio == null) v_ratio = 1;
	if(h_ratio == null) h_ratio = 1;
	var x = center.x;
	var y = center.y;
	if(new_drawing) {
		var xStart = x + Math.cos(start) * r * h_ratio;
		var yStart = y + Math.sin(start) * r * v_ratio;
		graphics.moveTo(xStart,yStart);
	}
	var segments = 8;
	var theta = (end - start) / segments;
	var angle = start;
	var ctrlRadius = r / Math.cos(theta / 2);
	var _g = 0;
	while(_g < segments) {
		var i = _g++;
		angle += theta;
		var angleMid = angle - theta / 2;
		var cx = x + Math.cos(angleMid) * (ctrlRadius * h_ratio);
		var cy = y + Math.sin(angleMid) * (ctrlRadius * v_ratio);
		var px = x + Math.cos(angle) * r * h_ratio;
		var py = y + Math.sin(angle) * r * v_ratio;
		graphics.curveTo(cx,cy,px,py);
	}
}
cx.flash.layout = {}
cx.flash.layout.DocumentLayout = function() { }
$hxClasses["cx.flash.layout.DocumentLayout"] = cx.flash.layout.DocumentLayout;
cx.flash.layout.DocumentLayout.__name__ = ["cx","flash","layout","DocumentLayout"];
cx.flash.layout.DocumentLayout.arrange = function(holder,holderWidth,childWidth,childHeight,tweenTime) {
	if(tweenTime == null) tweenTime = 0.6;
	if(childHeight == null) childHeight = 297;
	if(childWidth == null) childWidth = 210;
	if(holder == null) throw "HOLDER == null";
	var wrapperWidth = 0;
	var wrapperHeight = 0;
	var margin = 10.0;
	var childX = new Array();
	var childY = new Array();
	var currX = margin;
	var currY = margin;
	var numChildren = holder.nmeChildren.length;
	var _g = 0;
	while(_g < numChildren) {
		var i = _g++;
		childX[i] = currX;
		childY[i] = currY;
		currX += childWidth + margin;
		if(currX + childWidth > holderWidth) {
			currX = margin;
			currY = currY + childHeight + margin;
		}
	}
	var _g = 0;
	while(_g < numChildren) {
		var i = _g++;
		wrapperWidth = Math.max(wrapperWidth,childX[i] + childWidth);
		wrapperHeight = Math.max(wrapperHeight,childY[i] + childHeight);
	}
	holder.set_w(wrapperWidth + margin);
	holder.set_h(wrapperHeight + margin);
	var _g = 0;
	while(_g < numChildren) {
		var i = _g++;
		var child = holder.getChildAt(i);
		child.set_width(childWidth);
		child.set_height(childHeight);
	}
	var _g = 0;
	while(_g < numChildren) {
		var i = _g++;
		var child = holder.getChildAt(i);
		if(tweenTime > 0) motion.Actuate.tween(child,tweenTime,{ x : childX[i], y : childY[i]}); else {
			child.set_x(childX[i]);
			child.set_y(childY[i]);
		}
	}
	var holderX = Math.max(0,(holderWidth - holder.get_w()) / 2);
	var holderY = Math.max(0,holder.get_y());
	holder.set_x(holderX);
	holder.set_y(holderY);
	return new flash.geom.Point(childWidth,childHeight);
}
cx.flash.layout.DocumentLayout.pagesArrangeWidths = function(holder,holderWidth,childWidth,childHeight) {
	if(childHeight == null) childHeight = 297;
	if(childWidth == null) childWidth = 210;
	var numChildren = holder.nmeChildren.length;
	var _g = 0;
	while(_g < numChildren) {
		var i = _g++;
		var child = holder.getChildAt(i);
		child.set_width(childWidth);
		child.set_height(childHeight);
	}
}
cx.flash.ui = {}
cx.flash.ui.UIProgress = function(x,y,width,height,backColor,frontColor,initValue,lineThickness) {
	if(lineThickness == null) lineThickness = 6;
	if(initValue == null) initValue = 0;
	if(frontColor == null) frontColor = 16711680;
	if(backColor == null) backColor = 5592405;
	this.v = 0;
	this.value_ = 0;
	flash.display.Sprite.call(this);
	this.w = width;
	this.h = height;
	this.lineThickness = lineThickness;
	this.backColor = backColor;
	this.frontColor = frontColor;
	this.drawBack();
	this.frontSprite = new flash.display.Sprite();
	this.frontSprite.set_rotation(270);
	this.addChild(this.frontSprite);
	this.frontSprite.get_graphics().lineStyle(lineThickness,frontColor);
	this.segmentPoint = new flash.geom.Point(0,0);
	this.segmentRadius = width / 2;
	this.set_value(0);
	this.spin();
	this.frontSprite.set_x(width / 2);
	this.frontSprite.set_y(height / 2);
	this.set_x(x);
	this.set_y(y);
};
$hxClasses["cx.flash.ui.UIProgress"] = cx.flash.ui.UIProgress;
cx.flash.ui.UIProgress.__name__ = ["cx","flash","ui","UIProgress"];
cx.flash.ui.UIProgress.__super__ = flash.display.Sprite;
cx.flash.ui.UIProgress.prototype = $extend(flash.display.Sprite.prototype,{
	spinStop: function() {
		if(this.spinTimer != null) this.spinTimer.stop();
	}
	,show: function(val) {
		if(val == null) val = 0;
		this.drawBack();
		this.set_value(val);
	}
	,hide: function() {
		this.spinStop();
		this.set_value(0);
		($_=this.frontSprite.get_graphics(),$bind($_,$_.clear));
		($_=this.get_graphics(),$bind($_,$_.clear));
	}
	,onEnterFrame: function(e) {
		this.v += 0.015;
		if(this.v > 1) {
			var c = this.frontColor;
			this.frontColor = this.backColor;
			this.backColor = c;
			this.drawBack();
			this.v = 0;
		}
		this.set_value(this.v);
	}
	,spin: function(ms) {
		if(ms == null) ms = 20;
		this.spinStop();
		this.show();
		this.addEventListener(flash.events.Event.ENTER_FRAME,$bind(this,this.onEnterFrame),false,0,true);
	}
	,spinTimer: null
	,v: null
	,set_value: function(val) {
		this.frontSprite.get_graphics().clear();
		if(val > 1) val = val % 1;
		var segValue = val * 6.3;
		this.frontSprite.get_graphics().lineStyle(this.lineThickness,this.frontColor);
		cx.flash.graphic.GraphicTools.drawCircleSegment(this.frontSprite.get_graphics(),this.segmentPoint,0,segValue,this.segmentRadius);
		this.value_ = val;
		return this.value_;
	}
	,get_value: function() {
		return this.value_;
	}
	,h: null
	,w: null
	,frontColor: null
	,backColor: null
	,lineThickness: null
	,segmentRadius: null
	,segmentPoint: null
	,frontSprite: null
	,value_: null
	,drawBack: function() {
		this.get_graphics().lineStyle(this.lineThickness,this.backColor);
		this.get_graphics().endFill();
		this.get_graphics().drawEllipse(0,0,this.w,this.h);
	}
	,__class__: cx.flash.ui.UIProgress
	,__properties__: $extend(flash.display.Sprite.prototype.__properties__,{set_value:"set_value",get_value:"get_value"})
});
cx.layout = {}
cx.layout.Horizontal = $hxClasses["cx.layout.Horizontal"] = { __ename__ : true, __constructs__ : ["LEFT","CENTER","RIGHT","STRETCH","NONE","LEFT_MARGIN","RIGHT_MARGIN","STRETCH_MARGIN"] }
cx.layout.Horizontal.LEFT = ["LEFT",0];
cx.layout.Horizontal.LEFT.toString = $estr;
cx.layout.Horizontal.LEFT.__enum__ = cx.layout.Horizontal;
cx.layout.Horizontal.CENTER = ["CENTER",1];
cx.layout.Horizontal.CENTER.toString = $estr;
cx.layout.Horizontal.CENTER.__enum__ = cx.layout.Horizontal;
cx.layout.Horizontal.RIGHT = ["RIGHT",2];
cx.layout.Horizontal.RIGHT.toString = $estr;
cx.layout.Horizontal.RIGHT.__enum__ = cx.layout.Horizontal;
cx.layout.Horizontal.STRETCH = ["STRETCH",3];
cx.layout.Horizontal.STRETCH.toString = $estr;
cx.layout.Horizontal.STRETCH.__enum__ = cx.layout.Horizontal;
cx.layout.Horizontal.NONE = ["NONE",4];
cx.layout.Horizontal.NONE.toString = $estr;
cx.layout.Horizontal.NONE.__enum__ = cx.layout.Horizontal;
cx.layout.Horizontal.LEFT_MARGIN = function(margin) { var $x = ["LEFT_MARGIN",5,margin]; $x.__enum__ = cx.layout.Horizontal; $x.toString = $estr; return $x; }
cx.layout.Horizontal.RIGHT_MARGIN = function(margin) { var $x = ["RIGHT_MARGIN",6,margin]; $x.__enum__ = cx.layout.Horizontal; $x.toString = $estr; return $x; }
cx.layout.Horizontal.STRETCH_MARGIN = function(leftMargin,rightMargin) { var $x = ["STRETCH_MARGIN",7,leftMargin,rightMargin]; $x.__enum__ = cx.layout.Horizontal; $x.toString = $estr; return $x; }
cx.layout.ILayoutItem = function() { }
$hxClasses["cx.layout.ILayoutItem"] = cx.layout.ILayoutItem;
cx.layout.ILayoutItem.__name__ = ["cx","layout","ILayoutItem"];
cx.layout.ILayoutItem.prototype = {
	afterResize: null
	,resize: null
	,manager: null
	,__class__: cx.layout.ILayoutItem
}
cx.layout.LayoutManager = function(items) {
	if(items == null) items = [];
	this.items = items;
	this.initOnResize_();
};
$hxClasses["cx.layout.LayoutManager"] = cx.layout.LayoutManager;
cx.layout.LayoutManager.__name__ = ["cx","layout","LayoutManager"];
cx.layout.LayoutManager.prototype = {
	add: function(item) {
		this.items.push(item);
		item.manager = this;
	}
	,resize: function(stageWidth,stageHeight) {
		if(stageHeight == null) stageHeight = 0;
		if(stageWidth == null) stageWidth = 0;
		stageWidth = stageWidth == 0?flash.Lib.get_current().get_stage().get_stageWidth():stageWidth;
		stageHeight = stageHeight == 0?flash.Lib.get_current().get_stage().get_stageHeight():stageHeight;
		this.doLayout_(stageWidth,stageHeight);
	}
	,doLayout_: function(stageWidth,stageHeight) {
		var _g = 0, _g1 = this.items;
		while(_g < _g1.length) {
			var item = _g1[_g];
			++_g;
			item.resize(stageWidth,stageHeight);
		}
	}
	,onResize_: function(e) {
		var stageWidth = flash.Lib.get_current().get_stage().get_stageWidth();
		var stageHeight = flash.Lib.get_current().get_stage().get_stageHeight();
		this.doLayout_(stageWidth,stageHeight);
	}
	,initOnResize_: function() {
		flash.Lib.get_current().get_stage().addEventListener(flash.events.Event.RESIZE,$bind(this,this.onResize_));
	}
	,items: null
	,__class__: cx.layout.LayoutManager
}
cx.layout.SpriteItem = function(target,horizontal,vertical) {
	this.target = target;
	this.horizontal = horizontal;
	this.vertical = vertical;
};
$hxClasses["cx.layout.SpriteItem"] = cx.layout.SpriteItem;
cx.layout.SpriteItem.__name__ = ["cx","layout","SpriteItem"];
cx.layout.SpriteItem.__interfaces__ = [cx.layout.ILayoutItem];
cx.layout.SpriteItem.prototype = {
	afterResize: function(x,y,width,height) {
	}
	,resize: function(stageWidth,stageHeight) {
		var targetWidth = this.target.get_width();
		var targetHeight = this.target.get_height();
		var _g = this;
		var $e = (_g.horizontal);
		switch( $e[1] ) {
		case 0:
			this.target.set_x(0);
			break;
		case 1:
			this.target.set_x((stageWidth - targetWidth) / 2);
			break;
		case 2:
			this.target.set_x(stageWidth - targetWidth);
			break;
		case 3:
			this.target.set_x(0);
			this.target.set_width(stageWidth);
			break;
		case 4:
			break;
		case 5:
			var margin = $e[2];
			this.target.set_width(margin);
			break;
		case 6:
			var margin = $e[2];
			this.target.set_x(stageWidth - targetWidth - margin);
			break;
		case 7:
			var rightMargin = $e[3], leftMargin = $e[2];
			this.target.set_x(leftMargin + leftMargin);
			this.target.set_width(stageWidth - leftMargin - rightMargin);
			break;
		}
		var _g1 = this;
		var $e = (_g1.vertical);
		switch( $e[1] ) {
		case 0:
			this.target.set_y(0);
			break;
		case 1:
			this.target.set_y((stageHeight - targetHeight) / 2);
			break;
		case 2:
			this.target.set_y(stageHeight - targetHeight);
			break;
		case 3:
			this.target.set_y(0);
			this.target.set_height(stageHeight);
			break;
		case 4:
			break;
		case 5:
			var margin = $e[2];
			this.target.set_y(margin);
			break;
		case 6:
			var margin = $e[2];
			this.target.set_y(stageHeight - targetHeight - margin);
			break;
		case 7:
			var bottomMargin = $e[3], topMargin = $e[2];
			this.target.set_y(topMargin);
			this.target.set_height(stageHeight - topMargin - bottomMargin);
			break;
		}
		this.afterResize(this.target.get_x(),this.target.get_y(),this.target.get_width(),this.target.get_height());
	}
	,vertical: null
	,horizontal: null
	,target: null
	,manager: null
	,__class__: cx.layout.SpriteItem
}
cx.layout.UIManager = function() {
	flash.display.Sprite.call(this);
	this.manager = new cx.layout.LayoutManager();
};
$hxClasses["cx.layout.UIManager"] = cx.layout.UIManager;
cx.layout.UIManager.__name__ = ["cx","layout","UIManager"];
cx.layout.UIManager.__super__ = flash.display.Sprite;
cx.layout.UIManager.prototype = $extend(flash.display.Sprite.prototype,{
	addLayoutItems: function(items) {
		var _g = 0;
		while(_g < items.length) {
			var item = items[_g];
			++_g;
			this.manager.add(item);
		}
		($_=this.manager,$bind($_,$_.resize));
	}
	,manager: null
	,__class__: cx.layout.UIManager
});
cx.layout.Vertical = $hxClasses["cx.layout.Vertical"] = { __ename__ : true, __constructs__ : ["TOP","CENTER","BOTTOM","STRETCH","NONE","TOP_MARGIN","BOTTOM_MARGIN","STRETCH_MARGIN"] }
cx.layout.Vertical.TOP = ["TOP",0];
cx.layout.Vertical.TOP.toString = $estr;
cx.layout.Vertical.TOP.__enum__ = cx.layout.Vertical;
cx.layout.Vertical.CENTER = ["CENTER",1];
cx.layout.Vertical.CENTER.toString = $estr;
cx.layout.Vertical.CENTER.__enum__ = cx.layout.Vertical;
cx.layout.Vertical.BOTTOM = ["BOTTOM",2];
cx.layout.Vertical.BOTTOM.toString = $estr;
cx.layout.Vertical.BOTTOM.__enum__ = cx.layout.Vertical;
cx.layout.Vertical.STRETCH = ["STRETCH",3];
cx.layout.Vertical.STRETCH.toString = $estr;
cx.layout.Vertical.STRETCH.__enum__ = cx.layout.Vertical;
cx.layout.Vertical.NONE = ["NONE",4];
cx.layout.Vertical.NONE.toString = $estr;
cx.layout.Vertical.NONE.__enum__ = cx.layout.Vertical;
cx.layout.Vertical.TOP_MARGIN = function(margin) { var $x = ["TOP_MARGIN",5,margin]; $x.__enum__ = cx.layout.Vertical; $x.toString = $estr; return $x; }
cx.layout.Vertical.BOTTOM_MARGIN = function(margin) { var $x = ["BOTTOM_MARGIN",6,margin]; $x.__enum__ = cx.layout.Vertical; $x.toString = $estr; return $x; }
cx.layout.Vertical.STRETCH_MARGIN = function(topMargin,BOTTOM_MARGIN) { var $x = ["STRETCH_MARGIN",7,topMargin,BOTTOM_MARGIN]; $x.__enum__ = cx.layout.Vertical; $x.toString = $estr; return $x; }
cx.layout.WidgetItem = function(target,horizontal,vertical) {
	this.target = target;
	this.horizontal = horizontal;
	this.vertical = vertical;
};
$hxClasses["cx.layout.WidgetItem"] = cx.layout.WidgetItem;
cx.layout.WidgetItem.__name__ = ["cx","layout","WidgetItem"];
cx.layout.WidgetItem.__interfaces__ = [cx.layout.ILayoutItem];
cx.layout.WidgetItem.prototype = {
	afterResize: function(x,y,width,height) {
	}
	,resize: function(stageWidth,stageHeight) {
		var targetWidth = this.target.get_w();
		var targetHeight = this.target.get_h();
		var _g = this;
		var $e = (_g.horizontal);
		switch( $e[1] ) {
		case 0:
			this.target.set_x(0);
			break;
		case 1:
			this.target.set_x((stageWidth - targetWidth) / 2);
			break;
		case 2:
			this.target.set_x(stageWidth - targetWidth);
			break;
		case 3:
			this.target.set_x(0);
			this.target.set_w(stageWidth);
			break;
		case 4:
			break;
		case 5:
			var margin = $e[2];
			this.target.set_w(margin);
			break;
		case 6:
			var margin = $e[2];
			this.target.set_x(stageWidth - targetWidth - margin);
			break;
		case 7:
			var rightMargin = $e[3], leftMargin = $e[2];
			this.target.set_x(leftMargin + leftMargin);
			this.target.set_w(stageWidth - leftMargin - rightMargin);
			break;
		}
		var _g1 = this;
		var $e = (_g1.vertical);
		switch( $e[1] ) {
		case 0:
			this.target.set_y(0);
			break;
		case 1:
			this.target.set_y((stageHeight - targetHeight) / 2);
			break;
		case 2:
			this.target.set_y(stageHeight - targetHeight);
			break;
		case 3:
			this.target.set_y(0);
			this.target.set_h(stageHeight);
			break;
		case 4:
			break;
		case 5:
			var margin = $e[2];
			this.target.set_y(margin);
			break;
		case 6:
			var margin = $e[2];
			this.target.set_y(stageHeight - targetHeight - margin);
			break;
		case 7:
			var bottomMargin = $e[3], topMargin = $e[2];
			this.target.set_y(topMargin);
			this.target.set_h(stageHeight - topMargin - bottomMargin);
			break;
		}
		this.afterResize(this.target.get_x(),this.target.get_y(),this.target.get_w(),this.target.get_h());
	}
	,vertical: null
	,horizontal: null
	,target: null
	,manager: null
	,__class__: cx.layout.WidgetItem
}
var haxe = {}
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
$hxClasses["haxe.Timer"] = haxe.Timer;
haxe.Timer.__name__ = ["haxe","Timer"];
haxe.Timer.delay = function(f,time_ms) {
	var t = new haxe.Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
}
haxe.Timer.stamp = function() {
	return new Date().getTime() / 1000;
}
haxe.Timer.prototype = {
	run: function() {
		console.log("run");
	}
	,stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,id: null
	,__class__: haxe.Timer
}
flash.Lib = function(rootElement,width,height) {
	this.mKilled = false;
	this.__scr = rootElement;
	if(this.__scr == null) throw "Root element not found";
	this.__scr.style.setProperty("overflow","hidden","");
	this.__scr.style.setProperty("position","absolute","");
	if(this.__scr.style.getPropertyValue("width") != "100%") this.__scr.style.width = width + "px";
	if(this.__scr.style.getPropertyValue("height") != "100%") this.__scr.style.height = height + "px";
};
$hxClasses["flash.Lib"] = flash.Lib;
flash.Lib.__name__ = ["flash","Lib"];
flash.Lib.__properties__ = {get_current:"get_current"}
flash.Lib["as"] = function(v,c) {
	return js.Boot.__instanceof(v,c)?v:null;
}
flash.Lib.attach = function(name) {
	return new flash.display.MovieClip();
}
flash.Lib.getTimer = function() {
	return (haxe.Timer.stamp() - flash.Lib.starttime) * 1000 | 0;
}
flash.Lib.getURL = function(request,target) {
	document.open(request.url);
}
flash.Lib.nmeAppendSurface = function(surface,before,after) {
	if(flash.Lib.mMe.__scr != null) {
		surface.style.setProperty("position","absolute","");
		surface.style.setProperty("left","0px","");
		surface.style.setProperty("top","0px","");
		surface.style.setProperty("transform-origin","0 0","");
		surface.style.setProperty("-moz-transform-origin","0 0","");
		surface.style.setProperty("-webkit-transform-origin","0 0","");
		surface.style.setProperty("-o-transform-origin","0 0","");
		surface.style.setProperty("-ms-transform-origin","0 0","");
		try {
			if(surface.localName == "canvas") surface.onmouseover = surface.onselectstart = function() {
				return false;
			};
		} catch( e ) {
		}
		if(before != null) before.parentNode.insertBefore(surface,before); else if(after != null && after.nextSibling != null) after.parentNode.insertBefore(surface,after.nextSibling); else flash.Lib.mMe.__scr.appendChild(surface);
	}
}
flash.Lib.nmeAppendText = function(surface,container,text,wrap,isHtml) {
	var _g1 = 0, _g = surface.childNodes.length;
	while(_g1 < _g) {
		var i = _g1++;
		surface.removeChild(surface.childNodes[i]);
	}
	if(isHtml) container.innerHTML = text; else container.appendChild(js.Browser.document.createTextNode(text));
	container.style.setProperty("position","relative","");
	container.style.setProperty("cursor","default","");
	if(!wrap) container.style.setProperty("white-space","nowrap","");
	surface.appendChild(container);
}
flash.Lib.nmeBootstrap = function() {
	if(flash.Lib.mMe == null) {
		var target = js.Browser.document.getElementById("haxe:jeash");
		if(target == null) target = js.Browser.document.createElement("div");
		var agent = navigator.userAgent;
		if(agent.indexOf("BlackBerry") > -1 && target.style.height == "100%") target.style.height = screen.height + "px";
		if(agent.indexOf("Android") > -1) {
			var version = Std.parseFloat(HxOverrides.substr(agent,agent.indexOf("Android") + 8,3));
			if(version <= 2.3) flash.Lib.mForce2DTransform = true;
		}
		flash.Lib.Run(target,flash.Lib.nmeGetWidth(),flash.Lib.nmeGetHeight());
	}
}
flash.Lib.nmeCopyStyle = function(src,tgt) {
	tgt.id = src.id;
	var _g = 0, _g1 = ["left","top","transform","transform-origin","-moz-transform","-moz-transform-origin","-webkit-transform","-webkit-transform-origin","-o-transform","-o-transform-origin","opacity","display"];
	while(_g < _g1.length) {
		var prop = _g1[_g];
		++_g;
		tgt.style.setProperty(prop,src.style.getPropertyValue(prop),"");
	}
}
flash.Lib.nmeCreateSurfaceAnimationCSS = function(surface,data,template,templateFunc,fps,discrete,infinite) {
	if(infinite == null) infinite = false;
	if(discrete == null) discrete = false;
	if(fps == null) fps = 25;
	if(surface.id == null || surface.id == "") {
		flash.Lib.trace("Failed to create a CSS Style tag for a surface without an id attribute");
		return null;
	}
	var style = null;
	if(surface.getAttribute("data-nme-anim") != null) style = js.Browser.document.getElementById(surface.getAttribute("data-nme-anim")); else {
		style = flash.Lib.mMe.__scr.appendChild(js.Browser.document.createElement("style"));
		style.sheet.id = "__nme_anim_" + surface.id + "__";
		surface.setAttribute("data-nme-anim",style.sheet.id);
	}
	var keyframeStylesheetRule = "";
	var _g1 = 0, _g = data.length;
	while(_g1 < _g) {
		var i = _g1++;
		var perc = i / (data.length - 1) * 100;
		var frame = data[i];
		keyframeStylesheetRule += perc + "% { " + template.execute(templateFunc(frame)) + " } ";
	}
	var animationDiscreteRule = discrete?"steps(::steps::, end)":"";
	var animationInfiniteRule = infinite?"infinite":"";
	var animationTpl = "";
	var _g = 0, _g1 = ["animation","-moz-animation","-webkit-animation","-o-animation","-ms-animation"];
	while(_g < _g1.length) {
		var prefix = _g1[_g];
		++_g;
		animationTpl += prefix + ": ::id:: ::duration::s " + animationDiscreteRule + " " + animationInfiniteRule + "; ";
	}
	var animationStylesheetRule = new haxe.Template(animationTpl).execute({ id : surface.id, duration : data.length / fps, steps : 1});
	var rules = style.sheet.rules != null?style.sheet.rules:style.sheet.cssRules;
	var _g = 0, _g1 = ["","-moz-","-webkit-","-o-","-ms-"];
	while(_g < _g1.length) {
		var variant = _g1[_g];
		++_g;
		try {
			style.sheet.insertRule("@" + variant + "keyframes " + surface.id + " {" + keyframeStylesheetRule + "}",rules.length);
		} catch( e ) {
		}
	}
	style.sheet.insertRule("#" + surface.id + " { " + animationStylesheetRule + " } ",rules.length);
	return style;
}
flash.Lib.nmeDesignMode = function(mode) {
	js.Browser.document.designMode = mode?"on":"off";
}
flash.Lib.nmeDisableFullScreen = function() {
}
flash.Lib.nmeDisableRightClick = function() {
	if(flash.Lib.mMe != null) try {
		flash.Lib.mMe.__scr.oncontextmenu = function() {
			return false;
		};
	} catch( e ) {
		flash.Lib.trace("Disable right click not supported in this browser.");
	}
}
flash.Lib.nmeDrawClippedImage = function(surface,tgtCtx,clipRect) {
	if(clipRect != null) {
		if(clipRect.x < 0) {
			clipRect.width += clipRect.x;
			clipRect.x = 0;
		}
		if(clipRect.y < 0) {
			clipRect.height += clipRect.y;
			clipRect.y = 0;
		}
		if(clipRect.width > surface.width - clipRect.x) clipRect.width = surface.width - clipRect.x;
		if(clipRect.height > surface.height - clipRect.y) clipRect.height = surface.height - clipRect.y;
		tgtCtx.drawImage(surface,clipRect.x,clipRect.y,clipRect.width,clipRect.height,clipRect.x,clipRect.y,clipRect.width,clipRect.height);
	} else tgtCtx.drawImage(surface,0,0);
}
flash.Lib.nmeDrawSurfaceRect = function(surface,tgt,x,y,rect) {
	var tgtCtx = tgt.getContext("2d");
	tgt.width = rect.width;
	tgt.height = rect.height;
	tgtCtx.drawImage(surface,rect.x,rect.y,rect.width,rect.height,0,0,rect.width,rect.height);
	tgt.style.left = x + "px";
	tgt.style.top = y + "px";
}
flash.Lib.nmeDrawToSurface = function(surface,tgt,matrix,alpha,clipRect,smoothing) {
	if(smoothing == null) smoothing = true;
	if(alpha == null) alpha = 1.0;
	var srcCtx = surface.getContext("2d");
	var tgtCtx = tgt.getContext("2d");
	tgtCtx.globalAlpha = alpha;
	flash.Lib.nmeSetImageSmoothing(tgtCtx,smoothing);
	if(surface.width > 0 && surface.height > 0) {
		if(matrix != null) {
			tgtCtx.save();
			if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1) tgtCtx.translate(matrix.tx,matrix.ty); else tgtCtx.setTransform(matrix.a,matrix.b,matrix.c,matrix.d,matrix.tx,matrix.ty);
			flash.Lib.nmeDrawClippedImage(surface,tgtCtx,clipRect);
			tgtCtx.restore();
		} else flash.Lib.nmeDrawClippedImage(surface,tgtCtx,clipRect);
	}
}
flash.Lib.nmeEnableFullScreen = function() {
	if(flash.Lib.mMe != null) {
		var origWidth = flash.Lib.mMe.__scr.style.getPropertyValue("width");
		var origHeight = flash.Lib.mMe.__scr.style.getPropertyValue("height");
		flash.Lib.mMe.__scr.style.setProperty("width","100%","");
		flash.Lib.mMe.__scr.style.setProperty("height","100%","");
		flash.Lib.nmeDisableFullScreen = function() {
			flash.Lib.mMe.__scr.style.setProperty("width",origWidth,"");
			flash.Lib.mMe.__scr.style.setProperty("height",origHeight,"");
		};
	}
}
flash.Lib.nmeEnableRightClick = function() {
	if(flash.Lib.mMe != null) try {
		flash.Lib.mMe.__scr.oncontextmenu = null;
	} catch( e ) {
		flash.Lib.trace("Enable right click not supported in this browser.");
	}
}
flash.Lib.nmeFullScreenHeight = function() {
	return js.Browser.window.innerHeight;
}
flash.Lib.nmeFullScreenWidth = function() {
	return js.Browser.window.innerWidth;
}
flash.Lib.nmeGetHeight = function() {
	var tgt = flash.Lib.mMe != null?flash.Lib.mMe.__scr:js.Browser.document.getElementById("haxe:jeash");
	return tgt != null && tgt.clientHeight > 0?tgt.clientHeight:500;
}
flash.Lib.nmeGetStage = function() {
	if(flash.Lib.mStage == null) {
		var width = flash.Lib.nmeGetWidth();
		var height = flash.Lib.nmeGetHeight();
		flash.Lib.mStage = new flash.display.Stage(width,height);
	}
	return flash.Lib.mStage;
}
flash.Lib.nmeGetWidth = function() {
	var tgt = flash.Lib.mMe != null?flash.Lib.mMe.__scr:js.Browser.document.getElementById("haxe:jeash");
	return tgt != null && tgt.clientWidth > 0?tgt.clientWidth:500;
}
flash.Lib.nmeIsOnStage = function(surface) {
	var p = surface;
	while(p != null && p != flash.Lib.mMe.__scr) p = p.parentNode;
	return p == flash.Lib.mMe.__scr;
}
flash.Lib.nmeParseColor = function(str,cb) {
	var re = new EReg("rgb\\(([0-9]*), ?([0-9]*), ?([0-9]*)\\)","");
	var hex = new EReg("#([0-9a-zA-Z][0-9a-zA-Z])([0-9a-zA-Z][0-9a-zA-Z])([0-9a-zA-Z][0-9a-zA-Z])","");
	if(re.match(str)) {
		var col = 0;
		var _g = 1;
		while(_g < 4) {
			var pos = _g++;
			var v = Std.parseInt(re.matched(pos));
			col = cb(col,pos - 1,v);
		}
		return col;
	} else if(hex.match(str)) {
		var col = 0;
		var _g = 1;
		while(_g < 4) {
			var pos = _g++;
			var v = "0x" + hex.matched(pos) & 255;
			v = cb(col,pos - 1,v);
		}
		return col;
	} else throw "Cannot parse color '" + str + "'.";
}
flash.Lib.nmeRemoveSurface = function(surface) {
	if(flash.Lib.mMe.__scr != null) {
		var anim = surface.getAttribute("data-nme-anim");
		if(anim != null) {
			var style = js.Browser.document.getElementById(anim);
			if(style != null) flash.Lib.mMe.__scr.removeChild(style);
		}
		if(surface.parentNode != null) surface.parentNode.removeChild(surface);
	}
	return surface;
}
flash.Lib.nmeSetSurfaceBorder = function(surface,color,size) {
	surface.style.setProperty("border-color","#" + StringTools.hex(color),"");
	surface.style.setProperty("border-style","solid","");
	surface.style.setProperty("border-width",size + "px","");
	surface.style.setProperty("border-collapse","collapse","");
}
flash.Lib.nmeSetSurfaceClipping = function(surface,rect) {
}
flash.Lib.nmeSetSurfaceFont = function(surface,font,bold,size,color,align,lineHeight) {
	surface.style.setProperty("font-family",font,"");
	surface.style.setProperty("font-weight",Std.string(bold),"");
	surface.style.setProperty("color","#" + StringTools.hex(color),"");
	surface.style.setProperty("font-size",size + "px","");
	surface.style.setProperty("text-align",align,"");
	surface.style.setProperty("line-height",lineHeight + "px","");
}
flash.Lib.nmeSetSurfaceOpacity = function(surface,alpha) {
	surface.style.setProperty("opacity",Std.string(alpha),"");
}
flash.Lib.nmeSetSurfacePadding = function(surface,padding,margin,display) {
	surface.style.setProperty("padding",padding + "px","");
	surface.style.setProperty("margin",margin + "px","");
	surface.style.setProperty("top",padding + 2 + "px","");
	surface.style.setProperty("right",padding + 1 + "px","");
	surface.style.setProperty("left",padding + 1 + "px","");
	surface.style.setProperty("bottom",padding + 1 + "px","");
	surface.style.setProperty("display",display?"inline":"block","");
}
flash.Lib.nmeSetSurfaceTransform = function(surface,matrix) {
	if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1 && surface.getAttribute("data-nme-anim") == null) {
		surface.style.left = matrix.tx + "px";
		surface.style.top = matrix.ty + "px";
		surface.style.setProperty("transform","","");
		surface.style.setProperty("-moz-transform","","");
		surface.style.setProperty("-webkit-transform","","");
		surface.style.setProperty("-o-transform","","");
		surface.style.setProperty("-ms-transform","","");
	} else {
		surface.style.left = "0px";
		surface.style.top = "0px";
		surface.style.setProperty("transform","matrix(" + matrix.a + ", " + matrix.b + ", " + matrix.c + ", " + matrix.d + ", " + matrix.tx + ", " + matrix.ty + ")","");
		surface.style.setProperty("-moz-transform","matrix(" + matrix.a + ", " + matrix.b + ", " + matrix.c + ", " + matrix.d + ", " + matrix.tx + "px, " + matrix.ty + "px)","");
		if(!flash.Lib.mForce2DTransform) surface.style.setProperty("-webkit-transform","matrix3d(" + matrix.a + ", " + matrix.b + ", " + "0, 0, " + matrix.c + ", " + matrix.d + ", " + "0, 0, 0, 0, 1, 0, " + matrix.tx + ", " + matrix.ty + ", " + "0, 1" + ")",""); else surface.style.setProperty("-webkit-transform","matrix(" + matrix.a + ", " + matrix.b + ", " + matrix.c + ", " + matrix.d + ", " + matrix.tx + ", " + matrix.ty + ")","");
		surface.style.setProperty("-o-transform","matrix(" + matrix.a + ", " + matrix.b + ", " + matrix.c + ", " + matrix.d + ", " + matrix.tx + ", " + matrix.ty + ")","");
		surface.style.setProperty("-ms-transform","matrix(" + matrix.a + ", " + matrix.b + ", " + matrix.c + ", " + matrix.d + ", " + matrix.tx + ", " + matrix.ty + ")","");
	}
}
flash.Lib.nmeSetSurfaceZIndexAfter = function(surface1,surface2) {
	if(surface1 != null && surface2 != null) {
		if(surface1.parentNode != surface2.parentNode && surface2.parentNode != null) surface2.parentNode.appendChild(surface1);
		if(surface2.parentNode != null) {
			var nextSibling = surface2.nextSibling;
			if(surface1.previousSibling != surface2) {
				var swap = flash.Lib.nmeRemoveSurface(surface1);
				if(nextSibling == null) surface2.parentNode.appendChild(swap); else surface2.parentNode.insertBefore(swap,nextSibling);
			}
		}
	}
}
flash.Lib.nmeSwapSurface = function(surface1,surface2) {
	var parent1 = surface1.parentNode;
	var parent2 = surface2.parentNode;
	if(parent1 != null && parent2 != null) {
		if(parent1 == parent2) {
			var next1 = surface1.nextSibling;
			var next2 = surface2.nextSibling;
			if(next1 == surface2) parent1.insertBefore(surface2,surface1); else if(next2 == surface1) parent1.insertBefore(surface1,surface2); else {
				parent1.replaceChild(surface2,surface1);
				if(next2 != null) parent1.insertBefore(surface1,next2); else parent1.appendChild(surface1);
			}
		} else {
			var next2 = surface2.nextSibling;
			parent1.replaceChild(surface2,surface1);
			if(next2 != null) parent2.insertBefore(surface1,next2); else parent2.appendChild(surface1);
		}
	}
}
flash.Lib.nmeSetContentEditable = function(surface,contentEditable) {
	if(contentEditable == null) contentEditable = true;
	surface.setAttribute("contentEditable",contentEditable?"true":"false");
}
flash.Lib.nmeSetCursor = function(type) {
	if(flash.Lib.mMe != null) flash.Lib.mMe.__scr.style.cursor = (function($this) {
		var $r;
		switch( (type)[1] ) {
		case 0:
			$r = "pointer";
			break;
		case 1:
			$r = "text";
			break;
		default:
			$r = "default";
		}
		return $r;
	}(this));
}
flash.Lib.nmeSetImageSmoothing = function(context,enabled) {
	var _g = 0, _g1 = ["imageSmoothingEnabled","mozImageSmoothingEnabled","webkitImageSmoothingEnabled"];
	while(_g < _g1.length) {
		var variant = _g1[_g];
		++_g;
		context[variant] = enabled;
	}
}
flash.Lib.nmeSetSurfaceAlign = function(surface,align) {
	surface.style.setProperty("text-align",align,"");
}
flash.Lib.nmeSetSurfaceId = function(surface,name) {
	var regex = new EReg("[^a-zA-Z0-9\\-]","g");
	surface.id = regex.replace(name,"_");
}
flash.Lib.nmeSetSurfaceRotation = function(surface,rotate) {
	surface.style.setProperty("transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-moz-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-webkit-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-o-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-ms-transform","rotate(" + rotate + "deg)","");
}
flash.Lib.nmeSetSurfaceScale = function(surface,scale) {
	surface.style.setProperty("transform","scale(" + scale + ")","");
	surface.style.setProperty("-moz-transform","scale(" + scale + ")","");
	surface.style.setProperty("-webkit-transform","scale(" + scale + ")","");
	surface.style.setProperty("-o-transform","scale(" + scale + ")","");
	surface.style.setProperty("-ms-transform","scale(" + scale + ")","");
}
flash.Lib.nmeSetSurfaceSpritesheetAnimation = function(surface,spec,fps) {
	if(spec.length == 0) return surface;
	var div = js.Browser.document.createElement("div");
	div.style.backgroundImage = "url(" + surface.toDataURL("image/png") + ")";
	div.id = surface.id;
	var keyframeTpl = new haxe.Template("background-position: ::left::px ::top::px; width: ::width::px; height: ::height::px; ");
	var templateFunc = function(frame) {
		return { left : -frame.x, top : -frame.y, width : frame.width, height : frame.height};
	};
	flash.Lib.nmeCreateSurfaceAnimationCSS(div,spec,keyframeTpl,templateFunc,fps,true,true);
	if(flash.Lib.nmeIsOnStage(surface)) {
		flash.Lib.nmeAppendSurface(div);
		flash.Lib.nmeCopyStyle(surface,div);
		flash.Lib.nmeSwapSurface(surface,div);
		flash.Lib.nmeRemoveSurface(surface);
	} else flash.Lib.nmeCopyStyle(surface,div);
	return div;
}
flash.Lib.nmeSetSurfaceVisible = function(surface,visible) {
	if(visible) surface.style.setProperty("display","block",""); else surface.style.setProperty("display","none","");
}
flash.Lib.nmeSetTextDimensions = function(surface,width,height,align) {
	surface.style.setProperty("width",width + "px","");
	surface.style.setProperty("height",height + "px","");
	surface.style.setProperty("overflow","hidden","");
	surface.style.setProperty("text-align",align,"");
}
flash.Lib.nmeSurfaceHitTest = function(surface,x,y) {
	var _g1 = 0, _g = surface.childNodes.length;
	while(_g1 < _g) {
		var i = _g1++;
		var node = surface.childNodes[i];
		if(x >= node.offsetLeft && x <= node.offsetLeft + node.offsetWidth && y >= node.offsetTop && y <= node.offsetTop + node.offsetHeight) return true;
	}
	return false;
}
flash.Lib.preventDefaultTouchMove = function() {
	js.Browser.document.addEventListener("touchmove",function(evt) {
		evt.preventDefault();
	},false);
}
flash.Lib.Run = function(tgt,width,height) {
	flash.Lib.mMe = new flash.Lib(tgt,width,height);
	var _g1 = 0, _g = tgt.attributes.length;
	while(_g1 < _g) {
		var i = _g1++;
		var attr = tgt.attributes.item(i);
		if(StringTools.startsWith(attr.name,"data-")) {
			if(attr.name == "data-" + "framerate") flash.Lib.nmeGetStage().set_frameRate(Std.parseFloat(attr.value));
		}
	}
	if(Reflect.hasField(tgt,"on" + flash.Lib.HTML_TOUCH_EVENT_TYPES[0])) {
		var _g = 0, _g1 = flash.Lib.HTML_TOUCH_EVENT_TYPES;
		while(_g < _g1.length) {
			var type = _g1[_g];
			++_g;
			tgt.addEventListener(type,($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),true);
		}
	} else {
		var _g = 0, _g1 = flash.Lib.HTML_TOUCH_ALT_EVENT_TYPES;
		while(_g < _g1.length) {
			var type = _g1[_g];
			++_g;
			tgt.addEventListener(type,($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),true);
		}
	}
	var _g = 0, _g1 = flash.Lib.HTML_DIV_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		tgt.addEventListener(type,($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),true);
	}
	if(Reflect.hasField(js.Browser.window,"on" + "devicemotion")) js.Browser.window.addEventListener("devicemotion",($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),true);
	if(Reflect.hasField(js.Browser.window,"on" + "orientationchange")) js.Browser.window.addEventListener("orientationchange",($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),true);
	var _g = 0, _g1 = flash.Lib.HTML_WINDOW_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		js.Browser.window.addEventListener(type,($_=flash.Lib.nmeGetStage(),$bind($_,$_.nmeQueueStageEvent)),false);
	}
	if(tgt.style.backgroundColor != null && tgt.style.backgroundColor != "") flash.Lib.nmeGetStage().set_backgroundColor(flash.Lib.nmeParseColor(tgt.style.backgroundColor,function(res,pos,cur) {
		return pos == 0?res | cur << 16:pos == 1?res | cur << 8:pos == 2?res | cur:(function($this) {
			var $r;
			throw "pos should be 0-2";
			return $r;
		}(this));
	})); else flash.Lib.nmeGetStage().set_backgroundColor(16777215);
	flash.Lib.get_current().get_graphics().beginFill(flash.Lib.nmeGetStage().get_backgroundColor());
	flash.Lib.get_current().get_graphics().drawRect(0,0,width,height);
	flash.Lib.nmeSetSurfaceId(flash.Lib.get_current().get_graphics().nmeSurface,"Root MovieClip");
	flash.Lib.nmeGetStage().nmeUpdateNextWake();
	try {
		var winParameters = js.Browser.window.winParameters();
		var _g = 0, _g1 = Reflect.fields(winParameters);
		while(_g < _g1.length) {
			var prop = _g1[_g];
			++_g;
			flash.Lib.get_current().loaderInfo.parameters[prop] = Reflect.field(winParameters,prop);
		}
	} catch( e ) {
	}
	return flash.Lib.mMe;
}
flash.Lib.setUserScalable = function(isScalable) {
	if(isScalable == null) isScalable = true;
	var meta = js.Browser.document.createElement("meta");
	meta.name = "viewport";
	meta.content = "user-scalable=" + (isScalable?"yes":"no");
}
flash.Lib.trace = function(arg) {
	if(window.console != null) window.console.log(arg);
}
flash.Lib.get_current = function() {
	if(flash.Lib.mMainClassRoot == null) {
		flash.Lib.mMainClassRoot = new flash.display.MovieClip();
		flash.Lib.mCurrent = flash.Lib.mMainClassRoot;
		flash.Lib.nmeGetStage().addChild(flash.Lib.mCurrent);
	}
	return flash.Lib.mMainClassRoot;
}
flash.Lib.prototype = {
	__scr: null
	,mKilled: null
	,mArgs: null
	,__class__: flash.Lib
}
flash._Lib = {}
flash._Lib.CursorType = $hxClasses["flash._Lib.CursorType"] = { __ename__ : true, __constructs__ : ["Pointer","Text","Default"] }
flash._Lib.CursorType.Pointer = ["Pointer",0];
flash._Lib.CursorType.Pointer.toString = $estr;
flash._Lib.CursorType.Pointer.__enum__ = flash._Lib.CursorType;
flash._Lib.CursorType.Text = ["Text",1];
flash._Lib.CursorType.Text.toString = $estr;
flash._Lib.CursorType.Text.__enum__ = flash._Lib.CursorType;
flash._Lib.CursorType.Default = ["Default",2];
flash._Lib.CursorType.Default.toString = $estr;
flash._Lib.CursorType.Default.__enum__ = flash._Lib.CursorType;
flash._Vector = {}
flash._Vector.Vector_Impl_ = function() { }
$hxClasses["flash._Vector.Vector_Impl_"] = flash._Vector.Vector_Impl_;
flash._Vector.Vector_Impl_.__name__ = ["flash","_Vector","Vector_Impl_"];
flash._Vector.Vector_Impl_.__properties__ = {set_fixed:"set_fixed",get_fixed:"get_fixed",set_length:"set_length",get_length:"get_length"}
flash._Vector.Vector_Impl_._new = function(length,fixed) {
	return new Array();
}
flash._Vector.Vector_Impl_.concat = function(this1,a) {
	return this1.concat(a);
}
flash._Vector.Vector_Impl_.copy = function(this1) {
	return this1.slice();
}
flash._Vector.Vector_Impl_.iterator = function(this1) {
	return HxOverrides.iter(this1);
}
flash._Vector.Vector_Impl_.join = function(this1,sep) {
	return this1.join(sep);
}
flash._Vector.Vector_Impl_.pop = function(this1) {
	return this1.pop();
}
flash._Vector.Vector_Impl_.push = function(this1,x) {
	return this1.push(x);
}
flash._Vector.Vector_Impl_.reverse = function(this1) {
	this1.reverse();
}
flash._Vector.Vector_Impl_.shift = function(this1) {
	return this1.shift();
}
flash._Vector.Vector_Impl_.unshift = function(this1,x) {
	this1.unshift(x);
}
flash._Vector.Vector_Impl_.slice = function(this1,pos,end) {
	return this1.slice(pos,end);
}
flash._Vector.Vector_Impl_.sort = function(this1,f) {
	this1.sort(f);
}
flash._Vector.Vector_Impl_.splice = function(this1,pos,len) {
	return this1.splice(pos,len);
}
flash._Vector.Vector_Impl_.toString = function(this1) {
	return this1.toString();
}
flash._Vector.Vector_Impl_.indexOf = function(this1,x,from) {
	if(from == null) from = 0;
	var _g1 = from, _g = this1.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(this1[i] == x) return i;
	}
	return -1;
}
flash._Vector.Vector_Impl_.lastIndexOf = function(this1,x,from) {
	if(from == null) from = 0;
	var i = this1.length - 1;
	while(i >= from) {
		if(this1[i] == x) return i;
		i--;
	}
	return -1;
}
flash._Vector.Vector_Impl_.ofArray = function(a) {
	return flash._Vector.Vector_Impl_.concat(flash._Vector.Vector_Impl_._new(),a);
}
flash._Vector.Vector_Impl_.convert = function(v) {
	return v;
}
flash._Vector.Vector_Impl_.fromArray = function(a) {
	return a;
}
flash._Vector.Vector_Impl_.toArray = function(this1) {
	return this1;
}
flash._Vector.Vector_Impl_.get_length = function(this1) {
	return this1.length;
}
flash._Vector.Vector_Impl_.set_length = function(this1,value) {
	if(value < this1.length) this1 = this1.slice(0,value);
	while(value > this1.length) this1.push(null);
	return value;
}
flash._Vector.Vector_Impl_.get_fixed = function(this1) {
	return false;
}
flash._Vector.Vector_Impl_.set_fixed = function(this1,value) {
	return value;
}
flash.accessibility = {}
flash.accessibility.AccessibilityProperties = function() {
	this.description = "";
	this.forceSimple = false;
	this.name = "";
	this.noAutoLabeling = false;
	this.shortcut = "";
	this.silent = false;
};
$hxClasses["flash.accessibility.AccessibilityProperties"] = flash.accessibility.AccessibilityProperties;
flash.accessibility.AccessibilityProperties.__name__ = ["flash","accessibility","AccessibilityProperties"];
flash.accessibility.AccessibilityProperties.prototype = {
	silent: null
	,shortcut: null
	,noAutoLabeling: null
	,name: null
	,forceSimple: null
	,description: null
	,__class__: flash.accessibility.AccessibilityProperties
}
flash.display.Bitmap = function(inBitmapData,inPixelSnapping,inSmoothing) {
	if(inSmoothing == null) inSmoothing = false;
	flash.display.DisplayObject.call(this);
	this.pixelSnapping = inPixelSnapping;
	this.smoothing = inSmoothing;
	if(inBitmapData != null) {
		this.set_bitmapData(inBitmapData);
		this.bitmapData.nmeReferenceCount++;
		if(this.bitmapData.nmeReferenceCount == 1) this.nmeGraphics = new flash.display.Graphics(this.bitmapData._nmeTextureBuffer);
	}
	if(this.pixelSnapping == null) this.pixelSnapping = flash.display.PixelSnapping.AUTO;
	if(this.nmeGraphics == null) this.nmeGraphics = new flash.display.Graphics();
	if(this.bitmapData != null) this.nmeRender();
};
$hxClasses["flash.display.Bitmap"] = flash.display.Bitmap;
flash.display.Bitmap.__name__ = ["flash","display","Bitmap"];
flash.display.Bitmap.__super__ = flash.display.DisplayObject;
flash.display.Bitmap.prototype = $extend(flash.display.DisplayObject.prototype,{
	set_bitmapData: function(inBitmapData) {
		if(inBitmapData != this.bitmapData) {
			if(this.bitmapData != null) {
				this.bitmapData.nmeReferenceCount--;
				if(this.nmeGraphics.nmeSurface == this.bitmapData._nmeTextureBuffer) flash.Lib.nmeSetSurfaceOpacity(this.bitmapData._nmeTextureBuffer,0);
			}
			if(inBitmapData != null) inBitmapData.nmeReferenceCount++;
		}
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		this.bitmapData = inBitmapData;
		return inBitmapData;
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.DisplayObject.prototype.validateBounds.call(this);
			if(this.bitmapData != null) {
				var r = new flash.geom.Rectangle(0,0,this.bitmapData.get_width(),this.bitmapData.get_height());
				if(r.width != 0 || r.height != 0) {
					if(this.nmeBoundsRect.width == 0 && this.nmeBoundsRect.height == 0) this.nmeBoundsRect = r.clone(); else this.nmeBoundsRect.extendBounds(r);
				}
			}
			if(this.scale9Grid != null) {
				this.nmeBoundsRect.width *= this.nmeScaleX;
				this.nmeBoundsRect.height *= this.nmeScaleY;
				this.nmeWidth = this.nmeBoundsRect.width;
				this.nmeHeight = this.nmeBoundsRect.height;
			} else {
				this.nmeWidth = this.nmeBoundsRect.width * this.nmeScaleX;
				this.nmeHeight = this.nmeBoundsRect.height * this.nmeScaleY;
			}
		}
	}
	,toString: function() {
		return "[Bitmap name=" + this.name + " id=" + this._nmeId + "]";
	}
	,nmeRender: function(inMask,clipRect) {
		if(!this.nmeCombinedVisible) return;
		if(this.bitmapData == null) return;
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		if(this.bitmapData._nmeTextureBuffer != this.nmeGraphics.nmeSurface) {
			var imageDataLease = this.bitmapData.nmeLease;
			if(imageDataLease != null && (this.nmeCurrentLease == null || imageDataLease.seed != this.nmeCurrentLease.seed || imageDataLease.time != this.nmeCurrentLease.time)) {
				var srcCanvas = this.bitmapData._nmeTextureBuffer;
				this.nmeGraphics.nmeSurface.width = srcCanvas.width;
				this.nmeGraphics.nmeSurface.height = srcCanvas.height;
				this.nmeGraphics.clear();
				flash.Lib.nmeDrawToSurface(srcCanvas,this.nmeGraphics.nmeSurface);
				this.nmeCurrentLease = imageDataLease.clone();
				this._nmeRenderFlags |= 64;
				if(this.parent != null) this.parent._nmeRenderFlags |= 64;
				this.nmeApplyFilters(this.nmeGraphics.nmeSurface);
				this._nmeRenderFlags |= 32;
			}
		}
		if(inMask != null) {
			this.nmeApplyFilters(this.nmeGraphics.nmeSurface);
			var m = this.getBitmapSurfaceTransform(this.nmeGraphics);
			flash.Lib.nmeDrawToSurface(this.nmeGraphics.nmeSurface,inMask,m,(this.parent != null?this.parent.nmeCombinedAlpha:1) * this.alpha,clipRect,this.smoothing);
		} else {
			if((this._nmeRenderFlags & 32) != 0) {
				var m = this.getBitmapSurfaceTransform(this.nmeGraphics);
				flash.Lib.nmeSetSurfaceTransform(this.nmeGraphics.nmeSurface,m);
				this._nmeRenderFlags &= -33;
			}
			if(!this.nmeInit) {
				flash.Lib.nmeSetSurfaceOpacity(this.nmeGraphics.nmeSurface,0);
				this.nmeInit = true;
			} else flash.Lib.nmeSetSurfaceOpacity(this.nmeGraphics.nmeSurface,(this.parent != null?this.parent.nmeCombinedAlpha:1) * this.alpha);
		}
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null; else if(this.bitmapData != null) {
			var local = this.globalToLocal(point);
			if(local.x < 0 || local.y < 0 || local.x > this.get_width() || local.y > this.get_height()) return null; else return this;
		} else return flash.display.DisplayObject.prototype.nmeGetObjectUnderPoint.call(this,point);
	}
	,nmeGetGraphics: function() {
		return this.nmeGraphics;
	}
	,getBitmapSurfaceTransform: function(gfx) {
		var extent = gfx.nmeExtentWithFilters;
		var fm = this.transform.nmeGetFullMatrix(null);
		fm.nmeTranslateTransformed(extent.get_topLeft());
		return fm;
	}
	,nmeInit: null
	,nmeCurrentLease: null
	,nmeGraphics: null
	,smoothing: null
	,pixelSnapping: null
	,bitmapData: null
	,__class__: flash.display.Bitmap
	,__properties__: $extend(flash.display.DisplayObject.prototype.__properties__,{set_bitmapData:"set_bitmapData"})
});
flash.display.BitmapData = function(width,height,transparent,inFillColor) {
	if(inFillColor == null) inFillColor = -1;
	if(transparent == null) transparent = true;
	this.nmeLocked = false;
	this.nmeReferenceCount = 0;
	this.nmeLeaseNum = 0;
	this.nmeLease = new flash.display.ImageDataLease();
	this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
	this._nmeTextureBuffer = js.Browser.document.createElement("canvas");
	this._nmeTextureBuffer.width = width;
	this._nmeTextureBuffer.height = height;
	this._nmeId = flash.utils.Uuid.uuid();
	flash.Lib.nmeSetSurfaceId(this._nmeTextureBuffer,this._nmeId);
	this.nmeTransparent = transparent;
	this.rect = new flash.geom.Rectangle(0,0,width,height);
	if(this.nmeTransparent) {
		this.nmeTransparentFiller = js.Browser.document.createElement("canvas");
		this.nmeTransparentFiller.width = width;
		this.nmeTransparentFiller.height = height;
		var ctx = this.nmeTransparentFiller.getContext("2d");
		ctx.fillStyle = "rgba(0,0,0,0);";
		ctx.fill();
	}
	if(inFillColor != null && width > 0 && height > 0) {
		if(!this.nmeTransparent) inFillColor |= -16777216;
		this.nmeInitColor = inFillColor;
		this.nmeFillRect(this.rect,inFillColor);
	}
};
$hxClasses["flash.display.BitmapData"] = flash.display.BitmapData;
flash.display.BitmapData.__name__ = ["flash","display","BitmapData"];
flash.display.BitmapData.__interfaces__ = [flash.display.IBitmapDrawable];
flash.display.BitmapData.getRGBAPixels = function(bitmapData) {
	var p = bitmapData.getPixels(new flash.geom.Rectangle(0,0,bitmapData._nmeTextureBuffer != null?bitmapData._nmeTextureBuffer.width:0,bitmapData._nmeTextureBuffer != null?bitmapData._nmeTextureBuffer.height:0));
	var num = (bitmapData._nmeTextureBuffer != null?bitmapData._nmeTextureBuffer.width:0) * (bitmapData._nmeTextureBuffer != null?bitmapData._nmeTextureBuffer.height:0);
	p.position = 0;
	var _g = 0;
	while(_g < num) {
		var i = _g++;
		var pos = p.position;
		var alpha = p.readByte();
		var red = p.readByte();
		var green = p.readByte();
		var blue = p.readByte();
		p.position = pos;
		p.writeByte(red);
		p.writeByte(green);
		p.writeByte(blue);
		p.writeByte(alpha);
	}
	return p;
}
flash.display.BitmapData.loadFromBytes = function(bytes,inRawAlpha,onload) {
	var bitmapData = new flash.display.BitmapData(0,0);
	bitmapData.nmeLoadFromBytes(bytes,inRawAlpha,onload);
	return bitmapData;
}
flash.display.BitmapData.nmeBase64Encode = function(bytes) {
	var blob = "";
	var codex = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	bytes.position = 0;
	while(bytes.position < bytes.length) {
		var by1 = 0, by2 = 0, by3 = 0;
		by1 = bytes.readByte();
		if(bytes.position < bytes.length) by2 = bytes.readByte();
		if(bytes.position < bytes.length) by3 = bytes.readByte();
		var by4 = 0, by5 = 0, by6 = 0, by7 = 0;
		by4 = by1 >> 2;
		by5 = (by1 & 3) << 4 | by2 >> 4;
		by6 = (by2 & 15) << 2 | by3 >> 6;
		by7 = by3 & 63;
		blob += codex.charAt(by4);
		blob += codex.charAt(by5);
		if(bytes.position < bytes.length) blob += codex.charAt(by6); else blob += "=";
		if(bytes.position < bytes.length) blob += codex.charAt(by7); else blob += "=";
	}
	return blob;
}
flash.display.BitmapData.nmeCreateFromHandle = function(inHandle) {
	var result = new flash.display.BitmapData(0,0);
	result._nmeTextureBuffer = inHandle;
	return result;
}
flash.display.BitmapData.nmeIsJPG = function(bytes) {
	bytes.position = 0;
	return bytes.readByte() == 255 && bytes.readByte() == 216;
}
flash.display.BitmapData.nmeIsPNG = function(bytes) {
	bytes.position = 0;
	return bytes.readByte() == 137 && bytes.readByte() == 80 && bytes.readByte() == 78 && bytes.readByte() == 71 && bytes.readByte() == 13 && bytes.readByte() == 10 && bytes.readByte() == 26 && bytes.readByte() == 10;
}
flash.display.BitmapData.prototype = {
	get_width: function() {
		if(this._nmeTextureBuffer != null) return this._nmeTextureBuffer.width; else return 0;
	}
	,get_transparent: function() {
		return this.nmeTransparent;
	}
	,get_height: function() {
		if(this._nmeTextureBuffer != null) return this._nmeTextureBuffer.height; else return 0;
	}
	,nmeOnLoad: function(data,e) {
		var canvas = data.texture;
		var width = data.image.width;
		var height = data.image.height;
		canvas.width = width;
		canvas.height = height;
		var ctx = canvas.getContext("2d");
		ctx.drawImage(data.image,0,0,width,height);
		data.bitmapData.width = width;
		data.bitmapData.height = height;
		data.bitmapData.rect = new flash.geom.Rectangle(0,0,width,height);
		data.bitmapData.nmeBuildLease();
		if(data.inLoader != null) {
			var e1 = new flash.events.Event(flash.events.Event.COMPLETE);
			e1.target = data.inLoader;
			data.inLoader.dispatchEvent(e1);
		}
	}
	,unlock: function(changeRect) {
		this.nmeLocked = false;
		var ctx = this._nmeTextureBuffer.getContext("2d");
		if(this.nmeImageDataChanged) {
			if(changeRect != null) ctx.putImageData(this.nmeImageData,0,0,changeRect.x,changeRect.y,changeRect.width,changeRect.height); else ctx.putImageData(this.nmeImageData,0,0);
		}
		var _g = 0, _g1 = this.nmeCopyPixelList;
		while(_g < _g1.length) {
			var copyCache = _g1[_g];
			++_g;
			if(this.nmeTransparent && copyCache.transparentFiller != null) {
				var trpCtx = copyCache.transparentFiller.getContext("2d");
				var trpData = trpCtx.getImageData(copyCache.sourceX,copyCache.sourceY,copyCache.sourceWidth,copyCache.sourceHeight);
				ctx.putImageData(trpData,copyCache.destX,copyCache.destY);
			}
			ctx.drawImage(copyCache.handle,copyCache.sourceX,copyCache.sourceY,copyCache.sourceWidth,copyCache.sourceHeight,copyCache.destX,copyCache.destY,copyCache.sourceWidth,copyCache.sourceHeight);
		}
		this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
	}
	,threshold: function(sourceBitmapData,sourceRect,destPoint,operation,threshold,color,mask,copySource) {
		if(copySource == null) copySource = false;
		if(mask == null) mask = -1;
		if(color == null) color = 0;
		console.log("BitmapData.threshold not implemented");
		return 0;
	}
	,setPixels: function(rect,byteArray) {
		rect = this.clipRect(rect);
		if(rect == null) return;
		var len = Math.round(4 * rect.width * rect.height);
		if(!this.nmeLocked) {
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.createImageData(rect.width,rect.height);
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				imageData.data[i] = byteArray.readByte();
			}
			ctx.putImageData(imageData,rect.x,rect.y);
		} else {
			var offset = Math.round(4 * this.nmeImageData.width * rect.y + rect.x * 4);
			var pos = offset;
			var boundR = Math.round(4 * (rect.x + rect.width));
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				if(pos % (this.nmeImageData.width * 4) > boundR - 1) pos += this.nmeImageData.width * 4 - boundR;
				this.nmeImageData.data[pos] = byteArray.readByte();
				pos++;
			}
			this.nmeImageDataChanged = true;
		}
	}
	,setPixel32: function(x,y,color) {
		if(x < 0 || y < 0 || x >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) || y >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) return;
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.createImageData(1,1);
			imageData.data[0] = (color & 16711680) >>> 16;
			imageData.data[1] = (color & 65280) >>> 8;
			imageData.data[2] = color & 255;
			if(this.nmeTransparent) imageData.data[3] = (color & -16777216) >>> 24; else imageData.data[3] = 255;
			ctx.putImageData(imageData,x,y);
		} else {
			var offset = 4 * y * this.nmeImageData.width + x * 4;
			this.nmeImageData.data[offset] = (color & 16711680) >>> 16;
			this.nmeImageData.data[offset + 1] = (color & 65280) >>> 8;
			this.nmeImageData.data[offset + 2] = color & 255;
			if(this.nmeTransparent) this.nmeImageData.data[offset + 3] = (color & -16777216) >>> 24; else this.nmeImageData.data[offset + 3] = 255;
			this.nmeImageDataChanged = true;
		}
	}
	,setPixel: function(x,y,color) {
		if(x < 0 || y < 0 || x >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) || y >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) return;
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.createImageData(1,1);
			imageData.data[0] = (color & 16711680) >>> 16;
			imageData.data[1] = (color & 65280) >>> 8;
			imageData.data[2] = color & 255;
			if(this.nmeTransparent) imageData.data[3] = 255;
			ctx.putImageData(imageData,x,y);
		} else {
			var offset = 4 * y * this.nmeImageData.width + x * 4;
			this.nmeImageData.data[offset] = (color & 16711680) >>> 16;
			this.nmeImageData.data[offset + 1] = (color & 65280) >>> 8;
			this.nmeImageData.data[offset + 2] = color & 255;
			if(this.nmeTransparent) this.nmeImageData.data[offset + 3] = 255;
			this.nmeImageDataChanged = true;
		}
	}
	,scroll: function(x,y) {
		throw "bitmapData.scroll is currently not supported for HTML5";
	}
	,noise: function(randomSeed,low,high,channelOptions,grayScale) {
		if(grayScale == null) grayScale = false;
		if(channelOptions == null) channelOptions = 7;
		if(high == null) high = 255;
		if(low == null) low = 0;
		var generator = new flash.display._BitmapData.MinstdGenerator(randomSeed);
		var ctx = this._nmeTextureBuffer.getContext("2d");
		var imageData = null;
		if(this.nmeLocked) imageData = this.nmeImageData; else imageData = ctx.createImageData(this._nmeTextureBuffer.width,this._nmeTextureBuffer.height);
		var _g1 = 0, _g = this._nmeTextureBuffer.width * this._nmeTextureBuffer.height;
		while(_g1 < _g) {
			var i = _g1++;
			if(grayScale) imageData.data[i * 4] = imageData.data[i * 4 + 1] = imageData.data[i * 4 + 2] = low + generator.nextValue() % (high - low + 1); else {
				imageData.data[i * 4] = (channelOptions & 1) == 0?0:low + generator.nextValue() % (high - low + 1);
				imageData.data[i * 4 + 1] = (channelOptions & 2) == 0?0:low + generator.nextValue() % (high - low + 1);
				imageData.data[i * 4 + 2] = (channelOptions & 4) == 0?0:low + generator.nextValue() % (high - low + 1);
			}
			imageData.data[i * 4 + 3] = (channelOptions & 8) == 0?255:low + generator.nextValue() % (high - low + 1);
		}
		if(this.nmeLocked) this.nmeImageDataChanged = true; else ctx.putImageData(imageData,0,0);
	}
	,nmeLoadFromFile: function(inFilename,inLoader) {
		var _g = this;
		var image = js.Browser.document.createElement("img");
		if(inLoader != null) {
			var data = { image : image, texture : this._nmeTextureBuffer, inLoader : inLoader, bitmapData : this};
			image.addEventListener("load",(function(f,a1) {
				return function(e) {
					return f(a1,e);
				};
			})($bind(this,this.nmeOnLoad),data),false);
			image.addEventListener("error",function(e) {
				if(!image.complete) _g.nmeOnLoad(data,e);
			},false);
		}
		image.src = inFilename;
		if(image.complete) {
		}
	}
	,nmeIncrNumRefBitmaps: function() {
		this.nmeAssignedBitmaps++;
	}
	,nmeGetNumRefBitmaps: function() {
		return this.nmeAssignedBitmaps;
	}
	,nmeLoadFromBytes: function(bytes,inRawAlpha,onload) {
		var _g = this;
		var type = "";
		if(flash.display.BitmapData.nmeIsPNG(bytes)) type = "image/png"; else if(flash.display.BitmapData.nmeIsJPG(bytes)) type = "image/jpeg"; else throw new flash.errors.IOError("BitmapData tried to read a PNG/JPG ByteArray, but found an invalid header.");
		var img = js.Browser.document.createElement("img");
		var canvas = this._nmeTextureBuffer;
		var drawImage = function(_) {
			canvas.width = img.width;
			canvas.height = img.height;
			var ctx = canvas.getContext("2d");
			ctx.drawImage(img,0,0);
			if(inRawAlpha != null) {
				var pixels = ctx.getImageData(0,0,img.width,img.height);
				var _g1 = 0, _g2 = inRawAlpha.length;
				while(_g1 < _g2) {
					var i = _g1++;
					pixels.data[i * 4 + 3] = inRawAlpha.readUnsignedByte();
				}
				ctx.putImageData(pixels,0,0);
			}
			_g.rect = new flash.geom.Rectangle(0,0,canvas.width,canvas.height);
			if(onload != null) onload(_g);
		};
		img.addEventListener("load",drawImage,false);
		img.src = "data:" + type + ";base64," + flash.display.BitmapData.nmeBase64Encode(bytes);
	}
	,nmeGetLease: function() {
		return this.nmeLease;
	}
	,nmeFillRect: function(rect,color) {
		this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
		var ctx = this._nmeTextureBuffer.getContext("2d");
		var r = (color & 16711680) >>> 16;
		var g = (color & 65280) >>> 8;
		var b = color & 255;
		var a = this.nmeTransparent?color >>> 24:255;
		if(!this.nmeLocked) {
			var style = "rgba(" + r + ", " + g + ", " + b + ", " + a / 255 + ")";
			ctx.fillStyle = style;
			ctx.fillRect(rect.x,rect.y,rect.width,rect.height);
		} else {
			var s = 4 * (Math.round(rect.x) + Math.round(rect.y) * this.nmeImageData.width);
			var offsetY;
			var offsetX;
			var _g1 = 0, _g = Math.round(rect.height);
			while(_g1 < _g) {
				var i = _g1++;
				offsetY = i * this.nmeImageData.width;
				var _g3 = 0, _g2 = Math.round(rect.width);
				while(_g3 < _g2) {
					var j = _g3++;
					offsetX = 4 * (j + offsetY);
					this.nmeImageData.data[s + offsetX] = r;
					this.nmeImageData.data[s + offsetX + 1] = g;
					this.nmeImageData.data[s + offsetX + 2] = b;
					this.nmeImageData.data[s + offsetX + 3] = a;
				}
			}
			this.nmeImageDataChanged = true;
		}
	}
	,nmeDecrNumRefBitmaps: function() {
		this.nmeAssignedBitmaps--;
	}
	,nmeClearCanvas: function() {
		var ctx = this._nmeTextureBuffer.getContext("2d");
		ctx.clearRect(0,0,this._nmeTextureBuffer.width,this._nmeTextureBuffer.height);
	}
	,nmeBuildLease: function() {
		this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
	}
	,lock: function() {
		this.nmeLocked = true;
		var ctx = this._nmeTextureBuffer.getContext("2d");
		this.nmeImageData = ctx.getImageData(0,0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
		this.nmeImageDataChanged = false;
		this.nmeCopyPixelList = [];
	}
	,hitTest: function(firstPoint,firstAlphaThreshold,secondObject,secondBitmapDataPoint,secondAlphaThreshold) {
		if(secondAlphaThreshold == null) secondAlphaThreshold = 1;
		var type = Type.getClassName(Type.getClass(secondObject));
		firstAlphaThreshold = firstAlphaThreshold & -1;
		var me = this;
		var doHitTest = function(imageData) {
			if(secondObject.__proto__ == null || secondObject.__proto__.__class__ == null || secondObject.__proto__.__class__.__name__ == null) return false;
			var _g = secondObject.__proto__.__class__.__name__[2];
			switch(_g) {
			case "Rectangle":
				var rect = secondObject;
				rect.x -= firstPoint.x;
				rect.y -= firstPoint.y;
				rect = me.clipRect(me.rect);
				if(me.rect == null) return false;
				var boundingBox = new flash.geom.Rectangle(0,0,me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0,me._nmeTextureBuffer != null?me._nmeTextureBuffer.height:0);
				if(!rect.intersects(boundingBox)) return false;
				var diff = rect.intersection(boundingBox);
				var offset = 4 * (Math.round(diff.x) + Math.round(diff.y) * imageData.width) + 3;
				var pos = offset;
				var boundR = Math.round(4 * (diff.x + diff.width));
				while(pos < offset + Math.round(4 * (diff.width + imageData.width * diff.height))) {
					if(pos % (imageData.width * 4) > boundR - 1) pos += imageData.width * 4 - boundR;
					if(imageData.data[pos] - firstAlphaThreshold >= 0) return true;
					pos += 4;
				}
				return false;
			case "Point":
				var point = secondObject;
				var x = point.x - firstPoint.x;
				var y = point.y - firstPoint.y;
				if(x < 0 || y < 0 || x >= (me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) || y >= (me._nmeTextureBuffer != null?me._nmeTextureBuffer.height:0)) return false;
				if(imageData.data[Math.round(4 * (y * (me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) + x)) + 3] - firstAlphaThreshold > 0) return true;
				return false;
			case "Bitmap":
				throw "bitmapData.hitTest with a second object of type Bitmap is currently not supported for HTML5";
				return false;
			case "BitmapData":
				throw "bitmapData.hitTest with a second object of type BitmapData is currently not supported for HTML5";
				return false;
			default:
				throw "BitmapData::hitTest secondObject argument must be either a Rectangle, a Point, a Bitmap or a BitmapData object.";
				return false;
			}
		};
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
			return doHitTest(imageData);
		} else return doHitTest(this.nmeImageData);
	}
	,handle: function() {
		return this._nmeTextureBuffer;
	}
	,getPixels: function(rect) {
		var len = Math.round(4 * rect.width * rect.height);
		var byteArray = new flash.utils.ByteArray();
		if(byteArray.allocated < len) byteArray._nmeResizeBuffer(byteArray.allocated = Math.max(len,byteArray.allocated * 2) | 0); else if(byteArray.allocated > len) byteArray._nmeResizeBuffer(byteArray.allocated = len);
		byteArray.length = len;
		len;
		rect = this.clipRect(rect);
		if(rect == null) return byteArray;
		if(!this.nmeLocked) {
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imagedata = ctx.getImageData(rect.x,rect.y,rect.width,rect.height);
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				byteArray.writeByte(imagedata.data[i]);
			}
		} else {
			var offset = Math.round(4 * this.nmeImageData.width * rect.y + rect.x * 4);
			var pos = offset;
			var boundR = Math.round(4 * (rect.x + rect.width));
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				if(pos % (this.nmeImageData.width * 4) > boundR - 1) pos += this.nmeImageData.width * 4 - boundR;
				byteArray.writeByte(this.nmeImageData.data[pos]);
				pos++;
			}
		}
		byteArray.position = 0;
		return byteArray;
	}
	,getPixel32: function(x,y) {
		if(x < 0 || y < 0 || x >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) || y >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) return 0;
		if(!this.nmeLocked) {
			var ctx = this._nmeTextureBuffer.getContext("2d");
			return this.getInt32(0,ctx.getImageData(x,y,1,1).data);
		} else return this.getInt32(4 * y * this._nmeTextureBuffer.width + x * 4,this.nmeImageData.data);
	}
	,getPixel: function(x,y) {
		if(x < 0 || y < 0 || x >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) || y >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) return 0;
		if(!this.nmeLocked) {
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imagedata = ctx.getImageData(x,y,1,1);
			return imagedata.data[0] << 16 | imagedata.data[1] << 8 | imagedata.data[2];
		} else {
			var offset = 4 * y * (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) + x * 4;
			return this.nmeImageData.data[offset] << 16 | this.nmeImageData.data[offset + 1] << 8 | this.nmeImageData.data[offset + 2];
		}
	}
	,getInt32: function(offset,data) {
		return (this.nmeTransparent?data[offset + 3]:255) << 24 | data[offset] << 16 | data[offset + 1] << 8 | data[offset + 2];
	}
	,getColorBoundsRect: function(mask,color,findColor) {
		if(findColor == null) findColor = true;
		var me = this;
		var doGetColorBoundsRect = function(data) {
			var minX = me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0, maxX = 0, minY = me._nmeTextureBuffer != null?me._nmeTextureBuffer.height:0, maxY = 0, i = 0;
			while(i < data.length) {
				var value = me.getInt32(i,data);
				if(findColor) {
					if((value & mask) == color) {
						var x = Math.round(i % ((me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) * 4) / 4);
						var y = Math.round(i / ((me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) * 4));
						if(x < minX) minX = x;
						if(x > maxX) maxX = x;
						if(y < minY) minY = y;
						if(y > maxY) maxY = y;
					}
				} else if((value & mask) != color) {
					var x = Math.round(i % ((me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) * 4) / 4);
					var y = Math.round(i / ((me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0) * 4));
					if(x < minX) minX = x;
					if(x > maxX) maxX = x;
					if(y < minY) minY = y;
					if(y > maxY) maxY = y;
				}
				i += 4;
			}
			if(minX < maxX && minY < maxY) return new flash.geom.Rectangle(minX,minY,maxX - minX + 1,maxY - minY); else return new flash.geom.Rectangle(0,0,me._nmeTextureBuffer != null?me._nmeTextureBuffer.width:0,me._nmeTextureBuffer != null?me._nmeTextureBuffer.height:0);
		};
		if(!this.nmeLocked) {
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
			return doGetColorBoundsRect(imageData.data);
		} else return doGetColorBoundsRect(this.nmeImageData.data);
	}
	,floodFill: function(x,y,color) {
		var wasLocked = this.nmeLocked;
		if(!this.nmeLocked) this.lock();
		var queue = new Array();
		queue.push(new flash.geom.Point(x,y));
		var old = this.getPixel32(x,y);
		var iterations = 0;
		var search = new Array();
		var _g1 = 0, _g = (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0) + 1;
		while(_g1 < _g) {
			var i = _g1++;
			var column = new Array();
			var _g3 = 0, _g2 = (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0) + 1;
			while(_g3 < _g2) {
				var i1 = _g3++;
				column.push(false);
			}
			search.push(column);
		}
		var currPoint, newPoint;
		while(queue.length > 0) {
			currPoint = queue.shift();
			++iterations;
			var x1 = currPoint.x | 0;
			var y1 = currPoint.y | 0;
			if(x1 < 0 || x1 >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0)) continue;
			if(y1 < 0 || y1 >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) continue;
			search[x1][y1] = true;
			if(this.getPixel32(x1,y1) == old) {
				this.setPixel32(x1,y1,color);
				if(!search[x1 + 1][y1]) queue.push(new flash.geom.Point(x1 + 1,y1));
				if(!search[x1][y1 + 1]) queue.push(new flash.geom.Point(x1,y1 + 1));
				if(x1 > 0 && !search[x1 - 1][y1]) queue.push(new flash.geom.Point(x1 - 1,y1));
				if(y1 > 0 && !search[x1][y1 - 1]) queue.push(new flash.geom.Point(x1,y1 - 1));
			}
		}
		if(!wasLocked) this.unlock();
	}
	,fillRect: function(rect,color) {
		if(rect == null) return;
		if(rect.width <= 0 || rect.height <= 0) return;
		if(rect.x == 0 && rect.y == 0 && rect.width == this._nmeTextureBuffer.width && rect.height == this._nmeTextureBuffer.height) {
			if(this.nmeTransparent) {
				if(color >>> 24 == 0 || color == this.nmeInitColor) return this.nmeClearCanvas();
			} else if((color | -16777216) == (this.nmeInitColor | -16777216)) return this.nmeClearCanvas();
		}
		return this.nmeFillRect(rect,color);
	}
	,drawToSurface: function(inSurface,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
		var ctx = inSurface.getContext("2d");
		if(matrix != null) {
			ctx.save();
			if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1) ctx.translate(matrix.tx,matrix.ty); else {
				flash.Lib.nmeSetImageSmoothing(ctx,smoothing);
				ctx.setTransform(matrix.a,matrix.b,matrix.c,matrix.d,matrix.tx,matrix.ty);
			}
			ctx.drawImage(this._nmeTextureBuffer,0,0);
			ctx.restore();
		} else ctx.drawImage(this._nmeTextureBuffer,0,0);
		if(inColorTransform != null) this.colorTransform(new flash.geom.Rectangle(0,0,this._nmeTextureBuffer.width,this._nmeTextureBuffer.height),inColorTransform);
	}
	,draw: function(source,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		if(smoothing == null) smoothing = false;
		this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
		source.drawToSurface(this._nmeTextureBuffer,matrix,inColorTransform,blendMode,clipRect,smoothing);
		if(inColorTransform != null) {
			var rect = new flash.geom.Rectangle();
			var object = source;
			rect.x = matrix != null?matrix.tx:0;
			rect.y = matrix != null?matrix.ty:0;
			try {
				rect.width = Reflect.getProperty(source,"width");
				rect.height = Reflect.getProperty(source,"height");
			} catch( e ) {
				rect.width = this._nmeTextureBuffer.width;
				rect.height = this._nmeTextureBuffer.height;
			}
			this.colorTransform(rect,inColorTransform);
		}
	}
	,dispose: function() {
		this.nmeClearCanvas();
		this._nmeTextureBuffer = null;
		this.nmeLeaseNum = 0;
		this.nmeLease = null;
		this.nmeImageData = null;
	}
	,destroy: function() {
		this._nmeTextureBuffer = null;
	}
	,copyPixels: function(sourceBitmapData,sourceRect,destPoint,alphaBitmapData,alphaPoint,mergeAlpha) {
		if(mergeAlpha == null) mergeAlpha = false;
		if(sourceBitmapData._nmeTextureBuffer == null || this._nmeTextureBuffer == null || sourceBitmapData._nmeTextureBuffer.width == 0 || sourceBitmapData._nmeTextureBuffer.height == 0 || sourceRect.width <= 0 || sourceRect.height <= 0) return;
		if(sourceRect.x + sourceRect.width > sourceBitmapData._nmeTextureBuffer.width) sourceRect.width = sourceBitmapData._nmeTextureBuffer.width - sourceRect.x;
		if(sourceRect.y + sourceRect.height > sourceBitmapData._nmeTextureBuffer.height) sourceRect.height = sourceBitmapData._nmeTextureBuffer.height - sourceRect.y;
		if(alphaBitmapData != null && alphaBitmapData.nmeTransparent) {
			if(alphaPoint == null) alphaPoint = new flash.geom.Point();
			var bitmapData = new flash.display.BitmapData(sourceBitmapData._nmeTextureBuffer != null?sourceBitmapData._nmeTextureBuffer.width:0,sourceBitmapData._nmeTextureBuffer != null?sourceBitmapData._nmeTextureBuffer.height:0,true);
			bitmapData.copyPixels(sourceBitmapData,sourceRect,new flash.geom.Point(sourceRect.x,sourceRect.y));
			bitmapData.copyChannel(alphaBitmapData,new flash.geom.Rectangle(alphaPoint.x,alphaPoint.y,sourceRect.width,sourceRect.height),new flash.geom.Point(sourceRect.x,sourceRect.y),8,8);
			sourceBitmapData = bitmapData;
		}
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			if(!mergeAlpha) {
				if(this.nmeTransparent && sourceBitmapData.nmeTransparent) {
					var trpCtx = sourceBitmapData.nmeTransparentFiller.getContext("2d");
					var trpData = trpCtx.getImageData(sourceRect.x,sourceRect.y,sourceRect.width,sourceRect.height);
					ctx.putImageData(trpData,destPoint.x,destPoint.y);
				}
			}
			ctx.drawImage(sourceBitmapData._nmeTextureBuffer,sourceRect.x,sourceRect.y,sourceRect.width,sourceRect.height,destPoint.x,destPoint.y,sourceRect.width,sourceRect.height);
		} else this.nmeCopyPixelList[this.nmeCopyPixelList.length] = { handle : sourceBitmapData._nmeTextureBuffer, transparentFiller : mergeAlpha?null:sourceBitmapData.nmeTransparentFiller, sourceX : sourceRect.x, sourceY : sourceRect.y, sourceWidth : sourceRect.width, sourceHeight : sourceRect.height, destX : destPoint.x, destY : destPoint.y};
	}
	,copyChannel: function(sourceBitmapData,sourceRect,destPoint,sourceChannel,destChannel) {
		this.rect = this.clipRect(this.rect);
		if(this.rect == null) return;
		if(destChannel == 8 && !this.nmeTransparent) return;
		if(sourceBitmapData._nmeTextureBuffer == null || this._nmeTextureBuffer == null || sourceRect.width <= 0 || sourceRect.height <= 0) return;
		if(sourceRect.x + sourceRect.width > sourceBitmapData._nmeTextureBuffer.width) sourceRect.width = sourceBitmapData._nmeTextureBuffer.width - sourceRect.x;
		if(sourceRect.y + sourceRect.height > sourceBitmapData._nmeTextureBuffer.height) sourceRect.height = sourceBitmapData._nmeTextureBuffer.height - sourceRect.y;
		var doChannelCopy = function(imageData) {
			var srcCtx = sourceBitmapData._nmeTextureBuffer.getContext("2d");
			var srcImageData = srcCtx.getImageData(sourceRect.x,sourceRect.y,sourceRect.width,sourceRect.height);
			var destIdx = -1;
			if(destChannel == 8) destIdx = 3; else if(destChannel == 4) destIdx = 2; else if(destChannel == 2) destIdx = 1; else if(destChannel == 1) destIdx = 0; else throw "Invalid destination BitmapDataChannel passed to BitmapData::copyChannel.";
			var pos = 4 * (Math.round(destPoint.x) + Math.round(destPoint.y) * imageData.width) + destIdx;
			var boundR = Math.round(4 * (destPoint.x + sourceRect.width));
			var setPos = function(val) {
				if(pos % (imageData.width * 4) > boundR - 1) pos += imageData.width * 4 - boundR;
				imageData.data[pos] = val;
				pos += 4;
			};
			var srcIdx = -1;
			if(sourceChannel == 8) srcIdx = 3; else if(sourceChannel == 4) srcIdx = 2; else if(sourceChannel == 2) srcIdx = 1; else if(sourceChannel == 1) srcIdx = 0; else throw "Invalid source BitmapDataChannel passed to BitmapData::copyChannel.";
			while(srcIdx < srcImageData.data.length) {
				setPos(srcImageData.data[srcIdx]);
				srcIdx += 4;
			}
		};
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
			doChannelCopy(imageData);
			ctx.putImageData(imageData,0,0);
		} else {
			doChannelCopy(this.nmeImageData);
			this.nmeImageDataChanged = true;
		}
	}
	,compare: function(inBitmapTexture) {
		throw "bitmapData.compare is currently not supported for HTML5";
		return 0;
	}
	,colorTransform: function(rect,colorTransform) {
		if(rect == null) return;
		rect = this.clipRect(rect);
		if(!this.nmeLocked) {
			this.nmeLease.set(this.nmeLeaseNum++,new Date().getTime());
			var ctx = this._nmeTextureBuffer.getContext("2d");
			var imagedata = ctx.getImageData(rect.x,rect.y,rect.width,rect.height);
			var offsetX;
			var _g1 = 0, _g = imagedata.data.length >> 2;
			while(_g1 < _g) {
				var i = _g1++;
				offsetX = i * 4;
				imagedata.data[offsetX] = imagedata.data[offsetX] * colorTransform.redMultiplier + colorTransform.redOffset | 0;
				imagedata.data[offsetX + 1] = imagedata.data[offsetX + 1] * colorTransform.greenMultiplier + colorTransform.greenOffset | 0;
				imagedata.data[offsetX + 2] = imagedata.data[offsetX + 2] * colorTransform.blueMultiplier + colorTransform.blueOffset | 0;
				imagedata.data[offsetX + 3] = imagedata.data[offsetX + 3] * colorTransform.alphaMultiplier + colorTransform.alphaOffset | 0;
			}
			ctx.putImageData(imagedata,rect.x,rect.y);
		} else {
			var s = 4 * (Math.round(rect.x) + Math.round(rect.y) * this.nmeImageData.width);
			var offsetY;
			var offsetX;
			var _g1 = 0, _g = Math.round(rect.height);
			while(_g1 < _g) {
				var i = _g1++;
				offsetY = i * this.nmeImageData.width;
				var _g3 = 0, _g2 = Math.round(rect.width);
				while(_g3 < _g2) {
					var j = _g3++;
					offsetX = 4 * (j + offsetY);
					this.nmeImageData.data[s + offsetX] = this.nmeImageData.data[s + offsetX] * colorTransform.redMultiplier + colorTransform.redOffset | 0;
					this.nmeImageData.data[s + offsetX + 1] = this.nmeImageData.data[s + offsetX + 1] * colorTransform.greenMultiplier + colorTransform.greenOffset | 0;
					this.nmeImageData.data[s + offsetX + 2] = this.nmeImageData.data[s + offsetX + 2] * colorTransform.blueMultiplier + colorTransform.blueOffset | 0;
					this.nmeImageData.data[s + offsetX + 3] = this.nmeImageData.data[s + offsetX + 3] * colorTransform.alphaMultiplier + colorTransform.alphaOffset | 0;
				}
			}
			this.nmeImageDataChanged = true;
		}
	}
	,clone: function() {
		var bitmapData = new flash.display.BitmapData(this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0,this.nmeTransparent);
		var rect = new flash.geom.Rectangle(0,0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0,this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
		bitmapData.setPixels(rect,this.getPixels(rect));
		bitmapData.nmeLease.set(bitmapData.nmeLeaseNum++,new Date().getTime());
		return bitmapData;
	}
	,clipRect: function(r) {
		if(r.x < 0) {
			r.width -= -r.x;
			r.x = 0;
			if(r.x + r.width <= 0) return null;
		}
		if(r.y < 0) {
			r.height -= -r.y;
			r.y = 0;
			if(r.y + r.height <= 0) return null;
		}
		if(r.x + r.width >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0)) {
			r.width -= r.x + r.width - (this._nmeTextureBuffer != null?this._nmeTextureBuffer.width:0);
			if(r.width <= 0) return null;
		}
		if(r.y + r.height >= (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0)) {
			r.height -= r.y + r.height - (this._nmeTextureBuffer != null?this._nmeTextureBuffer.height:0);
			if(r.height <= 0) return null;
		}
		return r;
	}
	,clear: function(color) {
		this.fillRect(this.rect,color);
	}
	,applyFilter: function(sourceBitmapData,sourceRect,destPoint,filter) {
		if(sourceBitmapData == this && sourceRect.x == destPoint.x && sourceRect.y == destPoint.y) filter.nmeApplyFilter(this._nmeTextureBuffer,sourceRect); else {
			var bitmapData = new flash.display.BitmapData(sourceRect.width | 0,sourceRect.height | 0);
			bitmapData.copyPixels(sourceBitmapData,sourceRect,new flash.geom.Point());
			filter.nmeApplyFilter(bitmapData._nmeTextureBuffer);
			this.copyPixels(bitmapData,bitmapData.rect,destPoint);
		}
	}
	,_nmeTextureBuffer: null
	,_nmeId: null
	,nmeTransparentFiller: null
	,nmeTransparent: null
	,nmeLocked: null
	,nmeLeaseNum: null
	,nmeLease: null
	,nmeInitColor: null
	,nmeImageDataChanged: null
	,nmeCopyPixelList: null
	,nmeAssignedBitmaps: null
	,width: null
	,transparent: null
	,rect: null
	,nmeReferenceCount: null
	,nmeGLTexture: null
	,nmeImageData: null
	,height: null
	,__class__: flash.display.BitmapData
	,__properties__: {get_height:"get_height",get_transparent:"get_transparent",get_width:"get_width"}
}
flash.display.ImageDataLease = function() {
};
$hxClasses["flash.display.ImageDataLease"] = flash.display.ImageDataLease;
flash.display.ImageDataLease.__name__ = ["flash","display","ImageDataLease"];
flash.display.ImageDataLease.prototype = {
	set: function(s,t) {
		this.seed = s;
		this.time = t;
	}
	,clone: function() {
		var leaseClone = new flash.display.ImageDataLease();
		leaseClone.seed = this.seed;
		leaseClone.time = this.time;
		return leaseClone;
	}
	,time: null
	,seed: null
	,__class__: flash.display.ImageDataLease
}
flash.display._BitmapData = {}
flash.display._BitmapData.MinstdGenerator = function(seed) {
	if(seed == 0) this.value = 1; else this.value = seed;
};
$hxClasses["flash.display._BitmapData.MinstdGenerator"] = flash.display._BitmapData.MinstdGenerator;
flash.display._BitmapData.MinstdGenerator.__name__ = ["flash","display","_BitmapData","MinstdGenerator"];
flash.display._BitmapData.MinstdGenerator.prototype = {
	nextValue: function() {
		var lo = 16807 * (this.value & 65535);
		var hi = 16807 * (this.value >>> 16);
		lo += (hi & 32767) << 16;
		if(lo < 0 || lo > -2147483648 - 1) {
			lo &= -2147483648 - 1;
			++lo;
		}
		lo += hi >>> 15;
		if(lo < 0 || lo > -2147483648 - 1) {
			lo &= -2147483648 - 1;
			++lo;
		}
		return this.value = lo;
	}
	,value: null
	,__class__: flash.display._BitmapData.MinstdGenerator
}
flash.display.BitmapDataChannel = function() { }
$hxClasses["flash.display.BitmapDataChannel"] = flash.display.BitmapDataChannel;
flash.display.BitmapDataChannel.__name__ = ["flash","display","BitmapDataChannel"];
flash.display.BlendMode = $hxClasses["flash.display.BlendMode"] = { __ename__ : true, __constructs__ : ["ADD","ALPHA","DARKEN","DIFFERENCE","ERASE","HARDLIGHT","INVERT","LAYER","LIGHTEN","MULTIPLY","NORMAL","OVERLAY","SCREEN","SUBTRACT"] }
flash.display.BlendMode.ADD = ["ADD",0];
flash.display.BlendMode.ADD.toString = $estr;
flash.display.BlendMode.ADD.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.ALPHA = ["ALPHA",1];
flash.display.BlendMode.ALPHA.toString = $estr;
flash.display.BlendMode.ALPHA.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.DARKEN = ["DARKEN",2];
flash.display.BlendMode.DARKEN.toString = $estr;
flash.display.BlendMode.DARKEN.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.DIFFERENCE = ["DIFFERENCE",3];
flash.display.BlendMode.DIFFERENCE.toString = $estr;
flash.display.BlendMode.DIFFERENCE.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.ERASE = ["ERASE",4];
flash.display.BlendMode.ERASE.toString = $estr;
flash.display.BlendMode.ERASE.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.HARDLIGHT = ["HARDLIGHT",5];
flash.display.BlendMode.HARDLIGHT.toString = $estr;
flash.display.BlendMode.HARDLIGHT.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.INVERT = ["INVERT",6];
flash.display.BlendMode.INVERT.toString = $estr;
flash.display.BlendMode.INVERT.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.LAYER = ["LAYER",7];
flash.display.BlendMode.LAYER.toString = $estr;
flash.display.BlendMode.LAYER.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.LIGHTEN = ["LIGHTEN",8];
flash.display.BlendMode.LIGHTEN.toString = $estr;
flash.display.BlendMode.LIGHTEN.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.MULTIPLY = ["MULTIPLY",9];
flash.display.BlendMode.MULTIPLY.toString = $estr;
flash.display.BlendMode.MULTIPLY.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.NORMAL = ["NORMAL",10];
flash.display.BlendMode.NORMAL.toString = $estr;
flash.display.BlendMode.NORMAL.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.OVERLAY = ["OVERLAY",11];
flash.display.BlendMode.OVERLAY.toString = $estr;
flash.display.BlendMode.OVERLAY.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.SCREEN = ["SCREEN",12];
flash.display.BlendMode.SCREEN.toString = $estr;
flash.display.BlendMode.SCREEN.__enum__ = flash.display.BlendMode;
flash.display.BlendMode.SUBTRACT = ["SUBTRACT",13];
flash.display.BlendMode.SUBTRACT.toString = $estr;
flash.display.BlendMode.SUBTRACT.__enum__ = flash.display.BlendMode;
flash.display.CapsStyle = $hxClasses["flash.display.CapsStyle"] = { __ename__ : true, __constructs__ : ["NONE","ROUND","SQUARE"] }
flash.display.CapsStyle.NONE = ["NONE",0];
flash.display.CapsStyle.NONE.toString = $estr;
flash.display.CapsStyle.NONE.__enum__ = flash.display.CapsStyle;
flash.display.CapsStyle.ROUND = ["ROUND",1];
flash.display.CapsStyle.ROUND.toString = $estr;
flash.display.CapsStyle.ROUND.__enum__ = flash.display.CapsStyle;
flash.display.CapsStyle.SQUARE = ["SQUARE",2];
flash.display.CapsStyle.SQUARE.toString = $estr;
flash.display.CapsStyle.SQUARE.__enum__ = flash.display.CapsStyle;
flash.display.GradientType = $hxClasses["flash.display.GradientType"] = { __ename__ : true, __constructs__ : ["RADIAL","LINEAR"] }
flash.display.GradientType.RADIAL = ["RADIAL",0];
flash.display.GradientType.RADIAL.toString = $estr;
flash.display.GradientType.RADIAL.__enum__ = flash.display.GradientType;
flash.display.GradientType.LINEAR = ["LINEAR",1];
flash.display.GradientType.LINEAR.toString = $estr;
flash.display.GradientType.LINEAR.__enum__ = flash.display.GradientType;
flash.display.Graphics = function(inSurface) {
	flash.Lib.nmeBootstrap();
	if(inSurface == null) {
		this.nmeSurface = js.Browser.document.createElement("canvas");
		this.nmeSurface.width = 0;
		this.nmeSurface.height = 0;
	} else this.nmeSurface = inSurface;
	this.mLastMoveID = 0;
	this.mPenX = 0.0;
	this.mPenY = 0.0;
	this.mDrawList = new Array();
	this.mPoints = [];
	this.mSolidGradient = null;
	this.mBitmap = null;
	this.mFilling = false;
	this.mFillColour = 0;
	this.mFillAlpha = 0.0;
	this.mLastMoveID = 0;
	this.boundsDirty = true;
	this.nmeClearLine();
	this.mLineJobs = [];
	this.nmeChanged = true;
	this.nextDrawIndex = 0;
	this.nmeExtent = new flash.geom.Rectangle();
	this.nmeExtentWithFilters = new flash.geom.Rectangle();
	this._padding = 0.0;
	this.nmeClearNextCycle = true;
};
$hxClasses["flash.display.Graphics"] = flash.display.Graphics;
flash.display.Graphics.__name__ = ["flash","display","Graphics"];
flash.display.Graphics.nmeDetectIsPointInPathMode = function() {
	var canvas = js.Browser.document.createElement("canvas");
	var ctx = canvas.getContext("2d");
	if(ctx.isPointInPath == null) return flash.display.PointInPathMode.USER_SPACE;
	ctx.save();
	ctx.translate(1,0);
	ctx.beginPath();
	ctx.rect(0,0,1,1);
	var rv = ctx.isPointInPath(0.3,0.3)?flash.display.PointInPathMode.USER_SPACE:flash.display.PointInPathMode.DEVICE_SPACE;
	ctx.restore();
	return rv;
}
flash.display.Graphics.prototype = {
	nmeRender: function(maskHandle,filters,sx,sy,clip0,clip1,clip2,clip3) {
		if(sy == null) sy = 1.0;
		if(sx == null) sx = 1.0;
		if(!this.nmeChanged) return false;
		this.closePolygon(true);
		var padding = this._padding;
		if(filters != null) {
			var _g = 0;
			while(_g < filters.length) {
				var filter = filters[_g];
				++_g;
				if(Reflect.hasField(filter,"blurX")) padding += Math.max(Reflect.field(filter,"blurX"),Reflect.field(filter,"blurY")) * 4;
			}
		}
		this.nmeExpandFilteredExtent(-(padding * sx) / 2,-(padding * sy) / 2);
		if(this.nmeClearNextCycle) {
			this.nextDrawIndex = 0;
			this.nmeClearCanvas();
			this.nmeClearNextCycle = false;
		}
		if(this.nmeExtentWithFilters.width - this.nmeExtentWithFilters.x > this.nmeSurface.width || this.nmeExtentWithFilters.height - this.nmeExtentWithFilters.y > this.nmeSurface.height) this.nmeAdjustSurface(sx,sy);
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.nmeSurface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx == null) return false;
		if(clip0 != null) {
			ctx.beginPath();
			ctx.moveTo(clip0.x * sx,clip0.y * sy);
			ctx.lineTo(clip1.x * sx,clip1.y * sy);
			ctx.lineTo(clip2.x * sx,clip2.y * sy);
			ctx.lineTo(clip3.x * sx,clip3.y * sy);
			ctx.closePath();
			ctx.clip();
		}
		if(filters != null) {
			var _g = 0;
			while(_g < filters.length) {
				var filter = filters[_g];
				++_g;
				if(js.Boot.__instanceof(filter,flash.filters.DropShadowFilter)) filter.nmeApplyFilter(this.nmeSurface,null,true);
			}
		}
		var len = this.mDrawList.length;
		ctx.save();
		if(this.nmeExtentWithFilters.x != 0 || this.nmeExtentWithFilters.y != 0) ctx.translate(-this.nmeExtentWithFilters.x * sx,-this.nmeExtentWithFilters.y * sy);
		if(sx != 1 || sy != 0) ctx.scale(sx,sy);
		var doStroke = false;
		var _g = this.nextDrawIndex;
		while(_g < len) {
			var i = _g++;
			var d = this.mDrawList[len - 1 - i];
			if(d.tileJob != null) this.nmeDrawTiles(d.tileJob.sheet,d.tileJob.drawList,d.tileJob.flags); else {
				if(d.lineJobs.length > 0) {
					var _g1 = 0, _g2 = d.lineJobs;
					while(_g1 < _g2.length) {
						var lj = _g2[_g1];
						++_g1;
						ctx.lineWidth = lj.thickness;
						switch(lj.joints) {
						case 0:
							ctx.lineJoin = "round";
							break;
						case 4096:
							ctx.lineJoin = "miter";
							break;
						case 8192:
							ctx.lineJoin = "bevel";
							break;
						}
						switch(lj.caps) {
						case 256:
							ctx.lineCap = "round";
							break;
						case 512:
							ctx.lineCap = "square";
							break;
						case 0:
							ctx.lineCap = "butt";
							break;
						}
						ctx.miterLimit = lj.miter_limit;
						if(lj.grad != null) ctx.strokeStyle = this.createCanvasGradient(ctx,lj.grad); else ctx.strokeStyle = this.createCanvasColor(lj.colour,lj.alpha);
						ctx.beginPath();
						var _g4 = lj.point_idx0, _g3 = lj.point_idx1 + 1;
						while(_g4 < _g3) {
							var i1 = _g4++;
							var p = d.points[i1];
							switch(p.type) {
							case 0:
								ctx.moveTo(p.x,p.y);
								break;
							case 2:
								ctx.quadraticCurveTo(p.cx,p.cy,p.x,p.y);
								break;
							default:
								ctx.lineTo(p.x,p.y);
							}
						}
						ctx.closePath();
						doStroke = true;
					}
				} else {
					ctx.beginPath();
					var _g1 = 0, _g2 = d.points;
					while(_g1 < _g2.length) {
						var p = _g2[_g1];
						++_g1;
						switch(p.type) {
						case 0:
							ctx.moveTo(p.x,p.y);
							break;
						case 2:
							ctx.quadraticCurveTo(p.cx,p.cy,p.x,p.y);
							break;
						default:
							ctx.lineTo(p.x,p.y);
						}
					}
					ctx.closePath();
				}
				var fillColour = d.fillColour;
				var fillAlpha = d.fillAlpha;
				var g = d.solidGradient;
				var bitmap = d.bitmap;
				if(g != null) ctx.fillStyle = this.createCanvasGradient(ctx,g); else if(bitmap != null && (bitmap.flags & 16) > 0) {
					var m = bitmap.matrix;
					if(m != null) ctx.transform(m.a,m.b,m.c,m.d,m.tx,m.ty);
					if((bitmap.flags & 65536) == 0) {
						ctx.mozImageSmoothingEnabled = false;
						ctx.webkitImageSmoothingEnabled = false;
					}
					ctx.fillStyle = ctx.createPattern(bitmap.texture_buffer,"repeat");
				} else ctx.fillStyle = this.createCanvasColor(fillColour,Math.min(1.0,Math.max(0.0,fillAlpha)));
				ctx.fill();
				if(doStroke) ctx.stroke();
				ctx.save();
				if(bitmap != null && (bitmap.flags & 16) == 0) {
					ctx.clip();
					var img = bitmap.texture_buffer;
					var m = bitmap.matrix;
					if(m != null) ctx.transform(m.a,m.b,m.c,m.d,m.tx,m.ty);
					ctx.drawImage(img,0,0);
				}
				ctx.restore();
			}
		}
		ctx.restore();
		this.nmeChanged = false;
		this.nextDrawIndex = len;
		this.mDrawList = [];
		return true;
	}
	,nmeMediaSurface: function(surface) {
		this.nmeSurface = surface;
	}
	,nmeInvalidate: function() {
		this.nmeChanged = true;
		this.nmeClearNextCycle = true;
	}
	,nmeHitTest: function(inX,inY) {
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.nmeSurface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx == null) return false;
		if(ctx.isPointInPath(inX,inY)) return true; else if(this.mDrawList.length == 0 && this.nmeExtent.width > 0 && this.nmeExtent.height > 0) return true;
		return false;
	}
	,nmeExpandStandardExtent: function(x,y,thickness) {
		if(thickness == null) thickness = 0;
		if(this._padding > 0) {
			this.nmeExtent.width -= this._padding;
			this.nmeExtent.height -= this._padding;
		}
		if(thickness != null && thickness > this._padding) this._padding = thickness;
		var maxX, minX, maxY, minY;
		minX = this.nmeExtent.x;
		minY = this.nmeExtent.y;
		maxX = this.nmeExtent.width + minX;
		maxY = this.nmeExtent.height + minY;
		maxX = x > maxX?x:maxX;
		minX = x < minX?x:minX;
		maxY = y > maxY?y:maxY;
		minY = y < minY?y:minY;
		this.nmeExtent.x = minX;
		this.nmeExtent.y = minY;
		this.nmeExtent.width = maxX - minX + this._padding;
		this.nmeExtent.height = maxY - minY + this._padding;
		this.boundsDirty = true;
	}
	,nmeExpandFilteredExtent: function(x,y) {
		var maxX, minX, maxY, minY;
		minX = this.nmeExtent.x;
		minY = this.nmeExtent.y;
		maxX = this.nmeExtent.width + minX;
		maxY = this.nmeExtent.height + minY;
		maxX = x > maxX?x:maxX;
		minX = x < minX?x:minX;
		maxY = y > maxY?y:maxY;
		minY = y < minY?y:minY;
		this.nmeExtentWithFilters.x = minX;
		this.nmeExtentWithFilters.y = minY;
		this.nmeExtentWithFilters.width = maxX - minX;
		this.nmeExtentWithFilters.height = maxY - minY;
	}
	,nmeDrawTiles: function(sheet,tileData,flags) {
		if(flags == null) flags = 0;
		var useScale = (flags & 1) > 0;
		var useRotation = (flags & 2) > 0;
		var useTransform = (flags & 16) > 0;
		var useRGB = (flags & 4) > 0;
		var useAlpha = (flags & 8) > 0;
		if(useTransform) {
			useScale = false;
			useRotation = false;
		}
		var scaleIndex = 0;
		var rotationIndex = 0;
		var rgbIndex = 0;
		var alphaIndex = 0;
		var transformIndex = 0;
		var numValues = 3;
		if(useScale) {
			scaleIndex = numValues;
			numValues++;
		}
		if(useRotation) {
			rotationIndex = numValues;
			numValues++;
		}
		if(useTransform) {
			transformIndex = numValues;
			numValues += 4;
		}
		if(useRGB) {
			rgbIndex = numValues;
			numValues += 3;
		}
		if(useAlpha) {
			alphaIndex = numValues;
			numValues++;
		}
		var totalCount = tileData.length;
		var itemCount = totalCount / numValues | 0;
		var index = 0;
		var rect = null;
		var center = null;
		var previousTileID = -1;
		var surface = sheet.nmeBitmap._nmeTextureBuffer;
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.nmeSurface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx != null) while(index < totalCount) {
			var tileID = tileData[index + 2] | 0;
			if(tileID != previousTileID) {
				rect = sheet.nmeTileRects[tileID];
				center = sheet.nmeCenterPoints[tileID];
				previousTileID = tileID;
			}
			if(rect != null && center != null) {
				ctx.save();
				ctx.translate(tileData[index],tileData[index + 1]);
				if(useRotation) ctx.rotate(tileData[index + rotationIndex]);
				var scale = 1.0;
				if(useScale) scale = tileData[index + scaleIndex];
				if(useTransform) ctx.transform(tileData[index + transformIndex],tileData[index + transformIndex + 1],tileData[index + transformIndex + 2],tileData[index + transformIndex + 3],0,0);
				if(useAlpha) ctx.globalAlpha = tileData[index + alphaIndex];
				ctx.drawImage(surface,rect.x,rect.y,rect.width,rect.height,-center.x * scale,-center.y * scale,rect.width * scale,rect.height * scale);
				ctx.restore();
			}
			index += numValues;
		}
	}
	,nmeDrawEllipse: function(x,y,rx,ry) {
		this.moveTo(x + rx,y);
		this.curveTo(rx + x,-0.4142 * ry + y,0.7071 * rx + x,-0.7071 * ry + y);
		this.curveTo(0.4142 * rx + x,-ry + y,x,-ry + y);
		this.curveTo(-0.4142 * rx + x,-ry + y,-0.7071 * rx + x,-0.7071 * ry + y);
		this.curveTo(-rx + x,-0.4142 * ry + y,-rx + x,y);
		this.curveTo(-rx + x,0.4142 * ry + y,-0.7071 * rx + x,0.7071 * ry + y);
		this.curveTo(-0.4142 * rx + x,ry + y,x,ry + y);
		this.curveTo(0.4142 * rx + x,ry + y,0.7071 * rx + x,0.7071 * ry + y);
		this.curveTo(rx + x,0.4142 * ry + y,rx + x,y);
	}
	,nmeClearLine: function() {
		this.mCurrentLine = new flash.display.LineJob(null,-1,-1,0.0,0.0,0,1,0,256,3,3.0);
	}
	,nmeClearCanvas: function() {
		if(this.nmeSurface != null) {
			var ctx = (function($this) {
				var $r;
				try {
					$r = $this.nmeSurface.getContext("2d");
				} catch( e ) {
					$r = null;
				}
				return $r;
			}(this));
			if(ctx != null) ctx.clearRect(0,0,this.nmeSurface.width,this.nmeSurface.height);
		}
	}
	,nmeAdjustSurface: function(sx,sy) {
		if(sy == null) sy = 1.0;
		if(sx == null) sx = 1.0;
		if(Reflect.field(this.nmeSurface,"getContext") != null) {
			var width = Math.ceil((this.nmeExtentWithFilters.width - this.nmeExtentWithFilters.x) * sx);
			var height = Math.ceil((this.nmeExtentWithFilters.height - this.nmeExtentWithFilters.y) * sy);
			if(width <= 5000 && height <= 5000) {
				var dstCanvas = js.Browser.document.createElement("canvas");
				dstCanvas.width = width;
				dstCanvas.height = height;
				flash.Lib.nmeDrawToSurface(this.nmeSurface,dstCanvas);
				if(flash.Lib.nmeIsOnStage(this.nmeSurface)) {
					flash.Lib.nmeAppendSurface(dstCanvas);
					flash.Lib.nmeCopyStyle(this.nmeSurface,dstCanvas);
					flash.Lib.nmeSwapSurface(this.nmeSurface,dstCanvas);
					flash.Lib.nmeRemoveSurface(this.nmeSurface);
					if(this.nmeSurface.id != null) flash.Lib.nmeSetSurfaceId(dstCanvas,this.nmeSurface.id);
				}
				this.nmeSurface = dstCanvas;
			}
		}
	}
	,moveTo: function(inX,inY) {
		this.mPenX = inX;
		this.mPenY = inY;
		this.nmeExpandStandardExtent(inX,inY);
		if(!this.mFilling) this.closePolygon(false); else {
			this.addLineSegment();
			this.mLastMoveID = this.mPoints.length;
			this.mPoints.push(new flash.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,0));
		}
	}
	,lineTo: function(inX,inY) {
		var pid = this.mPoints.length;
		if(pid == 0) {
			this.mPoints.push(new flash.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,0));
			pid++;
		}
		this.mPenX = inX;
		this.mPenY = inY;
		this.nmeExpandStandardExtent(inX,inY,this.mCurrentLine.thickness);
		this.mPoints.push(new flash.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,1));
		if(this.mCurrentLine.grad != null || this.mCurrentLine.alpha > 0) {
			if(this.mCurrentLine.point_idx0 < 0) this.mCurrentLine.point_idx0 = pid - 1;
			this.mCurrentLine.point_idx1 = pid;
		}
		if(!this.mFilling) this.closePolygon(false);
	}
	,lineStyle: function(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit) {
		this.addLineSegment();
		if(thickness == null) {
			this.nmeClearLine();
			return;
		} else {
			this.mCurrentLine.grad = null;
			this.mCurrentLine.thickness = thickness;
			this.mCurrentLine.colour = color == null?0:color;
			this.mCurrentLine.alpha = alpha == null?1.0:alpha;
			this.mCurrentLine.miter_limit = miterLimit == null?3.0:miterLimit;
			this.mCurrentLine.pixel_hinting = pixelHinting == null || !pixelHinting?0:16384;
		}
		if(caps != null) {
			switch( (caps)[1] ) {
			case 1:
				this.mCurrentLine.caps = 256;
				break;
			case 2:
				this.mCurrentLine.caps = 512;
				break;
			case 0:
				this.mCurrentLine.caps = 0;
				break;
			}
		}
		this.mCurrentLine.scale_mode = 3;
		if(scaleMode != null) {
			switch( (scaleMode)[1] ) {
			case 2:
				this.mCurrentLine.scale_mode = 3;
				break;
			case 3:
				this.mCurrentLine.scale_mode = 1;
				break;
			case 0:
				this.mCurrentLine.scale_mode = 2;
				break;
			case 1:
				this.mCurrentLine.scale_mode = 0;
				break;
			}
		}
		this.mCurrentLine.joints = 0;
		if(joints != null) {
			switch( (joints)[1] ) {
			case 1:
				this.mCurrentLine.joints = 0;
				break;
			case 0:
				this.mCurrentLine.joints = 4096;
				break;
			case 2:
				this.mCurrentLine.joints = 8192;
				break;
			}
		}
	}
	,lineGradientStyle: function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
		this.mCurrentLine.grad = this.createGradient(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
	}
	,getContext: function() {
		try {
			return this.nmeSurface.getContext("2d");
		} catch( e ) {
			return null;
		}
	}
	,flush: function() {
		this.closePolygon(true);
	}
	,endFill: function() {
		this.closePolygon(true);
	}
	,drawTiles: function(sheet,tileData,smooth,flags) {
		if(flags == null) flags = 0;
		if(smooth == null) smooth = false;
		this.nmeExpandStandardExtent(flash.Lib.get_current().get_stage().get_stageWidth(),flash.Lib.get_current().get_stage().get_stageHeight());
		this.addDrawable(new flash.display.Drawable(null,null,null,null,null,null,new flash.display.TileJob(sheet,tileData,flags)));
		this.nmeChanged = true;
	}
	,drawRoundRect: function(x,y,width,height,rx,ry) {
		if(ry == null) ry = -1;
		if(ry == -1) ry = rx;
		rx *= 0.5;
		ry *= 0.5;
		var w = width * 0.5;
		x += w;
		if(rx > w) rx = w;
		var lw = w - rx;
		var w_ = lw + rx * Math.sin(Math.PI / 4);
		var cw_ = lw + rx * Math.tan(Math.PI / 8);
		var h = height * 0.5;
		y += h;
		if(ry > h) ry = h;
		var lh = h - ry;
		var h_ = lh + ry * Math.sin(Math.PI / 4);
		var ch_ = lh + ry * Math.tan(Math.PI / 8);
		this.closePolygon(false);
		this.moveTo(x + w,y + lh);
		this.curveTo(x + w,y + ch_,x + w_,y + h_);
		this.curveTo(x + cw_,y + h,x + lw,y + h);
		this.lineTo(x - lw,y + h);
		this.curveTo(x - cw_,y + h,x - w_,y + h_);
		this.curveTo(x - w,y + ch_,x - w,y + lh);
		this.lineTo(x - w,y - lh);
		this.curveTo(x - w,y - ch_,x - w_,y - h_);
		this.curveTo(x - cw_,y - h,x - lw,y - h);
		this.lineTo(x + lw,y - h);
		this.curveTo(x + cw_,y - h,x + w_,y - h_);
		this.curveTo(x + w,y - ch_,x + w,y - lh);
		this.lineTo(x + w,y + lh);
		this.closePolygon(false);
	}
	,drawRect: function(x,y,width,height) {
		this.closePolygon(false);
		this.moveTo(x,y);
		this.lineTo(x + width,y);
		this.lineTo(x + width,y + height);
		this.lineTo(x,y + height);
		this.lineTo(x,y);
		this.closePolygon(false);
	}
	,drawGraphicsData: function(points) {
		var $it0 = ((function(_e) {
			return function() {
				return $iterator(flash._Vector.Vector_Impl_)(_e);
			};
		})(points))();
		while( $it0.hasNext() ) {
			var data = $it0.next();
			if(data == null) this.mFilling = true; else switch(data.nmeGraphicsDataType) {
			case flash.display.GraphicsDataType.STROKE:
				var stroke = data;
				if(stroke.fill == null) this.lineStyle(stroke.thickness,0,1.,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit); else switch(stroke.fill.nmeGraphicsFillType) {
				case flash.display.GraphicsFillType.SOLID_FILL:
					var fill = stroke.fill;
					this.lineStyle(stroke.thickness,fill.color,fill.alpha,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit);
					break;
				case flash.display.GraphicsFillType.GRADIENT_FILL:
					var fill = stroke.fill;
					this.lineGradientStyle(fill.type,fill.colors,fill.alphas,fill.ratios,fill.matrix,fill.spreadMethod,fill.interpolationMethod,fill.focalPointRatio);
					break;
				}
				break;
			case flash.display.GraphicsDataType.PATH:
				var path = data;
				var j = 0;
				var _g1 = 0, _g = flash._Vector.Vector_Impl_.get_length(path.commands);
				while(_g1 < _g) {
					var i = _g1++;
					var command = path.commands[i];
					switch(command) {
					case 1:
						this.moveTo(path.data[j],path.data[j + 1]);
						j = j + 2;
						break;
					case 2:
						this.lineTo(path.data[j],path.data[j + 1]);
						j = j + 2;
						break;
					case 3:
						this.curveTo(path.data[j],path.data[j + 1],path.data[j + 2],path.data[j + 3]);
						j = j + 4;
						break;
					}
				}
				break;
			case flash.display.GraphicsDataType.SOLID:
				var fill = data;
				this.beginFill(fill.color,fill.alpha);
				break;
			case flash.display.GraphicsDataType.GRADIENT:
				var fill = data;
				this.beginGradientFill(fill.type,fill.colors,fill.alphas,fill.ratios,fill.matrix,fill.spreadMethod,fill.interpolationMethod,fill.focalPointRatio);
				break;
			}
		}
	}
	,drawEllipse: function(x,y,rx,ry) {
		this.closePolygon(false);
		rx /= 2;
		ry /= 2;
		this.nmeDrawEllipse(x + rx,y + ry,rx,ry);
		this.closePolygon(false);
	}
	,drawCircle: function(x,y,rad) {
		this.closePolygon(false);
		this.nmeDrawEllipse(x,y,rad,rad);
		this.closePolygon(false);
	}
	,curveTo: function(inCX,inCY,inX,inY) {
		var pid = this.mPoints.length;
		if(pid == 0) {
			this.mPoints.push(new flash.display.GfxPoint(this.mPenX,this.mPenY,0.0,0.0,0));
			pid++;
		}
		this.mPenX = inX;
		this.mPenY = inY;
		this.nmeExpandStandardExtent(inX,inY,this.mCurrentLine.thickness);
		this.mPoints.push(new flash.display.GfxPoint(inX,inY,inCX,inCY,2));
		if(this.mCurrentLine.grad != null || this.mCurrentLine.alpha > 0) {
			if(this.mCurrentLine.point_idx0 < 0) this.mCurrentLine.point_idx0 = pid - 1;
			this.mCurrentLine.point_idx1 = pid;
		}
	}
	,createGradient: function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
		var points = new Array();
		var _g1 = 0, _g = colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			points.push(new flash.display.GradPoint(colors[i],alphas[i],ratios[i]));
		}
		var flags = 0;
		if(type == flash.display.GradientType.RADIAL) flags |= 1;
		if(spreadMethod == flash.display.SpreadMethod.REPEAT) flags |= 2; else if(spreadMethod == flash.display.SpreadMethod.REFLECT) flags |= 4;
		if(matrix == null) {
			matrix = new flash.geom.Matrix();
			matrix.createGradientBox(25,25);
		} else matrix = matrix.clone();
		var focal = focalPointRatio == null?0:focalPointRatio;
		return new flash.display.Grad(points,matrix,flags,focal);
	}
	,createCanvasGradient: function(ctx,g) {
		var gradient;
		var matrix = g.matrix;
		if((g.flags & 1) == 0) {
			var p1 = matrix.transformPoint(new flash.geom.Point(-819.2,0));
			var p2 = matrix.transformPoint(new flash.geom.Point(819.2,0));
			gradient = ctx.createLinearGradient(p1.x,p1.y,p2.x,p2.y);
		} else {
			var p1 = matrix.transformPoint(new flash.geom.Point(g.focal * 819.2,0));
			var p2 = matrix.transformPoint(new flash.geom.Point(0,819.2));
			gradient = ctx.createRadialGradient(p1.x,p1.y,0,p2.x,p1.y,p2.y);
		}
		var _g = 0, _g1 = g.points;
		while(_g < _g1.length) {
			var point = _g1[_g];
			++_g;
			var color = this.createCanvasColor(point.col,point.alpha);
			var pos = point.ratio / 255;
			gradient.addColorStop(pos,color);
		}
		return gradient;
	}
	,createCanvasColor: function(color,alpha) {
		var r = (16711680 & color) >> 16;
		var g = (65280 & color) >> 8;
		var b = 255 & color;
		return "rgba" + "(" + r + "," + g + "," + b + "," + alpha + ")";
	}
	,closePolygon: function(inCancelFill) {
		var l = this.mPoints.length;
		if(l > 0) {
			if(l > 1) {
				if(this.mFilling && l > 2) {
					if(this.mPoints[this.mLastMoveID].x != this.mPoints[l - 1].x || this.mPoints[this.mLastMoveID].y != this.mPoints[l - 1].y) this.lineTo(this.mPoints[this.mLastMoveID].x,this.mPoints[this.mLastMoveID].y);
				}
				this.addLineSegment();
				var drawable = new flash.display.Drawable(this.mPoints,this.mFillColour,this.mFillAlpha,this.mSolidGradient,this.mBitmap,this.mLineJobs,null);
				this.addDrawable(drawable);
			}
			this.mLineJobs = [];
			this.mPoints = [];
		}
		if(inCancelFill) {
			this.mFillAlpha = 0;
			this.mSolidGradient = null;
			this.mBitmap = null;
			this.mFilling = false;
		}
		this.nmeChanged = true;
	}
	,clear: function() {
		this.nmeClearLine();
		this.mPenX = 0.0;
		this.mPenY = 0.0;
		this.mDrawList = new Array();
		this.nextDrawIndex = 0;
		this.mPoints = [];
		this.mSolidGradient = null;
		this.mFilling = false;
		this.mFillColour = 0;
		this.mFillAlpha = 0.0;
		this.mLastMoveID = 0;
		this.nmeClearNextCycle = true;
		this.boundsDirty = true;
		this.nmeExtent.x = 0.0;
		this.nmeExtent.y = 0.0;
		this.nmeExtent.width = 0.0;
		this.nmeExtent.height = 0.0;
		this._padding = 0.0;
		this.mLineJobs = [];
	}
	,blit: function(inTexture) {
		this.closePolygon(true);
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.nmeSurface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx != null) ctx.drawImage(inTexture._nmeTextureBuffer,this.mPenX,this.mPenY);
	}
	,beginGradientFill: function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
		this.closePolygon(true);
		this.mFilling = true;
		this.mBitmap = null;
		this.mSolidGradient = this.createGradient(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
	}
	,beginFill: function(color,alpha) {
		this.closePolygon(true);
		this.mFillColour = color;
		this.mFillAlpha = alpha == null?1.0:alpha;
		this.mFilling = true;
		this.mSolidGradient = null;
		this.mBitmap = null;
	}
	,beginBitmapFill: function(bitmap,matrix,in_repeat,in_smooth) {
		if(in_smooth == null) in_smooth = false;
		if(in_repeat == null) in_repeat = true;
		this.closePolygon(true);
		var repeat = in_repeat == null?true:in_repeat;
		var smooth = in_smooth == null?false:in_smooth;
		this.mFilling = true;
		this.mSolidGradient = null;
		this.nmeExpandStandardExtent(bitmap._nmeTextureBuffer != null?bitmap._nmeTextureBuffer.width:0,bitmap._nmeTextureBuffer != null?bitmap._nmeTextureBuffer.height:0);
		this.mBitmap = { texture_buffer : bitmap._nmeTextureBuffer, matrix : matrix == null?matrix:matrix.clone(), flags : (repeat?16:0) | (smooth?65536:0)};
	}
	,addLineSegment: function() {
		if(this.mCurrentLine.point_idx1 > 0) this.mLineJobs.push(new flash.display.LineJob(this.mCurrentLine.grad,this.mCurrentLine.point_idx0,this.mCurrentLine.point_idx1,this.mCurrentLine.thickness,this.mCurrentLine.alpha,this.mCurrentLine.colour,this.mCurrentLine.pixel_hinting,this.mCurrentLine.joints,this.mCurrentLine.caps,this.mCurrentLine.scale_mode,this.mCurrentLine.miter_limit));
		this.mCurrentLine.point_idx0 = this.mCurrentLine.point_idx1 = -1;
	}
	,addDrawable: function(inDrawable) {
		if(inDrawable == null) return;
		this.mDrawList.unshift(inDrawable);
	}
	,_padding: null
	,nmeClearNextCycle: null
	,nmeChanged: null
	,nextDrawIndex: null
	,mSolidGradient: null
	,mPoints: null
	,mPenY: null
	,mPenX: null
	,mLineJobs: null
	,mLineDraws: null
	,mLastMoveID: null
	,mFilling: null
	,mFillAlpha: null
	,mFillColour: null
	,mDrawList: null
	,mCurrentLine: null
	,mBitmap: null
	,nmeSurface: null
	,nmeExtentWithFilters: null
	,nmeExtent: null
	,boundsDirty: null
	,__class__: flash.display.Graphics
}
flash.display.Drawable = function(inPoints,inFillColour,inFillAlpha,inSolidGradient,inBitmap,inLineJobs,inTileJob) {
	this.points = inPoints;
	this.fillColour = inFillColour;
	this.fillAlpha = inFillAlpha;
	this.solidGradient = inSolidGradient;
	this.bitmap = inBitmap;
	this.lineJobs = inLineJobs;
	this.tileJob = inTileJob;
};
$hxClasses["flash.display.Drawable"] = flash.display.Drawable;
flash.display.Drawable.__name__ = ["flash","display","Drawable"];
flash.display.Drawable.prototype = {
	tileJob: null
	,solidGradient: null
	,points: null
	,lineJobs: null
	,fillColour: null
	,fillAlpha: null
	,bitmap: null
	,__class__: flash.display.Drawable
}
flash.display.GfxPoint = function(inX,inY,inCX,inCY,inType) {
	this.x = inX;
	this.y = inY;
	this.cx = inCX;
	this.cy = inCY;
	this.type = inType;
};
$hxClasses["flash.display.GfxPoint"] = flash.display.GfxPoint;
flash.display.GfxPoint.__name__ = ["flash","display","GfxPoint"];
flash.display.GfxPoint.prototype = {
	y: null
	,x: null
	,type: null
	,cy: null
	,cx: null
	,__class__: flash.display.GfxPoint
}
flash.display.Grad = function(inPoints,inMatrix,inFlags,inFocal) {
	this.points = inPoints;
	this.matrix = inMatrix;
	this.flags = inFlags;
	this.focal = inFocal;
};
$hxClasses["flash.display.Grad"] = flash.display.Grad;
flash.display.Grad.__name__ = ["flash","display","Grad"];
flash.display.Grad.prototype = {
	points: null
	,matrix: null
	,focal: null
	,flags: null
	,__class__: flash.display.Grad
}
flash.display.GradPoint = function(inCol,inAlpha,inRatio) {
	this.col = inCol;
	this.alpha = inAlpha;
	this.ratio = inRatio;
};
$hxClasses["flash.display.GradPoint"] = flash.display.GradPoint;
flash.display.GradPoint.__name__ = ["flash","display","GradPoint"];
flash.display.GradPoint.prototype = {
	ratio: null
	,col: null
	,alpha: null
	,__class__: flash.display.GradPoint
}
flash.display.LineJob = function(inGrad,inPoint_idx0,inPoint_idx1,inThickness,inAlpha,inColour,inPixel_hinting,inJoints,inCaps,inScale_mode,inMiter_limit) {
	this.grad = inGrad;
	this.point_idx0 = inPoint_idx0;
	this.point_idx1 = inPoint_idx1;
	this.thickness = inThickness;
	this.alpha = inAlpha;
	this.colour = inColour;
	this.pixel_hinting = inPixel_hinting;
	this.joints = inJoints;
	this.caps = inCaps;
	this.scale_mode = inScale_mode;
	this.miter_limit = inMiter_limit;
};
$hxClasses["flash.display.LineJob"] = flash.display.LineJob;
flash.display.LineJob.__name__ = ["flash","display","LineJob"];
flash.display.LineJob.prototype = {
	thickness: null
	,scale_mode: null
	,point_idx1: null
	,point_idx0: null
	,pixel_hinting: null
	,miter_limit: null
	,joints: null
	,grad: null
	,colour: null
	,caps: null
	,alpha: null
	,__class__: flash.display.LineJob
}
flash.display.PointInPathMode = $hxClasses["flash.display.PointInPathMode"] = { __ename__ : true, __constructs__ : ["USER_SPACE","DEVICE_SPACE"] }
flash.display.PointInPathMode.USER_SPACE = ["USER_SPACE",0];
flash.display.PointInPathMode.USER_SPACE.toString = $estr;
flash.display.PointInPathMode.USER_SPACE.__enum__ = flash.display.PointInPathMode;
flash.display.PointInPathMode.DEVICE_SPACE = ["DEVICE_SPACE",1];
flash.display.PointInPathMode.DEVICE_SPACE.toString = $estr;
flash.display.PointInPathMode.DEVICE_SPACE.__enum__ = flash.display.PointInPathMode;
flash.display.TileJob = function(sheet,drawList,flags) {
	this.sheet = sheet;
	this.drawList = drawList;
	this.flags = flags;
};
$hxClasses["flash.display.TileJob"] = flash.display.TileJob;
flash.display.TileJob.__name__ = ["flash","display","TileJob"];
flash.display.TileJob.prototype = {
	sheet: null
	,flags: null
	,drawList: null
	,__class__: flash.display.TileJob
}
flash.display.IGraphicsFill = function() { }
$hxClasses["flash.display.IGraphicsFill"] = flash.display.IGraphicsFill;
flash.display.IGraphicsFill.__name__ = ["flash","display","IGraphicsFill"];
flash.display.IGraphicsFill.prototype = {
	nmeGraphicsFillType: null
	,__class__: flash.display.IGraphicsFill
}
flash.display.IGraphicsData = function() { }
$hxClasses["flash.display.IGraphicsData"] = flash.display.IGraphicsData;
flash.display.IGraphicsData.__name__ = ["flash","display","IGraphicsData"];
flash.display.IGraphicsData.prototype = {
	nmeGraphicsDataType: null
	,__class__: flash.display.IGraphicsData
}
flash.display.GraphicsGradientFill = function(type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio) {
	if(focalPointRatio == null) focalPointRatio = 0;
	this.type = type;
	this.colors = colors;
	this.alphas = alphas;
	this.ratios = ratios;
	this.matrix = matrix;
	this.spreadMethod = spreadMethod;
	this.interpolationMethod = interpolationMethod;
	this.focalPointRatio = focalPointRatio;
	this.nmeGraphicsDataType = flash.display.GraphicsDataType.GRADIENT;
	this.nmeGraphicsFillType = flash.display.GraphicsFillType.GRADIENT_FILL;
};
$hxClasses["flash.display.GraphicsGradientFill"] = flash.display.GraphicsGradientFill;
flash.display.GraphicsGradientFill.__name__ = ["flash","display","GraphicsGradientFill"];
flash.display.GraphicsGradientFill.__interfaces__ = [flash.display.IGraphicsFill,flash.display.IGraphicsData];
flash.display.GraphicsGradientFill.prototype = {
	type: null
	,spreadMethod: null
	,ratios: null
	,nmeGraphicsFillType: null
	,nmeGraphicsDataType: null
	,matrix: null
	,interpolationMethod: null
	,focalPointRatio: null
	,colors: null
	,alphas: null
	,__class__: flash.display.GraphicsGradientFill
}
flash.display.IGraphicsPath = function() { }
$hxClasses["flash.display.IGraphicsPath"] = flash.display.IGraphicsPath;
flash.display.IGraphicsPath.__name__ = ["flash","display","IGraphicsPath"];
flash.display.GraphicsPath = function(commands,data,winding) {
	this.commands = commands;
	this.data = data;
	this.winding = winding;
	this.nmeGraphicsDataType = flash.display.GraphicsDataType.PATH;
};
$hxClasses["flash.display.GraphicsPath"] = flash.display.GraphicsPath;
flash.display.GraphicsPath.__name__ = ["flash","display","GraphicsPath"];
flash.display.GraphicsPath.__interfaces__ = [flash.display.IGraphicsPath,flash.display.IGraphicsData];
flash.display.GraphicsPath.prototype = {
	moveTo: function(x,y) {
		if(this.commands != null && this.data != null) {
			flash._Vector.Vector_Impl_.push(this.commands,1);
			flash._Vector.Vector_Impl_.push(this.data,x);
			flash._Vector.Vector_Impl_.push(this.data,y);
		}
	}
	,lineTo: function(x,y) {
		if(this.commands != null && this.data != null) {
			flash._Vector.Vector_Impl_.push(this.commands,2);
			flash._Vector.Vector_Impl_.push(this.data,x);
			flash._Vector.Vector_Impl_.push(this.data,y);
		}
	}
	,curveTo: function(controlX,controlY,anchorX,anchorY) {
		if(this.commands != null && this.data != null) {
			flash._Vector.Vector_Impl_.push(this.commands,3);
			flash._Vector.Vector_Impl_.push(this.data,anchorX);
			flash._Vector.Vector_Impl_.push(this.data,anchorY);
			flash._Vector.Vector_Impl_.push(this.data,controlX);
			flash._Vector.Vector_Impl_.push(this.data,controlY);
		}
	}
	,winding: null
	,nmeGraphicsDataType: null
	,data: null
	,commands: null
	,__class__: flash.display.GraphicsPath
}
flash.display.GraphicsPathCommand = function() { }
$hxClasses["flash.display.GraphicsPathCommand"] = flash.display.GraphicsPathCommand;
flash.display.GraphicsPathCommand.__name__ = ["flash","display","GraphicsPathCommand"];
flash.display.GraphicsPathWinding = $hxClasses["flash.display.GraphicsPathWinding"] = { __ename__ : true, __constructs__ : ["EVEN_ODD","NON_ZERO"] }
flash.display.GraphicsPathWinding.EVEN_ODD = ["EVEN_ODD",0];
flash.display.GraphicsPathWinding.EVEN_ODD.toString = $estr;
flash.display.GraphicsPathWinding.EVEN_ODD.__enum__ = flash.display.GraphicsPathWinding;
flash.display.GraphicsPathWinding.NON_ZERO = ["NON_ZERO",1];
flash.display.GraphicsPathWinding.NON_ZERO.toString = $estr;
flash.display.GraphicsPathWinding.NON_ZERO.__enum__ = flash.display.GraphicsPathWinding;
flash.display.GraphicsSolidFill = function(color,alpha) {
	if(alpha == null) alpha = 1;
	if(color == null) color = 0;
	this.alpha = alpha;
	this.color = color;
	this.nmeGraphicsDataType = flash.display.GraphicsDataType.SOLID;
	this.nmeGraphicsFillType = flash.display.GraphicsFillType.SOLID_FILL;
};
$hxClasses["flash.display.GraphicsSolidFill"] = flash.display.GraphicsSolidFill;
flash.display.GraphicsSolidFill.__name__ = ["flash","display","GraphicsSolidFill"];
flash.display.GraphicsSolidFill.__interfaces__ = [flash.display.IGraphicsFill,flash.display.IGraphicsData];
flash.display.GraphicsSolidFill.prototype = {
	nmeGraphicsFillType: null
	,nmeGraphicsDataType: null
	,color: null
	,alpha: null
	,__class__: flash.display.GraphicsSolidFill
}
flash.display.IGraphicsStroke = function() { }
$hxClasses["flash.display.IGraphicsStroke"] = flash.display.IGraphicsStroke;
flash.display.IGraphicsStroke.__name__ = ["flash","display","IGraphicsStroke"];
flash.display.GraphicsStroke = function(thickness,pixelHinting,scaleMode,caps,joints,miterLimit,fill) {
	if(miterLimit == null) miterLimit = 3;
	if(pixelHinting == null) pixelHinting = false;
	if(thickness == null) thickness = 0.0;
	this.caps = caps != null?caps:null;
	this.fill = fill;
	this.joints = joints != null?joints:null;
	this.miterLimit = miterLimit;
	this.pixelHinting = pixelHinting;
	this.scaleMode = scaleMode != null?scaleMode:null;
	this.thickness = thickness;
	this.nmeGraphicsDataType = flash.display.GraphicsDataType.STROKE;
};
$hxClasses["flash.display.GraphicsStroke"] = flash.display.GraphicsStroke;
flash.display.GraphicsStroke.__name__ = ["flash","display","GraphicsStroke"];
flash.display.GraphicsStroke.__interfaces__ = [flash.display.IGraphicsStroke,flash.display.IGraphicsData];
flash.display.GraphicsStroke.prototype = {
	thickness: null
	,scaleMode: null
	,pixelHinting: null
	,nmeGraphicsDataType: null
	,miterLimit: null
	,joints: null
	,fill: null
	,caps: null
	,__class__: flash.display.GraphicsStroke
}
flash.display.GraphicsDataType = $hxClasses["flash.display.GraphicsDataType"] = { __ename__ : true, __constructs__ : ["STROKE","SOLID","GRADIENT","PATH"] }
flash.display.GraphicsDataType.STROKE = ["STROKE",0];
flash.display.GraphicsDataType.STROKE.toString = $estr;
flash.display.GraphicsDataType.STROKE.__enum__ = flash.display.GraphicsDataType;
flash.display.GraphicsDataType.SOLID = ["SOLID",1];
flash.display.GraphicsDataType.SOLID.toString = $estr;
flash.display.GraphicsDataType.SOLID.__enum__ = flash.display.GraphicsDataType;
flash.display.GraphicsDataType.GRADIENT = ["GRADIENT",2];
flash.display.GraphicsDataType.GRADIENT.toString = $estr;
flash.display.GraphicsDataType.GRADIENT.__enum__ = flash.display.GraphicsDataType;
flash.display.GraphicsDataType.PATH = ["PATH",3];
flash.display.GraphicsDataType.PATH.toString = $estr;
flash.display.GraphicsDataType.PATH.__enum__ = flash.display.GraphicsDataType;
flash.display.GraphicsFillType = $hxClasses["flash.display.GraphicsFillType"] = { __ename__ : true, __constructs__ : ["SOLID_FILL","GRADIENT_FILL"] }
flash.display.GraphicsFillType.SOLID_FILL = ["SOLID_FILL",0];
flash.display.GraphicsFillType.SOLID_FILL.toString = $estr;
flash.display.GraphicsFillType.SOLID_FILL.__enum__ = flash.display.GraphicsFillType;
flash.display.GraphicsFillType.GRADIENT_FILL = ["GRADIENT_FILL",1];
flash.display.GraphicsFillType.GRADIENT_FILL.toString = $estr;
flash.display.GraphicsFillType.GRADIENT_FILL.__enum__ = flash.display.GraphicsFillType;
flash.display.InterpolationMethod = $hxClasses["flash.display.InterpolationMethod"] = { __ename__ : true, __constructs__ : ["RGB","LINEAR_RGB"] }
flash.display.InterpolationMethod.RGB = ["RGB",0];
flash.display.InterpolationMethod.RGB.toString = $estr;
flash.display.InterpolationMethod.RGB.__enum__ = flash.display.InterpolationMethod;
flash.display.InterpolationMethod.LINEAR_RGB = ["LINEAR_RGB",1];
flash.display.InterpolationMethod.LINEAR_RGB.toString = $estr;
flash.display.InterpolationMethod.LINEAR_RGB.__enum__ = flash.display.InterpolationMethod;
flash.display.JointStyle = $hxClasses["flash.display.JointStyle"] = { __ename__ : true, __constructs__ : ["MITER","ROUND","BEVEL"] }
flash.display.JointStyle.MITER = ["MITER",0];
flash.display.JointStyle.MITER.toString = $estr;
flash.display.JointStyle.MITER.__enum__ = flash.display.JointStyle;
flash.display.JointStyle.ROUND = ["ROUND",1];
flash.display.JointStyle.ROUND.toString = $estr;
flash.display.JointStyle.ROUND.__enum__ = flash.display.JointStyle;
flash.display.JointStyle.BEVEL = ["BEVEL",2];
flash.display.JointStyle.BEVEL.toString = $estr;
flash.display.JointStyle.BEVEL.__enum__ = flash.display.JointStyle;
flash.display.LineScaleMode = $hxClasses["flash.display.LineScaleMode"] = { __ename__ : true, __constructs__ : ["HORIZONTAL","NONE","NORMAL","VERTICAL"] }
flash.display.LineScaleMode.HORIZONTAL = ["HORIZONTAL",0];
flash.display.LineScaleMode.HORIZONTAL.toString = $estr;
flash.display.LineScaleMode.HORIZONTAL.__enum__ = flash.display.LineScaleMode;
flash.display.LineScaleMode.NONE = ["NONE",1];
flash.display.LineScaleMode.NONE.toString = $estr;
flash.display.LineScaleMode.NONE.__enum__ = flash.display.LineScaleMode;
flash.display.LineScaleMode.NORMAL = ["NORMAL",2];
flash.display.LineScaleMode.NORMAL.toString = $estr;
flash.display.LineScaleMode.NORMAL.__enum__ = flash.display.LineScaleMode;
flash.display.LineScaleMode.VERTICAL = ["VERTICAL",3];
flash.display.LineScaleMode.VERTICAL.toString = $estr;
flash.display.LineScaleMode.VERTICAL.__enum__ = flash.display.LineScaleMode;
flash.display.Loader = function() {
	flash.display.Sprite.call(this);
	this.contentLoaderInfo = flash.display.LoaderInfo.create(this);
};
$hxClasses["flash.display.Loader"] = flash.display.Loader;
flash.display.Loader.__name__ = ["flash","display","Loader"];
flash.display.Loader.__super__ = flash.display.Sprite;
flash.display.Loader.prototype = $extend(flash.display.Sprite.prototype,{
	handleLoad: function(e) {
		e.currentTarget = this;
		this.content.nmeInvalidateBounds();
		this.content.nmeRender(null,null);
		this.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE,$bind(this,this.handleLoad));
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.Sprite.prototype.validateBounds.call(this);
			if(this.mImage != null) {
				var r = new flash.geom.Rectangle(0,0,this.mImage.get_width(),this.mImage.get_height());
				if(r.width != 0 || r.height != 0) {
					if(this.nmeBoundsRect.width == 0 && this.nmeBoundsRect.height == 0) this.nmeBoundsRect = r.clone(); else this.nmeBoundsRect.extendBounds(r);
				}
			}
			if(this.scale9Grid != null) {
				this.nmeBoundsRect.width *= this.nmeScaleX;
				this.nmeBoundsRect.height *= this.nmeScaleY;
				this.nmeWidth = this.nmeBoundsRect.width;
				this.nmeHeight = this.nmeBoundsRect.height;
			} else {
				this.nmeWidth = this.nmeBoundsRect.width * this.nmeScaleX;
				this.nmeHeight = this.nmeBoundsRect.height * this.nmeScaleY;
			}
		}
	}
	,toString: function() {
		return "[Loader name=" + this.name + " id=" + this._nmeId + "]";
	}
	,loadBytes: function(buffer) {
		var _g = this;
		try {
			this.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.handleLoad),false,2147483647);
			flash.display.BitmapData.loadFromBytes(buffer,null,function(bmd) {
				_g.content = new flash.display.Bitmap(bmd);
				_g.contentLoaderInfo.content = _g.content;
				_g.addChild(_g.content);
				var evt = new flash.events.Event(flash.events.Event.COMPLETE);
				evt.currentTarget = _g;
				_g.contentLoaderInfo.dispatchEvent(evt);
			});
		} catch( e ) {
			console.log("Error " + Std.string(e));
			var evt = new flash.events.IOErrorEvent(flash.events.IOErrorEvent.IO_ERROR);
			evt.currentTarget = this;
			this.contentLoaderInfo.dispatchEvent(evt);
		}
	}
	,load: function(request,context) {
		var extension = "";
		var parts = request.url.split(".");
		if(parts.length > 0) extension = parts[parts.length - 1].toLowerCase();
		var transparent = true;
		this.contentLoaderInfo.url = request.url;
		this.contentLoaderInfo.contentType = (function($this) {
			var $r;
			switch(extension) {
			case "swf":
				$r = "application/x-shockwave-flash";
				break;
			case "jpg":case "jpeg":
				$r = (function($this) {
					var $r;
					transparent = false;
					$r = "image/jpeg";
					return $r;
				}($this));
				break;
			case "png":
				$r = "image/png";
				break;
			case "gif":
				$r = "image/gif";
				break;
			default:
				$r = (function($this) {
					var $r;
					throw "Unrecognized file " + request.url;
					return $r;
				}($this));
			}
			return $r;
		}(this));
		this.mImage = new flash.display.BitmapData(0,0,transparent);
		try {
			this.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.handleLoad),false,2147483647);
			this.mImage.nmeLoadFromFile(request.url,this.contentLoaderInfo);
			this.content = new flash.display.Bitmap(this.mImage);
			this.contentLoaderInfo.content = this.content;
			this.addChild(this.content);
		} catch( e ) {
			console.log("Error " + Std.string(e));
			var evt = new flash.events.IOErrorEvent(flash.events.IOErrorEvent.IO_ERROR);
			evt.currentTarget = this;
			this.contentLoaderInfo.dispatchEvent(evt);
			return;
		}
		if(this.mShape == null) {
			this.mShape = new flash.display.Shape();
			this.addChild(this.mShape);
		}
	}
	,mShape: null
	,mImage: null
	,contentLoaderInfo: null
	,content: null
	,__class__: flash.display.Loader
});
flash.display.LoaderInfo = function() {
	flash.events.EventDispatcher.call(this);
	this.applicationDomain = flash.system.ApplicationDomain.currentDomain;
	this.bytesLoaded = 0;
	this.bytesTotal = 0;
	this.childAllowsParent = true;
	this.parameters = { };
};
$hxClasses["flash.display.LoaderInfo"] = flash.display.LoaderInfo;
flash.display.LoaderInfo.__name__ = ["flash","display","LoaderInfo"];
flash.display.LoaderInfo.create = function(ldr) {
	var li = new flash.display.LoaderInfo();
	if(ldr != null) li.loader = ldr; else li.url = "";
	return li;
}
flash.display.LoaderInfo.__super__ = flash.events.EventDispatcher;
flash.display.LoaderInfo.prototype = $extend(flash.events.EventDispatcher.prototype,{
	width: null
	,url: null
	,sharedEvents: null
	,sameDomain: null
	,parentAllowsChild: null
	,parameters: null
	,loaderURL: null
	,loader: null
	,height: null
	,frameRate: null
	,contentType: null
	,content: null
	,childAllowsParent: null
	,bytesTotal: null
	,bytesLoaded: null
	,bytes: null
	,applicationDomain: null
	,__class__: flash.display.LoaderInfo
});
flash.display.MovieClip = function() {
	flash.display.Sprite.call(this);
	this.enabled = true;
	this.__currentFrame = 0;
	this.__totalFrames = 0;
	this.loaderInfo = flash.display.LoaderInfo.create(null);
};
$hxClasses["flash.display.MovieClip"] = flash.display.MovieClip;
flash.display.MovieClip.__name__ = ["flash","display","MovieClip"];
flash.display.MovieClip.__super__ = flash.display.Sprite;
flash.display.MovieClip.prototype = $extend(flash.display.Sprite.prototype,{
	get_totalFrames: function() {
		return this.__totalFrames;
	}
	,get_framesLoaded: function() {
		return this.__totalFrames;
	}
	,get_currentFrame: function() {
		return this.__currentFrame;
	}
	,toString: function() {
		return "[MovieClip name=" + this.name + " id=" + this._nmeId + "]";
	}
	,stop: function() {
	}
	,prevFrame: function() {
	}
	,play: function() {
	}
	,nextFrame: function() {
	}
	,gotoAndStop: function(frame,scene) {
		if(scene == null) scene = "";
	}
	,gotoAndPlay: function(frame,scene) {
		if(scene == null) scene = "";
	}
	,__totalFrames: null
	,__currentFrame: null
	,totalFrames: null
	,framesLoaded: null
	,enabled: null
	,currentFrame: null
	,__class__: flash.display.MovieClip
	,__properties__: $extend(flash.display.Sprite.prototype.__properties__,{get_currentFrame:"get_currentFrame",get_framesLoaded:"get_framesLoaded",get_totalFrames:"get_totalFrames"})
});
flash.display.PixelSnapping = $hxClasses["flash.display.PixelSnapping"] = { __ename__ : true, __constructs__ : ["NEVER","AUTO","ALWAYS"] }
flash.display.PixelSnapping.NEVER = ["NEVER",0];
flash.display.PixelSnapping.NEVER.toString = $estr;
flash.display.PixelSnapping.NEVER.__enum__ = flash.display.PixelSnapping;
flash.display.PixelSnapping.AUTO = ["AUTO",1];
flash.display.PixelSnapping.AUTO.toString = $estr;
flash.display.PixelSnapping.AUTO.__enum__ = flash.display.PixelSnapping;
flash.display.PixelSnapping.ALWAYS = ["ALWAYS",2];
flash.display.PixelSnapping.ALWAYS.toString = $estr;
flash.display.PixelSnapping.ALWAYS.__enum__ = flash.display.PixelSnapping;
flash.display.Shape = function() {
	flash.display.DisplayObject.call(this);
	this.nmeGraphics = new flash.display.Graphics();
};
$hxClasses["flash.display.Shape"] = flash.display.Shape;
flash.display.Shape.__name__ = ["flash","display","Shape"];
flash.display.Shape.__super__ = flash.display.DisplayObject;
flash.display.Shape.prototype = $extend(flash.display.DisplayObject.prototype,{
	get_graphics: function() {
		return this.nmeGraphics;
	}
	,toString: function() {
		return "[Shape name=" + this.name + " id=" + this._nmeId + "]";
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(this.parent == null) return null;
		if(this.parent.mouseEnabled && flash.display.DisplayObject.prototype.nmeGetObjectUnderPoint.call(this,point) == this) return this.parent; else return null;
	}
	,nmeGetGraphics: function() {
		return this.nmeGraphics;
	}
	,nmeGraphics: null
	,__class__: flash.display.Shape
	,__properties__: $extend(flash.display.DisplayObject.prototype.__properties__,{get_graphics:"get_graphics"})
});
flash.display.SpreadMethod = $hxClasses["flash.display.SpreadMethod"] = { __ename__ : true, __constructs__ : ["REPEAT","REFLECT","PAD"] }
flash.display.SpreadMethod.REPEAT = ["REPEAT",0];
flash.display.SpreadMethod.REPEAT.toString = $estr;
flash.display.SpreadMethod.REPEAT.__enum__ = flash.display.SpreadMethod;
flash.display.SpreadMethod.REFLECT = ["REFLECT",1];
flash.display.SpreadMethod.REFLECT.toString = $estr;
flash.display.SpreadMethod.REFLECT.__enum__ = flash.display.SpreadMethod;
flash.display.SpreadMethod.PAD = ["PAD",2];
flash.display.SpreadMethod.PAD.toString = $estr;
flash.display.SpreadMethod.PAD.__enum__ = flash.display.SpreadMethod;
flash.events.Event = function(inType,inBubbles,inCancelable) {
	if(inCancelable == null) inCancelable = false;
	if(inBubbles == null) inBubbles = false;
	this.type = inType;
	this.bubbles = inBubbles;
	this.cancelable = inCancelable;
	this.nmeIsCancelled = false;
	this.nmeIsCancelledNow = false;
	this.target = null;
	this.currentTarget = null;
	this.eventPhase = flash.events.EventPhase.AT_TARGET;
};
$hxClasses["flash.events.Event"] = flash.events.Event;
flash.events.Event.__name__ = ["flash","events","Event"];
flash.events.Event.prototype = {
	toString: function() {
		return "[Event type=" + this.type + " bubbles=" + Std.string(this.bubbles) + " cancelable=" + Std.string(this.cancelable) + "]";
	}
	,stopPropagation: function() {
		this.nmeIsCancelled = true;
	}
	,stopImmediatePropagation: function() {
		this.nmeIsCancelled = true;
		this.nmeIsCancelledNow = true;
	}
	,nmeSetPhase: function(phase) {
		this.eventPhase = phase;
	}
	,nmeGetIsCancelledNow: function() {
		return this.nmeIsCancelledNow;
	}
	,nmeGetIsCancelled: function() {
		return this.nmeIsCancelled;
	}
	,nmeCreateSimilar: function(type,related,targ) {
		var result = new flash.events.Event(type,this.bubbles,this.cancelable);
		if(targ != null) result.target = targ;
		return result;
	}
	,clone: function() {
		return new flash.events.Event(this.type,this.bubbles,this.cancelable);
	}
	,nmeIsCancelledNow: null
	,nmeIsCancelled: null
	,type: null
	,target: null
	,eventPhase: null
	,currentTarget: null
	,cancelable: null
	,bubbles: null
	,__class__: flash.events.Event
}
flash.events.MouseEvent = function(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta,commandKey,clickCount) {
	if(clickCount == null) clickCount = 0;
	if(commandKey == null) commandKey = false;
	if(delta == null) delta = 0;
	if(buttonDown == null) buttonDown = false;
	if(shiftKey == null) shiftKey = false;
	if(altKey == null) altKey = false;
	if(ctrlKey == null) ctrlKey = false;
	if(localY == null) localY = 0;
	if(localX == null) localX = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = true;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.shiftKey = shiftKey;
	this.altKey = altKey;
	this.ctrlKey = ctrlKey;
	this.bubbles = bubbles;
	this.relatedObject = relatedObject;
	this.delta = delta;
	this.localX = localX;
	this.localY = localY;
	this.buttonDown = buttonDown;
	this.commandKey = commandKey;
	this.clickCount = clickCount;
};
$hxClasses["flash.events.MouseEvent"] = flash.events.MouseEvent;
flash.events.MouseEvent.__name__ = ["flash","events","MouseEvent"];
flash.events.MouseEvent.nmeCreate = function(type,event,local,target) {
	var nmeMouseDown = false;
	var delta = 2;
	if(type == flash.events.MouseEvent.MOUSE_WHEEL) {
		var mouseEvent = event;
		if(mouseEvent.wheelDelta) delta = mouseEvent.wheelDelta / 120 | 0; else if(mouseEvent.detail) -mouseEvent.detail | 0;
	}
	if(type == flash.events.MouseEvent.MOUSE_DOWN) nmeMouseDown = event.which != null?event.which == 1:event.button != null?event.button == 0:false; else if(type == flash.events.MouseEvent.MOUSE_UP) {
		if(event.which != null) {
			if(event.which == 1) nmeMouseDown = false; else if(event.button != null) {
				if(event.button == 0) nmeMouseDown = false; else nmeMouseDown = false;
			}
		}
	}
	var pseudoEvent = new flash.events.MouseEvent(type,true,false,local.x,local.y,null,event.ctrlKey,event.altKey,event.shiftKey,nmeMouseDown,delta);
	pseudoEvent.stageX = flash.Lib.get_current().get_stage().get_mouseX();
	pseudoEvent.stageY = flash.Lib.get_current().get_stage().get_mouseY();
	pseudoEvent.target = target;
	return pseudoEvent;
}
flash.events.MouseEvent.__super__ = flash.events.Event;
flash.events.MouseEvent.prototype = $extend(flash.events.Event.prototype,{
	updateAfterEvent: function() {
	}
	,nmeCreateSimilar: function(type,related,targ) {
		var result = new flash.events.MouseEvent(type,this.bubbles,this.cancelable,this.localX,this.localY,related == null?this.relatedObject:related,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.delta,this.commandKey,this.clickCount);
		if(targ != null) result.target = targ;
		return result;
	}
	,stageY: null
	,stageX: null
	,shiftKey: null
	,relatedObject: null
	,localY: null
	,localX: null
	,delta: null
	,ctrlKey: null
	,clickCount: null
	,commandKey: null
	,buttonDown: null
	,altKey: null
	,__class__: flash.events.MouseEvent
});
flash.display.Stage = function(width,height) {
	flash.display.DisplayObjectContainer.call(this);
	this.nmeFocusObject = null;
	this.nmeFocusObjectActivated = false;
	this.nmeWindowWidth = width;
	this.nmeWindowHeight = height;
	this.stageFocusRect = false;
	this.scaleMode = flash.display.StageScaleMode.SHOW_ALL;
	this.nmeStageMatrix = new flash.geom.Matrix();
	this.tabEnabled = true;
	this.set_frameRate(0.0);
	this.set_backgroundColor(16777215);
	this.name = "Stage";
	this.loaderInfo = flash.display.LoaderInfo.create(null);
	this.loaderInfo.parameters.width = Std.string(this.nmeWindowWidth);
	this.loaderInfo.parameters.height = Std.string(this.nmeWindowHeight);
	this.nmePointInPathMode = flash.display.Graphics.nmeDetectIsPointInPathMode();
	this.nmeMouseOverObjects = [];
	this.set_showDefaultContextMenu(true);
	this.nmeTouchInfo = [];
	this.nmeUIEventsQueue = new Array(1000);
	this.nmeUIEventsQueueIndex = 0;
};
$hxClasses["flash.display.Stage"] = flash.display.Stage;
flash.display.Stage.__name__ = ["flash","display","Stage"];
flash.display.Stage.getOrientation = function() {
	var rotation = window.orientation;
	var orientation = flash.display.Stage.OrientationPortrait;
	switch(rotation) {
	case -90:
		orientation = flash.display.Stage.OrientationLandscapeLeft;
		break;
	case 180:
		orientation = flash.display.Stage.OrientationPortraitUpsideDown;
		break;
	case 90:
		orientation = flash.display.Stage.OrientationLandscapeRight;
		break;
	default:
		orientation = flash.display.Stage.OrientationPortrait;
	}
	return orientation;
}
flash.display.Stage.__super__ = flash.display.DisplayObjectContainer;
flash.display.Stage.prototype = $extend(flash.display.DisplayObjectContainer.prototype,{
	get_stageWidth: function() {
		return this.nmeWindowWidth;
	}
	,get_stageHeight: function() {
		return this.nmeWindowHeight;
	}
	,get_stage: function() {
		return flash.Lib.nmeGetStage();
	}
	,set_showDefaultContextMenu: function(showDefaultContextMenu) {
		if(showDefaultContextMenu != this.nmeShowDefaultContextMenu && this.nmeShowDefaultContextMenu != null) {
			if(!showDefaultContextMenu) flash.Lib.nmeDisableRightClick(); else flash.Lib.nmeEnableRightClick();
		}
		this.nmeShowDefaultContextMenu = showDefaultContextMenu;
		return showDefaultContextMenu;
	}
	,get_showDefaultContextMenu: function() {
		return this.nmeShowDefaultContextMenu;
	}
	,set_quality: function(inQuality) {
		return this.quality = inQuality;
	}
	,get_quality: function() {
		return this.quality != null?this.quality:flash.display.StageQuality.BEST;
	}
	,get_mouseY: function() {
		return this._mouseY;
	}
	,get_mouseX: function() {
		return this._mouseX;
	}
	,get_fullScreenHeight: function() {
		return js.Browser.window.innerHeight;
	}
	,get_fullScreenWidth: function() {
		return js.Browser.window.innerWidth;
	}
	,set_frameRate: function(speed) {
		if(speed == 0) {
			var window = js.Browser.window;
			var nmeRequestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame;
			if(nmeRequestAnimationFrame == null) speed = 60;
		}
		if(speed != 0) this.nmeInterval = 1000.0 / speed | 0;
		this.nmeFrameRate = speed;
		this.nmeUpdateNextWake();
		return speed;
	}
	,get_frameRate: function() {
		return this.nmeFrameRate;
	}
	,set_focus: function(inObj) {
		this.nmeOnFocus(inObj);
		return this.nmeFocusObject;
	}
	,get_focus: function() {
		return this.nmeFocusObject;
	}
	,set_displayState: function(displayState) {
		if(displayState != this.displayState && this.displayState != null) {
			switch( (displayState)[1] ) {
			case 0:
				flash.Lib.nmeDisableFullScreen();
				break;
			case 1:
			case 2:
				flash.Lib.nmeEnableFullScreen();
				break;
			}
		}
		this.displayState = displayState;
		return displayState;
	}
	,get_displayState: function() {
		return this.displayState;
	}
	,set_backgroundColor: function(col) {
		return this.nmeBackgroundColour = col;
	}
	,get_backgroundColor: function() {
		return this.nmeBackgroundColour;
	}
	,nmeOnTouch: function(event,touch,type,touchInfo,isPrimaryTouchPoint) {
		var point = new flash.geom.Point(touch.pageX - flash.Lib.mMe.__scr.offsetLeft + window.pageXOffset,touch.pageY - flash.Lib.mMe.__scr.offsetTop + window.pageYOffset);
		var obj = this.nmeGetObjectUnderPoint(point);
		this._mouseX = point.x;
		this._mouseY = point.y;
		var stack = new Array();
		if(obj != null) obj.nmeGetInteractiveObjectStack(stack);
		if(stack.length > 0) {
			stack.reverse();
			var local = obj.globalToLocal(point);
			var evt = flash.events.TouchEvent.nmeCreate(type,event,touch,local,obj);
			evt.touchPointID = touch.identifier;
			evt.isPrimaryTouchPoint = isPrimaryTouchPoint;
			this.nmeCheckInOuts(evt,stack,touchInfo);
			obj.nmeFireEvent(evt);
			var mouseType = (function($this) {
				var $r;
				switch(type) {
				case "touchBegin":
					$r = flash.events.MouseEvent.MOUSE_DOWN;
					break;
				case "touchEnd":
					$r = flash.events.MouseEvent.MOUSE_UP;
					break;
				default:
					$r = (function($this) {
						var $r;
						if($this.nmeDragObject != null) $this.nmeDrag(point);
						$r = flash.events.MouseEvent.MOUSE_MOVE;
						return $r;
					}($this));
				}
				return $r;
			}(this));
			obj.nmeFireEvent(flash.events.MouseEvent.nmeCreate(mouseType,evt,local,obj));
		} else {
			var evt = flash.events.TouchEvent.nmeCreate(type,event,touch,point,null);
			evt.touchPointID = touch.identifier;
			evt.isPrimaryTouchPoint = isPrimaryTouchPoint;
			this.nmeCheckInOuts(evt,stack,touchInfo);
		}
	}
	,nmeOnResize: function(inW,inH) {
		this.nmeWindowWidth = inW;
		this.nmeWindowHeight = inH;
		var event = new flash.events.Event(flash.events.Event.RESIZE);
		event.target = this;
		this.nmeBroadcast(event);
	}
	,nmeOnMouse: function(event,type) {
		var point = new flash.geom.Point(event.clientX - flash.Lib.mMe.__scr.offsetLeft + window.pageXOffset,event.clientY - flash.Lib.mMe.__scr.offsetTop + window.pageYOffset);
		if(this.nmeDragObject != null) this.nmeDrag(point);
		var obj = this.nmeGetObjectUnderPoint(point);
		this._mouseX = point.x;
		this._mouseY = point.y;
		var stack = new Array();
		if(obj != null) obj.nmeGetInteractiveObjectStack(stack);
		if(stack.length > 0) {
			stack.reverse();
			var local = obj.globalToLocal(point);
			var evt = flash.events.MouseEvent.nmeCreate(type,event,local,obj);
			this.nmeCheckInOuts(evt,stack);
			if(type == flash.events.MouseEvent.MOUSE_DOWN) this.nmeOnFocus(stack[stack.length - 1]);
			obj.nmeFireEvent(evt);
		} else {
			var evt = flash.events.MouseEvent.nmeCreate(type,event,point,null);
			this.nmeCheckInOuts(evt,stack);
		}
	}
	,nmeOnFocus: function(target) {
		if(target != this.nmeFocusObject) {
			if(this.nmeFocusObject != null) this.nmeFocusObject.nmeFireEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_OUT,true,false,this.nmeFocusObject,false,0));
			target.nmeFireEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_IN,true,false,target,false,0));
			this.nmeFocusObject = target;
		}
	}
	,nmeOnKey: function(code,pressed,inChar,ctrl,alt,shift,keyLocation) {
		var stack = new Array();
		if(this.nmeFocusObject == null) this.nmeGetInteractiveObjectStack(stack); else this.nmeFocusObject.nmeGetInteractiveObjectStack(stack);
		if(stack.length > 0) {
			var obj = stack[0];
			var evt = new flash.events.KeyboardEvent(pressed?flash.events.KeyboardEvent.KEY_DOWN:flash.events.KeyboardEvent.KEY_UP,true,false,inChar,code,keyLocation,ctrl,alt,shift);
			obj.nmeFireEvent(evt);
		}
	}
	,nmeHandleOrientationChange: function() {
	}
	,nmeHandleAccelerometer: function(evt) {
		flash.display.Stage.nmeAcceleration.x = evt.accelerationIncludingGravity.x;
		flash.display.Stage.nmeAcceleration.y = evt.accelerationIncludingGravity.y;
		flash.display.Stage.nmeAcceleration.z = evt.accelerationIncludingGravity.z;
	}
	,toString: function() {
		return "[Stage id=" + this._nmeId + "]";
	}
	,nmeUpdateNextWake: function() {
		if(this.nmeFrameRate == 0) {
			var nmeRequestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame;
			nmeRequestAnimationFrame($bind(this,this.nmeUpdateNextWake));
			this.nmeStageRender();
		} else {
			js.Browser.window.clearInterval(this.nmeTimer);
			this.nmeTimer = js.Browser.window.setInterval($bind(this,this.nmeStageRender),this.nmeInterval);
		}
	}
	,nmeStopDrag: function(sprite) {
		this.nmeDragBounds = null;
		this.nmeDragObject = null;
	}
	,nmeStartDrag: function(sprite,lockCenter,bounds) {
		if(lockCenter == null) lockCenter = false;
		this.nmeDragBounds = bounds == null?null:bounds.clone();
		this.nmeDragObject = sprite;
		if(this.nmeDragObject != null) {
			var mouse = new flash.geom.Point(this._mouseX,this._mouseY);
			var p = this.nmeDragObject.parent;
			if(p != null) mouse = p.globalToLocal(mouse);
			if(lockCenter) {
				var bounds1 = sprite.getBounds(this);
				this.nmeDragOffsetX = this.nmeDragObject.get_x() - (bounds1.width / 2 + bounds1.x);
				this.nmeDragOffsetY = this.nmeDragObject.get_y() - (bounds1.height / 2 + bounds1.y);
			} else {
				this.nmeDragOffsetX = this.nmeDragObject.get_x() - mouse.x;
				this.nmeDragOffsetY = this.nmeDragObject.get_y() - mouse.y;
			}
		}
	}
	,nmeStageRender: function(_) {
		if(!this.nmeStageActive) {
			this.nmeOnResize(this.nmeWindowWidth,this.nmeWindowHeight);
			var event = new flash.events.Event(flash.events.Event.ACTIVATE);
			event.target = this;
			this.nmeBroadcast(event);
			this.nmeStageActive = true;
		}
		var _g1 = 0, _g = this.nmeUIEventsQueueIndex;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.nmeUIEventsQueue[i] != null) this.nmeProcessStageEvent(this.nmeUIEventsQueue[i]);
		}
		this.nmeUIEventsQueueIndex = 0;
		var event = new flash.events.Event(flash.events.Event.ENTER_FRAME);
		this.nmeBroadcast(event);
		if(this.nmeInvalid) {
			var event1 = new flash.events.Event(flash.events.Event.RENDER);
			this.nmeBroadcast(event1);
		}
		this.nmeRenderAll();
	}
	,nmeRenderToCanvas: function(canvas) {
		canvas.width = canvas.width;
		this.nmeRender(canvas);
	}
	,nmeRenderAll: function() {
		this.nmeRender(null,null);
	}
	,nmeQueueStageEvent: function(evt) {
		this.nmeUIEventsQueue[this.nmeUIEventsQueueIndex++] = evt;
	}
	,nmeProcessStageEvent: function(evt) {
		evt.stopPropagation();
		switch(evt.type) {
		case "resize":
			this.nmeOnResize(flash.Lib.nmeGetWidth(),flash.Lib.nmeGetHeight());
			break;
		case "focus":
			this.nmeOnFocus(this);
			if(!this.nmeFocusObjectActivated) {
				this.nmeFocusObjectActivated = true;
				this.dispatchEvent(new flash.events.Event(flash.events.Event.ACTIVATE));
			}
			break;
		case "blur":
			if(this.nmeFocusObjectActivated) {
				this.nmeFocusObjectActivated = false;
				this.dispatchEvent(new flash.events.Event(flash.events.Event.DEACTIVATE));
			}
			break;
		case "mousemove":
			this.nmeOnMouse(evt,flash.events.MouseEvent.MOUSE_MOVE);
			break;
		case "mousedown":
			this.nmeOnMouse(evt,flash.events.MouseEvent.MOUSE_DOWN);
			break;
		case "mouseup":
			this.nmeOnMouse(evt,flash.events.MouseEvent.MOUSE_UP);
			break;
		case "click":
			this.nmeOnMouse(evt,flash.events.MouseEvent.CLICK);
			break;
		case "mousewheel":
			this.nmeOnMouse(evt,flash.events.MouseEvent.MOUSE_WHEEL);
			break;
		case "dblclick":
			this.nmeOnMouse(evt,flash.events.MouseEvent.DOUBLE_CLICK);
			break;
		case "keydown":
			var evt1 = evt;
			var keyCode = evt1.keyCode != null?evt1.keyCode:evt1.which;
			keyCode = flash.ui.Keyboard.nmeConvertMozillaCode(keyCode);
			this.nmeOnKey(keyCode,true,evt1.charCode,evt1.ctrlKey,evt1.altKey,evt1.shiftKey,evt1.keyLocation);
			break;
		case "keyup":
			var evt1 = evt;
			var keyCode = evt1.keyCode != null?evt1.keyCode:evt1.which;
			keyCode = flash.ui.Keyboard.nmeConvertMozillaCode(keyCode);
			this.nmeOnKey(keyCode,false,evt1.charCode,evt1.ctrlKey,evt1.altKey,evt1.shiftKey,evt1.keyLocation);
			break;
		case "touchstart":
			var evt1 = evt;
			evt1.preventDefault();
			var touchInfo = new flash.display._Stage.TouchInfo();
			this.nmeTouchInfo[evt1.changedTouches[0].identifier] = touchInfo;
			this.nmeOnTouch(evt1,evt1.changedTouches[0],"touchBegin",touchInfo,false);
			break;
		case "touchmove":
			var evt1 = evt;
			var touchInfo = this.nmeTouchInfo[evt1.changedTouches[0].identifier];
			this.nmeOnTouch(evt1,evt1.changedTouches[0],"touchMove",touchInfo,true);
			break;
		case "touchend":
			var evt1 = evt;
			var touchInfo = this.nmeTouchInfo[evt1.changedTouches[0].identifier];
			this.nmeOnTouch(evt1,evt1.changedTouches[0],"touchEnd",touchInfo,true);
			this.nmeTouchInfo[evt1.changedTouches[0].identifier] = null;
			break;
		case "devicemotion":
			var evt1 = evt;
			this.nmeHandleAccelerometer(evt1);
			break;
		case "orientationchange":
			this.nmeHandleOrientationChange();
			break;
		default:
		}
	}
	,nmeIsOnStage: function() {
		return true;
	}
	,nmeDrag: function(point) {
		var p = this.nmeDragObject.parent;
		if(p != null) point = p.globalToLocal(point);
		var x = point.x + this.nmeDragOffsetX;
		var y = point.y + this.nmeDragOffsetY;
		if(this.nmeDragBounds != null) {
			if(x < this.nmeDragBounds.x) x = this.nmeDragBounds.x; else if(x > this.nmeDragBounds.get_right()) x = this.nmeDragBounds.get_right();
			if(y < this.nmeDragBounds.y) y = this.nmeDragBounds.y; else if(y > this.nmeDragBounds.get_bottom()) y = this.nmeDragBounds.get_bottom();
		}
		this.nmeDragObject.set_x(x);
		this.nmeDragObject.set_y(y);
	}
	,nmeCheckInOuts: function(event,stack,touchInfo) {
		var prev = touchInfo == null?this.nmeMouseOverObjects:touchInfo.touchOverObjects;
		var changeEvents = touchInfo == null?flash.display.Stage.nmeMouseChanges:flash.display.Stage.nmeTouchChanges;
		var new_n = stack.length;
		var new_obj = new_n > 0?stack[new_n - 1]:null;
		var old_n = prev.length;
		var old_obj = old_n > 0?prev[old_n - 1]:null;
		if(new_obj != old_obj) {
			if(old_obj != null) old_obj.nmeFireEvent(event.nmeCreateSimilar(changeEvents[0],new_obj,old_obj));
			if(new_obj != null) new_obj.nmeFireEvent(event.nmeCreateSimilar(changeEvents[1],old_obj,new_obj));
			var common = 0;
			while(common < new_n && common < old_n && stack[common] == prev[common]) common++;
			var rollOut = event.nmeCreateSimilar(changeEvents[2],new_obj,old_obj);
			var i = old_n - 1;
			while(i >= common) {
				prev[i].dispatchEvent(rollOut);
				i--;
			}
			var rollOver = event.nmeCreateSimilar(changeEvents[3],old_obj);
			var i1 = new_n - 1;
			while(i1 >= common) {
				stack[i1].dispatchEvent(rollOver);
				i1--;
			}
			if(touchInfo == null) this.nmeMouseOverObjects = stack; else touchInfo.touchOverObjects = stack;
		}
	}
	,invalidate: function() {
		this.nmeInvalid = true;
	}
	,_mouseY: null
	,_mouseX: null
	,nmeWindowHeight: null
	,nmeWindowWidth: null
	,nmeUIEventsQueueIndex: null
	,nmeUIEventsQueue: null
	,nmeTouchInfo: null
	,nmeTimer: null
	,nmeStageMatrix: null
	,nmeStageActive: null
	,nmeShowDefaultContextMenu: null
	,nmeMouseOverObjects: null
	,nmeInvalid: null
	,nmeInterval: null
	,nmeFrameRate: null
	,nmeFocusObjectActivated: null
	,nmeFocusObject: null
	,nmeDragOffsetY: null
	,nmeDragOffsetX: null
	,nmeDragObject: null
	,nmeDragBounds: null
	,nmeBackgroundColour: null
	,stageWidth: null
	,stageHeight: null
	,stageFocusRect: null
	,scaleMode: null
	,quality: null
	,nmePointInPathMode: null
	,fullScreenWidth: null
	,fullScreenHeight: null
	,displayState: null
	,align: null
	,__class__: flash.display.Stage
	,__properties__: $extend(flash.display.DisplayObjectContainer.prototype.__properties__,{set_backgroundColor:"set_backgroundColor",get_backgroundColor:"get_backgroundColor",set_displayState:"set_displayState",get_displayState:"get_displayState",set_focus:"set_focus",get_focus:"get_focus",set_frameRate:"set_frameRate",get_frameRate:"get_frameRate",get_fullScreenHeight:"get_fullScreenHeight",get_fullScreenWidth:"get_fullScreenWidth",set_quality:"set_quality",get_quality:"get_quality",set_showDefaultContextMenu:"set_showDefaultContextMenu",get_showDefaultContextMenu:"get_showDefaultContextMenu",get_stageHeight:"get_stageHeight",get_stageWidth:"get_stageWidth"})
});
flash.display._Stage = {}
flash.display._Stage.TouchInfo = function() {
	this.touchOverObjects = [];
};
$hxClasses["flash.display._Stage.TouchInfo"] = flash.display._Stage.TouchInfo;
flash.display._Stage.TouchInfo.__name__ = ["flash","display","_Stage","TouchInfo"];
flash.display._Stage.TouchInfo.prototype = {
	touchOverObjects: null
	,__class__: flash.display._Stage.TouchInfo
}
flash.display.StageAlign = $hxClasses["flash.display.StageAlign"] = { __ename__ : true, __constructs__ : ["TOP_RIGHT","TOP_LEFT","TOP","RIGHT","LEFT","BOTTOM_RIGHT","BOTTOM_LEFT","BOTTOM"] }
flash.display.StageAlign.TOP_RIGHT = ["TOP_RIGHT",0];
flash.display.StageAlign.TOP_RIGHT.toString = $estr;
flash.display.StageAlign.TOP_RIGHT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.TOP_LEFT = ["TOP_LEFT",1];
flash.display.StageAlign.TOP_LEFT.toString = $estr;
flash.display.StageAlign.TOP_LEFT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.TOP = ["TOP",2];
flash.display.StageAlign.TOP.toString = $estr;
flash.display.StageAlign.TOP.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.RIGHT = ["RIGHT",3];
flash.display.StageAlign.RIGHT.toString = $estr;
flash.display.StageAlign.RIGHT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.LEFT = ["LEFT",4];
flash.display.StageAlign.LEFT.toString = $estr;
flash.display.StageAlign.LEFT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.BOTTOM_RIGHT = ["BOTTOM_RIGHT",5];
flash.display.StageAlign.BOTTOM_RIGHT.toString = $estr;
flash.display.StageAlign.BOTTOM_RIGHT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.BOTTOM_LEFT = ["BOTTOM_LEFT",6];
flash.display.StageAlign.BOTTOM_LEFT.toString = $estr;
flash.display.StageAlign.BOTTOM_LEFT.__enum__ = flash.display.StageAlign;
flash.display.StageAlign.BOTTOM = ["BOTTOM",7];
flash.display.StageAlign.BOTTOM.toString = $estr;
flash.display.StageAlign.BOTTOM.__enum__ = flash.display.StageAlign;
flash.display.StageDisplayState = $hxClasses["flash.display.StageDisplayState"] = { __ename__ : true, __constructs__ : ["NORMAL","FULL_SCREEN","FULL_SCREEN_INTERACTIVE"] }
flash.display.StageDisplayState.NORMAL = ["NORMAL",0];
flash.display.StageDisplayState.NORMAL.toString = $estr;
flash.display.StageDisplayState.NORMAL.__enum__ = flash.display.StageDisplayState;
flash.display.StageDisplayState.FULL_SCREEN = ["FULL_SCREEN",1];
flash.display.StageDisplayState.FULL_SCREEN.toString = $estr;
flash.display.StageDisplayState.FULL_SCREEN.__enum__ = flash.display.StageDisplayState;
flash.display.StageDisplayState.FULL_SCREEN_INTERACTIVE = ["FULL_SCREEN_INTERACTIVE",2];
flash.display.StageDisplayState.FULL_SCREEN_INTERACTIVE.toString = $estr;
flash.display.StageDisplayState.FULL_SCREEN_INTERACTIVE.__enum__ = flash.display.StageDisplayState;
flash.display.StageQuality = function() { }
$hxClasses["flash.display.StageQuality"] = flash.display.StageQuality;
flash.display.StageQuality.__name__ = ["flash","display","StageQuality"];
flash.display.StageScaleMode = $hxClasses["flash.display.StageScaleMode"] = { __ename__ : true, __constructs__ : ["SHOW_ALL","NO_SCALE","NO_BORDER","EXACT_FIT"] }
flash.display.StageScaleMode.SHOW_ALL = ["SHOW_ALL",0];
flash.display.StageScaleMode.SHOW_ALL.toString = $estr;
flash.display.StageScaleMode.SHOW_ALL.__enum__ = flash.display.StageScaleMode;
flash.display.StageScaleMode.NO_SCALE = ["NO_SCALE",1];
flash.display.StageScaleMode.NO_SCALE.toString = $estr;
flash.display.StageScaleMode.NO_SCALE.__enum__ = flash.display.StageScaleMode;
flash.display.StageScaleMode.NO_BORDER = ["NO_BORDER",2];
flash.display.StageScaleMode.NO_BORDER.toString = $estr;
flash.display.StageScaleMode.NO_BORDER.__enum__ = flash.display.StageScaleMode;
flash.display.StageScaleMode.EXACT_FIT = ["EXACT_FIT",3];
flash.display.StageScaleMode.EXACT_FIT.toString = $estr;
flash.display.StageScaleMode.EXACT_FIT.__enum__ = flash.display.StageScaleMode;
flash.errors = {}
flash.errors.Error = function(message,id) {
	if(id == null) id = 0;
	if(message == null) message = "";
	this.message = message;
	this.errorID = id;
};
$hxClasses["flash.errors.Error"] = flash.errors.Error;
flash.errors.Error.__name__ = ["flash","errors","Error"];
flash.errors.Error.prototype = {
	toString: function() {
		if(this.message != null) return this.message; else return "Error";
	}
	,getStackTrace: function() {
		return haxe.CallStack.toString(haxe.CallStack.exceptionStack());
	}
	,name: null
	,message: null
	,errorID: null
	,__class__: flash.errors.Error
}
flash.errors.IOError = function(message) {
	if(message == null) message = "";
	flash.errors.Error.call(this,message);
};
$hxClasses["flash.errors.IOError"] = flash.errors.IOError;
flash.errors.IOError.__name__ = ["flash","errors","IOError"];
flash.errors.IOError.__super__ = flash.errors.Error;
flash.errors.IOError.prototype = $extend(flash.errors.Error.prototype,{
	__class__: flash.errors.IOError
});
flash.events.TextEvent = function(type,bubbles,cancelable,text) {
	if(text == null) text = "";
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.text = text;
};
$hxClasses["flash.events.TextEvent"] = flash.events.TextEvent;
flash.events.TextEvent.__name__ = ["flash","events","TextEvent"];
flash.events.TextEvent.__super__ = flash.events.Event;
flash.events.TextEvent.prototype = $extend(flash.events.Event.prototype,{
	text: null
	,__class__: flash.events.TextEvent
});
flash.events.ErrorEvent = function(type,bubbles,cancelable,text) {
	flash.events.TextEvent.call(this,type,bubbles,cancelable);
	this.text = text;
};
$hxClasses["flash.events.ErrorEvent"] = flash.events.ErrorEvent;
flash.events.ErrorEvent.__name__ = ["flash","events","ErrorEvent"];
flash.events.ErrorEvent.__super__ = flash.events.TextEvent;
flash.events.ErrorEvent.prototype = $extend(flash.events.TextEvent.prototype,{
	__class__: flash.events.ErrorEvent
});
flash.events.Listener = function(inListener,inUseCapture,inPriority) {
	this.mListner = inListener;
	this.mUseCapture = inUseCapture;
	this.mPriority = inPriority;
	this.mID = flash.events.Listener.sIDs++;
};
$hxClasses["flash.events.Listener"] = flash.events.Listener;
flash.events.Listener.__name__ = ["flash","events","Listener"];
flash.events.Listener.prototype = {
	Is: function(inListener,inCapture) {
		return Reflect.compareMethods(this.mListner,inListener) && this.mUseCapture == inCapture;
	}
	,dispatchEvent: function(event) {
		this.mListner(event);
	}
	,mUseCapture: null
	,mPriority: null
	,mListner: null
	,mID: null
	,__class__: flash.events.Listener
}
flash.events.EventPhase = function() { }
$hxClasses["flash.events.EventPhase"] = flash.events.EventPhase;
flash.events.EventPhase.__name__ = ["flash","events","EventPhase"];
flash.events.FocusEvent = function(type,bubbles,cancelable,inObject,inShiftKey,inKeyCode) {
	if(inKeyCode == null) inKeyCode = 0;
	if(inShiftKey == null) inShiftKey = false;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.keyCode = inKeyCode;
	this.shiftKey = inShiftKey == null?false:inShiftKey;
	this.target = inObject;
};
$hxClasses["flash.events.FocusEvent"] = flash.events.FocusEvent;
flash.events.FocusEvent.__name__ = ["flash","events","FocusEvent"];
flash.events.FocusEvent.__super__ = flash.events.Event;
flash.events.FocusEvent.prototype = $extend(flash.events.Event.prototype,{
	shiftKey: null
	,relatedObject: null
	,keyCode: null
	,__class__: flash.events.FocusEvent
});
flash.events.HTTPStatusEvent = function(type,bubbles,cancelable,status) {
	if(status == null) status = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	this.status = status;
	flash.events.Event.call(this,type,bubbles,cancelable);
};
$hxClasses["flash.events.HTTPStatusEvent"] = flash.events.HTTPStatusEvent;
flash.events.HTTPStatusEvent.__name__ = ["flash","events","HTTPStatusEvent"];
flash.events.HTTPStatusEvent.__super__ = flash.events.Event;
flash.events.HTTPStatusEvent.prototype = $extend(flash.events.Event.prototype,{
	status: null
	,responseURL: null
	,responseHeaders: null
	,__class__: flash.events.HTTPStatusEvent
});
flash.events.IOErrorEvent = function(type,bubbles,cancelable,inText) {
	if(inText == null) inText = "";
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.text = inText;
};
$hxClasses["flash.events.IOErrorEvent"] = flash.events.IOErrorEvent;
flash.events.IOErrorEvent.__name__ = ["flash","events","IOErrorEvent"];
flash.events.IOErrorEvent.__super__ = flash.events.Event;
flash.events.IOErrorEvent.prototype = $extend(flash.events.Event.prototype,{
	text: null
	,__class__: flash.events.IOErrorEvent
});
flash.events.KeyboardEvent = function(type,bubbles,cancelable,inCharCode,inKeyCode,inKeyLocation,inCtrlKey,inAltKey,inShiftKey,controlKeyValue,commandKeyValue) {
	if(commandKeyValue == null) commandKeyValue = false;
	if(controlKeyValue == null) controlKeyValue = false;
	if(inShiftKey == null) inShiftKey = false;
	if(inAltKey == null) inAltKey = false;
	if(inCtrlKey == null) inCtrlKey = false;
	if(inKeyLocation == null) inKeyLocation = 0;
	if(inKeyCode == null) inKeyCode = 0;
	if(inCharCode == null) inCharCode = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.altKey = inAltKey == null?false:inAltKey;
	this.charCode = inCharCode == null?0:inCharCode;
	this.ctrlKey = inCtrlKey == null?false:inCtrlKey;
	this.commandKey = commandKeyValue;
	this.controlKey = controlKeyValue;
	this.keyCode = inKeyCode;
	this.keyLocation = inKeyLocation == null?0:inKeyLocation;
	this.shiftKey = inShiftKey == null?false:inShiftKey;
};
$hxClasses["flash.events.KeyboardEvent"] = flash.events.KeyboardEvent;
flash.events.KeyboardEvent.__name__ = ["flash","events","KeyboardEvent"];
flash.events.KeyboardEvent.__super__ = flash.events.Event;
flash.events.KeyboardEvent.prototype = $extend(flash.events.Event.prototype,{
	shiftKey: null
	,keyLocation: null
	,keyCode: null
	,controlKey: null
	,commandKey: null
	,ctrlKey: null
	,charCode: null
	,altKey: null
	,__class__: flash.events.KeyboardEvent
});
flash.events.ProgressEvent = function(type,bubbles,cancelable,bytesLoaded,bytesTotal) {
	if(bytesTotal == null) bytesTotal = 0;
	if(bytesLoaded == null) bytesLoaded = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.bytesLoaded = bytesLoaded;
	this.bytesTotal = bytesTotal;
};
$hxClasses["flash.events.ProgressEvent"] = flash.events.ProgressEvent;
flash.events.ProgressEvent.__name__ = ["flash","events","ProgressEvent"];
flash.events.ProgressEvent.__super__ = flash.events.Event;
flash.events.ProgressEvent.prototype = $extend(flash.events.Event.prototype,{
	bytesTotal: null
	,bytesLoaded: null
	,__class__: flash.events.ProgressEvent
});
flash.events.SecurityErrorEvent = function(type,bubbles,cancelable,text) {
	if(text == null) text = "";
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.ErrorEvent.call(this,type,bubbles,cancelable);
	this.text = text;
};
$hxClasses["flash.events.SecurityErrorEvent"] = flash.events.SecurityErrorEvent;
flash.events.SecurityErrorEvent.__name__ = ["flash","events","SecurityErrorEvent"];
flash.events.SecurityErrorEvent.__super__ = flash.events.ErrorEvent;
flash.events.SecurityErrorEvent.prototype = $extend(flash.events.ErrorEvent.prototype,{
	__class__: flash.events.SecurityErrorEvent
});
flash.events.TouchEvent = function(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta,commandKey,clickCount) {
	if(clickCount == null) clickCount = 0;
	if(commandKey == null) commandKey = false;
	if(delta == null) delta = 0;
	if(buttonDown == null) buttonDown = false;
	if(shiftKey == null) shiftKey = false;
	if(altKey == null) altKey = false;
	if(ctrlKey == null) ctrlKey = false;
	if(localY == null) localY = 0;
	if(localX == null) localX = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = true;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.shiftKey = shiftKey;
	this.altKey = altKey;
	this.ctrlKey = ctrlKey;
	this.bubbles = bubbles;
	this.relatedObject = relatedObject;
	this.delta = delta;
	this.localX = localX;
	this.localY = localY;
	this.buttonDown = buttonDown;
	this.commandKey = commandKey;
	this.touchPointID = 0;
	this.isPrimaryTouchPoint = true;
};
$hxClasses["flash.events.TouchEvent"] = flash.events.TouchEvent;
flash.events.TouchEvent.__name__ = ["flash","events","TouchEvent"];
flash.events.TouchEvent.nmeCreate = function(type,event,touch,local,target) {
	var evt = new flash.events.TouchEvent(type,true,false,local.x,local.y,null,event.ctrlKey,event.altKey,event.shiftKey,false,0,null,0);
	evt.stageX = flash.Lib.get_current().get_stage().get_mouseX();
	evt.stageY = flash.Lib.get_current().get_stage().get_mouseY();
	evt.target = target;
	return evt;
}
flash.events.TouchEvent.__super__ = flash.events.Event;
flash.events.TouchEvent.prototype = $extend(flash.events.Event.prototype,{
	nmeCreateSimilar: function(type,related,targ) {
		var result = new flash.events.TouchEvent(type,this.bubbles,this.cancelable,this.localX,this.localY,related == null?this.relatedObject:related,this.ctrlKey,this.altKey,this.shiftKey,this.buttonDown,this.delta,this.commandKey);
		result.touchPointID = this.touchPointID;
		result.isPrimaryTouchPoint = this.isPrimaryTouchPoint;
		if(targ != null) result.target = targ;
		return result;
	}
	,touchPointID: null
	,stageY: null
	,stageX: null
	,shiftKey: null
	,relatedObject: null
	,localY: null
	,localX: null
	,isPrimaryTouchPoint: null
	,delta: null
	,ctrlKey: null
	,commandKey: null
	,buttonDown: null
	,altKey: null
	,__class__: flash.events.TouchEvent
});
flash.filters = {}
flash.filters.BitmapFilter = function(inType) {
	this._mType = inType;
};
$hxClasses["flash.filters.BitmapFilter"] = flash.filters.BitmapFilter;
flash.filters.BitmapFilter.__name__ = ["flash","filters","BitmapFilter"];
flash.filters.BitmapFilter.prototype = {
	nmeApplyFilter: function(surface,rect,refreshCache) {
		if(refreshCache == null) refreshCache = false;
	}
	,nmePreFilter: function(surface) {
	}
	,clone: function() {
		throw "Implement in subclass. BitmapFilter::clone";
		return null;
	}
	,_nmeCached: null
	,_mType: null
	,__class__: flash.filters.BitmapFilter
}
flash.filters.DropShadowFilter = function(in_distance,in_angle,in_color,in_alpha,in_blurX,in_blurY,in_strength,in_quality,in_inner,in_knockout,in_hideObject) {
	if(in_hideObject == null) in_hideObject = false;
	if(in_knockout == null) in_knockout = false;
	if(in_inner == null) in_inner = false;
	if(in_quality == null) in_quality = 1;
	if(in_strength == null) in_strength = 1.0;
	if(in_blurY == null) in_blurY = 4.0;
	if(in_blurX == null) in_blurX = 4.0;
	if(in_alpha == null) in_alpha = 1.0;
	if(in_color == null) in_color = 0;
	if(in_angle == null) in_angle = 45.0;
	if(in_distance == null) in_distance = 4.0;
	flash.filters.BitmapFilter.call(this,"DropShadowFilter");
	this.distance = in_distance;
	this.angle = in_angle;
	this.color = in_color;
	this.alpha = in_alpha;
	this.blurX = in_blurX;
	this.blurY = in_blurX;
	this.strength = in_strength;
	this.quality = in_quality;
	this.inner = in_inner;
	this.knockout = in_knockout;
	this.hideObject = in_hideObject;
	this._nmeCached = false;
};
$hxClasses["flash.filters.DropShadowFilter"] = flash.filters.DropShadowFilter;
flash.filters.DropShadowFilter.__name__ = ["flash","filters","DropShadowFilter"];
flash.filters.DropShadowFilter.__super__ = flash.filters.BitmapFilter;
flash.filters.DropShadowFilter.prototype = $extend(flash.filters.BitmapFilter.prototype,{
	nmeApplyFilter: function(surface,rect,refreshCache) {
		if(refreshCache == null) refreshCache = false;
		if(!this._nmeCached || refreshCache) {
			var distanceX = this.distance * Math.sin(2 * Math.PI * this.angle / 360.0);
			var distanceY = this.distance * Math.cos(2 * Math.PI * this.angle / 360.0);
			var blurRadius = Math.max(this.blurX,this.blurY);
			var context = surface.getContext("2d");
			context.shadowOffsetX = distanceX;
			context.shadowOffsetY = distanceY;
			context.shadowBlur = blurRadius;
			context.shadowColor = "rgba(" + (this.color >> 16 & 255) + "," + (this.color >> 8 & 255) + "," + (this.color & 255) + "," + this.alpha + ")";
			this._nmeCached = true;
		}
	}
	,clone: function() {
		return new flash.filters.DropShadowFilter(this.distance,this.angle,this.color,this.alpha,this.blurX,this.blurY,this.strength,this.quality,this.inner,this.knockout,this.hideObject);
	}
	,strength: null
	,quality: null
	,knockout: null
	,inner: null
	,hideObject: null
	,distance: null
	,color: null
	,blurY: null
	,blurX: null
	,angle: null
	,alpha: null
	,__class__: flash.filters.DropShadowFilter
});
flash.geom = {}
flash.geom.ColorTransform = function(inRedMultiplier,inGreenMultiplier,inBlueMultiplier,inAlphaMultiplier,inRedOffset,inGreenOffset,inBlueOffset,inAlphaOffset) {
	if(inAlphaOffset == null) inAlphaOffset = 0;
	if(inBlueOffset == null) inBlueOffset = 0;
	if(inGreenOffset == null) inGreenOffset = 0;
	if(inRedOffset == null) inRedOffset = 0;
	if(inAlphaMultiplier == null) inAlphaMultiplier = 1;
	if(inBlueMultiplier == null) inBlueMultiplier = 1;
	if(inGreenMultiplier == null) inGreenMultiplier = 1;
	if(inRedMultiplier == null) inRedMultiplier = 1;
	this.redMultiplier = inRedMultiplier == null?1.0:inRedMultiplier;
	this.greenMultiplier = inGreenMultiplier == null?1.0:inGreenMultiplier;
	this.blueMultiplier = inBlueMultiplier == null?1.0:inBlueMultiplier;
	this.alphaMultiplier = inAlphaMultiplier == null?1.0:inAlphaMultiplier;
	this.redOffset = inRedOffset == null?0.0:inRedOffset;
	this.greenOffset = inGreenOffset == null?0.0:inGreenOffset;
	this.blueOffset = inBlueOffset == null?0.0:inBlueOffset;
	this.alphaOffset = inAlphaOffset == null?0.0:inAlphaOffset;
};
$hxClasses["flash.geom.ColorTransform"] = flash.geom.ColorTransform;
flash.geom.ColorTransform.__name__ = ["flash","geom","ColorTransform"];
flash.geom.ColorTransform.prototype = {
	set_color: function(value) {
		this.redOffset = value >> 16 & 255;
		this.greenOffset = value >> 8 & 255;
		this.blueOffset = value & 255;
		this.redMultiplier = 0;
		this.greenMultiplier = 0;
		this.blueMultiplier = 0;
		return this.get_color();
	}
	,get_color: function() {
		return (this.redOffset | 0) << 16 | (this.greenOffset | 0) << 8 | (this.blueOffset | 0);
	}
	,concat: function(second) {
		this.redMultiplier += second.redMultiplier;
		this.greenMultiplier += second.greenMultiplier;
		this.blueMultiplier += second.blueMultiplier;
		this.alphaMultiplier += second.alphaMultiplier;
	}
	,redOffset: null
	,redMultiplier: null
	,greenOffset: null
	,greenMultiplier: null
	,blueOffset: null
	,blueMultiplier: null
	,alphaOffset: null
	,alphaMultiplier: null
	,__class__: flash.geom.ColorTransform
	,__properties__: {set_color:"set_color",get_color:"get_color"}
}
flash.geom.Matrix = function(in_a,in_b,in_c,in_d,in_tx,in_ty) {
	if(in_ty == null) in_ty = 0;
	if(in_tx == null) in_tx = 0;
	if(in_d == null) in_d = 1;
	if(in_c == null) in_c = 0;
	if(in_b == null) in_b = 0;
	if(in_a == null) in_a = 1;
	this.a = in_a;
	this.b = in_b;
	this.c = in_c;
	this.d = in_d;
	this.set_tx(in_tx);
	this.set_ty(in_ty);
	this._sx = 1.0;
	this._sy = 1.0;
};
$hxClasses["flash.geom.Matrix"] = flash.geom.Matrix;
flash.geom.Matrix.__name__ = ["flash","geom","Matrix"];
flash.geom.Matrix.prototype = {
	set_ty: function(inValue) {
		this.ty = inValue;
		return this.ty;
	}
	,set_tx: function(inValue) {
		this.tx = inValue;
		return this.tx;
	}
	,translate: function(inDX,inDY) {
		var m = new flash.geom.Matrix();
		m.set_tx(inDX);
		m.set_ty(inDY);
		this.concat(m);
	}
	,transformPoint: function(inPos) {
		return new flash.geom.Point(inPos.x * this.a + inPos.y * this.c + this.tx,inPos.x * this.b + inPos.y * this.d + this.ty);
	}
	,toString: function() {
		return "matrix(" + this.a + ", " + this.b + ", " + this.c + ", " + this.d + ", " + this.tx + ", " + this.ty + ")";
	}
	,toMozString: function() {
		return "matrix(" + this.a + ", " + this.b + ", " + this.c + ", " + this.d + ", " + this.tx + "px, " + this.ty + "px)";
	}
	,to3DString: function() {
		return "matrix3d(" + this.a + ", " + this.b + ", " + "0, 0, " + this.c + ", " + this.d + ", " + "0, 0, 0, 0, 1, 0, " + this.tx + ", " + this.ty + ", " + "0, 1" + ")";
	}
	,setRotation: function(inTheta,inScale) {
		if(inScale == null) inScale = 1;
		var scale = inScale;
		this.a = Math.cos(inTheta) * scale;
		this.c = Math.sin(inTheta) * scale;
		this.b = -this.c;
		this.d = this.a;
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,scale: function(inSX,inSY) {
		this._sx = inSX;
		this._sy = inSY;
		this.a *= inSX;
		this.b *= inSY;
		this.c *= inSX;
		this.d *= inSY;
		var _g = this;
		_g.set_tx(_g.tx * inSX);
		var _g = this;
		_g.set_ty(_g.ty * inSY);
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,rotate: function(inTheta) {
		var cos = Math.cos(inTheta);
		var sin = Math.sin(inTheta);
		var a1 = this.a * cos - this.b * sin;
		this.b = this.a * sin + this.b * cos;
		this.a = a1;
		var c1 = this.c * cos - this.d * sin;
		this.d = this.c * sin + this.d * cos;
		this.c = c1;
		var tx1 = this.tx * cos - this.ty * sin;
		this.set_ty(this.tx * sin + this.ty * cos);
		this.set_tx(tx1);
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,nmeTranslateTransformed: function(inPos) {
		this.set_tx(inPos.x * this.a + inPos.y * this.c + this.tx);
		this.set_ty(inPos.x * this.b + inPos.y * this.d + this.ty);
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,nmeTransformY: function(inPos) {
		return inPos.x * this.b + inPos.y * this.d + this.ty;
	}
	,nmeTransformX: function(inPos) {
		return inPos.x * this.a + inPos.y * this.c + this.tx;
	}
	,mult: function(m) {
		var result = this.clone();
		result.concat(m);
		return result;
	}
	,invert: function() {
		var norm = this.a * this.d - this.b * this.c;
		if(norm == 0) {
			this.a = this.b = this.c = this.d = 0;
			this.set_tx(-this.tx);
			this.set_ty(-this.ty);
		} else {
			norm = 1.0 / norm;
			var a1 = this.d * norm;
			this.d = this.a * norm;
			this.a = a1;
			this.b *= -norm;
			this.c *= -norm;
			var tx1 = -this.a * this.tx - this.c * this.ty;
			this.set_ty(-this.b * this.tx - this.d * this.ty);
			this.set_tx(tx1);
		}
		this._sx /= this._sx;
		this._sy /= this._sy;
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
		return this;
	}
	,identity: function() {
		this.a = 1;
		this.b = 0;
		this.c = 0;
		this.d = 1;
		this.set_tx(0);
		this.set_ty(0);
		this._sx = 1.0;
		this._sy = 1.0;
	}
	,createGradientBox: function(in_width,in_height,rotation,in_tx,in_ty) {
		if(in_ty == null) in_ty = 0;
		if(in_tx == null) in_tx = 0;
		if(rotation == null) rotation = 0;
		this.a = in_width / 1638.4;
		this.d = in_height / 1638.4;
		if(rotation != null && rotation != 0.0) {
			var cos = Math.cos(rotation);
			var sin = Math.sin(rotation);
			this.b = sin * this.d;
			this.c = -sin * this.a;
			this.a *= cos;
			this.d *= cos;
		} else {
			this.b = 0;
			this.c = 0;
		}
		this.set_tx(in_tx != null?in_tx + in_width / 2:in_width / 2);
		this.set_ty(in_ty != null?in_ty + in_height / 2:in_height / 2);
	}
	,copy: function(m) {
		this.a = m.a;
		this.b = m.b;
		this.c = m.c;
		this.d = m.d;
		this.set_tx(m.tx);
		this.set_ty(m.ty);
		this._sx = m._sx;
		this._sy = m._sy;
	}
	,concat: function(m) {
		var a1 = this.a * m.a + this.b * m.c;
		this.b = this.a * m.b + this.b * m.d;
		this.a = a1;
		var c1 = this.c * m.a + this.d * m.c;
		this.d = this.c * m.b + this.d * m.d;
		this.c = c1;
		var tx1 = this.tx * m.a + this.ty * m.c + m.tx;
		this.set_ty(this.tx * m.b + this.ty * m.d + m.ty);
		this.set_tx(tx1);
		this._sx *= m._sx;
		this._sy *= m._sy;
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,clone: function() {
		var m = new flash.geom.Matrix(this.a,this.b,this.c,this.d,this.tx,this.ty);
		m._sx = this._sx;
		m._sy = this._sy;
		return m;
	}
	,cleanValues: function() {
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,_sy: null
	,_sx: null
	,ty: null
	,tx: null
	,d: null
	,c: null
	,b: null
	,a: null
	,__class__: flash.geom.Matrix
	,__properties__: {set_tx:"set_tx",set_ty:"set_ty"}
}
flash.geom.Point = function(inX,inY) {
	if(inY == null) inY = 0;
	if(inX == null) inX = 0;
	this.x = inX;
	this.y = inY;
};
$hxClasses["flash.geom.Point"] = flash.geom.Point;
flash.geom.Point.__name__ = ["flash","geom","Point"];
flash.geom.Point.distance = function(pt1,pt2) {
	var dx = pt1.x - pt2.x;
	var dy = pt1.y - pt2.y;
	return Math.sqrt(dx * dx + dy * dy);
}
flash.geom.Point.interpolate = function(pt1,pt2,f) {
	return new flash.geom.Point(pt2.x + f * (pt1.x - pt2.x),pt2.y + f * (pt1.y - pt2.y));
}
flash.geom.Point.polar = function(len,angle) {
	return new flash.geom.Point(len * Math.cos(angle),len * Math.sin(angle));
}
flash.geom.Point.prototype = {
	get_length: function() {
		return Math.sqrt(this.x * this.x + this.y * this.y);
	}
	,subtract: function(v) {
		return new flash.geom.Point(this.x - v.x,this.y - v.y);
	}
	,offset: function(dx,dy) {
		this.x += dx;
		this.y += dy;
	}
	,normalize: function(thickness) {
		if(this.x == 0 && this.y == 0) return; else {
			var norm = thickness / Math.sqrt(this.x * this.x + this.y * this.y);
			this.x *= norm;
			this.y *= norm;
		}
	}
	,equals: function(toCompare) {
		return toCompare.x == this.x && toCompare.y == this.y;
	}
	,clone: function() {
		return new flash.geom.Point(this.x,this.y);
	}
	,add: function(v) {
		return new flash.geom.Point(v.x + this.x,v.y + this.y);
	}
	,y: null
	,x: null
	,length: null
	,__class__: flash.geom.Point
	,__properties__: {get_length:"get_length"}
}
flash.geom.Rectangle = function(inX,inY,inWidth,inHeight) {
	if(inHeight == null) inHeight = 0;
	if(inWidth == null) inWidth = 0;
	if(inY == null) inY = 0;
	if(inX == null) inX = 0;
	this.x = inX;
	this.y = inY;
	this.width = inWidth;
	this.height = inHeight;
};
$hxClasses["flash.geom.Rectangle"] = flash.geom.Rectangle;
flash.geom.Rectangle.__name__ = ["flash","geom","Rectangle"];
flash.geom.Rectangle.prototype = {
	set_topLeft: function(p) {
		this.x = p.x;
		this.y = p.y;
		return p.clone();
	}
	,get_topLeft: function() {
		return new flash.geom.Point(this.x,this.y);
	}
	,set_top: function(t) {
		this.height -= t - this.y;
		this.y = t;
		return t;
	}
	,get_top: function() {
		return this.y;
	}
	,set_size: function(p) {
		this.width = p.x;
		this.height = p.y;
		return p.clone();
	}
	,get_size: function() {
		return new flash.geom.Point(this.width,this.height);
	}
	,set_right: function(r) {
		this.width = r - this.x;
		return r;
	}
	,get_right: function() {
		return this.x + this.width;
	}
	,set_left: function(l) {
		this.width -= l - this.x;
		this.x = l;
		return l;
	}
	,get_left: function() {
		return this.x;
	}
	,set_bottomRight: function(p) {
		this.width = p.x - this.x;
		this.height = p.y - this.y;
		return p.clone();
	}
	,get_bottomRight: function() {
		return new flash.geom.Point(this.x + this.width,this.y + this.height);
	}
	,set_bottom: function(b) {
		this.height = b - this.y;
		return b;
	}
	,get_bottom: function() {
		return this.y + this.height;
	}
	,union: function(toUnion) {
		var x0 = this.x > toUnion.x?toUnion.x:this.x;
		var x1 = this.get_right() < toUnion.get_right()?toUnion.get_right():this.get_right();
		var y0 = this.y > toUnion.y?toUnion.y:this.y;
		var y1 = this.get_bottom() < toUnion.get_bottom()?toUnion.get_bottom():this.get_bottom();
		return new flash.geom.Rectangle(x0,y0,x1 - x0,y1 - y0);
	}
	,transform: function(m) {
		var tx0 = m.a * this.x + m.c * this.y;
		var tx1 = tx0;
		var ty0 = m.b * this.x + m.d * this.y;
		var ty1 = tx0;
		var tx = m.a * (this.x + this.width) + m.c * this.y;
		var ty = m.b * (this.x + this.width) + m.d * this.y;
		if(tx < tx0) tx0 = tx;
		if(ty < ty0) ty0 = ty;
		if(tx > tx1) tx1 = tx;
		if(ty > ty1) ty1 = ty;
		tx = m.a * (this.x + this.width) + m.c * (this.y + this.height);
		ty = m.b * (this.x + this.width) + m.d * (this.y + this.height);
		if(tx < tx0) tx0 = tx;
		if(ty < ty0) ty0 = ty;
		if(tx > tx1) tx1 = tx;
		if(ty > ty1) ty1 = ty;
		tx = m.a * this.x + m.c * (this.y + this.height);
		ty = m.b * this.x + m.d * (this.y + this.height);
		if(tx < tx0) tx0 = tx;
		if(ty < ty0) ty0 = ty;
		if(tx > tx1) tx1 = tx;
		if(ty > ty1) ty1 = ty;
		return new flash.geom.Rectangle(tx0 + m.tx,ty0 + m.ty,tx1 - tx0,ty1 - ty0);
	}
	,setEmpty: function() {
		this.x = this.y = this.width = this.height = 0;
	}
	,offsetPoint: function(point) {
		this.x += point.x;
		this.y += point.y;
	}
	,offset: function(dx,dy) {
		this.x += dx;
		this.y += dy;
	}
	,isEmpty: function() {
		return this.width <= 0 || this.height <= 0;
	}
	,intersects: function(toIntersect) {
		var x0 = this.x < toIntersect.x?toIntersect.x:this.x;
		var x1 = this.get_right() > toIntersect.get_right()?toIntersect.get_right():this.get_right();
		if(x1 <= x0) return false;
		var y0 = this.y < toIntersect.y?toIntersect.y:this.y;
		var y1 = this.get_bottom() > toIntersect.get_bottom()?toIntersect.get_bottom():this.get_bottom();
		return y1 > y0;
	}
	,intersection: function(toIntersect) {
		var x0 = this.x < toIntersect.x?toIntersect.x:this.x;
		var x1 = this.get_right() > toIntersect.get_right()?toIntersect.get_right():this.get_right();
		if(x1 <= x0) return new flash.geom.Rectangle();
		var y0 = this.y < toIntersect.y?toIntersect.y:this.y;
		var y1 = this.get_bottom() > toIntersect.get_bottom()?toIntersect.get_bottom():this.get_bottom();
		if(y1 <= y0) return new flash.geom.Rectangle();
		return new flash.geom.Rectangle(x0,y0,x1 - x0,y1 - y0);
	}
	,inflatePoint: function(point) {
		this.inflate(point.x,point.y);
	}
	,inflate: function(dx,dy) {
		this.x -= dx;
		this.width += dx * 2;
		this.y -= dy;
		this.height += dy * 2;
	}
	,extendBounds: function(r) {
		var dx = this.x - r.x;
		if(dx > 0) {
			this.x -= dx;
			this.width += dx;
		}
		var dy = this.y - r.y;
		if(dy > 0) {
			this.y -= dy;
			this.height += dy;
		}
		if(r.get_right() > this.get_right()) this.set_right(r.get_right());
		if(r.get_bottom() > this.get_bottom()) this.set_bottom(r.get_bottom());
	}
	,equals: function(toCompare) {
		return this.x == toCompare.x && this.y == toCompare.y && this.width == toCompare.width && this.height == toCompare.height;
	}
	,containsRect: function(rect) {
		if(rect.width <= 0 || rect.height <= 0) return rect.x > this.x && rect.y > this.y && rect.get_right() < this.get_right() && rect.get_bottom() < this.get_bottom(); else return rect.x >= this.x && rect.y >= this.y && rect.get_right() <= this.get_right() && rect.get_bottom() <= this.get_bottom();
	}
	,containsPoint: function(point) {
		return this.contains(point.x,point.y);
	}
	,contains: function(inX,inY) {
		return inX >= this.x && inY >= this.y && inX < this.get_right() && inY < this.get_bottom();
	}
	,clone: function() {
		return new flash.geom.Rectangle(this.x,this.y,this.width,this.height);
	}
	,y: null
	,x: null
	,width: null
	,height: null
	,__class__: flash.geom.Rectangle
	,__properties__: {set_bottom:"set_bottom",get_bottom:"get_bottom",set_bottomRight:"set_bottomRight",get_bottomRight:"get_bottomRight",set_left:"set_left",get_left:"get_left",set_right:"set_right",get_right:"get_right",set_size:"set_size",get_size:"get_size",set_top:"set_top",get_top:"get_top",set_topLeft:"set_topLeft",get_topLeft:"get_topLeft"}
}
flash.geom.Transform = function(displayObject) {
	if(displayObject == null) throw "Cannot create Transform with no DisplayObject.";
	this._displayObject = displayObject;
	this._matrix = new flash.geom.Matrix();
	this._fullMatrix = new flash.geom.Matrix();
	this.set_colorTransform(new flash.geom.ColorTransform());
};
$hxClasses["flash.geom.Transform"] = flash.geom.Transform;
flash.geom.Transform.__name__ = ["flash","geom","Transform"];
flash.geom.Transform.prototype = {
	get_pixelBounds: function() {
		return this._displayObject.getBounds(null);
	}
	,set_matrix: function(inValue) {
		this._matrix.copy(inValue);
		this._displayObject.nmeMatrixOverridden();
		return this._matrix;
	}
	,get_matrix: function() {
		return this._matrix.clone();
	}
	,get_concatenatedMatrix: function() {
		return this.nmeGetFullMatrix(this._matrix);
	}
	,set_colorTransform: function(inValue) {
		this.colorTransform = inValue;
		return inValue;
	}
	,nmeSetMatrix: function(inValue) {
		this._matrix.copy(inValue);
	}
	,nmeSetFullMatrix: function(inValue) {
		this._fullMatrix.copy(inValue);
		return this._fullMatrix;
	}
	,nmeGetFullMatrix: function(localMatrix) {
		var m;
		if(localMatrix != null) m = localMatrix.mult(this._fullMatrix); else m = this._fullMatrix.clone();
		return m;
	}
	,_matrix: null
	,_fullMatrix: null
	,_displayObject: null
	,concatenatedMatrix: null
	,colorTransform: null
	,__class__: flash.geom.Transform
	,__properties__: {set_colorTransform:"set_colorTransform",get_concatenatedMatrix:"get_concatenatedMatrix",set_matrix:"set_matrix",get_matrix:"get_matrix",get_pixelBounds:"get_pixelBounds"}
}
flash.media = {}
flash.media.Sound = function(stream,context) {
	flash.events.EventDispatcher.call(this,this);
	this.bytesLoaded = 0;
	this.bytesTotal = 0;
	this.id3 = null;
	this.isBuffering = false;
	this.length = 0;
	this.url = null;
	this.nmeSoundChannels = new haxe.ds.IntMap();
	this.nmeSoundIdx = 0;
	if(stream != null) this.load(stream,context);
};
$hxClasses["flash.media.Sound"] = flash.media.Sound;
flash.media.Sound.__name__ = ["flash","media","Sound"];
flash.media.Sound.nmeCanPlayMime = function(mime) {
	var audio = js.Browser.document.createElement("audio");
	var playable = function(ok) {
		if(ok != "" && ok != "no") return true; else return false;
	};
	return playable(audio.canPlayType(mime,null));
}
flash.media.Sound.nmeCanPlayType = function(extension) {
	var mime = flash.media.Sound.nmeMimeForExtension(extension);
	if(mime == null) return false;
	return flash.media.Sound.nmeCanPlayMime(mime);
}
flash.media.Sound.nmeMimeForExtension = function(extension) {
	var mime = null;
	switch(extension) {
	case "mp3":
		mime = "audio/mpeg";
		break;
	case "ogg":
		mime = "audio/ogg; codecs=\"vorbis\"";
		break;
	case "wav":
		mime = "audio/wav; codecs=\"1\"";
		break;
	case "aac":
		mime = "audio/mp4; codecs=\"mp4a.40.2\"";
		break;
	default:
		mime = null;
	}
	return mime;
}
flash.media.Sound.__super__ = flash.events.EventDispatcher;
flash.media.Sound.prototype = $extend(flash.events.EventDispatcher.prototype,{
	nmeOnSoundLoaded: function(evt) {
		this.nmeRemoveEventListeners();
		var evt1 = new flash.events.Event(flash.events.Event.COMPLETE);
		this.dispatchEvent(evt1);
	}
	,nmeOnSoundLoadError: function(evt) {
		this.nmeRemoveEventListeners();
		var evt1 = new flash.events.IOErrorEvent(flash.events.IOErrorEvent.IO_ERROR);
		this.dispatchEvent(evt1);
	}
	,play: function(startTime,loops,sndTransform) {
		if(loops == null) loops = 0;
		if(startTime == null) startTime = 0.0;
		if(this.nmeStreamUrl == null) return null;
		var self = this;
		var curIdx = this.nmeSoundIdx;
		var removeRef = function() {
			self.nmeSoundChannels.remove(curIdx);
		};
		var channel = flash.media.SoundChannel.nmeCreate(this.nmeStreamUrl,startTime,loops,sndTransform,removeRef);
		this.nmeSoundChannels.set(curIdx,channel);
		this.nmeSoundIdx++;
		var audio = channel.nmeAudio;
		return channel;
	}
	,nmeRemoveEventListeners: function() {
		this.nmeSoundCache.removeEventListener(flash.events.Event.COMPLETE,$bind(this,this.nmeOnSoundLoaded),false);
		this.nmeSoundCache.removeEventListener(flash.events.IOErrorEvent.IO_ERROR,$bind(this,this.nmeOnSoundLoadError),false);
	}
	,nmeLoad: function(stream,context,mime) {
		if(mime == null) mime = "";
		this.nmeStreamUrl = stream.url;
		try {
			this.nmeSoundCache = new flash.net.URLLoader();
			this.nmeAddEventListeners();
			this.nmeSoundCache.load(stream);
		} catch( e ) {
		}
	}
	,nmeAddEventListeners: function() {
		this.nmeSoundCache.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.nmeOnSoundLoaded));
		this.nmeSoundCache.addEventListener(flash.events.IOErrorEvent.IO_ERROR,$bind(this,this.nmeOnSoundLoadError));
	}
	,load: function(stream,context) {
		this.nmeLoad(stream,context);
	}
	,close: function() {
	}
	,nmeStreamUrl: null
	,nmeSoundIdx: null
	,nmeSoundChannels: null
	,nmeSoundCache: null
	,url: null
	,length: null
	,isBuffering: null
	,id3: null
	,bytesTotal: null
	,bytesLoaded: null
	,__class__: flash.media.Sound
});
flash.media.SoundChannel = function() {
	flash.events.EventDispatcher.call(this,this);
	this.ChannelId = -1;
	this.leftPeak = 0.;
	this.position = 0.;
	this.rightPeak = 0.;
	this.nmeAudioCurrentLoop = 1;
	this.nmeAudioTotalLoops = 1;
};
$hxClasses["flash.media.SoundChannel"] = flash.media.SoundChannel;
flash.media.SoundChannel.__name__ = ["flash","media","SoundChannel"];
flash.media.SoundChannel.nmeCreate = function(src,startTime,loops,sndTransform,removeRef) {
	if(loops == null) loops = 0;
	if(startTime == null) startTime = 0.0;
	var channel = new flash.media.SoundChannel();
	channel.nmeAudio = js.Browser.document.createElement("audio");
	channel.nmeRemoveRef = removeRef;
	channel.nmeAudio.addEventListener("ended",$bind(channel,channel.__onSoundChannelFinished),false);
	channel.nmeAudio.addEventListener("seeked",$bind(channel,channel.__onSoundSeeked),false);
	channel.nmeAudio.addEventListener("stalled",$bind(channel,channel.__onStalled),false);
	channel.nmeAudio.addEventListener("progress",$bind(channel,channel.__onProgress),false);
	if(loops > 0) {
		channel.nmeAudioTotalLoops = loops;
		channel.nmeAudio.loop = true;
	}
	channel.nmeStartTime = startTime;
	if(startTime > 0.) {
		var onLoad = null;
		onLoad = function(_) {
			channel.nmeAudio.currentTime = channel.nmeStartTime;
			channel.nmeAudio.play();
			channel.nmeAudio.removeEventListener("canplaythrough",onLoad,false);
		};
		channel.nmeAudio.addEventListener("canplaythrough",onLoad,false);
	} else channel.nmeAudio.autoplay = true;
	channel.nmeAudio.src = src;
	return channel;
}
flash.media.SoundChannel.__super__ = flash.events.EventDispatcher;
flash.media.SoundChannel.prototype = $extend(flash.events.EventDispatcher.prototype,{
	set_soundTransform: function(v) {
		this.nmeAudio.volume = v.volume;
		return this.soundTransform = v;
	}
	,__onStalled: function(evt) {
		if(this.nmeAudio != null) this.nmeAudio.load();
	}
	,__onSoundSeeked: function(evt) {
		if(this.nmeAudioCurrentLoop >= this.nmeAudioTotalLoops) {
			this.nmeAudio.loop = false;
			this.stop();
		} else this.nmeAudioCurrentLoop++;
	}
	,__onSoundChannelFinished: function(evt) {
		if(this.nmeAudioCurrentLoop >= this.nmeAudioTotalLoops) {
			this.nmeAudio.removeEventListener("ended",$bind(this,this.__onSoundChannelFinished),false);
			this.nmeAudio.removeEventListener("seeked",$bind(this,this.__onSoundSeeked),false);
			this.nmeAudio.removeEventListener("stalled",$bind(this,this.__onStalled),false);
			this.nmeAudio.removeEventListener("progress",$bind(this,this.__onProgress),false);
			this.nmeAudio = null;
			var evt1 = new flash.events.Event(flash.events.Event.COMPLETE);
			evt1.target = this;
			this.dispatchEvent(evt1);
			if(this.nmeRemoveRef != null) this.nmeRemoveRef();
		} else {
			this.nmeAudio.currentTime = this.nmeStartTime;
			this.nmeAudio.play();
		}
	}
	,__onProgress: function(evt) {
	}
	,stop: function() {
		if(this.nmeAudio != null) {
			this.nmeAudio.pause();
			this.nmeAudio = null;
			if(this.nmeRemoveRef != null) this.nmeRemoveRef();
		}
	}
	,nmeStartTime: null
	,nmeRemoveRef: null
	,nmeAudioTotalLoops: null
	,nmeAudioCurrentLoop: null
	,soundTransform: null
	,rightPeak: null
	,position: null
	,nmeAudio: null
	,leftPeak: null
	,ChannelId: null
	,__class__: flash.media.SoundChannel
	,__properties__: {set_soundTransform:"set_soundTransform"}
});
flash.media.SoundLoaderContext = function(bufferTime,checkPolicyFile) {
	if(checkPolicyFile == null) checkPolicyFile = false;
	if(bufferTime == null) bufferTime = 0;
	this.bufferTime = bufferTime;
	this.checkPolicyFile = checkPolicyFile;
};
$hxClasses["flash.media.SoundLoaderContext"] = flash.media.SoundLoaderContext;
flash.media.SoundLoaderContext.__name__ = ["flash","media","SoundLoaderContext"];
flash.media.SoundLoaderContext.prototype = {
	checkPolicyFile: null
	,bufferTime: null
	,__class__: flash.media.SoundLoaderContext
}
flash.media.SoundTransform = function(vol,panning) {
	if(panning == null) panning = 0;
	if(vol == null) vol = 1;
};
$hxClasses["flash.media.SoundTransform"] = flash.media.SoundTransform;
flash.media.SoundTransform.__name__ = ["flash","media","SoundTransform"];
flash.media.SoundTransform.prototype = {
	volume: null
	,rightToRight: null
	,rightToLeft: null
	,pan: null
	,leftToRight: null
	,leftToLeft: null
	,__class__: flash.media.SoundTransform
}
flash.net = {}
flash.net.URLLoader = function(request) {
	flash.events.EventDispatcher.call(this);
	this.bytesLoaded = 0;
	this.bytesTotal = 0;
	this.set_dataFormat(flash.net.URLLoaderDataFormat.TEXT);
	if(request != null) this.load(request);
};
$hxClasses["flash.net.URLLoader"] = flash.net.URLLoader;
flash.net.URLLoader.__name__ = ["flash","net","URLLoader"];
flash.net.URLLoader.__super__ = flash.events.EventDispatcher;
flash.net.URLLoader.prototype = $extend(flash.events.EventDispatcher.prototype,{
	onStatus: function(status) {
		var evt = new flash.events.HTTPStatusEvent(flash.events.HTTPStatusEvent.HTTP_STATUS,false,false,status);
		evt.currentTarget = this;
		this.dispatchEvent(evt);
	}
	,onSecurityError: function(msg) {
		var evt = new flash.events.SecurityErrorEvent(flash.events.SecurityErrorEvent.SECURITY_ERROR);
		evt.text = msg;
		evt.currentTarget = this;
		this.dispatchEvent(evt);
	}
	,onProgress: function(event) {
		var evt = new flash.events.ProgressEvent(flash.events.ProgressEvent.PROGRESS);
		evt.currentTarget = this;
		evt.bytesLoaded = event.loaded;
		evt.bytesTotal = event.total;
		this.dispatchEvent(evt);
	}
	,onOpen: function() {
		var evt = new flash.events.Event(flash.events.Event.OPEN);
		evt.currentTarget = this;
		this.dispatchEvent(evt);
	}
	,onError: function(msg) {
		var evt = new flash.events.IOErrorEvent(flash.events.IOErrorEvent.IO_ERROR);
		evt.text = msg;
		evt.currentTarget = this;
		this.dispatchEvent(evt);
	}
	,onData: function(_) {
		var content = this.getData();
		var _g = this;
		switch( (_g.dataFormat)[1] ) {
		case 0:
			this.data = flash.utils.ByteArray.nmeOfBuffer(content);
			break;
		default:
			this.data = Std.string(content);
		}
		var evt = new flash.events.Event(flash.events.Event.COMPLETE);
		evt.currentTarget = this;
		this.dispatchEvent(evt);
	}
	,requestUrl: function(url,method,data,requestHeaders) {
		var xmlHttpRequest = new XMLHttpRequest();
		this.registerEvents(xmlHttpRequest);
		var uri = "";
		if(js.Boot.__instanceof(data,flash.utils.ByteArray)) {
			var data1 = data;
			var _g = this;
			switch( (_g.dataFormat)[1] ) {
			case 0:
				uri = data1.data.buffer;
				break;
			default:
				uri = data1.readUTFBytes(data1.length);
			}
		} else if(js.Boot.__instanceof(data,flash.net.URLVariables)) {
			var data1 = data;
			var _g = 0, _g1 = Reflect.fields(data1);
			while(_g < _g1.length) {
				var p = _g1[_g];
				++_g;
				if(uri.length != 0) uri += "&";
				uri += StringTools.urlEncode(p) + "=" + StringTools.urlEncode(Reflect.field(data1,p));
			}
		} else if(data != null) uri = data.toString();
		try {
			if(method == "GET" && uri != null && uri != "") {
				var question = url.split("?").length <= 1;
				xmlHttpRequest.open(method,url + (question?"?":"&") + Std.string(uri),true);
				uri = "";
			} else xmlHttpRequest.open(method,url,true);
		} catch( e ) {
			this.onError(e.toString());
			return;
		}
		var _g = this;
		switch( (_g.dataFormat)[1] ) {
		case 0:
			xmlHttpRequest.responseType = "arraybuffer";
			break;
		default:
		}
		var _g1 = 0;
		while(_g1 < requestHeaders.length) {
			var header = requestHeaders[_g1];
			++_g1;
			xmlHttpRequest.setRequestHeader(header.name,header.value);
		}
		xmlHttpRequest.send(uri);
		this.onOpen();
		this.getData = function() {
			if(xmlHttpRequest.response != null) return xmlHttpRequest.response; else return xmlHttpRequest.responseText;
		};
	}
	,registerEvents: function(subject) {
		var self = this;
		if(typeof XMLHttpRequestProgressEvent != "undefined") subject.addEventListener("progress",$bind(this,this.onProgress),false);
		subject.onreadystatechange = function() {
			if(subject.readyState != 4) return;
			var s = (function($this) {
				var $r;
				try {
					$r = subject.status;
				} catch( e ) {
					$r = null;
				}
				return $r;
			}(this));
			if(s == undefined) s = null;
			if(s != null) self.onStatus(s);
			if(s != null && s >= 200 && s < 400) self.onData(subject.response); else if(s == null) self.onError("Failed to connect or resolve host"); else if(s == 12029) self.onError("Failed to connect to host"); else if(s == 12007) self.onError("Unknown host"); else if(s == 0) {
				self.onError("Unable to make request (may be blocked due to cross-domain permissions)");
				self.onSecurityError("Unable to make request (may be blocked due to cross-domain permissions)");
			} else self.onError("Http Error #" + subject.status);
		};
	}
	,load: function(request) {
		this.requestUrl(request.url,request.method,request.data,request.formatRequestHeaders());
	}
	,getData: function() {
		return null;
	}
	,close: function() {
	}
	,set_dataFormat: function(inputVal) {
		if(inputVal == flash.net.URLLoaderDataFormat.BINARY && !Reflect.hasField(js.Browser.window,"ArrayBuffer")) this.dataFormat = flash.net.URLLoaderDataFormat.TEXT; else this.dataFormat = inputVal;
		return this.dataFormat;
	}
	,dataFormat: null
	,data: null
	,bytesTotal: null
	,bytesLoaded: null
	,__class__: flash.net.URLLoader
	,__properties__: {set_dataFormat:"set_dataFormat"}
});
flash.net.URLLoaderDataFormat = $hxClasses["flash.net.URLLoaderDataFormat"] = { __ename__ : true, __constructs__ : ["BINARY","TEXT","VARIABLES"] }
flash.net.URLLoaderDataFormat.BINARY = ["BINARY",0];
flash.net.URLLoaderDataFormat.BINARY.toString = $estr;
flash.net.URLLoaderDataFormat.BINARY.__enum__ = flash.net.URLLoaderDataFormat;
flash.net.URLLoaderDataFormat.TEXT = ["TEXT",1];
flash.net.URLLoaderDataFormat.TEXT.toString = $estr;
flash.net.URLLoaderDataFormat.TEXT.__enum__ = flash.net.URLLoaderDataFormat;
flash.net.URLLoaderDataFormat.VARIABLES = ["VARIABLES",2];
flash.net.URLLoaderDataFormat.VARIABLES.toString = $estr;
flash.net.URLLoaderDataFormat.VARIABLES.__enum__ = flash.net.URLLoaderDataFormat;
flash.net.URLRequest = function(inURL) {
	if(inURL != null) this.url = inURL;
	this.requestHeaders = [];
	this.method = flash.net.URLRequestMethod.GET;
	this.contentType = null;
};
$hxClasses["flash.net.URLRequest"] = flash.net.URLRequest;
flash.net.URLRequest.__name__ = ["flash","net","URLRequest"];
flash.net.URLRequest.prototype = {
	formatRequestHeaders: function() {
		var res = this.requestHeaders;
		if(res == null) res = [];
		if(this.method == flash.net.URLRequestMethod.GET || this.data == null) return res;
		if(js.Boot.__instanceof(this.data,String) || js.Boot.__instanceof(this.data,flash.utils.ByteArray)) {
			res = res.slice();
			res.push(new flash.net.URLRequestHeader("Content-Type",this.contentType != null?this.contentType:"application/x-www-form-urlencoded"));
		}
		return res;
	}
	,url: null
	,requestHeaders: null
	,method: null
	,data: null
	,contentType: null
	,__class__: flash.net.URLRequest
}
flash.net.URLRequestHeader = function(name,value) {
	if(value == null) value = "";
	if(name == null) name = "";
	this.name = name;
	this.value = value;
};
$hxClasses["flash.net.URLRequestHeader"] = flash.net.URLRequestHeader;
flash.net.URLRequestHeader.__name__ = ["flash","net","URLRequestHeader"];
flash.net.URLRequestHeader.prototype = {
	value: null
	,name: null
	,__class__: flash.net.URLRequestHeader
}
flash.net.URLRequestMethod = function() { }
$hxClasses["flash.net.URLRequestMethod"] = flash.net.URLRequestMethod;
flash.net.URLRequestMethod.__name__ = ["flash","net","URLRequestMethod"];
flash.net.URLVariables = function(inEncoded) {
	if(inEncoded != null) this.decode(inEncoded);
};
$hxClasses["flash.net.URLVariables"] = flash.net.URLVariables;
flash.net.URLVariables.__name__ = ["flash","net","URLVariables"];
flash.net.URLVariables.prototype = {
	toString: function() {
		var result = new Array();
		var fields = Reflect.fields(this);
		var _g = 0;
		while(_g < fields.length) {
			var f = fields[_g];
			++_g;
			result.push(StringTools.urlEncode(f) + "=" + StringTools.urlEncode(Reflect.field(this,f)));
		}
		return result.join("&");
	}
	,decode: function(inVars) {
		var fields = Reflect.fields(this);
		var _g = 0;
		while(_g < fields.length) {
			var f = fields[_g];
			++_g;
			Reflect.deleteField(this,f);
		}
		var fields1 = inVars.split(";").join("&").split("&");
		var _g = 0;
		while(_g < fields1.length) {
			var f = fields1[_g];
			++_g;
			var eq = f.indexOf("=");
			if(eq > 0) this[StringTools.urlDecode(HxOverrides.substr(f,0,eq))] = StringTools.urlDecode(HxOverrides.substr(f,eq + 1,null)); else if(eq != 0) this[StringTools.urlDecode(f)] = "";
		}
	}
	,__class__: flash.net.URLVariables
}
flash.system = {}
flash.system.ApplicationDomain = function(parentDomain) {
	if(parentDomain != null) this.parentDomain = parentDomain; else this.parentDomain = flash.system.ApplicationDomain.currentDomain;
};
$hxClasses["flash.system.ApplicationDomain"] = flash.system.ApplicationDomain;
flash.system.ApplicationDomain.__name__ = ["flash","system","ApplicationDomain"];
flash.system.ApplicationDomain.prototype = {
	hasDefinition: function(name) {
		return Type.resolveClass(name) != null;
	}
	,getDefinition: function(name) {
		return Type.resolveClass(name);
	}
	,parentDomain: null
	,__class__: flash.system.ApplicationDomain
}
flash.system.LoaderContext = function(checkPolicyFile,applicationDomain,securityDomain) {
	if(checkPolicyFile == null) checkPolicyFile = false;
	this.checkPolicyFile = checkPolicyFile;
	this.securityDomain = securityDomain;
	if(applicationDomain != null) this.applicationDomain = applicationDomain; else this.applicationDomain = flash.system.ApplicationDomain.currentDomain;
};
$hxClasses["flash.system.LoaderContext"] = flash.system.LoaderContext;
flash.system.LoaderContext.__name__ = ["flash","system","LoaderContext"];
flash.system.LoaderContext.prototype = {
	securityDomain: null
	,checkPolicyFile: null
	,applicationDomain: null
	,allowLoadBytesCodeExecution: null
	,allowCodeImport: null
	,__class__: flash.system.LoaderContext
}
flash.system.SecurityDomain = function() {
};
$hxClasses["flash.system.SecurityDomain"] = flash.system.SecurityDomain;
flash.system.SecurityDomain.__name__ = ["flash","system","SecurityDomain"];
flash.system.SecurityDomain.prototype = {
	__class__: flash.system.SecurityDomain
}
flash.text = {}
flash.text.Font = function() {
	this.nmeMetrics = [];
	this.nmeFontScale = 9.0;
	var className = Type.getClassName(Type.getClass(this));
	if(flash.text.Font.nmeFontData == null) {
		flash.text.Font.nmeFontData = [];
		flash.text.Font.nmeFontData["Bitstream_Vera_Sans"] = haxe.Unserializer.run(flash.text.Font.DEFAULT_FONT_DATA);
	}
	if(className == "flash.text.Font") this.set_fontName("Bitstream_Vera_Sans"); else this.set_fontName(className.split(".").pop());
};
$hxClasses["flash.text.Font"] = flash.text.Font;
flash.text.Font.__name__ = ["flash","text","Font"];
flash.text.Font.enumerateFonts = function(enumerateDeviceFonts) {
	if(enumerateDeviceFonts == null) enumerateDeviceFonts = false;
	return flash.text.Font.nmeRegisteredFonts.slice();
}
flash.text.Font.nmeOfResource = function(resourceName,fontName) {
	if(fontName == null) fontName = "";
	var data = haxe.Unserializer.run(haxe.Resource.getString(resourceName));
	if(data == null) {
	} else {
		if(fontName == "") {
			flash.text.Font.nmeFontData[resourceName] = data.hash;
			fontName = data.fontName;
		}
		flash.text.Font.nmeFontData[data.fontName] = data.hash;
	}
	return fontName;
}
flash.text.Font.registerFont = function(font) {
	var instance = js.Boot.__cast(Type.createInstance(font,[]) , flash.text.Font);
	if(instance != null) {
		if(Reflect.hasField(font,"resourceName")) instance.set_fontName(flash.text.Font.nmeOfResource(Reflect.field(font,"resourceName")));
		flash.text.Font.nmeRegisteredFonts.push(instance);
	}
}
flash.text.Font.prototype = {
	set_fontName: function(name) {
		if(name == "_sans" || name == "_serif" || name == "_typewriter") name = "Bitstream_Vera_Sans";
		this.fontName = name;
		if(flash.text.Font.nmeFontData[this.fontName] == null) try {
			flash.text.Font.nmeOfResource(name);
		} catch( e ) {
			this.fontName = "Bitstream_Vera_Sans";
		}
		if(flash.text.Font.nmeFontData[this.fontName] != null) try {
			this.nmeGlyphData = flash.text.Font.nmeFontData[this.fontName];
		} catch( e ) {
			this.fontName = "Bitstream_Vera_Sans";
		}
		return name;
	}
	,nmeSetScale: function(scale) {
		this.nmeFontScale = scale / 1024;
	}
	,nmeRender: function(graphics,inChar,inX,inY,inOutline) {
		var index = 0;
		var glyph = this.nmeGlyphData.get(inChar);
		if(glyph == null) return;
		var commands = glyph.commands;
		var data = glyph.data;
		var _g = 0;
		while(_g < commands.length) {
			var c = commands[_g];
			++_g;
			switch(c) {
			case 1:
				graphics.moveTo(inX + data[index++] * this.nmeFontScale,inY + data[index++] * this.nmeFontScale);
				break;
			case 2:
				graphics.lineTo(inX + data[index++] * this.nmeFontScale,inY + data[index++] * this.nmeFontScale);
				break;
			case 3:
				graphics.curveTo(inX + data[index++] * this.nmeFontScale,inY + data[index++] * this.nmeFontScale,inX + data[index++] * this.nmeFontScale,inY + data[index++] * this.nmeFontScale);
				break;
			}
		}
	}
	,nmeGetAdvance: function(inGlyph,height) {
		var m = this.nmeMetrics[inGlyph];
		if(m == null) {
			var glyph = this.nmeGlyphData.get(inGlyph);
			if(glyph == null) return 0;
			this.nmeMetrics[inGlyph] = m = glyph._width * this.nmeFontScale | 0;
		}
		if(m == null) return 0;
		return m;
	}
	,hasGlyph: function(str) {
		return this.nmeGlyphData.exists(HxOverrides.cca(str,0));
	}
	,nmeMetrics: null
	,nmeGlyphData: null
	,nmeFontScale: null
	,fontType: null
	,fontStyle: null
	,fontName: null
	,__class__: flash.text.Font
	,__properties__: {set_fontName:"set_fontName"}
}
flash.text.FontStyle = $hxClasses["flash.text.FontStyle"] = { __ename__ : true, __constructs__ : ["REGULAR","ITALIC","BOLD_ITALIC","BOLD"] }
flash.text.FontStyle.REGULAR = ["REGULAR",0];
flash.text.FontStyle.REGULAR.toString = $estr;
flash.text.FontStyle.REGULAR.__enum__ = flash.text.FontStyle;
flash.text.FontStyle.ITALIC = ["ITALIC",1];
flash.text.FontStyle.ITALIC.toString = $estr;
flash.text.FontStyle.ITALIC.__enum__ = flash.text.FontStyle;
flash.text.FontStyle.BOLD_ITALIC = ["BOLD_ITALIC",2];
flash.text.FontStyle.BOLD_ITALIC.toString = $estr;
flash.text.FontStyle.BOLD_ITALIC.__enum__ = flash.text.FontStyle;
flash.text.FontStyle.BOLD = ["BOLD",3];
flash.text.FontStyle.BOLD.toString = $estr;
flash.text.FontStyle.BOLD.__enum__ = flash.text.FontStyle;
flash.text.FontType = $hxClasses["flash.text.FontType"] = { __ename__ : true, __constructs__ : ["EMBEDDED","DEVICE"] }
flash.text.FontType.EMBEDDED = ["EMBEDDED",0];
flash.text.FontType.EMBEDDED.toString = $estr;
flash.text.FontType.EMBEDDED.__enum__ = flash.text.FontType;
flash.text.FontType.DEVICE = ["DEVICE",1];
flash.text.FontType.DEVICE.toString = $estr;
flash.text.FontType.DEVICE.__enum__ = flash.text.FontType;
flash.text.GridFitType = $hxClasses["flash.text.GridFitType"] = { __ename__ : true, __constructs__ : ["NONE","PIXEL","SUBPIXEL"] }
flash.text.GridFitType.NONE = ["NONE",0];
flash.text.GridFitType.NONE.toString = $estr;
flash.text.GridFitType.NONE.__enum__ = flash.text.GridFitType;
flash.text.GridFitType.PIXEL = ["PIXEL",1];
flash.text.GridFitType.PIXEL.toString = $estr;
flash.text.GridFitType.PIXEL.__enum__ = flash.text.GridFitType;
flash.text.GridFitType.SUBPIXEL = ["SUBPIXEL",2];
flash.text.GridFitType.SUBPIXEL.toString = $estr;
flash.text.GridFitType.SUBPIXEL.__enum__ = flash.text.GridFitType;
flash.text.TextField = function() {
	flash.display.InteractiveObject.call(this);
	this.mWidth = 100;
	this.mHeight = 20;
	this.mHTMLMode = false;
	this.multiline = false;
	this.nmeGraphics = new flash.display.Graphics();
	this.mFace = flash.text.TextField.mDefaultFont;
	this.mAlign = flash.text.TextFormatAlign.LEFT;
	this.mParagraphs = new Array();
	this.mSelStart = -1;
	this.mSelEnd = -1;
	this.scrollH = 0;
	this.scrollV = 1;
	this.mType = flash.text.TextFieldType.DYNAMIC;
	this.set_autoSize("NONE");
	this.mTextHeight = 12;
	this.mMaxHeight = this.mTextHeight;
	this.mHTMLText = " ";
	this.mText = " ";
	this.mTextColour = 0;
	this.tabEnabled = false;
	this.mTryFreeType = true;
	this.selectable = true;
	this.mInsertPos = 0;
	this.nmeInputEnabled = false;
	this.mDownChar = 0;
	this.mSelectDrag = -1;
	this.mLineInfo = [];
	this.set_defaultTextFormat(new flash.text.TextFormat());
	this.set_borderColor(0);
	this.set_border(false);
	this.set_backgroundColor(16777215);
	this.set_background(false);
	this.gridFitType = flash.text.GridFitType.PIXEL;
	this.sharpness = 0;
};
$hxClasses["flash.text.TextField"] = flash.text.TextField;
flash.text.TextField.__name__ = ["flash","text","TextField"];
flash.text.TextField.__super__ = flash.display.InteractiveObject;
flash.text.TextField.prototype = $extend(flash.display.InteractiveObject.prototype,{
	set_wordWrap: function(inWordWrap) {
		this.wordWrap = inWordWrap;
		this.Rebuild();
		return this.get_wordWrap();
	}
	,get_wordWrap: function() {
		return this.wordWrap;
	}
	,set_width: function(inValue) {
		if(this.parent != null) this.parent.nmeInvalidateBounds();
		if(this.get__boundsInvalid()) this.validateBounds();
		if(inValue != this.mWidth) {
			this.mWidth = inValue;
			this.Rebuild();
		}
		return this.mWidth;
	}
	,get_width: function() {
		return Math.max(this.mWidth,this.getBounds(this.get_stage()).width);
	}
	,set_type: function(inType) {
		this.mType = inType;
		this.nmeInputEnabled = this.mType == flash.text.TextFieldType.INPUT;
		if(this.mHTMLMode) {
			if(this.nmeInputEnabled) flash.Lib.nmeSetContentEditable(this.nmeGraphics.nmeSurface,true); else flash.Lib.nmeSetContentEditable(this.nmeGraphics.nmeSurface,false);
		} else if(this.nmeInputEnabled) {
			this.set_htmlText(StringTools.replace(this.mText,"\n","<BR />"));
			flash.Lib.nmeSetContentEditable(this.nmeGraphics.nmeSurface,true);
		}
		this.tabEnabled = this.get_type() == flash.text.TextFieldType.INPUT;
		this.Rebuild();
		return inType;
	}
	,get_type: function() {
		return this.mType;
	}
	,get_textHeight: function() {
		return this.mMaxHeight;
	}
	,get_textWidth: function() {
		return this.mMaxWidth;
	}
	,set_textColor: function(inCol) {
		this.mTextColour = inCol;
		this.RebuildText();
		return inCol;
	}
	,get_textColor: function() {
		return this.mTextColour;
	}
	,set_text: function(inText) {
		this.mText = Std.string(inText);
		this.mHTMLMode = false;
		this.RebuildText();
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		return this.mText;
	}
	,get_text: function() {
		if(this.mHTMLMode) this.ConvertHTMLToText(false);
		return this.mText;
	}
	,set_scrollV: function(value) {
		return this.scrollV = value;
	}
	,get_scrollV: function() {
		return this.scrollV;
	}
	,set_scrollH: function(value) {
		return this.scrollH = value;
	}
	,get_scrollH: function() {
		return this.scrollH;
	}
	,get_numLines: function() {
		return 0;
	}
	,set_multiline: function(value) {
		return this.multiline = value;
	}
	,get_multiline: function() {
		return this.multiline;
	}
	,get_maxScrollV: function() {
		return 0;
	}
	,get_maxScrollH: function() {
		return 0;
	}
	,set_htmlText: function(inHTMLText) {
		this.mParagraphs = new Array();
		this.mHTMLText = inHTMLText;
		if(!this.mHTMLMode) {
			var domElement = js.Browser.document.createElement("div");
			if(this.background || this.border) {
				domElement.style.width = this.mWidth + "px";
				domElement.style.height = this.mHeight + "px";
			}
			if(this.background) domElement.style.backgroundColor = "#" + StringTools.hex(this.backgroundColor,6);
			if(this.border) domElement.style.border = "1px solid #" + StringTools.hex(this.borderColor,6);
			domElement.style.color = "#" + StringTools.hex(this.mTextColour,6);
			domElement.style.fontFamily = this.mFace;
			domElement.style.fontSize = this.mTextHeight + "px";
			domElement.style.textAlign = Std.string(this.mAlign);
			var wrapper = domElement;
			wrapper.innerHTML = inHTMLText;
			var destination = new flash.display.Graphics(wrapper);
			var nmeSurface = this.nmeGraphics.nmeSurface;
			if(flash.Lib.nmeIsOnStage(nmeSurface)) {
				flash.Lib.nmeAppendSurface(wrapper);
				flash.Lib.nmeCopyStyle(nmeSurface,wrapper);
				flash.Lib.nmeSwapSurface(nmeSurface,wrapper);
				flash.Lib.nmeRemoveSurface(nmeSurface);
			}
			this.nmeGraphics = destination;
			this.nmeGraphics.nmeExtent.width = wrapper.width;
			this.nmeGraphics.nmeExtent.height = wrapper.height;
		} else this.nmeGraphics.nmeSurface.innerHTML = inHTMLText;
		this.mHTMLMode = true;
		this.RebuildText();
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		return this.mHTMLText;
	}
	,get_htmlText: function() {
		return this.mHTMLText;
	}
	,set_height: function(inValue) {
		if(this.parent != null) this.parent.nmeInvalidateBounds();
		if(this.get__boundsInvalid()) this.validateBounds();
		if(inValue != this.mHeight) {
			this.mHeight = inValue;
			this.Rebuild();
		}
		return this.mHeight;
	}
	,get_height: function() {
		return Math.max(this.mHeight,this.getBounds(this.get_stage()).height);
	}
	,set_defaultTextFormat: function(inFmt) {
		this.setTextFormat(inFmt);
		this._defaultTextFormat = inFmt;
		return inFmt;
	}
	,get_defaultTextFormat: function() {
		return this._defaultTextFormat;
	}
	,get_caretPos: function() {
		return this.mInsertPos;
	}
	,get_bottomScrollV: function() {
		return 0;
	}
	,set_borderColor: function(inBorderCol) {
		this.borderColor = inBorderCol;
		this.Rebuild();
		return inBorderCol;
	}
	,set_border: function(inBorder) {
		this.border = inBorder;
		this.Rebuild();
		return inBorder;
	}
	,set_backgroundColor: function(inCol) {
		this.backgroundColor = inCol;
		this.Rebuild();
		return inCol;
	}
	,set_background: function(inBack) {
		this.background = inBack;
		this.Rebuild();
		return inBack;
	}
	,set_autoSize: function(inAutoSize) {
		this.autoSize = inAutoSize;
		this.Rebuild();
		return inAutoSize;
	}
	,get_autoSize: function() {
		return this.autoSize;
	}
	,toString: function() {
		return "[TextField name=" + this.name + " id=" + this._nmeId + "]";
	}
	,setTextFormat: function(inFmt,beginIndex,endIndex) {
		if(endIndex == null) endIndex = 0;
		if(beginIndex == null) beginIndex = 0;
		if(inFmt.font != null) this.mFace = inFmt.font;
		if(inFmt.size != null) this.mTextHeight = inFmt.size | 0;
		if(inFmt.align != null) this.mAlign = inFmt.align;
		if(inFmt.color != null) this.mTextColour = inFmt.color;
		this.RebuildText();
		this._nmeRenderFlags |= 64;
		if(this.parent != null) this.parent._nmeRenderFlags |= 64;
		return this.getTextFormat();
	}
	,setSelection: function(beginIndex,endIndex) {
	}
	,RenderRow: function(inRow,inY,inCharIdx,inAlign,inInsert) {
		if(inInsert == null) inInsert = 0;
		var h = 0;
		var w = 0;
		var _g = 0;
		while(_g < inRow.length) {
			var chr = inRow[_g];
			++_g;
			if(chr.fh > h) h = chr.fh;
			w += chr.adv;
		}
		if(w > this.mMaxWidth) this.mMaxWidth = w;
		var full_height = h * 1.2 | 0;
		var align_x = 0;
		var insert_x = 0;
		if(inInsert != null) {
			if(this.autoSize != "NONE") {
				this.scrollH = 0;
				insert_x = inInsert;
			} else {
				insert_x = inInsert - this.scrollH;
				if(insert_x < 0) this.scrollH -= (this.mLimitRenderX * 3 >> 2) - insert_x; else if(insert_x > this.mLimitRenderX) this.scrollH += insert_x - (this.mLimitRenderX * 3 >> 2);
				if(this.scrollH < 0) this.scrollH = 0;
			}
		}
		if(this.autoSize == "NONE" && w <= this.mLimitRenderX) {
			if(inAlign == flash.text.TextFormatAlign.CENTER) align_x = Math.round(this.mWidth) - w >> 1; else if(inAlign == flash.text.TextFormatAlign.RIGHT) align_x = Math.round(this.mWidth) - w;
		}
		var x_list = new Array();
		this.mLineInfo.push({ mY0 : inY, mIndex : inCharIdx - 1, mX : x_list});
		var cache_sel_font = null;
		var cache_normal_font = null;
		var x = align_x - this.scrollH;
		var x0 = x;
		var _g = 0;
		while(_g < inRow.length) {
			var chr = inRow[_g];
			++_g;
			var adv = chr.adv;
			if(x + adv > this.mLimitRenderX) break;
			x_list.push(x);
			if(x >= 0) {
				var font = chr.font;
				if(chr.sel) {
					this.nmeGraphics.lineStyle();
					this.nmeGraphics.beginFill(2105440);
					this.nmeGraphics.drawRect(x,inY,adv,full_height);
					this.nmeGraphics.endFill();
					if(cache_normal_font == chr.font) font = cache_sel_font; else {
						font = flash.text.FontInstance.CreateSolid(chr.font.GetFace(),chr.fh,16777215,1.0);
						cache_sel_font = font;
						cache_normal_font = chr.font;
					}
				}
				font.RenderChar(this.nmeGraphics,chr.chr,x,inY + (h - chr.fh) | 0);
			}
			x += adv;
		}
		x += this.scrollH;
		return full_height;
	}
	,RebuildText: function() {
		this.mParagraphs = [];
		if(!this.mHTMLMode) {
			var font = flash.text.FontInstance.CreateSolid(this.mFace,this.mTextHeight,this.mTextColour,1.0);
			var paras = this.mText.split("\n");
			var _g = 0;
			while(_g < paras.length) {
				var paragraph = paras[_g];
				++_g;
				this.mParagraphs.push({ align : this.mAlign, spans : [{ font : font, text : paragraph + "\n"}]});
			}
		}
		this.Rebuild();
	}
	,Rebuild: function() {
		if(this.mHTMLMode) return;
		this.mLineInfo = [];
		this.nmeGraphics.clear();
		if(this.background) {
			this.nmeGraphics.beginFill(this.backgroundColor);
			this.nmeGraphics.drawRect(0,0,this.get_width(),this.get_height());
			this.nmeGraphics.endFill();
		}
		this.nmeGraphics.lineStyle(this.mTextColour);
		var insert_x = null;
		this.mMaxWidth = 0;
		var wrap = this.mLimitRenderX = this.get_wordWrap() && !this.nmeInputEnabled?this.mWidth | 0:999999;
		var char_idx = 0;
		var h = 0;
		var s0 = this.mSelStart;
		var s1 = this.mSelEnd;
		var _g = 0, _g1 = this.mParagraphs;
		while(_g < _g1.length) {
			var paragraph = _g1[_g];
			++_g;
			var row = [];
			var row_width = 0;
			var last_word_break = 0;
			var last_word_break_width = 0;
			var last_word_char_idx = 0;
			var start_idx = char_idx;
			var tx = 0;
			var _g2 = 0, _g3 = paragraph.spans;
			while(_g2 < _g3.length) {
				var span = _g3[_g2];
				++_g2;
				var text = span.text;
				var font = span.font;
				var fh = font.get_height();
				last_word_break = row.length;
				last_word_break_width = row_width;
				last_word_char_idx = char_idx;
				var _g5 = 0, _g4 = text.length;
				while(_g5 < _g4) {
					var ch = _g5++;
					var g = HxOverrides.cca(text,ch);
					var adv = font.nmeGetAdvance(g);
					if(g == 32) {
						last_word_break = row.length;
						last_word_break_width = tx;
						last_word_char_idx = char_idx;
					}
					if(tx + adv > wrap) {
						if(last_word_break > 0) {
							var row_end = row.splice(last_word_break,row.length - last_word_break);
							h += this.RenderRow(row,h,start_idx,paragraph.align);
							row = row_end;
							tx -= last_word_break_width;
							start_idx = last_word_char_idx;
							last_word_break = 0;
							last_word_break_width = 0;
							last_word_char_idx = 0;
							if(row_end.length > 0 && row_end[0].chr == 32) {
								row_end.shift();
								start_idx++;
							}
						} else {
							h += this.RenderRow(row,h,char_idx,paragraph.align);
							row = [];
							tx = 0;
							start_idx = char_idx;
						}
					}
					row.push({ font : font, chr : g, x : tx, fh : fh, sel : char_idx >= s0 && char_idx < s1, adv : adv});
					tx += adv;
					char_idx++;
				}
			}
			if(row.length > 0) {
				h += this.RenderRow(row,h,start_idx,paragraph.align,insert_x);
				insert_x = null;
			}
		}
		var w = this.mMaxWidth;
		if(h < this.mTextHeight) h = this.mTextHeight;
		this.mMaxHeight = h;
		var _g = this;
		switch(_g.autoSize) {
		case "LEFT":
			break;
		case "RIGHT":
			var x0 = this.get_x() + this.get_width();
			this.set_x(this.mWidth - x0);
			break;
		case "CENTER":
			var x0 = this.get_x() + this.get_width() / 2;
			this.set_x(this.mWidth / 2 - x0);
			break;
		default:
			if(this.get_wordWrap()) this.set_height(h);
		}
		if(this.border) {
			this.nmeGraphics.endFill();
			this.nmeGraphics.lineStyle(1,this.borderColor,1,true);
			this.nmeGraphics.drawRect(.5,.5,this.get_width() - .5,this.get_height() - .5);
		}
	}
	,nmeRender: function(inMask,clipRect) {
		if(!this.nmeCombinedVisible) return;
		if((this._nmeRenderFlags & 4) != 0 || (this._nmeRenderFlags & 8) != 0) this.nmeValidateMatrix();
		if(this.nmeGraphics.nmeRender(inMask,this.nmeFilters,1,1)) {
			this._nmeRenderFlags |= 64;
			if(this.parent != null) this.parent._nmeRenderFlags |= 64;
			this.nmeApplyFilters(this.nmeGraphics.nmeSurface);
			this._nmeRenderFlags |= 32;
		}
		if(!this.mHTMLMode && inMask != null) {
			var m = this.getSurfaceTransform(this.nmeGraphics);
			flash.Lib.nmeDrawToSurface(this.nmeGraphics.nmeSurface,inMask,m,(this.parent != null?this.parent.nmeCombinedAlpha:1) * this.alpha,clipRect,this.gridFitType != flash.text.GridFitType.PIXEL);
		} else {
			if((this._nmeRenderFlags & 32) != 0) {
				var m = this.getSurfaceTransform(this.nmeGraphics);
				flash.Lib.nmeSetSurfaceTransform(this.nmeGraphics.nmeSurface,m);
				this._nmeRenderFlags &= -33;
			}
			flash.Lib.nmeSetSurfaceOpacity(this.nmeGraphics.nmeSurface,(this.parent != null?this.parent.nmeCombinedAlpha:1) * this.alpha);
		}
	}
	,nmeGetObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null; else if(this.mText.length > 1) {
			var local = this.globalToLocal(point);
			if(local.x < 0 || local.y < 0 || local.x > this.mMaxWidth || local.y > this.mMaxHeight) return null; else return this;
		} else return flash.display.InteractiveObject.prototype.nmeGetObjectUnderPoint.call(this,point);
	}
	,nmeGetGraphics: function() {
		return this.nmeGraphics;
	}
	,getTextFormat: function(beginIndex,endIndex) {
		if(endIndex == null) endIndex = 0;
		if(beginIndex == null) beginIndex = 0;
		return new flash.text.TextFormat(this.mFace,this.mTextHeight,this.mTextColour);
	}
	,getLineIndexAtPoint: function(inX,inY) {
		if(this.mLineInfo.length < 1) return -1;
		if(inY <= 0) return 0;
		var _g1 = 0, _g = this.mLineInfo.length;
		while(_g1 < _g) {
			var l = _g1++;
			if(this.mLineInfo[l].mY0 > inY) return l == 0?0:l - 1;
		}
		return this.mLineInfo.length - 1;
	}
	,getCharIndexAtPoint: function(inX,inY) {
		var li = this.getLineIndexAtPoint(inX,inY);
		if(li < 0) return -1;
		var line = this.mLineInfo[li];
		var idx = line.mIndex;
		var _g = 0, _g1 = line.mX;
		while(_g < _g1.length) {
			var x = _g1[_g];
			++_g;
			if(x > inX) return idx;
			idx++;
		}
		return idx;
	}
	,getCharBoundaries: function(a) {
		return null;
	}
	,DecodeColour: function(col) {
		return Std.parseInt("0x" + HxOverrides.substr(col,1,null));
	}
	,ConvertHTMLToText: function(inUnSetHTML) {
		this.mText = "";
		var _g = 0, _g1 = this.mParagraphs;
		while(_g < _g1.length) {
			var paragraph = _g1[_g];
			++_g;
			var _g2 = 0, _g3 = paragraph.spans;
			while(_g2 < _g3.length) {
				var span = _g3[_g2];
				++_g2;
				this.mText += span.text;
			}
		}
		if(inUnSetHTML) {
			this.mHTMLMode = false;
			this.RebuildText();
		}
	}
	,appendText: function(newText) {
		var _g = this;
		_g.set_text(_g.get_text() + newText);
	}
	,_defaultTextFormat: null
	,nmeInputEnabled: null
	,nmeGraphics: null
	,mWidth: null
	,mType: null
	,mTextColour: null
	,mText: null
	,mSelectDrag: null
	,mSelStart: null
	,mSelEnd: null
	,mSelectionAnchored: null
	,mSelectionAnchor: null
	,mMaxWidth: null
	,mMaxHeight: null
	,mLineInfo: null
	,mLimitRenderX: null
	,mInsertPos: null
	,mHTMLMode: null
	,mHTMLText: null
	,mHeight: null
	,mAlign: null
	,wordWrap: null
	,textWidth: null
	,textHeight: null
	,sharpness: null
	,selectionEndIndex: null
	,selectionBeginIndex: null
	,selectable: null
	,scrollV: null
	,scrollH: null
	,restrict: null
	,numLines: null
	,multiline: null
	,mTryFreeType: null
	,mTextHeight: null
	,mParagraphs: null
	,mFace: null
	,mDownChar: null
	,maxScrollV: null
	,maxScrollH: null
	,maxChars: null
	,length: null
	,gridFitType: null
	,embedFonts: null
	,displayAsPassword: null
	,caretPos: null
	,caretIndex: null
	,bottomScrollV: null
	,borderColor: null
	,border: null
	,backgroundColor: null
	,background: null
	,autoSize: null
	,antiAliasType: null
	,__class__: flash.text.TextField
	,__properties__: $extend(flash.display.InteractiveObject.prototype.__properties__,{set_autoSize:"set_autoSize",set_background:"set_background",set_backgroundColor:"set_backgroundColor",set_border:"set_border",set_borderColor:"set_borderColor",get_bottomScrollV:"get_bottomScrollV",get_caretPos:"get_caretPos",set_defaultTextFormat:"set_defaultTextFormat",get_defaultTextFormat:"get_defaultTextFormat",set_htmlText:"set_htmlText",get_htmlText:"get_htmlText",get_maxScrollH:"get_maxScrollH",get_maxScrollV:"get_maxScrollV",get_numLines:"get_numLines",set_text:"set_text",get_text:"get_text",set_textColor:"set_textColor",get_textColor:"get_textColor",get_textHeight:"get_textHeight",get_textWidth:"get_textWidth",set_type:"set_type",get_type:"get_type",set_wordWrap:"set_wordWrap",get_wordWrap:"get_wordWrap"})
});
flash.text.FontInstanceMode = $hxClasses["flash.text.FontInstanceMode"] = { __ename__ : true, __constructs__ : ["fimSolid"] }
flash.text.FontInstanceMode.fimSolid = ["fimSolid",0];
flash.text.FontInstanceMode.fimSolid.toString = $estr;
flash.text.FontInstanceMode.fimSolid.__enum__ = flash.text.FontInstanceMode;
flash.text.FontInstance = function(inFont,inHeight) {
	this.mFont = inFont;
	this.mHeight = inHeight;
	this.mTryFreeType = true;
	this.mGlyphs = [];
	this.mCacheAsBitmap = false;
};
$hxClasses["flash.text.FontInstance"] = flash.text.FontInstance;
flash.text.FontInstance.__name__ = ["flash","text","FontInstance"];
flash.text.FontInstance.CreateSolid = function(inFace,inHeight,inColour,inAlpha) {
	var id = "SOLID:" + inFace + ":" + inHeight + ":" + inColour + ":" + inAlpha;
	var f = flash.text.FontInstance.mSolidFonts.get(id);
	if(f != null) return f;
	var font = new flash.text.Font();
	font.nmeSetScale(inHeight);
	font.set_fontName(inFace);
	if(font == null) return null;
	f = new flash.text.FontInstance(font,inHeight);
	f.SetSolid(inColour,inAlpha);
	flash.text.FontInstance.mSolidFonts.set(id,f);
	return f;
}
flash.text.FontInstance.prototype = {
	get_height: function() {
		return this.mHeight;
	}
	,toString: function() {
		return "FontInstance:" + Std.string(this.mFont) + ":" + this.mColour + "(" + this.mGlyphs.length + ")";
	}
	,RenderChar: function(inGraphics,inGlyph,inX,inY) {
		inGraphics.nmeClearLine();
		inGraphics.beginFill(this.mColour,this.mAlpha);
		this.mFont.nmeRender(inGraphics,inGlyph,inX,inY,this.mTryFreeType);
		inGraphics.endFill();
	}
	,SetSolid: function(inCol,inAlpha) {
		this.mColour = inCol;
		this.mAlpha = inAlpha;
		this.mMode = flash.text.FontInstanceMode.fimSolid;
	}
	,nmeGetAdvance: function(inChar) {
		if(this.mFont == null) return 0;
		return this.mFont.nmeGetAdvance(inChar,this.mHeight);
	}
	,GetFace: function() {
		return this.mFont.fontName;
	}
	,mCacheAsBitmap: null
	,mGlyphs: null
	,mHeight: null
	,mFont: null
	,mAlpha: null
	,mColour: null
	,mMode: null
	,mTryFreeType: null
	,height: null
	,__class__: flash.text.FontInstance
	,__properties__: {get_height:"get_height"}
}
flash.text.TextFieldAutoSize = function() {
};
$hxClasses["flash.text.TextFieldAutoSize"] = flash.text.TextFieldAutoSize;
flash.text.TextFieldAutoSize.__name__ = ["flash","text","TextFieldAutoSize"];
flash.text.TextFieldAutoSize.prototype = {
	__class__: flash.text.TextFieldAutoSize
}
flash.text.TextFieldType = function() {
};
$hxClasses["flash.text.TextFieldType"] = flash.text.TextFieldType;
flash.text.TextFieldType.__name__ = ["flash","text","TextFieldType"];
flash.text.TextFieldType.prototype = {
	__class__: flash.text.TextFieldType
}
flash.text.TextFormat = function(in_font,in_size,in_color,in_bold,in_italic,in_underline,in_url,in_target,in_align,in_leftMargin,in_rightMargin,in_indent,in_leading) {
	this.font = in_font;
	this.size = in_size;
	this.color = in_color;
	this.bold = in_bold;
	this.italic = in_italic;
	this.underline = in_underline;
	this.url = in_url;
	this.target = in_target;
	this.align = in_align;
	this.leftMargin = in_leftMargin;
	this.rightMargin = in_rightMargin;
	this.indent = in_indent;
	this.leading = in_leading;
};
$hxClasses["flash.text.TextFormat"] = flash.text.TextFormat;
flash.text.TextFormat.__name__ = ["flash","text","TextFormat"];
flash.text.TextFormat.prototype = {
	clone: function() {
		var newFormat = new flash.text.TextFormat(this.font,this.size,this.color,this.bold,this.italic,this.underline,this.url,this.target);
		newFormat.align = this.align;
		newFormat.leftMargin = this.leftMargin;
		newFormat.rightMargin = this.rightMargin;
		newFormat.indent = this.indent;
		newFormat.leading = this.leading;
		newFormat.blockIndent = this.blockIndent;
		newFormat.bullet = this.bullet;
		newFormat.display = this.display;
		newFormat.kerning = this.kerning;
		newFormat.letterSpacing = this.letterSpacing;
		newFormat.tabStops = this.tabStops;
		return newFormat;
	}
	,url: null
	,underline: null
	,target: null
	,tabStops: null
	,size: null
	,rightMargin: null
	,letterSpacing: null
	,leftMargin: null
	,leading: null
	,kerning: null
	,italic: null
	,indent: null
	,font: null
	,display: null
	,color: null
	,bullet: null
	,bold: null
	,blockIndent: null
	,align: null
	,__class__: flash.text.TextFormat
}
flash.text.TextFormatAlign = $hxClasses["flash.text.TextFormatAlign"] = { __ename__ : true, __constructs__ : ["LEFT","RIGHT","JUSTIFY","CENTER"] }
flash.text.TextFormatAlign.LEFT = ["LEFT",0];
flash.text.TextFormatAlign.LEFT.toString = $estr;
flash.text.TextFormatAlign.LEFT.__enum__ = flash.text.TextFormatAlign;
flash.text.TextFormatAlign.RIGHT = ["RIGHT",1];
flash.text.TextFormatAlign.RIGHT.toString = $estr;
flash.text.TextFormatAlign.RIGHT.__enum__ = flash.text.TextFormatAlign;
flash.text.TextFormatAlign.JUSTIFY = ["JUSTIFY",2];
flash.text.TextFormatAlign.JUSTIFY.toString = $estr;
flash.text.TextFormatAlign.JUSTIFY.__enum__ = flash.text.TextFormatAlign;
flash.text.TextFormatAlign.CENTER = ["CENTER",3];
flash.text.TextFormatAlign.CENTER.toString = $estr;
flash.text.TextFormatAlign.CENTER.__enum__ = flash.text.TextFormatAlign;
flash.ui = {}
flash.ui.Keyboard = function() { }
$hxClasses["flash.ui.Keyboard"] = flash.ui.Keyboard;
flash.ui.Keyboard.__name__ = ["flash","ui","Keyboard"];
flash.ui.Keyboard.isAccessible = function() {
	return false;
}
flash.ui.Keyboard.nmeConvertMozillaCode = function(code) {
	switch(code) {
	case 8:
		return 8;
	case 9:
		return 9;
	case 13:
		return 13;
	case 14:
		return 13;
	case 16:
		return 16;
	case 17:
		return 17;
	case 20:
		return 18;
	case 27:
		return 27;
	case 32:
		return 32;
	case 33:
		return 33;
	case 34:
		return 34;
	case 35:
		return 35;
	case 36:
		return 36;
	case 37:
		return 37;
	case 39:
		return 39;
	case 38:
		return 38;
	case 40:
		return 40;
	case 45:
		return 45;
	case 46:
		return 46;
	case 144:
		return 144;
	default:
		return code;
	}
}
flash.ui.Keyboard.nmeConvertWebkitCode = function(code) {
	var _g = code.toLowerCase();
	switch(_g) {
	case "backspace":
		return 8;
	case "tab":
		return 9;
	case "enter":
		return 13;
	case "shift":
		return 16;
	case "control":
		return 17;
	case "capslock":
		return 18;
	case "escape":
		return 27;
	case "space":
		return 32;
	case "pageup":
		return 33;
	case "pagedown":
		return 34;
	case "end":
		return 35;
	case "home":
		return 36;
	case "left":
		return 37;
	case "right":
		return 39;
	case "up":
		return 38;
	case "down":
		return 40;
	case "insert":
		return 45;
	case "delete":
		return 46;
	case "numlock":
		return 144;
	case "break":
		return 19;
	}
	if(code.indexOf("U+") == 0) return Std.parseInt("0x" + HxOverrides.substr(code,3,null));
	throw "Unrecognized key code: " + code;
	return 0;
}
flash.utils = {}
flash.utils.ByteArray = function() {
	this.littleEndian = false;
	this.allocated = 0;
	this.position = 0;
	this.length = 0;
	this._nmeResizeBuffer(this.allocated);
};
$hxClasses["flash.utils.ByteArray"] = flash.utils.ByteArray;
flash.utils.ByteArray.__name__ = ["flash","utils","ByteArray"];
flash.utils.ByteArray.fromBytes = function(inBytes) {
	var result = new flash.utils.ByteArray();
	result.byteView = new Uint8Array(inBytes.b);
	result.set_length(result.byteView.length);
	result.allocated = result.length;
	return result;
}
flash.utils.ByteArray.nmeOfBuffer = function(buffer) {
	var bytes = new flash.utils.ByteArray();
	bytes.set_length(bytes.allocated = buffer.byteLength);
	bytes.data = new DataView(buffer);
	bytes.byteView = new Uint8Array(buffer);
	return bytes;
}
flash.utils.ByteArray.prototype = {
	set_length: function(value) {
		if(this.allocated < value) this._nmeResizeBuffer(this.allocated = Math.max(value,this.allocated * 2) | 0); else if(this.allocated > value) this._nmeResizeBuffer(this.allocated = value);
		this.length = value;
		return value;
	}
	,set_endian: function(endian) {
		this.littleEndian = endian == "littleEndian";
		return endian;
	}
	,get_endian: function() {
		return this.littleEndian?"littleEndian":"bigEndian";
	}
	,get_bytesAvailable: function() {
		return this.length - this.position;
	}
	,writeUTFBytes: function(value) {
		var _g1 = 0, _g = value.length;
		while(_g1 < _g) {
			var i = _g1++;
			var c = value.charCodeAt(i);
			if(c <= 127) this.writeByte(c); else if(c <= 2047) {
				this.writeByte(192 | c >> 6);
				this.writeByte(128 | c & 63);
			} else if(c <= 65535) {
				this.writeByte(224 | c >> 12);
				this.writeByte(128 | c >> 6 & 63);
				this.writeByte(128 | c & 63);
			} else {
				this.writeByte(240 | c >> 18);
				this.writeByte(128 | c >> 12 & 63);
				this.writeByte(128 | c >> 6 & 63);
				this.writeByte(128 | c & 63);
			}
		}
	}
	,writeUTF: function(value) {
		this.writeUnsignedShort(this._getUTFBytesCount(value));
		this.writeUTFBytes(value);
	}
	,writeUnsignedShort: function(value) {
		var lengthToEnsure = this.position + 2;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setUint16(this.position,value,this.littleEndian);
		this.position += 2;
	}
	,writeUnsignedInt: function(value) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setUint32(this.position,value,this.littleEndian);
		this.position += 4;
	}
	,writeShort: function(value) {
		var lengthToEnsure = this.position + 2;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setInt16(this.position,value,this.littleEndian);
		this.position += 2;
	}
	,writeInt: function(value) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setInt32(this.position,value,this.littleEndian);
		this.position += 4;
	}
	,writeFloat: function(x) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setFloat32(this.position,x,this.littleEndian);
		this.position += 4;
	}
	,writeDouble: function(x) {
		var lengthToEnsure = this.position + 8;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setFloat64(this.position,x,this.littleEndian);
		this.position += 8;
	}
	,writeBytes: function(bytes,offset,length) {
		if(offset < 0 || length < 0) throw new flash.errors.IOError("Write error - Out of bounds");
		var lengthToEnsure = this.position + length;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.byteView.set(bytes.byteView.subarray(offset,offset + length),this.position);
		this.position += length;
	}
	,writeByte: function(value) {
		var lengthToEnsure = this.position + 1;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this._nmeResizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this._nmeResizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		var data = this.data;
		data.setInt8(this.position,value);
		this.position += 1;
	}
	,writeBoolean: function(value) {
		this.writeByte(value?1:0);
	}
	,toString: function() {
		var cachePosition = this.position;
		this.position = 0;
		var value = this.readUTFBytes(this.length);
		this.position = cachePosition;
		return value;
	}
	,readUTFBytes: function(len) {
		var value = "";
		var max = this.position + len;
		while(this.position < max) {
			var data = this.data;
			var c = data.getUint8(this.position++);
			if(c < 128) {
				if(c == 0) break;
				value += String.fromCharCode(c);
			} else if(c < 224) value += String.fromCharCode((c & 63) << 6 | data.getUint8(this.position++) & 127); else if(c < 240) {
				var c2 = data.getUint8(this.position++);
				value += String.fromCharCode((c & 31) << 12 | (c2 & 127) << 6 | data.getUint8(this.position++) & 127);
			} else {
				var c2 = data.getUint8(this.position++);
				var c3 = data.getUint8(this.position++);
				value += String.fromCharCode((c & 15) << 18 | (c2 & 127) << 12 | c3 << 6 & 127 | data.getUint8(this.position++) & 127);
			}
		}
		return value;
	}
	,readUTF: function() {
		var bytesCount = this.readUnsignedShort();
		return this.readUTFBytes(bytesCount);
	}
	,readUnsignedShort: function() {
		var uShort = this.data.getUint16(this.position,this.littleEndian);
		this.position += 2;
		return uShort;
	}
	,readUnsignedInt: function() {
		var uInt = this.data.getUint32(this.position,this.littleEndian);
		this.position += 4;
		return uInt;
	}
	,readUnsignedByte: function() {
		var data = this.data;
		return data.getUint8(this.position++);
	}
	,readShort: function() {
		var $short = this.data.getInt16(this.position,this.littleEndian);
		this.position += 2;
		return $short;
	}
	,readInt: function() {
		var $int = this.data.getInt32(this.position,this.littleEndian);
		this.position += 4;
		return $int;
	}
	,readFullBytes: function(bytes,pos,len) {
		if(this.length < len) {
			if(this.allocated < len) this._nmeResizeBuffer(this.allocated = Math.max(len,this.allocated * 2) | 0); else if(this.allocated > len) this._nmeResizeBuffer(this.allocated = len);
			this.length = len;
			len;
		}
		var _g1 = pos, _g = pos + len;
		while(_g1 < _g) {
			var i = _g1++;
			var data = this.data;
			data.setInt8(this.position++,bytes.b[i]);
		}
	}
	,readFloat: function() {
		var $float = this.data.getFloat32(this.position,this.littleEndian);
		this.position += 4;
		return $float;
	}
	,readDouble: function() {
		var $double = this.data.getFloat64(this.position,this.littleEndian);
		this.position += 8;
		return $double;
	}
	,readBytes: function(bytes,offset,length) {
		if(offset < 0 || length < 0) throw new flash.errors.IOError("Read error - Out of bounds");
		if(offset == null) offset = 0;
		if(length == null) length = this.length;
		var lengthToEnsure = offset + length;
		if(bytes.length < lengthToEnsure) {
			if(bytes.allocated < lengthToEnsure) bytes._nmeResizeBuffer(bytes.allocated = Math.max(lengthToEnsure,bytes.allocated * 2) | 0); else if(bytes.allocated > lengthToEnsure) bytes._nmeResizeBuffer(bytes.allocated = lengthToEnsure);
			bytes.length = lengthToEnsure;
			lengthToEnsure;
		}
		bytes.byteView.set(this.byteView.subarray(this.position,this.position + length),offset);
		bytes.position = offset;
		this.position += length;
		if(bytes.position + length > bytes.length) bytes.set_length(bytes.position + length);
	}
	,readByte: function() {
		var data = this.data;
		return data.getUint8(this.position++);
	}
	,readBoolean: function() {
		return this.readByte() != 0;
	}
	,nmeSet: function(pos,v) {
		var data = this.data;
		data.setUint8(pos,v);
	}
	,nmeGetBuffer: function() {
		return this.data.buffer;
	}
	,nmeGet: function(pos) {
		var data = this.data;
		return data.getUint8(pos);
	}
	,nmeFromBytes: function(inBytes) {
		this.byteView = new Uint8Array(inBytes.b);
		this.set_length(this.byteView.length);
		this.allocated = this.length;
	}
	,clear: function() {
		if(this.allocated < 0) this._nmeResizeBuffer(this.allocated = Math.max(0,this.allocated * 2) | 0); else if(this.allocated > 0) this._nmeResizeBuffer(this.allocated = 0);
		this.length = 0;
		0;
	}
	,_nmeResizeBuffer: function(len) {
		var oldByteView = this.byteView;
		var newByteView = new Uint8Array(len);
		if(oldByteView != null) {
			if(oldByteView.length <= len) newByteView.set(oldByteView); else newByteView.set(oldByteView.subarray(0,len));
		}
		this.byteView = newByteView;
		this.data = new DataView(newByteView.buffer);
	}
	,_getUTFBytesCount: function(value) {
		var count = 0;
		var _g1 = 0, _g = value.length;
		while(_g1 < _g) {
			var i = _g1++;
			var c = value.charCodeAt(i);
			if(c <= 127) count += 1; else if(c <= 2047) count += 2; else if(c <= 65535) count += 3; else count += 4;
		}
		return count;
	}
	,__set: function(pos,v) {
		this.data.setUint8(pos,v);
	}
	,__get: function(pos) {
		return this.data.getUint8(pos);
	}
	,littleEndian: null
	,data: null
	,byteView: null
	,allocated: null
	,position: null
	,objectEncoding: null
	,length: null
	,bytesAvailable: null
	,__class__: flash.utils.ByteArray
	,__properties__: {get_bytesAvailable:"get_bytesAvailable",set_endian:"set_endian",get_endian:"get_endian",set_length:"set_length"}
}
flash.utils.Endian = function() { }
$hxClasses["flash.utils.Endian"] = flash.utils.Endian;
flash.utils.Endian.__name__ = ["flash","utils","Endian"];
flash.utils.Uuid = function() { }
$hxClasses["flash.utils.Uuid"] = flash.utils.Uuid;
flash.utils.Uuid.__name__ = ["flash","utils","Uuid"];
flash.utils.Uuid.random = function(size) {
	if(size == null) size = 32;
	var nchars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".length;
	var uid = new StringBuf();
	var _g = 0;
	while(_g < size) {
		var i = _g++;
		uid.b += Std.string("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(Math.random() * nchars | 0));
	}
	return uid.b;
}
flash.utils.Uuid.uuid = function() {
	return flash.utils.Uuid.random(8) + "-" + flash.utils.Uuid.random(4) + "-" + flash.utils.Uuid.random(4) + "-" + flash.utils.Uuid.random(4) + "-" + flash.utils.Uuid.random(12);
}
haxe.StackItem = $hxClasses["haxe.StackItem"] = { __ename__ : true, __constructs__ : ["CFunction","Module","FilePos","Method","Lambda"] }
haxe.StackItem.CFunction = ["CFunction",0];
haxe.StackItem.CFunction.toString = $estr;
haxe.StackItem.CFunction.__enum__ = haxe.StackItem;
haxe.StackItem.Module = function(m) { var $x = ["Module",1,m]; $x.__enum__ = haxe.StackItem; $x.toString = $estr; return $x; }
haxe.StackItem.FilePos = function(s,file,line) { var $x = ["FilePos",2,s,file,line]; $x.__enum__ = haxe.StackItem; $x.toString = $estr; return $x; }
haxe.StackItem.Method = function(classname,method) { var $x = ["Method",3,classname,method]; $x.__enum__ = haxe.StackItem; $x.toString = $estr; return $x; }
haxe.StackItem.Lambda = function(v) { var $x = ["Lambda",4,v]; $x.__enum__ = haxe.StackItem; $x.toString = $estr; return $x; }
haxe.CallStack = function() { }
$hxClasses["haxe.CallStack"] = haxe.CallStack;
haxe.CallStack.__name__ = ["haxe","CallStack"];
haxe.CallStack.exceptionStack = function() {
	return [];
}
haxe.CallStack.toString = function(stack) {
	var b = new StringBuf();
	var _g = 0;
	while(_g < stack.length) {
		var s = stack[_g];
		++_g;
		b.b += "\nCalled from ";
		haxe.CallStack.itemToString(b,s);
	}
	return b.b;
}
haxe.CallStack.itemToString = function(b,s) {
	var $e = (s);
	switch( $e[1] ) {
	case 0:
		b.b += "a C function";
		break;
	case 1:
		var m = $e[2];
		b.b += "module ";
		b.b += Std.string(m);
		break;
	case 2:
		var line = $e[4], file = $e[3], s1 = $e[2];
		if(s1 != null) {
			haxe.CallStack.itemToString(b,s1);
			b.b += " (";
		}
		b.b += Std.string(file);
		b.b += " line ";
		b.b += Std.string(line);
		if(s1 != null) b.b += ")";
		break;
	case 3:
		var meth = $e[3], cname = $e[2];
		b.b += Std.string(cname);
		b.b += ".";
		b.b += Std.string(meth);
		break;
	case 4:
		var n = $e[2];
		b.b += "local function #";
		b.b += Std.string(n);
		break;
	}
}
haxe.Http = function(url) {
	this.url = url;
	this.headers = new haxe.ds.StringMap();
	this.params = new haxe.ds.StringMap();
	this.async = true;
};
$hxClasses["haxe.Http"] = haxe.Http;
haxe.Http.__name__ = ["haxe","Http"];
haxe.Http.prototype = {
	onStatus: function(status) {
	}
	,onError: function(msg) {
	}
	,onData: function(data) {
	}
	,setPostData: function(data) {
		this.postData = data;
		return this;
	}
	,setHeader: function(header,value) {
		this.headers.set(header,value);
		return this;
	}
	,params: null
	,headers: null
	,postData: null
	,async: null
	,responseData: null
	,url: null
	,__class__: haxe.Http
}
haxe.Json = function() {
};
$hxClasses["haxe.Json"] = haxe.Json;
haxe.Json.__name__ = ["haxe","Json"];
haxe.Json.stringify = function(value,replacer) {
	return new haxe.Json().toString(value,replacer);
}
haxe.Json.prototype = {
	quote: function(s) {
		this.buf.b += "\"";
		var i = 0;
		while(true) {
			var c = s.charCodeAt(i++);
			if(c != c) break;
			switch(c) {
			case 34:
				this.buf.b += "\\\"";
				break;
			case 92:
				this.buf.b += "\\\\";
				break;
			case 10:
				this.buf.b += "\\n";
				break;
			case 13:
				this.buf.b += "\\r";
				break;
			case 9:
				this.buf.b += "\\t";
				break;
			case 8:
				this.buf.b += "\\b";
				break;
			case 12:
				this.buf.b += "\\f";
				break;
			default:
				this.buf.b += String.fromCharCode(c);
			}
		}
		this.buf.b += "\"";
	}
	,toStringRec: function(k,v) {
		if(this.replacer != null) v = this.replacer(k,v);
		var _g = Type["typeof"](v);
		var $e = (_g);
		switch( $e[1] ) {
		case 8:
			this.buf.b += "\"???\"";
			break;
		case 4:
			this.objString(v);
			break;
		case 1:
			var v1 = v;
			this.buf.b += Std.string(v1);
			break;
		case 2:
			this.buf.b += Std.string(Math.isFinite(v)?v:"null");
			break;
		case 5:
			this.buf.b += "\"<fun>\"";
			break;
		case 6:
			var c = $e[2];
			if(c == String) this.quote(v); else if(c == Array) {
				var v1 = v;
				this.buf.b += "[";
				var len = v1.length;
				if(len > 0) {
					this.toStringRec(0,v1[0]);
					var i = 1;
					while(i < len) {
						this.buf.b += ",";
						this.toStringRec(i,v1[i++]);
					}
				}
				this.buf.b += "]";
			} else if(c == haxe.ds.StringMap) {
				var v1 = v;
				var o = { };
				var $it0 = v1.keys();
				while( $it0.hasNext() ) {
					var k1 = $it0.next();
					o[k1] = v1.get(k1);
				}
				this.objString(o);
			} else this.objString(v);
			break;
		case 7:
			var i = Type.enumIndex(v);
			var v1 = i;
			this.buf.b += Std.string(v1);
			break;
		case 3:
			var v1 = v;
			this.buf.b += Std.string(v1);
			break;
		case 0:
			this.buf.b += "null";
			break;
		}
	}
	,objString: function(v) {
		this.fieldsString(v,Reflect.fields(v));
	}
	,fieldsString: function(v,fields) {
		var first = true;
		this.buf.b += "{";
		var _g = 0;
		while(_g < fields.length) {
			var f = fields[_g];
			++_g;
			var value = Reflect.field(v,f);
			if(Reflect.isFunction(value)) continue;
			if(first) first = false; else this.buf.b += ",";
			this.quote(f);
			this.buf.b += ":";
			this.toStringRec(f,value);
		}
		this.buf.b += "}";
	}
	,toString: function(v,replacer) {
		this.buf = new StringBuf();
		this.replacer = replacer;
		this.toStringRec("",v);
		return this.buf.b;
	}
	,replacer: null
	,buf: null
	,__class__: haxe.Json
}
haxe.Resource = function() { }
$hxClasses["haxe.Resource"] = haxe.Resource;
haxe.Resource.__name__ = ["haxe","Resource"];
haxe.Resource.listNames = function() {
	var names = new Array();
	var _g = 0, _g1 = haxe.Resource.content;
	while(_g < _g1.length) {
		var x = _g1[_g];
		++_g;
		names.push(x.name);
	}
	return names;
}
haxe.Resource.getString = function(name) {
	var _g = 0, _g1 = haxe.Resource.content;
	while(_g < _g1.length) {
		var x = _g1[_g];
		++_g;
		if(x.name == name) {
			if(x.str != null) return x.str;
			var b = haxe.Unserializer.run(x.data);
			return b.toString();
		}
	}
	return null;
}
haxe._Template = {}
haxe._Template.TemplateExpr = $hxClasses["haxe._Template.TemplateExpr"] = { __ename__ : true, __constructs__ : ["OpVar","OpExpr","OpIf","OpStr","OpBlock","OpForeach","OpMacro"] }
haxe._Template.TemplateExpr.OpVar = function(v) { var $x = ["OpVar",0,v]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpExpr = function(expr) { var $x = ["OpExpr",1,expr]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpIf = function(expr,eif,eelse) { var $x = ["OpIf",2,expr,eif,eelse]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpStr = function(str) { var $x = ["OpStr",3,str]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpBlock = function(l) { var $x = ["OpBlock",4,l]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpForeach = function(expr,loop) { var $x = ["OpForeach",5,expr,loop]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe._Template.TemplateExpr.OpMacro = function(name,params) { var $x = ["OpMacro",6,name,params]; $x.__enum__ = haxe._Template.TemplateExpr; $x.toString = $estr; return $x; }
haxe.Template = function(str) {
	var tokens = this.parseTokens(str);
	this.expr = this.parseBlock(tokens);
	if(!tokens.isEmpty()) throw "Unexpected '" + Std.string(tokens.first().s) + "'";
};
$hxClasses["haxe.Template"] = haxe.Template;
haxe.Template.__name__ = ["haxe","Template"];
haxe.Template.prototype = {
	run: function(e) {
		var $e = (e);
		switch( $e[1] ) {
		case 0:
			var v = $e[2];
			this.buf.b += Std.string(Std.string(this.resolve(v)));
			break;
		case 1:
			var e1 = $e[2];
			this.buf.b += Std.string(Std.string(e1()));
			break;
		case 2:
			var eelse = $e[4], eif = $e[3], e1 = $e[2];
			var v = e1();
			if(v == null || v == false) {
				if(eelse != null) this.run(eelse);
			} else this.run(eif);
			break;
		case 3:
			var str = $e[2];
			this.buf.b += Std.string(str);
			break;
		case 4:
			var l = $e[2];
			var $it0 = l.iterator();
			while( $it0.hasNext() ) {
				var e1 = $it0.next();
				this.run(e1);
			}
			break;
		case 5:
			var loop = $e[3], e1 = $e[2];
			var v = e1();
			try {
				var x = $iterator(v)();
				if(x.hasNext == null) throw null;
				v = x;
			} catch( e2 ) {
				try {
					if(v.hasNext == null) throw null;
				} catch( e3 ) {
					throw "Cannot iter on " + Std.string(v);
				}
			}
			this.stack.push(this.context);
			var v1 = v;
			while( v1.hasNext() ) {
				var ctx = v1.next();
				this.context = ctx;
				this.run(loop);
			}
			this.context = this.stack.pop();
			break;
		case 6:
			var params = $e[3], m = $e[2];
			var v = Reflect.field(this.macros,m);
			var pl = new Array();
			var old = this.buf;
			pl.push($bind(this,this.resolve));
			var $it1 = params.iterator();
			while( $it1.hasNext() ) {
				var p = $it1.next();
				var $e = (p);
				switch( $e[1] ) {
				case 0:
					var v1 = $e[2];
					pl.push(this.resolve(v1));
					break;
				default:
					this.buf = new StringBuf();
					this.run(p);
					pl.push(this.buf.b);
				}
			}
			this.buf = old;
			try {
				this.buf.b += Std.string(Std.string(v.apply(this.macros,pl)));
			} catch( e1 ) {
				var plstr = (function($this) {
					var $r;
					try {
						$r = pl.join(",");
					} catch( e2 ) {
						$r = "???";
					}
					return $r;
				}(this));
				var msg = "Macro call " + m + "(" + plstr + ") failed (" + Std.string(e1) + ")";
				throw msg;
			}
			break;
		}
	}
	,makeExpr2: function(l) {
		var p = l.pop();
		if(p == null) throw "<eof>";
		if(p.s) return this.makeConst(p.p);
		switch(p.p) {
		case "(":
			var e1 = this.makeExpr(l);
			var p1 = l.pop();
			if(p1 == null || p1.s) throw p1.p;
			if(p1.p == ")") return e1;
			var e2 = this.makeExpr(l);
			var p2 = l.pop();
			if(p2 == null || p2.p != ")") throw p2.p;
			return (function($this) {
				var $r;
				switch(p1.p) {
				case "+":
					$r = function() {
						return e1() + e2();
					};
					break;
				case "-":
					$r = function() {
						return e1() - e2();
					};
					break;
				case "*":
					$r = function() {
						return e1() * e2();
					};
					break;
				case "/":
					$r = function() {
						return e1() / e2();
					};
					break;
				case ">":
					$r = function() {
						return e1() > e2();
					};
					break;
				case "<":
					$r = function() {
						return e1() < e2();
					};
					break;
				case ">=":
					$r = function() {
						return e1() >= e2();
					};
					break;
				case "<=":
					$r = function() {
						return e1() <= e2();
					};
					break;
				case "==":
					$r = function() {
						return e1() == e2();
					};
					break;
				case "!=":
					$r = function() {
						return e1() != e2();
					};
					break;
				case "&&":
					$r = function() {
						return e1() && e2();
					};
					break;
				case "||":
					$r = function() {
						return e1() || e2();
					};
					break;
				default:
					$r = (function($this) {
						var $r;
						throw "Unknown operation " + p1.p;
						return $r;
					}($this));
				}
				return $r;
			}(this));
		case "!":
			var e = this.makeExpr(l);
			return function() {
				var v = e();
				return v == null || v == false;
			};
		case "-":
			var e3 = this.makeExpr(l);
			return function() {
				return -e3();
			};
		}
		throw p.p;
	}
	,makeExpr: function(l) {
		return this.makePath(this.makeExpr2(l),l);
	}
	,makePath: function(e,l) {
		var p = l.first();
		if(p == null || p.p != ".") return e;
		l.pop();
		var field = l.pop();
		if(field == null || !field.s) throw field.p;
		var f = field.p;
		haxe.Template.expr_trim.match(f);
		f = haxe.Template.expr_trim.matched(1);
		return this.makePath(function() {
			return Reflect.field(e(),f);
		},l);
	}
	,makeConst: function(v) {
		haxe.Template.expr_trim.match(v);
		v = haxe.Template.expr_trim.matched(1);
		if(HxOverrides.cca(v,0) == 34) {
			var str = HxOverrides.substr(v,1,v.length - 2);
			return function() {
				return str;
			};
		}
		if(haxe.Template.expr_int.match(v)) {
			var i = Std.parseInt(v);
			return function() {
				return i;
			};
		}
		if(haxe.Template.expr_float.match(v)) {
			var f = Std.parseFloat(v);
			return function() {
				return f;
			};
		}
		var me = this;
		return function() {
			return me.resolve(v);
		};
	}
	,parseExpr: function(data) {
		var l = new List();
		var expr = data;
		while(haxe.Template.expr_splitter.match(data)) {
			var p = haxe.Template.expr_splitter.matchedPos();
			var k = p.pos + p.len;
			if(p.pos != 0) l.add({ p : HxOverrides.substr(data,0,p.pos), s : true});
			var p1 = haxe.Template.expr_splitter.matched(0);
			l.add({ p : p1, s : p1.indexOf("\"") >= 0});
			data = haxe.Template.expr_splitter.matchedRight();
		}
		if(data.length != 0) l.add({ p : data, s : true});
		var e;
		try {
			e = this.makeExpr(l);
			if(!l.isEmpty()) throw l.first().p;
		} catch( s ) {
			if( js.Boot.__instanceof(s,String) ) {
				throw "Unexpected '" + s + "' in " + expr;
			} else throw(s);
		}
		return function() {
			try {
				return e();
			} catch( exc ) {
				throw "Error : " + Std.string(exc) + " in " + expr;
			}
		};
	}
	,parse: function(tokens) {
		var t = tokens.pop();
		var p = t.p;
		if(t.s) return haxe._Template.TemplateExpr.OpStr(p);
		if(t.l != null) {
			var pe = new List();
			var _g = 0, _g1 = t.l;
			while(_g < _g1.length) {
				var p1 = _g1[_g];
				++_g;
				pe.add(this.parseBlock(this.parseTokens(p1)));
			}
			return haxe._Template.TemplateExpr.OpMacro(p,pe);
		}
		if(HxOverrides.substr(p,0,3) == "if ") {
			p = HxOverrides.substr(p,3,p.length - 3);
			var e = this.parseExpr(p);
			var eif = this.parseBlock(tokens);
			var t1 = tokens.first();
			var eelse;
			if(t1 == null) throw "Unclosed 'if'";
			if(t1.p == "end") {
				tokens.pop();
				eelse = null;
			} else if(t1.p == "else") {
				tokens.pop();
				eelse = this.parseBlock(tokens);
				t1 = tokens.pop();
				if(t1 == null || t1.p != "end") throw "Unclosed 'else'";
			} else {
				t1.p = HxOverrides.substr(t1.p,4,t1.p.length - 4);
				eelse = this.parse(tokens);
			}
			return haxe._Template.TemplateExpr.OpIf(e,eif,eelse);
		}
		if(HxOverrides.substr(p,0,8) == "foreach ") {
			p = HxOverrides.substr(p,8,p.length - 8);
			var e = this.parseExpr(p);
			var efor = this.parseBlock(tokens);
			var t1 = tokens.pop();
			if(t1 == null || t1.p != "end") throw "Unclosed 'foreach'";
			return haxe._Template.TemplateExpr.OpForeach(e,efor);
		}
		if(haxe.Template.expr_splitter.match(p)) return haxe._Template.TemplateExpr.OpExpr(this.parseExpr(p));
		return haxe._Template.TemplateExpr.OpVar(p);
	}
	,parseBlock: function(tokens) {
		var l = new List();
		while(true) {
			var t = tokens.first();
			if(t == null) break;
			if(!t.s && (t.p == "end" || t.p == "else" || HxOverrides.substr(t.p,0,7) == "elseif ")) break;
			l.add(this.parse(tokens));
		}
		if(l.length == 1) return l.first();
		return haxe._Template.TemplateExpr.OpBlock(l);
	}
	,parseTokens: function(data) {
		var tokens = new List();
		while(haxe.Template.splitter.match(data)) {
			var p = haxe.Template.splitter.matchedPos();
			if(p.pos > 0) tokens.add({ p : HxOverrides.substr(data,0,p.pos), s : true, l : null});
			if(HxOverrides.cca(data,p.pos) == 58) {
				tokens.add({ p : HxOverrides.substr(data,p.pos + 2,p.len - 4), s : false, l : null});
				data = haxe.Template.splitter.matchedRight();
				continue;
			}
			var parp = p.pos + p.len;
			var npar = 1;
			while(npar > 0) {
				var c = HxOverrides.cca(data,parp);
				if(c == 40) npar++; else if(c == 41) npar--; else if(c == null) throw "Unclosed macro parenthesis";
				parp++;
			}
			var params = HxOverrides.substr(data,p.pos + p.len,parp - (p.pos + p.len) - 1).split(",");
			tokens.add({ p : haxe.Template.splitter.matched(2), s : false, l : params});
			data = HxOverrides.substr(data,parp,data.length - parp);
		}
		if(data.length > 0) tokens.add({ p : data, s : true, l : null});
		return tokens;
	}
	,resolve: function(v) {
		if(Reflect.hasField(this.context,v)) return Reflect.field(this.context,v);
		var $it0 = this.stack.iterator();
		while( $it0.hasNext() ) {
			var ctx = $it0.next();
			if(Reflect.hasField(ctx,v)) return Reflect.field(ctx,v);
		}
		if(v == "__current__") return this.context;
		return Reflect.field(haxe.Template.globals,v);
	}
	,execute: function(context,macros) {
		this.macros = macros == null?{ }:macros;
		this.context = context;
		this.stack = new List();
		this.buf = new StringBuf();
		this.run(this.expr);
		return this.buf.b;
	}
	,buf: null
	,stack: null
	,macros: null
	,context: null
	,expr: null
	,__class__: haxe.Template
}
haxe.Unserializer = function(buf) {
	this.buf = buf;
	this.length = buf.length;
	this.pos = 0;
	this.scache = new Array();
	this.cache = new Array();
	var r = haxe.Unserializer.DEFAULT_RESOLVER;
	if(r == null) {
		r = Type;
		haxe.Unserializer.DEFAULT_RESOLVER = r;
	}
	this.setResolver(r);
};
$hxClasses["haxe.Unserializer"] = haxe.Unserializer;
haxe.Unserializer.__name__ = ["haxe","Unserializer"];
haxe.Unserializer.initCodes = function() {
	var codes = new Array();
	var _g1 = 0, _g = haxe.Unserializer.BASE64.length;
	while(_g1 < _g) {
		var i = _g1++;
		codes[haxe.Unserializer.BASE64.charCodeAt(i)] = i;
	}
	return codes;
}
haxe.Unserializer.run = function(v) {
	return new haxe.Unserializer(v).unserialize();
}
haxe.Unserializer.prototype = {
	unserialize: function() {
		var _g = this.buf.charCodeAt(this.pos++);
		switch(_g) {
		case 110:
			return null;
		case 116:
			return true;
		case 102:
			return false;
		case 122:
			return 0;
		case 105:
			return this.readDigits();
		case 100:
			var p1 = this.pos;
			while(true) {
				var c = this.buf.charCodeAt(this.pos);
				if(c >= 43 && c < 58 || c == 101 || c == 69) this.pos++; else break;
			}
			return Std.parseFloat(HxOverrides.substr(this.buf,p1,this.pos - p1));
		case 121:
			var len = this.readDigits();
			if(this.buf.charCodeAt(this.pos++) != 58 || this.length - this.pos < len) throw "Invalid string length";
			var s = HxOverrides.substr(this.buf,this.pos,len);
			this.pos += len;
			s = StringTools.urlDecode(s);
			this.scache.push(s);
			return s;
		case 107:
			return Math.NaN;
		case 109:
			return Math.NEGATIVE_INFINITY;
		case 112:
			return Math.POSITIVE_INFINITY;
		case 97:
			var buf = this.buf;
			var a = new Array();
			this.cache.push(a);
			while(true) {
				var c = this.buf.charCodeAt(this.pos);
				if(c == 104) {
					this.pos++;
					break;
				}
				if(c == 117) {
					this.pos++;
					var n = this.readDigits();
					a[a.length + n - 1] = null;
				} else a.push(this.unserialize());
			}
			return a;
		case 111:
			var o = { };
			this.cache.push(o);
			this.unserializeObject(o);
			return o;
		case 114:
			var n = this.readDigits();
			if(n < 0 || n >= this.cache.length) throw "Invalid reference";
			return this.cache[n];
		case 82:
			var n = this.readDigits();
			if(n < 0 || n >= this.scache.length) throw "Invalid string reference";
			return this.scache[n];
		case 120:
			throw this.unserialize();
			break;
		case 99:
			var name = this.unserialize();
			var cl = this.resolver.resolveClass(name);
			if(cl == null) throw "Class not found " + name;
			var o = Type.createEmptyInstance(cl);
			this.cache.push(o);
			this.unserializeObject(o);
			return o;
		case 119:
			var name = this.unserialize();
			var edecl = this.resolver.resolveEnum(name);
			if(edecl == null) throw "Enum not found " + name;
			var e = this.unserializeEnum(edecl,this.unserialize());
			this.cache.push(e);
			return e;
		case 106:
			var name = this.unserialize();
			var edecl = this.resolver.resolveEnum(name);
			if(edecl == null) throw "Enum not found " + name;
			this.pos++;
			var index = this.readDigits();
			var tag = Type.getEnumConstructs(edecl)[index];
			if(tag == null) throw "Unknown enum index " + name + "@" + index;
			var e = this.unserializeEnum(edecl,tag);
			this.cache.push(e);
			return e;
		case 108:
			var l = new List();
			this.cache.push(l);
			var buf = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) l.add(this.unserialize());
			this.pos++;
			return l;
		case 98:
			var h = new haxe.ds.StringMap();
			this.cache.push(h);
			var buf = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s = this.unserialize();
				h.set(s,this.unserialize());
			}
			this.pos++;
			return h;
		case 113:
			var h = new haxe.ds.IntMap();
			this.cache.push(h);
			var buf = this.buf;
			var c = this.buf.charCodeAt(this.pos++);
			while(c == 58) {
				var i = this.readDigits();
				h.set(i,this.unserialize());
				c = this.buf.charCodeAt(this.pos++);
			}
			if(c != 104) throw "Invalid IntMap format";
			return h;
		case 77:
			var h = new haxe.ds.ObjectMap();
			this.cache.push(h);
			var buf = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s = this.unserialize();
				h.set(s,this.unserialize());
			}
			this.pos++;
			return h;
		case 118:
			var d = HxOverrides.strDate(HxOverrides.substr(this.buf,this.pos,19));
			this.cache.push(d);
			this.pos += 19;
			return d;
		case 115:
			var len = this.readDigits();
			var buf = this.buf;
			if(this.buf.charCodeAt(this.pos++) != 58 || this.length - this.pos < len) throw "Invalid bytes length";
			var codes = haxe.Unserializer.CODES;
			if(codes == null) {
				codes = haxe.Unserializer.initCodes();
				haxe.Unserializer.CODES = codes;
			}
			var i = this.pos;
			var rest = len & 3;
			var size = (len >> 2) * 3 + (rest >= 2?rest - 1:0);
			var max = i + (len - rest);
			var bytes = haxe.io.Bytes.alloc(size);
			var bpos = 0;
			while(i < max) {
				var c1 = codes[buf.charCodeAt(i++)];
				var c2 = codes[buf.charCodeAt(i++)];
				bytes.b[bpos++] = (c1 << 2 | c2 >> 4) & 255;
				var c3 = codes[buf.charCodeAt(i++)];
				bytes.b[bpos++] = (c2 << 4 | c3 >> 2) & 255;
				var c4 = codes[buf.charCodeAt(i++)];
				bytes.b[bpos++] = (c3 << 6 | c4) & 255;
			}
			if(rest >= 2) {
				var c1 = codes[buf.charCodeAt(i++)];
				var c2 = codes[buf.charCodeAt(i++)];
				bytes.b[bpos++] = (c1 << 2 | c2 >> 4) & 255;
				if(rest == 3) {
					var c3 = codes[buf.charCodeAt(i++)];
					bytes.b[bpos++] = (c2 << 4 | c3 >> 2) & 255;
				}
			}
			this.pos += len;
			this.cache.push(bytes);
			return bytes;
		case 67:
			var name = this.unserialize();
			var cl = this.resolver.resolveClass(name);
			if(cl == null) throw "Class not found " + name;
			var o = Type.createEmptyInstance(cl);
			this.cache.push(o);
			o.hxUnserialize(this);
			if(this.buf.charCodeAt(this.pos++) != 103) throw "Invalid custom data";
			return o;
		default:
		}
		this.pos--;
		throw "Invalid char " + this.buf.charAt(this.pos) + " at position " + this.pos;
	}
	,unserializeEnum: function(edecl,tag) {
		if(this.buf.charCodeAt(this.pos++) != 58) throw "Invalid enum format";
		var nargs = this.readDigits();
		if(nargs == 0) return Type.createEnum(edecl,tag);
		var args = new Array();
		while(nargs-- > 0) args.push(this.unserialize());
		return Type.createEnum(edecl,tag,args);
	}
	,unserializeObject: function(o) {
		while(true) {
			if(this.pos >= this.length) throw "Invalid object";
			if(this.buf.charCodeAt(this.pos) == 103) break;
			var k = this.unserialize();
			if(!js.Boot.__instanceof(k,String)) throw "Invalid object key";
			var v = this.unserialize();
			o[k] = v;
		}
		this.pos++;
	}
	,readDigits: function() {
		var k = 0;
		var s = false;
		var fpos = this.pos;
		while(true) {
			var c = this.buf.charCodeAt(this.pos);
			if(c != c) break;
			if(c == 45) {
				if(this.pos != fpos) break;
				s = true;
				this.pos++;
				continue;
			}
			if(c < 48 || c > 57) break;
			k = k * 10 + (c - 48);
			this.pos++;
		}
		if(s) k *= -1;
		return k;
	}
	,setResolver: function(r) {
		if(r == null) this.resolver = { resolveClass : function(_) {
			return null;
		}, resolveEnum : function(_) {
			return null;
		}}; else this.resolver = r;
	}
	,resolver: null
	,scache: null
	,cache: null
	,length: null
	,pos: null
	,buf: null
	,__class__: haxe.Unserializer
}
haxe.Utf8 = function() { }
$hxClasses["haxe.Utf8"] = haxe.Utf8;
haxe.Utf8.__name__ = ["haxe","Utf8"];
haxe.Utf8.decode = function(s) {
	throw "Not implemented";
	return s;
}
haxe.ds = {}
haxe.ds.IntMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.IntMap"] = haxe.ds.IntMap;
haxe.ds.IntMap.__name__ = ["haxe","ds","IntMap"];
haxe.ds.IntMap.__interfaces__ = [IMap];
haxe.ds.IntMap.prototype = {
	remove: function(key) {
		if(!this.h.hasOwnProperty(key)) return false;
		delete(this.h[key]);
		return true;
	}
	,exists: function(key) {
		return this.h.hasOwnProperty(key);
	}
	,get: function(key) {
		return this.h[key];
	}
	,set: function(key,value) {
		this.h[key] = value;
	}
	,h: null
	,__class__: haxe.ds.IntMap
}
haxe.ds.ObjectMap = function() {
	this.h = { };
	this.h.__keys__ = { };
};
$hxClasses["haxe.ds.ObjectMap"] = haxe.ds.ObjectMap;
haxe.ds.ObjectMap.__name__ = ["haxe","ds","ObjectMap"];
haxe.ds.ObjectMap.__interfaces__ = [IMap];
haxe.ds.ObjectMap.prototype = {
	iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref[i.__id__];
		}};
	}
	,keys: function() {
		var a = [];
		for( var key in this.h.__keys__ ) {
		if(this.h.hasOwnProperty(key)) a.push(this.h.__keys__[key]);
		}
		return HxOverrides.iter(a);
	}
	,remove: function(key) {
		var id = key.__id__;
		if(!this.h.hasOwnProperty(id)) return false;
		delete(this.h[id]);
		delete(this.h.__keys__[id]);
		return true;
	}
	,exists: function(key) {
		return this.h.hasOwnProperty(key.__id__);
	}
	,get: function(key) {
		return this.h[key.__id__];
	}
	,set: function(key,value) {
		var id = key.__id__ != null?key.__id__:key.__id__ = ++haxe.ds.ObjectMap.count;
		this.h[id] = value;
		this.h.__keys__[id] = key;
	}
	,h: null
	,__class__: haxe.ds.ObjectMap
}
haxe.ds.StringMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.StringMap"] = haxe.ds.StringMap;
haxe.ds.StringMap.__name__ = ["haxe","ds","StringMap"];
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key.substr(1));
		}
		return HxOverrides.iter(a);
	}
	,remove: function(key) {
		key = "$" + key;
		if(!this.h.hasOwnProperty(key)) return false;
		delete(this.h[key]);
		return true;
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,set: function(key,value) {
		this.h["$" + key] = value;
	}
	,h: null
	,__class__: haxe.ds.StringMap
}
haxe.io = {}
haxe.io.Bytes = function(length,b) {
	this.length = length;
	this.b = b;
};
$hxClasses["haxe.io.Bytes"] = haxe.io.Bytes;
haxe.io.Bytes.__name__ = ["haxe","io","Bytes"];
haxe.io.Bytes.alloc = function(length) {
	var a = new Array();
	var _g = 0;
	while(_g < length) {
		var i = _g++;
		a.push(0);
	}
	return new haxe.io.Bytes(length,a);
}
haxe.io.Bytes.prototype = {
	toString: function() {
		return this.readString(0,this.length);
	}
	,readString: function(pos,len) {
		if(pos < 0 || len < 0 || pos + len > this.length) throw haxe.io.Error.OutsideBounds;
		var s = "";
		var b = this.b;
		var fcc = String.fromCharCode;
		var i = pos;
		var max = pos + len;
		while(i < max) {
			var c = b[i++];
			if(c < 128) {
				if(c == 0) break;
				s += fcc(c);
			} else if(c < 224) s += fcc((c & 63) << 6 | b[i++] & 127); else if(c < 240) {
				var c2 = b[i++];
				s += fcc((c & 31) << 12 | (c2 & 127) << 6 | b[i++] & 127);
			} else {
				var c2 = b[i++];
				var c3 = b[i++];
				s += fcc((c & 15) << 18 | (c2 & 127) << 12 | c3 << 6 & 127 | b[i++] & 127);
			}
		}
		return s;
	}
	,b: null
	,length: null
	,__class__: haxe.io.Bytes
}
haxe.io.Eof = function() { }
$hxClasses["haxe.io.Eof"] = haxe.io.Eof;
haxe.io.Eof.__name__ = ["haxe","io","Eof"];
haxe.io.Eof.prototype = {
	toString: function() {
		return "Eof";
	}
	,__class__: haxe.io.Eof
}
haxe.io.Error = $hxClasses["haxe.io.Error"] = { __ename__ : true, __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] }
haxe.io.Error.Blocked = ["Blocked",0];
haxe.io.Error.Blocked.toString = $estr;
haxe.io.Error.Blocked.__enum__ = haxe.io.Error;
haxe.io.Error.Overflow = ["Overflow",1];
haxe.io.Error.Overflow.toString = $estr;
haxe.io.Error.Overflow.__enum__ = haxe.io.Error;
haxe.io.Error.OutsideBounds = ["OutsideBounds",2];
haxe.io.Error.OutsideBounds.toString = $estr;
haxe.io.Error.OutsideBounds.__enum__ = haxe.io.Error;
haxe.io.Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe.io.Error; $x.toString = $estr; return $x; }
var jasononeil = {}
jasononeil.CompileTime = function() { }
$hxClasses["jasononeil.CompileTime"] = jasononeil.CompileTime;
jasononeil.CompileTime.__name__ = ["jasononeil","CompileTime"];
var js = {}
js.Boot = function() { }
$hxClasses["js.Boot"] = js.Boot;
js.Boot.__name__ = ["js","Boot"];
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0, _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
}
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) {
					if(cl == Array) return o.__enum__ == null;
					return true;
				}
				if(js.Boot.__interfLoop(o.__class__,cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
}
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
}
js.Browser = function() { }
$hxClasses["js.Browser"] = js.Browser;
js.Browser.__name__ = ["js","Browser"];
js.Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") return new XMLHttpRequest();
	if(typeof ActiveXObject != "undefined") return new ActiveXObject("Microsoft.XMLHTTP");
	throw "Unable to create XMLHttpRequest object.";
}
var mloader = {}
mloader.Http = function(url) {
	haxe.Http.call(this,url);
};
$hxClasses["mloader.Http"] = mloader.Http;
mloader.Http.__name__ = ["mloader","Http"];
mloader.Http.__super__ = haxe.Http;
mloader.Http.prototype = $extend(haxe.Http.prototype,{
	request: function(post) {
		var me = this;
		me.responseData = null;
		var r = this.loader = js.Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if(r.readyState != 4) return;
			var s = (function($this) {
				var $r;
				try {
					$r = r.status;
				} catch( e ) {
					$r = null;
				}
				return $r;
			}(this));
			if(s == undefined) s = null;
			if(s != null) me.onStatus(s);
			if(s != null && s >= 200 && s < 400) {
				me.loader = null;
				me.onData(me.responseData = r.responseText);
			} else if(s == null) {
				me.loader = null;
				me.onError("Failed to connect or resolve host");
			} else switch(s) {
			case 12029:
				me.loader = null;
				me.onError("Failed to connect to host");
				break;
			case 12007:
				me.loader = null;
				me.onError("Unknown host");
				break;
			default:
				me.responseData = r.responseText;
				me.loader = null;
				me.onError("Http Error #" + r.status);
			}
		};
		if(this.async) r.onreadystatechange = onreadystatechange;
		var uri = this.postData;
		if(uri != null) post = true; else {
			var $it0 = this.params.keys();
			while( $it0.hasNext() ) {
				var p = $it0.next();
				if(uri == null) uri = ""; else uri += "&";
				uri += StringTools.urlEncode(p) + "=" + StringTools.urlEncode(this.params.get(p));
			}
		}
		try {
			if(post) r.open("POST",this.url,this.async); else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question?"?":"&") + uri,this.async);
				uri = null;
			} else r.open("GET",this.url,this.async);
		} catch( e ) {
			me.loader = null;
			this.onError(e.toString());
			return;
		}
		if(this.headers.get("Content-Type") == null && post && this.postData == null) r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var $it1 = this.headers.keys();
		while( $it1.hasNext() ) {
			var h = $it1.next();
			r.setRequestHeader(h,this.headers.get(h));
		}
		r.send(uri);
		if(!this.async) onreadystatechange(null);
	}
	,cancel: function() {
		if(this.loader != null) {
			this.loader.abort();
			this.loader = null;
		}
	}
	,loader: null
	,__class__: mloader.Http
});
mloader.Loader = function() { }
$hxClasses["mloader.Loader"] = mloader.Loader;
mloader.Loader.__name__ = ["mloader","Loader"];
mloader.Loader.prototype = {
	cancel: null
	,load: null
	,loaded: null
	,loading: null
	,content: null
	,progress: null
	,url: null
	,__class__: mloader.Loader
}
mloader.LoaderBase = function(url) {
	this.loaded = new msignal.EventSignal(this);
	this.set_url(url);
	this.progress = 0;
	this.loading = false;
};
$hxClasses["mloader.LoaderBase"] = mloader.LoaderBase;
mloader.LoaderBase.__name__ = ["mloader","LoaderBase"];
mloader.LoaderBase.__interfaces__ = [mloader.Loader];
mloader.LoaderBase.prototype = {
	loaderFail: function(error) {
		if(!this.loading) return;
		this.loading = false;
		this.loaded.dispatchType(mloader.LoaderEventType.Fail(error));
	}
	,loaderComplete: function() {
		if(!this.loading) return;
		this.progress = 1;
		this.loading = false;
		this.loaded.dispatchType(mloader.LoaderEventType.Complete);
	}
	,loaderCancel: function() {
		throw "missing implementation";
	}
	,loaderLoad: function() {
		throw "missing implementation";
	}
	,cancel: function() {
		if(!this.loading) return;
		this.loading = false;
		this.loaderCancel();
		this.progress = 0;
		this.content = null;
		this.loaded.dispatchType(mloader.LoaderEventType.Cancel);
	}
	,load: function() {
		if(this.loading) return;
		if(this.url == null) throw "No url defined for Loader";
		this.loading = true;
		this.loaded.dispatchType(mloader.LoaderEventType.Start);
		this.loaderLoad();
	}
	,loaded: null
	,progress: null
	,loading: null
	,content: null
	,set_url: function(value) {
		if(value == this.url) return this.url;
		if(this.loading) this.cancel();
		return this.url = value;
	}
	,url: null
	,__class__: mloader.LoaderBase
	,__properties__: {set_url:"set_url"}
}
mloader.HttpLoader = function(url,http) {
	mloader.LoaderBase.call(this,url);
	this.headers = new haxe.ds.StringMap();
	if(http == null) http = new mloader.Http("");
	this.http = http;
	http.onData = $bind(this,this.httpData);
	http.onError = $bind(this,this.httpError);
	http.onStatus = $bind(this,this.httpStatus);
};
$hxClasses["mloader.HttpLoader"] = mloader.HttpLoader;
mloader.HttpLoader.__name__ = ["mloader","HttpLoader"];
mloader.HttpLoader.__super__ = mloader.LoaderBase;
mloader.HttpLoader.prototype = $extend(mloader.LoaderBase.prototype,{
	httpSecurityError: function(error) {
		this.loaderFail(mloader.LoaderErrorType.Security(error));
	}
	,httpError: function(error) {
		this.loaderFail(mloader.LoaderErrorType.IO(error));
	}
	,httpStatus: function(status) {
		this.statusCode = status;
	}
	,httpData: function(data) {
		this.content = data;
		this.loaderComplete();
	}
	,addHeaders: function() {
		var $it0 = this.headers.keys();
		while( $it0.hasNext() ) {
			var name = $it0.next();
			this.http.setHeader(name,this.headers.get(name));
		}
	}
	,httpConfigure: function() {
	}
	,loaderCancel: function() {
		this.http.cancel();
	}
	,loaderLoad: function() {
		this.httpConfigure();
		this.addHeaders();
		this.http.url = this.url;
		try {
			this.http.request(false);
		} catch( e ) {
			this.loaderFail(mloader.LoaderErrorType.Security(Std.string(e)));
		}
	}
	,send: function(data) {
		if(this.loading) this.cancel();
		if(this.url == null) throw "No url defined for Loader";
		this.loading = true;
		this.loaded.dispatchType(mloader.LoaderEventType.Start);
		var contentType = "application/octet-stream";
		if(js.Boot.__instanceof(data,Xml)) {
			data = Std.string(data);
			contentType = "application/xml";
		} else if(!js.Boot.__instanceof(data,String)) {
			data = haxe.Json.stringify(data);
			contentType = "application/json";
		}
		if(!this.headers.exists("Content-Type")) this.headers.set("Content-Type",contentType);
		this.httpConfigure();
		this.addHeaders();
		this.http.url = this.url;
		this.http.setPostData(data);
		try {
			this.http.request(true);
		} catch( e ) {
			this.loaderFail(mloader.LoaderErrorType.Security(Std.string(e)));
		}
	}
	,statusCode: null
	,headers: null
	,http: null
	,__class__: mloader.HttpLoader
});
mloader.ImageLoader = function(url) {
	mloader.LoaderBase.call(this,url);
	this.loader = new flash.display.Loader();
	var loaderInfo = this.loader.contentLoaderInfo;
	loaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS,$bind(this,this.loaderProgressed));
	loaderInfo.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.loaderCompleted));
	loaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR,$bind(this,this.loaderErrored));
};
$hxClasses["mloader.ImageLoader"] = mloader.ImageLoader;
mloader.ImageLoader.__name__ = ["mloader","ImageLoader"];
mloader.ImageLoader.__super__ = mloader.LoaderBase;
mloader.ImageLoader.prototype = $extend(mloader.LoaderBase.prototype,{
	loaderErrored: function(event) {
		this.loaderFail(mloader.LoaderErrorType.IO(Std.string(event)));
	}
	,loaderCompleted: function(event) {
		this.content = this.loader.content.bitmapData;
		this.loaderComplete();
	}
	,loaderProgressed: function(event) {
		this.progress = 0.0;
		if(event.bytesTotal > 0) this.progress = event.bytesLoaded / event.bytesTotal;
		this.loaded.dispatchType(mloader.LoaderEventType.Progress);
	}
	,loaderCancel: function() {
	}
	,loaderLoad: function() {
		this.loader.load(new flash.net.URLRequest(this.url));
	}
	,loader: null
	,__class__: mloader.ImageLoader
});
mloader.LoaderEventType = $hxClasses["mloader.LoaderEventType"] = { __ename__ : true, __constructs__ : ["Start","Cancel","Progress","Complete","Fail"] }
mloader.LoaderEventType.Start = ["Start",0];
mloader.LoaderEventType.Start.toString = $estr;
mloader.LoaderEventType.Start.__enum__ = mloader.LoaderEventType;
mloader.LoaderEventType.Cancel = ["Cancel",1];
mloader.LoaderEventType.Cancel.toString = $estr;
mloader.LoaderEventType.Cancel.__enum__ = mloader.LoaderEventType;
mloader.LoaderEventType.Progress = ["Progress",2];
mloader.LoaderEventType.Progress.toString = $estr;
mloader.LoaderEventType.Progress.__enum__ = mloader.LoaderEventType;
mloader.LoaderEventType.Complete = ["Complete",3];
mloader.LoaderEventType.Complete.toString = $estr;
mloader.LoaderEventType.Complete.__enum__ = mloader.LoaderEventType;
mloader.LoaderEventType.Fail = function(error) { var $x = ["Fail",4,error]; $x.__enum__ = mloader.LoaderEventType; $x.toString = $estr; return $x; }
mloader.LoaderErrorType = $hxClasses["mloader.LoaderErrorType"] = { __ename__ : true, __constructs__ : ["IO","Security","Format","Data"] }
mloader.LoaderErrorType.IO = function(info) { var $x = ["IO",0,info]; $x.__enum__ = mloader.LoaderErrorType; $x.toString = $estr; return $x; }
mloader.LoaderErrorType.Security = function(info) { var $x = ["Security",1,info]; $x.__enum__ = mloader.LoaderErrorType; $x.toString = $estr; return $x; }
mloader.LoaderErrorType.Format = function(info) { var $x = ["Format",2,info]; $x.__enum__ = mloader.LoaderErrorType; $x.toString = $estr; return $x; }
mloader.LoaderErrorType.Data = function(info,data) { var $x = ["Data",3,info,data]; $x.__enum__ = mloader.LoaderErrorType; $x.toString = $estr; return $x; }
mloader.LoaderQueue = function() {
	this.maxLoading = 8;
	this.loaded = new msignal.EventSignal(this);
	this.loading = false;
	this.ignoreFailures = true;
	this.autoLoad = false;
	this.numLoaded = 0;
	this.numFailed = 0;
	this.pendingQueue = [];
	this.activeLoaders = [];
};
$hxClasses["mloader.LoaderQueue"] = mloader.LoaderQueue;
mloader.LoaderQueue.__name__ = ["mloader","LoaderQueue"];
mloader.LoaderQueue.__interfaces__ = [mloader.Loader];
mloader.LoaderQueue.prototype = {
	removePendingLoader: function(loader) {
		var i = this.pendingQueue.length;
		while(i-- > 0) if(this.pendingQueue[i].loader == loader) this.pendingQueue.splice(i,1);
	}
	,removeActiveLoader: function(loader) {
		var i = this.activeLoaders.length;
		while(i-- > 0) if(this.activeLoaders[i] == loader) {
			loader.loaded.remove($bind(this,this.loaderLoaded));
			this.activeLoaders.splice(i,1);
		}
	}
	,containsPendingLoader: function(loader) {
		var _g = 0, _g1 = this.pendingQueue;
		while(_g < _g1.length) {
			var pending = _g1[_g];
			++_g;
			if(pending.loader == loader) return true;
		}
		return false;
	}
	,containsActiveLoader: function(loader) {
		var _g = 0, _g1 = this.activeLoaders;
		while(_g < _g1.length) {
			var active = _g1[_g];
			++_g;
			if(active == loader) return true;
		}
		return false;
	}
	,loaderLoaded: function(event) {
		var loader = event.target;
		var $e = (event.type);
		switch( $e[1] ) {
		case 3:
		case 1:
			this.loaderCompleted(loader);
			break;
		case 4:
			var e = $e[2];
			this.loaderFail(loader,e);
			break;
		default:
		}
	}
	,cancel: function() {
		while(this.activeLoaders.length > 0) {
			var loader = this.activeLoaders.pop();
			loader.loaded.remove($bind(this,this.loaderLoaded));
			loader.cancel();
		}
		this.loading = false;
		this.pendingQueue = [];
		this.loaded.dispatchType(mloader.LoaderEventType.Cancel);
	}
	,queueCompleted: function() {
		this.loaded.dispatchType(mloader.LoaderEventType.Complete);
		this.loading = false;
	}
	,continueLoading: function() {
		while(this.pendingQueue.length > 0 && this.activeLoaders.length < this.maxLoading) {
			var info = this.pendingQueue.shift();
			var loader = info.loader;
			loader.loaded.add($bind(this,this.loaderLoaded));
			this.activeLoaders.push(loader);
			loader.load();
		}
	}
	,loaderFail: function(loader,error) {
		this.numFailed += 1;
		if(this.ignoreFailures) this.loaderCompleted(loader); else {
			loader.loaded.remove($bind(this,this.loaderLoaded));
			HxOverrides.remove(this.activeLoaders,loader);
			this.loaded.dispatchType(mloader.LoaderEventType.Fail(error));
			this.loading = false;
		}
	}
	,loaderCompleted: function(loader) {
		loader.loaded.remove($bind(this,this.loaderLoaded));
		HxOverrides.remove(this.activeLoaders,loader);
		this.numLoaded++;
		this.progress = this.numLoaded == 0?0:this.numLoaded / (this.numLoaded + this.get_size());
		this.loaded.dispatchType(mloader.LoaderEventType.Progress);
		if(this.loading) {
			if(this.pendingQueue.length > 0) this.continueLoading(); else if(this.activeLoaders.length == 0) this.queueCompleted();
		} else throw "should not be!";
	}
	,load: function() {
		if(this.loading) return;
		this.loading = true;
		this.numLoaded = this.numFailed = 0;
		this.loaded.dispatchType(mloader.LoaderEventType.Start);
		if(this.pendingQueue.length > 0) this.continueLoading(); else this.queueCompleted();
	}
	,remove: function(loader) {
		if(this.containsActiveLoader(loader)) {
			this.removeActiveLoader(loader);
			loader.cancel();
			this.continueLoading();
		} else if(this.containsPendingLoader(loader)) this.removePendingLoader(loader);
	}
	,addWithPriority: function(loader,priority) {
		this.pendingQueue.push({ loader : loader, priority : priority});
		this.pendingQueue.sort(function(a,b) {
			return b.priority - a.priority;
		});
		if(this.autoLoad) this.load();
	}
	,add: function(loader) {
		this.addWithPriority(loader,0);
	}
	,activeLoaders: null
	,pendingQueue: null
	,set_url: function(value) {
		return value;
	}
	,url: null
	,progress: null
	,numFailed: null
	,numLoaded: null
	,get_numLoading: function() {
		return this.activeLoaders.length;
	}
	,numLoading: null
	,get_numPending: function() {
		return this.pendingQueue.length;
	}
	,numPending: null
	,get_size: function() {
		return this.pendingQueue.length + this.activeLoaders.length;
	}
	,size: null
	,autoLoad: null
	,ignoreFailures: null
	,maxLoading: null
	,loaded: null
	,loading: null
	,content: null
	,__class__: mloader.LoaderQueue
	,__properties__: {get_size:"get_size",get_numPending:"get_numPending",get_numLoading:"get_numLoading",set_url:"set_url"}
}
mloader.StringLoader = function(url,http) {
	mloader.HttpLoader.call(this,url,http);
};
$hxClasses["mloader.StringLoader"] = mloader.StringLoader;
mloader.StringLoader.__name__ = ["mloader","StringLoader"];
mloader.StringLoader.__super__ = mloader.HttpLoader;
mloader.StringLoader.prototype = $extend(mloader.HttpLoader.prototype,{
	__class__: mloader.StringLoader
});
var motion = {}
motion.actuators = {}
motion.actuators.IGenericActuator = function() { }
$hxClasses["motion.actuators.IGenericActuator"] = motion.actuators.IGenericActuator;
motion.actuators.IGenericActuator.__name__ = ["motion","actuators","IGenericActuator"];
motion.actuators.IGenericActuator.prototype = {
	snapping: null
	,smartRotation: null
	,reverse: null
	,repeat: null
	,reflect: null
	,onUpdate: null
	,onRepeat: null
	,onComplete: null
	,ease: null
	,delay: null
	,autoVisible: null
	,__class__: motion.actuators.IGenericActuator
}
motion.actuators.GenericActuator = function(target,duration,properties) {
	this._autoVisible = true;
	this._delay = 0;
	this._reflect = false;
	this._repeat = 0;
	this._reverse = false;
	this._smartRotation = false;
	this._snapping = false;
	this.special = false;
	this.target = target;
	this.properties = properties;
	this.duration = duration;
	this._ease = motion.Actuate.defaultEase;
};
$hxClasses["motion.actuators.GenericActuator"] = motion.actuators.GenericActuator;
motion.actuators.GenericActuator.__name__ = ["motion","actuators","GenericActuator"];
motion.actuators.GenericActuator.__interfaces__ = [motion.actuators.IGenericActuator];
motion.actuators.GenericActuator.prototype = {
	stop: function(properties,complete,sendEvent) {
	}
	,snapping: function(value) {
		if(value == null) value = true;
		this._snapping = value;
		this.special = true;
		return this;
	}
	,smartRotation: function(value) {
		if(value == null) value = true;
		this._smartRotation = value;
		this.special = true;
		return this;
	}
	,reverse: function(value) {
		if(value == null) value = true;
		this._reverse = value;
		this.special = true;
		return this;
	}
	,resume: function() {
	}
	,repeat: function(times) {
		if(times == null) times = -1;
		this._repeat = times;
		return this;
	}
	,reflect: function(value) {
		if(value == null) value = true;
		this._reflect = value;
		this.special = true;
		return this;
	}
	,pause: function() {
	}
	,onUpdate: function(handler,parameters) {
		this._onUpdate = handler;
		if(parameters == null) this._onUpdateParams = []; else this._onUpdateParams = parameters;
		return this;
	}
	,onRepeat: function(handler,parameters) {
		this._onRepeat = handler;
		if(parameters == null) this._onRepeatParams = []; else this._onRepeatParams = parameters;
		return this;
	}
	,onComplete: function(handler,parameters) {
		this._onComplete = handler;
		if(parameters == null) this._onCompleteParams = []; else this._onCompleteParams = parameters;
		if(this.duration == 0) this.complete();
		return this;
	}
	,move: function() {
	}
	,ease: function(easing) {
		this._ease = easing;
		return this;
	}
	,delay: function(duration) {
		this._delay = duration;
		return this;
	}
	,complete: function(sendEvent) {
		if(sendEvent == null) sendEvent = true;
		if(sendEvent) {
			this.change();
			if(this._onComplete != null) this._onComplete.apply(this._onComplete,this._onCompleteParams);
		}
		motion.Actuate.unload(this);
	}
	,change: function() {
		if(this._onUpdate != null) this._onUpdate.apply(this._onUpdate,this._onUpdateParams);
	}
	,autoVisible: function(value) {
		if(value == null) value = true;
		this._autoVisible = value;
		return this;
	}
	,apply: function() {
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var i = _g1[_g];
			++_g;
			if(Reflect.hasField(this.target,i)) this.target[i] = Reflect.field(this.properties,i); else Reflect.setProperty(this.target,i,Reflect.field(this.properties,i));
		}
	}
	,special: null
	,_snapping: null
	,_smartRotation: null
	,_reverse: null
	,_repeat: null
	,_reflect: null
	,_onUpdateParams: null
	,_onUpdate: null
	,_onRepeatParams: null
	,_onRepeat: null
	,_onCompleteParams: null
	,_onComplete: null
	,_ease: null
	,_delay: null
	,_autoVisible: null
	,target: null
	,properties: null
	,id: null
	,duration: null
	,__class__: motion.actuators.GenericActuator
}
motion.actuators.SimpleActuator = function(target,duration,properties) {
	this.active = true;
	this.propertyDetails = new Array();
	this.sendChange = false;
	this.paused = false;
	this.cacheVisible = false;
	this.initialized = false;
	this.setVisible = false;
	this.toggleVisible = false;
	this.startTime = flash.Lib.getTimer() / 1000;
	motion.actuators.GenericActuator.call(this,target,duration,properties);
	if(!motion.actuators.SimpleActuator.addedEvent) {
		motion.actuators.SimpleActuator.addedEvent = true;
		flash.Lib.get_current().get_stage().addEventListener(flash.events.Event.ENTER_FRAME,motion.actuators.SimpleActuator.stage_onEnterFrame);
	}
};
$hxClasses["motion.actuators.SimpleActuator"] = motion.actuators.SimpleActuator;
motion.actuators.SimpleActuator.__name__ = ["motion","actuators","SimpleActuator"];
motion.actuators.SimpleActuator.stage_onEnterFrame = function(event) {
	var currentTime = flash.Lib.getTimer() / 1000;
	var actuator;
	var j = 0;
	var _g1 = 0, _g = motion.actuators.SimpleActuator.actuatorsLength;
	while(_g1 < _g) {
		var i = _g1++;
		actuator = motion.actuators.SimpleActuator.actuators[j];
		if(actuator.active) {
			if(currentTime > actuator.timeOffset) actuator.update(currentTime);
			j++;
		} else {
			motion.actuators.SimpleActuator.actuators.splice(j,1);
			--motion.actuators.SimpleActuator.actuatorsLength;
		}
	}
}
motion.actuators.SimpleActuator.__super__ = motion.actuators.GenericActuator;
motion.actuators.SimpleActuator.prototype = $extend(motion.actuators.GenericActuator.prototype,{
	update: function(currentTime) {
		if(!this.paused) {
			var details;
			var easing;
			var i;
			var tweenPosition = (currentTime - this.timeOffset) / this.duration;
			if(tweenPosition > 1) tweenPosition = 1;
			if(!this.initialized) this.initialize();
			if(!this.special) {
				easing = this._ease.calculate(tweenPosition);
				var _g1 = 0, _g = this.detailsLength;
				while(_g1 < _g) {
					var i1 = _g1++;
					details = this.propertyDetails[i1];
					if(details.isField) details.target[details.propertyName] = details.start + details.change * easing; else Reflect.setProperty(details.target,details.propertyName,details.start + details.change * easing);
				}
			} else {
				if(!this._reverse) easing = this._ease.calculate(tweenPosition); else easing = this._ease.calculate(1 - tweenPosition);
				var endValue;
				var _g1 = 0, _g = this.detailsLength;
				while(_g1 < _g) {
					var i1 = _g1++;
					details = this.propertyDetails[i1];
					if(this._smartRotation && (details.propertyName == "rotation" || details.propertyName == "rotationX" || details.propertyName == "rotationY" || details.propertyName == "rotationZ")) {
						var rotation = details.change % 360;
						if(rotation > 180) rotation -= 360; else if(rotation < -180) rotation += 360;
						endValue = details.start + rotation * easing;
					} else endValue = details.start + details.change * easing;
					if(!this._snapping) {
						if(details.isField) details.target[details.propertyName] = endValue; else Reflect.setProperty(details.target,details.propertyName,endValue);
					} else if(details.isField) details.target[details.propertyName] = Math.round(endValue); else Reflect.setProperty(details.target,details.propertyName,Math.round(endValue));
				}
			}
			if(tweenPosition == 1) {
				if(this._repeat == 0) {
					this.active = false;
					if(this.toggleVisible && this.target.alpha == 0) this.target.visible = false;
					this.complete(true);
					return;
				} else {
					if(this._onRepeat != null) this._onRepeat.apply(this._onRepeat,this._onRepeatParams);
					if(this._reflect) this._reverse = !this._reverse;
					this.startTime = currentTime;
					this.timeOffset = this.startTime + this._delay;
					if(this._repeat > 0) this._repeat--;
				}
			}
			if(this.sendChange) this.change();
		}
	}
	,stop: function(properties,complete,sendEvent) {
		if(this.active) {
			if(properties == null) {
				this.active = false;
				if(complete) this.apply();
				this.complete(sendEvent);
				return;
			}
			var _g = 0, _g1 = Reflect.fields(properties);
			while(_g < _g1.length) {
				var i = _g1[_g];
				++_g;
				if(Reflect.hasField(this.properties,i)) {
					this.active = false;
					if(complete) this.apply();
					this.complete(sendEvent);
					return;
				}
			}
		}
	}
	,resume: function() {
		if(this.paused) {
			this.paused = false;
			this.timeOffset += (flash.Lib.getTimer() - this.pauseTime) / 1000;
		}
	}
	,pause: function() {
		this.paused = true;
		this.pauseTime = flash.Lib.getTimer();
	}
	,onUpdate: function(handler,parameters) {
		this._onUpdate = handler;
		this._onUpdateParams = parameters;
		this.sendChange = true;
		return this;
	}
	,move: function() {
		this.toggleVisible = Reflect.hasField(this.properties,"alpha") && js.Boot.__instanceof(this.target,flash.display.DisplayObject);
		if(this.toggleVisible && !this.target.visible && this.properties.alpha != 0) {
			this.setVisible = true;
			this.cacheVisible = this.target.visible;
			this.target.visible = true;
		}
		this.timeOffset = this.startTime;
		motion.actuators.SimpleActuator.actuators.push(this);
		++motion.actuators.SimpleActuator.actuatorsLength;
	}
	,initialize: function() {
		var details;
		var start;
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var i = _g1[_g];
			++_g;
			var isField = true;
			if(Reflect.hasField(this.target,i)) start = Reflect.field(this.target,i); else {
				isField = false;
				start = Reflect.getProperty(this.target,i);
			}
			details = new motion.actuators.PropertyDetails(this.target,i,start,Reflect.field(this.properties,i) - start,isField);
			this.propertyDetails.push(details);
		}
		this.detailsLength = this.propertyDetails.length;
		this.initialized = true;
	}
	,delay: function(duration) {
		this._delay = duration;
		this.timeOffset = this.startTime + duration;
		return this;
	}
	,autoVisible: function(value) {
		if(value == null) value = true;
		this._autoVisible = value;
		if(!value) {
			this.toggleVisible = false;
			if(this.setVisible) this.target.visible = this.cacheVisible;
		}
		return this;
	}
	,toggleVisible: null
	,startTime: null
	,setVisible: null
	,sendChange: null
	,propertyDetails: null
	,pauseTime: null
	,paused: null
	,initialized: null
	,detailsLength: null
	,cacheVisible: null
	,active: null
	,timeOffset: null
	,__class__: motion.actuators.SimpleActuator
});
motion.easing = {}
motion.easing.Expo = function() { }
$hxClasses["motion.easing.Expo"] = motion.easing.Expo;
motion.easing.Expo.__name__ = ["motion","easing","Expo"];
motion.easing.Expo.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Expo.get_easeIn = function() {
	return new motion.easing.ExpoEaseIn();
}
motion.easing.Expo.get_easeInOut = function() {
	return new motion.easing.ExpoEaseInOut();
}
motion.easing.Expo.get_easeOut = function() {
	return new motion.easing.ExpoEaseOut();
}
motion.easing.IEasing = function() { }
$hxClasses["motion.easing.IEasing"] = motion.easing.IEasing;
motion.easing.IEasing.__name__ = ["motion","easing","IEasing"];
motion.easing.IEasing.prototype = {
	ease: null
	,calculate: null
	,__class__: motion.easing.IEasing
}
motion.easing.ExpoEaseOut = function() {
};
$hxClasses["motion.easing.ExpoEaseOut"] = motion.easing.ExpoEaseOut;
motion.easing.ExpoEaseOut.__name__ = ["motion","easing","ExpoEaseOut"];
motion.easing.ExpoEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.ExpoEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return t == d?b + c:c * (1 - Math.pow(2,-10 * t / d)) + b;
	}
	,calculate: function(k) {
		return k == 1?1:1 - Math.pow(2,-10 * k);
	}
	,__class__: motion.easing.ExpoEaseOut
}
motion.Actuate = function() { }
$hxClasses["motion.Actuate"] = motion.Actuate;
motion.Actuate.__name__ = ["motion","Actuate"];
motion.Actuate.apply = function(target,properties,customActuator) {
	motion.Actuate.stop(target,properties);
	if(customActuator == null) customActuator = motion.Actuate.defaultActuator;
	var actuator = Type.createInstance(customActuator,[target,0,properties]);
	actuator.apply();
	return actuator;
}
motion.Actuate.effects = function(target,duration,overwrite) {
	if(overwrite == null) overwrite = true;
	return new motion._Actuate.EffectsOptions(target,duration,overwrite);
}
motion.Actuate.getLibrary = function(target) {
	if(!motion.Actuate.targetLibraries.exists(target)) motion.Actuate.targetLibraries.set(target,new Array());
	return motion.Actuate.targetLibraries.get(target);
}
motion.Actuate.motionPath = function(target,duration,properties,overwrite) {
	if(overwrite == null) overwrite = true;
	return motion.Actuate.tween(target,duration,properties,overwrite,motion.actuators.MotionPathActuator);
}
motion.Actuate.pause = function(target) {
	if(js.Boot.__instanceof(target,motion.actuators.GenericActuator)) (js.Boot.__cast(target , motion.actuators.GenericActuator)).pause(); else {
		var library = motion.Actuate.getLibrary(target);
		var _g = 0;
		while(_g < library.length) {
			var actuator = library[_g];
			++_g;
			actuator.pause();
		}
	}
}
motion.Actuate.pauseAll = function() {
	var $it0 = motion.Actuate.targetLibraries.iterator();
	while( $it0.hasNext() ) {
		var library = $it0.next();
		var _g = 0;
		while(_g < library.length) {
			var actuator = library[_g];
			++_g;
			actuator.pause();
		}
	}
}
motion.Actuate.reset = function() {
	var $it0 = motion.Actuate.targetLibraries.iterator();
	while( $it0.hasNext() ) {
		var library = $it0.next();
		var i = library.length - 1;
		while(i >= 0) {
			library[i].stop(null,false,false);
			i--;
		}
	}
	motion.Actuate.targetLibraries = new haxe.ds.ObjectMap();
}
motion.Actuate.resume = function(target) {
	if(js.Boot.__instanceof(target,motion.actuators.GenericActuator)) (js.Boot.__cast(target , motion.actuators.GenericActuator)).resume(); else {
		var library = motion.Actuate.getLibrary(target);
		var _g = 0;
		while(_g < library.length) {
			var actuator = library[_g];
			++_g;
			actuator.resume();
		}
	}
}
motion.Actuate.resumeAll = function() {
	var $it0 = motion.Actuate.targetLibraries.iterator();
	while( $it0.hasNext() ) {
		var library = $it0.next();
		var _g = 0;
		while(_g < library.length) {
			var actuator = library[_g];
			++_g;
			actuator.resume();
		}
	}
}
motion.Actuate.stop = function(target,properties,complete,sendEvent) {
	if(sendEvent == null) sendEvent = true;
	if(complete == null) complete = false;
	if(target != null) {
		if(js.Boot.__instanceof(target,motion.actuators.GenericActuator)) (js.Boot.__cast(target , motion.actuators.GenericActuator)).stop(null,complete,sendEvent); else {
			var library = motion.Actuate.getLibrary(target);
			if(js.Boot.__instanceof(properties,String)) {
				var temp = { };
				Reflect.setField(temp,properties,null);
				properties = temp;
			} else if(js.Boot.__instanceof(properties,Array)) {
				var temp = { };
				var _g = 0, _g1 = js.Boot.__cast(properties , Array);
				while(_g < _g1.length) {
					var property = _g1[_g];
					++_g;
					Reflect.setField(temp,property,null);
				}
				properties = temp;
			}
			var i = library.length - 1;
			while(i >= 0) {
				library[i].stop(properties,complete,sendEvent);
				i--;
			}
		}
	}
}
motion.Actuate.timer = function(duration,customActuator) {
	return motion.Actuate.tween(new motion._Actuate.TweenTimer(0),duration,new motion._Actuate.TweenTimer(1),false,customActuator);
}
motion.Actuate.transform = function(target,duration,overwrite) {
	if(overwrite == null) overwrite = true;
	if(duration == null) duration = 0;
	return new motion._Actuate.TransformOptions(target,duration,overwrite);
}
motion.Actuate.tween = function(target,duration,properties,overwrite,customActuator) {
	if(overwrite == null) overwrite = true;
	if(target != null) {
		if(duration > 0) {
			if(customActuator == null) customActuator = motion.Actuate.defaultActuator;
			var actuator = Type.createInstance(customActuator,[target,duration,properties]);
			var library = motion.Actuate.getLibrary(actuator.target);
			if(overwrite) {
				var i = library.length - 1;
				while(i >= 0) {
					library[i].stop(actuator.properties,false,false);
					i--;
				}
			}
			library.push(actuator);
			actuator.move();
			return actuator;
		} else return motion.Actuate.apply(target,properties,customActuator);
	}
	return null;
}
motion.Actuate.unload = function(actuator) {
	var target = actuator.target;
	if(motion.Actuate.targetLibraries.h.hasOwnProperty(target.__id__)) {
		HxOverrides.remove(motion.Actuate.targetLibraries.h[target.__id__],actuator);
		if(motion.Actuate.targetLibraries.h[target.__id__].length == 0) motion.Actuate.targetLibraries.remove(target);
	}
}
motion.Actuate.update = function(target,duration,start,end,overwrite) {
	if(overwrite == null) overwrite = true;
	var properties = { start : start, end : end};
	return motion.Actuate.tween(target,duration,properties,overwrite,motion.actuators.MethodActuator);
}
motion._Actuate = {}
motion._Actuate.EffectsOptions = function(target,duration,overwrite) {
	this.target = target;
	this.duration = duration;
	this.overwrite = overwrite;
};
$hxClasses["motion._Actuate.EffectsOptions"] = motion._Actuate.EffectsOptions;
motion._Actuate.EffectsOptions.__name__ = ["motion","_Actuate","EffectsOptions"];
motion._Actuate.EffectsOptions.prototype = {
	filter: function(reference,properties) {
		properties.filter = reference;
		return motion.Actuate.tween(this.target,this.duration,properties,this.overwrite,motion.actuators.FilterActuator);
	}
	,target: null
	,overwrite: null
	,duration: null
	,__class__: motion._Actuate.EffectsOptions
}
motion._Actuate.TransformOptions = function(target,duration,overwrite) {
	this.target = target;
	this.duration = duration;
	this.overwrite = overwrite;
};
$hxClasses["motion._Actuate.TransformOptions"] = motion._Actuate.TransformOptions;
motion._Actuate.TransformOptions.__name__ = ["motion","_Actuate","TransformOptions"];
motion._Actuate.TransformOptions.prototype = {
	sound: function(volume,pan) {
		var properties = { };
		if(volume != null) properties.soundVolume = volume;
		if(pan != null) properties.soundPan = pan;
		return motion.Actuate.tween(this.target,this.duration,properties,this.overwrite,motion.actuators.TransformActuator);
	}
	,color: function(value,strength,alpha) {
		if(strength == null) strength = 1;
		if(value == null) value = 0;
		var properties = { colorValue : value, colorStrength : strength};
		if(alpha != null) properties.colorAlpha = alpha;
		return motion.Actuate.tween(this.target,this.duration,properties,this.overwrite,motion.actuators.TransformActuator);
	}
	,target: null
	,overwrite: null
	,duration: null
	,__class__: motion._Actuate.TransformOptions
}
motion._Actuate.TweenTimer = function(progress) {
	this.progress = progress;
};
$hxClasses["motion._Actuate.TweenTimer"] = motion._Actuate.TweenTimer;
motion._Actuate.TweenTimer.__name__ = ["motion","_Actuate","TweenTimer"];
motion._Actuate.TweenTimer.prototype = {
	progress: null
	,__class__: motion._Actuate.TweenTimer
}
motion.MotionPath = function() {
	this._x = new motion.ComponentPath();
	this._y = new motion.ComponentPath();
};
$hxClasses["motion.MotionPath"] = motion.MotionPath;
motion.MotionPath.__name__ = ["motion","MotionPath"];
motion.MotionPath.prototype = {
	get_y: function() {
		return this._y;
	}
	,get_x: function() {
		return this._x;
	}
	,line: function(x,y,strength) {
		if(strength == null) strength = 1;
		this._x.addPath(new motion.LinearPath(x,strength));
		this._y.addPath(new motion.LinearPath(y,strength));
		return this;
	}
	,bezier: function(x,y,controlX,controlY,strength) {
		if(strength == null) strength = 1;
		this._x.addPath(new motion.BezierPath(x,controlX,strength));
		this._y.addPath(new motion.BezierPath(y,controlY,strength));
		return this;
	}
	,_y: null
	,_x: null
	,y: null
	,x: null
	,__class__: motion.MotionPath
	,__properties__: {get_x:"get_x",get_y:"get_y"}
}
motion.IComponentPath = function() { }
$hxClasses["motion.IComponentPath"] = motion.IComponentPath;
motion.IComponentPath.__name__ = ["motion","IComponentPath"];
motion.IComponentPath.prototype = {
	calculate: null
	,start: null
	,end: null
	,__class__: motion.IComponentPath
}
motion.ComponentPath = function() {
	this.paths = new Array();
	this.start = 0;
	this.totalStrength = 0;
};
$hxClasses["motion.ComponentPath"] = motion.ComponentPath;
motion.ComponentPath.__name__ = ["motion","ComponentPath"];
motion.ComponentPath.__interfaces__ = [motion.IComponentPath];
motion.ComponentPath.prototype = {
	get_end: function() {
		if(this.paths.length > 0) {
			var path = this.paths[this.paths.length - 1];
			return path.end;
		} else return this.start;
	}
	,calculate: function(k) {
		if(this.paths.length == 1) return this.paths[0].calculate(this.start,k); else {
			var ratio = k * this.totalStrength;
			var lastEnd = this.start;
			var _g = 0, _g1 = this.paths;
			while(_g < _g1.length) {
				var path = _g1[_g];
				++_g;
				if(ratio > path.strength) {
					ratio -= path.strength;
					lastEnd = path.end;
				} else return path.calculate(lastEnd,ratio / path.strength);
			}
		}
		return 0;
	}
	,addPath: function(path) {
		this.paths.push(path);
		this.totalStrength += path.strength;
	}
	,totalStrength: null
	,paths: null
	,end: null
	,start: null
	,__class__: motion.ComponentPath
	,__properties__: {get_end:"get_end"}
}
motion.BezierPath = function(end,control,strength) {
	this.end = end;
	this.control = control;
	this.strength = strength;
};
$hxClasses["motion.BezierPath"] = motion.BezierPath;
motion.BezierPath.__name__ = ["motion","BezierPath"];
motion.BezierPath.prototype = {
	calculate: function(start,k) {
		return (1 - k) * (1 - k) * start + 2 * (1 - k) * k * this.control + k * k * this.end;
	}
	,strength: null
	,end: null
	,control: null
	,__class__: motion.BezierPath
}
motion.LinearPath = function(end,strength) {
	motion.BezierPath.call(this,end,0,strength);
};
$hxClasses["motion.LinearPath"] = motion.LinearPath;
motion.LinearPath.__name__ = ["motion","LinearPath"];
motion.LinearPath.__super__ = motion.BezierPath;
motion.LinearPath.prototype = $extend(motion.BezierPath.prototype,{
	calculate: function(start,k) {
		return start + k * (this.end - start);
	}
	,__class__: motion.LinearPath
});
motion.actuators.FilterActuator = function(target,duration,properties) {
	this.filterIndex = -1;
	motion.actuators.SimpleActuator.call(this,target,duration,properties);
	if(js.Boot.__instanceof(properties.filter,Class)) {
		this.filterClass = properties.filter;
		var _g = 0, _g1 = (js.Boot.__cast(target , flash.display.DisplayObject)).get_filters();
		while(_g < _g1.length) {
			var filter = _g1[_g];
			++_g;
			if(js.Boot.__instanceof(filter,this.filterClass)) this.filter = filter;
		}
	} else {
		this.filterIndex = properties.filter;
		this.filter = (js.Boot.__cast(target , flash.display.DisplayObject)).get_filters()[this.filterIndex];
	}
};
$hxClasses["motion.actuators.FilterActuator"] = motion.actuators.FilterActuator;
motion.actuators.FilterActuator.__name__ = ["motion","actuators","FilterActuator"];
motion.actuators.FilterActuator.__super__ = motion.actuators.SimpleActuator;
motion.actuators.FilterActuator.prototype = $extend(motion.actuators.SimpleActuator.prototype,{
	update: function(currentTime) {
		motion.actuators.SimpleActuator.prototype.update.call(this,currentTime);
		var filters = (js.Boot.__cast(this.target , flash.display.DisplayObject)).get_filters();
		if(this.filterIndex > -1) Reflect.setField(filters,this.properties.filter,this.filter); else {
			var _g1 = 0, _g = filters.length;
			while(_g1 < _g) {
				var i = _g1++;
				if(js.Boot.__instanceof(filters[i],this.filterClass)) filters[i] = this.filter;
			}
		}
		this.target.filters = filters;
	}
	,initialize: function() {
		var details;
		var start;
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var propertyName = _g1[_g];
			++_g;
			if(propertyName != "filter") {
				start = Reflect.field(this.filter,propertyName);
				details = new motion.actuators.PropertyDetails(this.filter,propertyName,start,Reflect.field(this.properties,propertyName) - start);
				this.propertyDetails.push(details);
			}
		}
		this.detailsLength = this.propertyDetails.length;
		this.initialized = true;
	}
	,apply: function() {
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var propertyName = _g1[_g];
			++_g;
			if(propertyName != "filter") this.filter[propertyName] = Reflect.field(this.properties,propertyName);
		}
		var filters = this.target.filters;
		Reflect.setField(filters,this.properties.filter,this.filter);
		this.target.filters = filters;
	}
	,filterIndex: null
	,filterClass: null
	,filter: null
	,__class__: motion.actuators.FilterActuator
});
motion.actuators.MethodActuator = function(target,duration,properties) {
	this.currentParameters = new Array();
	this.tweenProperties = { };
	motion.actuators.SimpleActuator.call(this,target,duration,properties);
	if(!Reflect.hasField(properties,"start")) this.properties.start = new Array();
	if(!Reflect.hasField(properties,"end")) this.properties.end = this.properties.start;
	var _g1 = 0, _g = this.properties.start.length;
	while(_g1 < _g) {
		var i = _g1++;
		this.currentParameters.push(null);
	}
};
$hxClasses["motion.actuators.MethodActuator"] = motion.actuators.MethodActuator;
motion.actuators.MethodActuator.__name__ = ["motion","actuators","MethodActuator"];
motion.actuators.MethodActuator.__super__ = motion.actuators.SimpleActuator;
motion.actuators.MethodActuator.prototype = $extend(motion.actuators.SimpleActuator.prototype,{
	update: function(currentTime) {
		motion.actuators.SimpleActuator.prototype.update.call(this,currentTime);
		if(this.active) {
			var _g1 = 0, _g = this.properties.start.length;
			while(_g1 < _g) {
				var i = _g1++;
				this.currentParameters[i] = Reflect.field(this.tweenProperties,"param" + i);
			}
			this.target.apply(null,this.currentParameters);
		}
	}
	,initialize: function() {
		var details;
		var propertyName;
		var start;
		var _g1 = 0, _g = this.properties.start.length;
		while(_g1 < _g) {
			var i = _g1++;
			propertyName = "param" + i;
			start = this.properties.start[i];
			this.tweenProperties[propertyName] = start;
			if(js.Boot.__instanceof(start,Float) || js.Boot.__instanceof(start,Int)) {
				details = new motion.actuators.PropertyDetails(this.tweenProperties,propertyName,start,this.properties.end[i] - start);
				this.propertyDetails.push(details);
			}
		}
		this.detailsLength = this.propertyDetails.length;
		this.initialized = true;
	}
	,complete: function(sendEvent) {
		if(sendEvent == null) sendEvent = true;
		var _g1 = 0, _g = this.properties.start.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.currentParameters[i] = Reflect.field(this.tweenProperties,"param" + i);
		}
		this.target.apply(null,this.currentParameters);
		motion.actuators.SimpleActuator.prototype.complete.call(this,sendEvent);
	}
	,apply: function() {
		Reflect.callMethod(null,this.target,this.properties.end);
	}
	,tweenProperties: null
	,currentParameters: null
	,__class__: motion.actuators.MethodActuator
});
motion.actuators.MotionPathActuator = function(target,duration,properties) {
	motion.actuators.SimpleActuator.call(this,target,duration,properties);
};
$hxClasses["motion.actuators.MotionPathActuator"] = motion.actuators.MotionPathActuator;
motion.actuators.MotionPathActuator.__name__ = ["motion","actuators","MotionPathActuator"];
motion.actuators.MotionPathActuator.__super__ = motion.actuators.SimpleActuator;
motion.actuators.MotionPathActuator.prototype = $extend(motion.actuators.SimpleActuator.prototype,{
	update: function(currentTime) {
		if(!this.paused) {
			var details;
			var easing;
			var tweenPosition = (currentTime - this.timeOffset) / this.duration;
			if(tweenPosition > 1) tweenPosition = 1;
			if(!this.initialized) this.initialize();
			if(!this.special) {
				easing = this._ease.calculate(tweenPosition);
				var _g = 0, _g1 = this.propertyDetails;
				while(_g < _g1.length) {
					var details1 = _g1[_g];
					++_g;
					if(details1.isField) details1.target[details1.propertyName] = (js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing); else Reflect.setProperty(details1.target,details1.propertyName,(js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing));
				}
			} else {
				if(!this._reverse) easing = this._ease.calculate(tweenPosition); else easing = this._ease.calculate(1 - tweenPosition);
				var endValue;
				var _g = 0, _g1 = this.propertyDetails;
				while(_g < _g1.length) {
					var details1 = _g1[_g];
					++_g;
					if(!this._snapping) {
						if(details1.isField) details1.target[details1.propertyName] = (js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing); else Reflect.setProperty(details1.target,details1.propertyName,(js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing));
					} else if(details1.isField) details1.target[details1.propertyName] = Math.round((js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing)); else Reflect.setProperty(details1.target,details1.propertyName,Math.round((js.Boot.__cast(details1 , motion.actuators.PropertyPathDetails)).path.calculate(easing)));
				}
			}
			if(tweenPosition == 1) {
				if(this._repeat == 0) {
					this.active = false;
					if(this.toggleVisible && this.target.alpha == 0) this.target.visible = false;
					this.complete(true);
					return;
				} else {
					if(this._reflect) this._reverse = !this._reverse;
					this.startTime = currentTime;
					this.timeOffset = this.startTime + this._delay;
					if(this._repeat > 0) this._repeat--;
				}
			}
			if(this.sendChange) this.change();
		}
	}
	,initialize: function() {
		var details;
		var path;
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var propertyName = _g1[_g];
			++_g;
			path = js.Boot.__cast(Reflect.field(this.properties,propertyName) , motion.IComponentPath);
			if(path != null) {
				var isField = true;
				if(Reflect.hasField(this.target,propertyName)) path.start = Reflect.field(this.target,propertyName); else {
					isField = false;
					path.start = Reflect.getProperty(this.target,propertyName);
				}
				details = new motion.actuators.PropertyPathDetails(this.target,propertyName,path,isField);
				this.propertyDetails.push(details);
			}
		}
		this.detailsLength = this.propertyDetails.length;
		this.initialized = true;
	}
	,apply: function() {
		var _g = 0, _g1 = Reflect.fields(this.properties);
		while(_g < _g1.length) {
			var propertyName = _g1[_g];
			++_g;
			if(Reflect.hasField(this.target,propertyName)) this.target[propertyName] = (js.Boot.__cast(Reflect.field(this.properties,propertyName) , motion.IComponentPath)).get_end(); else Reflect.setProperty(this.target,propertyName,(js.Boot.__cast(Reflect.field(this.properties,propertyName) , motion.IComponentPath)).get_end());
		}
	}
	,__class__: motion.actuators.MotionPathActuator
});
motion.actuators.PropertyDetails = function(target,propertyName,start,change,isField) {
	if(isField == null) isField = true;
	this.target = target;
	this.propertyName = propertyName;
	this.start = start;
	this.change = change;
	this.isField = isField;
};
$hxClasses["motion.actuators.PropertyDetails"] = motion.actuators.PropertyDetails;
motion.actuators.PropertyDetails.__name__ = ["motion","actuators","PropertyDetails"];
motion.actuators.PropertyDetails.prototype = {
	target: null
	,start: null
	,propertyName: null
	,isField: null
	,change: null
	,__class__: motion.actuators.PropertyDetails
}
motion.actuators.PropertyPathDetails = function(target,propertyName,path,isField) {
	if(isField == null) isField = true;
	motion.actuators.PropertyDetails.call(this,target,propertyName,0,0,isField);
	this.path = path;
};
$hxClasses["motion.actuators.PropertyPathDetails"] = motion.actuators.PropertyPathDetails;
motion.actuators.PropertyPathDetails.__name__ = ["motion","actuators","PropertyPathDetails"];
motion.actuators.PropertyPathDetails.__super__ = motion.actuators.PropertyDetails;
motion.actuators.PropertyPathDetails.prototype = $extend(motion.actuators.PropertyDetails.prototype,{
	path: null
	,__class__: motion.actuators.PropertyPathDetails
});
motion.actuators.TransformActuator = function(target,duration,properties) {
	motion.actuators.SimpleActuator.call(this,target,duration,properties);
};
$hxClasses["motion.actuators.TransformActuator"] = motion.actuators.TransformActuator;
motion.actuators.TransformActuator.__name__ = ["motion","actuators","TransformActuator"];
motion.actuators.TransformActuator.__super__ = motion.actuators.SimpleActuator;
motion.actuators.TransformActuator.prototype = $extend(motion.actuators.SimpleActuator.prototype,{
	update: function(currentTime) {
		motion.actuators.SimpleActuator.prototype.update.call(this,currentTime);
		if(this.endColorTransform != null) this.target.transform.colorTransform = this.tweenColorTransform;
		if(this.endSoundTransform != null) this.target.soundTransform = this.tweenSoundTransform;
	}
	,initializeSound: function() {
		if(this.target.soundTransform == null) this.target.soundTransform = new flash.media.SoundTransform();
		var start = this.target.soundTransform;
		this.endSoundTransform = this.target.soundTransform;
		this.tweenSoundTransform = new flash.media.SoundTransform();
		if(Reflect.hasField(this.properties,"soundVolume")) {
			this.endSoundTransform.volume = this.properties.soundVolume;
			this.propertyDetails.push(new motion.actuators.PropertyDetails(this.tweenSoundTransform,"volume",start.volume,this.endSoundTransform.volume - start.volume));
		}
		if(Reflect.hasField(this.properties,"soundPan")) {
			this.endSoundTransform.pan = this.properties.soundPan;
			this.propertyDetails.push(new motion.actuators.PropertyDetails(this.tweenSoundTransform,"pan",start.pan,this.endSoundTransform.pan - start.pan));
		}
	}
	,initializeColor: function() {
		this.endColorTransform = new flash.geom.ColorTransform();
		var color = this.properties.colorValue;
		var strength = this.properties.colorStrength;
		if(strength < 1) {
			var multiplier;
			var offset;
			if(strength < 0.5) {
				multiplier = 1;
				offset = strength * 2;
			} else {
				multiplier = 1 - (strength - 0.5) * 2;
				offset = 1;
			}
			this.endColorTransform.redMultiplier = multiplier;
			this.endColorTransform.greenMultiplier = multiplier;
			this.endColorTransform.blueMultiplier = multiplier;
			this.endColorTransform.redOffset = offset * (color >> 16 & 255);
			this.endColorTransform.greenOffset = offset * (color >> 8 & 255);
			this.endColorTransform.blueOffset = offset * (color & 255);
		} else {
			this.endColorTransform.redMultiplier = 0;
			this.endColorTransform.greenMultiplier = 0;
			this.endColorTransform.blueMultiplier = 0;
			this.endColorTransform.redOffset = color >> 16 & 255;
			this.endColorTransform.greenOffset = color >> 8 & 255;
			this.endColorTransform.blueOffset = color & 255;
		}
		var propertyNames = ["redMultiplier","greenMultiplier","blueMultiplier","redOffset","greenOffset","blueOffset"];
		if(Reflect.hasField(this.properties,"colorAlpha")) {
			this.endColorTransform.alphaMultiplier = this.properties.colorAlpha;
			propertyNames.push("alphaMultiplier");
		} else this.endColorTransform.alphaMultiplier = this.target.alpha;
		var begin = this.target.transform.colorTransform;
		this.tweenColorTransform = new flash.geom.ColorTransform();
		var details;
		var start;
		var _g = 0;
		while(_g < propertyNames.length) {
			var propertyName = propertyNames[_g];
			++_g;
			start = Reflect.field(begin,propertyName);
			details = new motion.actuators.PropertyDetails(this.tweenColorTransform,propertyName,start,Reflect.field(this.endColorTransform,propertyName) - start);
			this.propertyDetails.push(details);
		}
	}
	,initialize: function() {
		if(Reflect.hasField(this.properties,"colorValue") && js.Boot.__instanceof(this.target,flash.display.DisplayObject)) this.initializeColor();
		if(Reflect.hasField(this.properties,"soundVolume") || Reflect.hasField(this.properties,"soundPan")) this.initializeSound();
		this.detailsLength = this.propertyDetails.length;
		this.initialized = true;
	}
	,apply: function() {
		this.initialize();
		if(this.endColorTransform != null) this.target.transform.colorTransform = this.endColorTransform;
		if(this.endSoundTransform != null) this.target.soundTransform = this.endSoundTransform;
	}
	,tweenSoundTransform: null
	,tweenColorTransform: null
	,endSoundTransform: null
	,endColorTransform: null
	,__class__: motion.actuators.TransformActuator
});
motion.easing.Back = function() { }
$hxClasses["motion.easing.Back"] = motion.easing.Back;
motion.easing.Back.__name__ = ["motion","easing","Back"];
motion.easing.Back.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Back.get_easeIn = function() {
	return new motion.easing.BackEaseIn(1.70158);
}
motion.easing.Back.get_easeInOut = function() {
	return new motion.easing.BackEaseInOut(1.70158);
}
motion.easing.Back.get_easeOut = function() {
	return new motion.easing.BackEaseOut(1.70158);
}
motion.easing.BackEaseIn = function(s) {
	this.s = s;
};
$hxClasses["motion.easing.BackEaseIn"] = motion.easing.BackEaseIn;
motion.easing.BackEaseIn.__name__ = ["motion","easing","BackEaseIn"];
motion.easing.BackEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.BackEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c * (t /= d) * t * ((this.s + 1) * t - this.s) + b;
	}
	,calculate: function(k) {
		return k * k * ((this.s + 1) * k - this.s);
	}
	,s: null
	,__class__: motion.easing.BackEaseIn
}
motion.easing.BackEaseInOut = function(s) {
	this.s = s;
};
$hxClasses["motion.easing.BackEaseInOut"] = motion.easing.BackEaseInOut;
motion.easing.BackEaseInOut.__name__ = ["motion","easing","BackEaseInOut"];
motion.easing.BackEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.BackEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if((t /= d / 2) < 1) return c / 2 * (t * t * (((this.s *= 1.525) + 1) * t - this.s)) + b;
		return c / 2 * ((t -= 2) * t * (((this.s *= 1.525) + 1) * t + this.s) + 2) + b;
	}
	,calculate: function(k) {
		if((k /= 0.5) < 1) return 0.5 * (k * k * (((this.s *= 1.525) + 1) * k - this.s));
		return 0.5 * ((k -= 2) * k * (((this.s *= 1.525) + 1) * k + this.s) + 2);
	}
	,s: null
	,__class__: motion.easing.BackEaseInOut
}
motion.easing.BackEaseOut = function(s) {
	this.s = s;
};
$hxClasses["motion.easing.BackEaseOut"] = motion.easing.BackEaseOut;
motion.easing.BackEaseOut.__name__ = ["motion","easing","BackEaseOut"];
motion.easing.BackEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.BackEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return c * ((t = t / d - 1) * t * ((this.s + 1) * t + this.s) + 1) + b;
	}
	,calculate: function(k) {
		return (k = k - 1) * k * ((this.s + 1) * k + this.s) + 1;
	}
	,s: null
	,__class__: motion.easing.BackEaseOut
}
motion.easing.Bounce = function() { }
$hxClasses["motion.easing.Bounce"] = motion.easing.Bounce;
motion.easing.Bounce.__name__ = ["motion","easing","Bounce"];
motion.easing.Bounce.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Bounce.get_easeIn = function() {
	return new motion.easing.BounceEaseIn();
}
motion.easing.Bounce.get_easeInOut = function() {
	return new motion.easing.BounceEaseInOut();
}
motion.easing.Bounce.get_easeOut = function() {
	return new motion.easing.BounceEaseOut();
}
motion.easing.BounceEaseIn = function() {
};
$hxClasses["motion.easing.BounceEaseIn"] = motion.easing.BounceEaseIn;
motion.easing.BounceEaseIn.__name__ = ["motion","easing","BounceEaseIn"];
motion.easing.BounceEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.BounceEaseIn._ease = function(t,b,c,d) {
	return c - motion.easing.BounceEaseOut._ease(d - t,0,c,d) + b;
}
motion.easing.BounceEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c - motion.easing.BounceEaseOut._ease(d - t,0,c,d) + b;
	}
	,calculate: function(k) {
		return 1 - motion.easing.BounceEaseOut._ease(1 - k,0,1,1);
	}
	,__class__: motion.easing.BounceEaseIn
}
motion.easing.BounceEaseInOut = function() {
};
$hxClasses["motion.easing.BounceEaseInOut"] = motion.easing.BounceEaseInOut;
motion.easing.BounceEaseInOut.__name__ = ["motion","easing","BounceEaseInOut"];
motion.easing.BounceEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.BounceEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if(t < d / 2) return (c - motion.easing.BounceEaseOut._ease(d - t * 2,0,c,d)) * .5 + b; else return motion.easing.BounceEaseOut._ease(t * 2 - d,0,c,d) * .5 + c * .5 + b;
	}
	,calculate: function(k) {
		if(k < .5) return (1 - motion.easing.BounceEaseOut._ease(1 - k * 2,0,1,1)) * .5; else return motion.easing.BounceEaseOut._ease(k * 2 - 1,0,1,1) * .5 + .5;
	}
	,__class__: motion.easing.BounceEaseInOut
}
motion.easing.BounceEaseOut = function() {
};
$hxClasses["motion.easing.BounceEaseOut"] = motion.easing.BounceEaseOut;
motion.easing.BounceEaseOut.__name__ = ["motion","easing","BounceEaseOut"];
motion.easing.BounceEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.BounceEaseOut._ease = function(t,b,c,d) {
	if((t /= d) < 1 / 2.75) return c * (7.5625 * t * t) + b; else if(t < 2 / 2.75) return c * (7.5625 * (t -= 1.5 / 2.75) * t + .75) + b; else if(t < 2.5 / 2.75) return c * (7.5625 * (t -= 2.25 / 2.75) * t + .9375) + b; else return c * (7.5625 * (t -= 2.625 / 2.75) * t + .984375) + b;
}
motion.easing.BounceEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return motion.easing.BounceEaseOut._ease(t,b,c,d);
	}
	,calculate: function(k) {
		return motion.easing.BounceEaseOut._ease(k,0,1,1);
	}
	,__class__: motion.easing.BounceEaseOut
}
motion.easing.Cubic = function() { }
$hxClasses["motion.easing.Cubic"] = motion.easing.Cubic;
motion.easing.Cubic.__name__ = ["motion","easing","Cubic"];
motion.easing.Cubic.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Cubic.get_easeIn = function() {
	return new motion.easing.CubicEaseIn();
}
motion.easing.Cubic.get_easeInOut = function() {
	return new motion.easing.CubicEaseInOut();
}
motion.easing.Cubic.get_easeOut = function() {
	return new motion.easing.CubicEaseOut();
}
motion.easing.CubicEaseIn = function() {
};
$hxClasses["motion.easing.CubicEaseIn"] = motion.easing.CubicEaseIn;
motion.easing.CubicEaseIn.__name__ = ["motion","easing","CubicEaseIn"];
motion.easing.CubicEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.CubicEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c * (t /= d) * t * t + b;
	}
	,calculate: function(k) {
		return k * k * k;
	}
	,__class__: motion.easing.CubicEaseIn
}
motion.easing.CubicEaseInOut = function() {
};
$hxClasses["motion.easing.CubicEaseInOut"] = motion.easing.CubicEaseInOut;
motion.easing.CubicEaseInOut.__name__ = ["motion","easing","CubicEaseInOut"];
motion.easing.CubicEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.CubicEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		return (t /= d / 2) < 1?c / 2 * t * t * t + b:c / 2 * ((t -= 2) * t * t + 2) + b;
	}
	,calculate: function(k) {
		return (k /= 0.5) < 1?0.5 * k * k * k:0.5 * ((k -= 2) * k * k + 2);
	}
	,__class__: motion.easing.CubicEaseInOut
}
motion.easing.CubicEaseOut = function() {
};
$hxClasses["motion.easing.CubicEaseOut"] = motion.easing.CubicEaseOut;
motion.easing.CubicEaseOut.__name__ = ["motion","easing","CubicEaseOut"];
motion.easing.CubicEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.CubicEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return c * ((t = t / d - 1) * t * t + 1) + b;
	}
	,calculate: function(k) {
		return --k * k * k + 1;
	}
	,__class__: motion.easing.CubicEaseOut
}
motion.easing.Elastic = function() { }
$hxClasses["motion.easing.Elastic"] = motion.easing.Elastic;
motion.easing.Elastic.__name__ = ["motion","easing","Elastic"];
motion.easing.Elastic.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Elastic.get_easeIn = function() {
	return new motion.easing.ElasticEaseIn(0.1,0.4);
}
motion.easing.Elastic.get_easeInOut = function() {
	return new motion.easing.ElasticEaseInOut(0.1,0.4);
}
motion.easing.Elastic.get_easeOut = function() {
	return new motion.easing.ElasticEaseOut(0.1,0.4);
}
motion.easing.ElasticEaseIn = function(a,p) {
	this.a = a;
	this.p = p;
};
$hxClasses["motion.easing.ElasticEaseIn"] = motion.easing.ElasticEaseIn;
motion.easing.ElasticEaseIn.__name__ = ["motion","easing","ElasticEaseIn"];
motion.easing.ElasticEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.ElasticEaseIn.prototype = {
	ease: function(t,b,c,d) {
		if(t == 0) return b;
		if((t /= d) == 1) return b + c;
		var s;
		if(this.a < Math.abs(c)) {
			this.a = c;
			s = this.p / 4;
		} else s = this.p / (2 * Math.PI) * Math.asin(c / this.a);
		return -(this.a * Math.pow(2,10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / this.p)) + b;
	}
	,calculate: function(k) {
		if(k == 0) return 0;
		if(k == 1) return 1;
		var s;
		if(this.a < 1) {
			this.a = 1;
			s = this.p / 4;
		} else s = this.p / (2 * Math.PI) * Math.asin(1 / this.a);
		return -(this.a * Math.pow(2,10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / this.p));
	}
	,p: null
	,a: null
	,__class__: motion.easing.ElasticEaseIn
}
motion.easing.ElasticEaseInOut = function(a,p) {
	this.a = a;
	this.p = p;
};
$hxClasses["motion.easing.ElasticEaseInOut"] = motion.easing.ElasticEaseInOut;
motion.easing.ElasticEaseInOut.__name__ = ["motion","easing","ElasticEaseInOut"];
motion.easing.ElasticEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.ElasticEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if(t == 0) return b;
		if((t /= d / 2) == 2) return b + c;
		var s;
		if(this.a < Math.abs(c)) {
			this.a = c;
			s = this.p / 4;
		} else s = this.p / (2 * Math.PI) * Math.asin(c / this.a);
		if(t < 1) return -0.5 * (this.a * Math.pow(2,10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / this.p)) + b;
		return this.a * Math.pow(2,-10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / this.p) * 0.5 + c + b;
	}
	,calculate: function(k) {
		if(k == 0) return 0;
		if((k /= 0.5) == 2) return 1;
		var p = 0.3 * 1.5;
		var a = 1;
		var s = p / 4;
		if(k < 1) return -0.5 * (Math.pow(2,10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p));
		return Math.pow(2,-10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p) * 0.5 + 1;
	}
	,p: null
	,a: null
	,__class__: motion.easing.ElasticEaseInOut
}
motion.easing.ElasticEaseOut = function(a,p) {
	this.a = a;
	this.p = p;
};
$hxClasses["motion.easing.ElasticEaseOut"] = motion.easing.ElasticEaseOut;
motion.easing.ElasticEaseOut.__name__ = ["motion","easing","ElasticEaseOut"];
motion.easing.ElasticEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.ElasticEaseOut.prototype = {
	ease: function(t,b,c,d) {
		if(t == 0) return b;
		if((t /= d) == 1) return b + c;
		var s;
		if(this.a < Math.abs(c)) {
			this.a = c;
			s = this.p / 4;
		} else s = this.p / (2 * Math.PI) * Math.asin(c / this.a);
		return this.a * Math.pow(2,-10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / this.p) + c + b;
	}
	,calculate: function(k) {
		if(k == 0) return 0;
		if(k == 1) return 1;
		var s;
		if(this.a < 1) {
			this.a = 1;
			s = this.p / 4;
		} else s = this.p / (2 * Math.PI) * Math.asin(1 / this.a);
		return this.a * Math.pow(2,-10 * k) * Math.sin((k - s) * (2 * Math.PI) / this.p) + 1;
	}
	,p: null
	,a: null
	,__class__: motion.easing.ElasticEaseOut
}
motion.easing.ExpoEaseIn = function() {
};
$hxClasses["motion.easing.ExpoEaseIn"] = motion.easing.ExpoEaseIn;
motion.easing.ExpoEaseIn.__name__ = ["motion","easing","ExpoEaseIn"];
motion.easing.ExpoEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.ExpoEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return t == 0?b:c * Math.pow(2,10 * (t / d - 1)) + b;
	}
	,calculate: function(k) {
		return k == 0?0:Math.pow(2,10 * (k - 1));
	}
	,__class__: motion.easing.ExpoEaseIn
}
motion.easing.ExpoEaseInOut = function() {
};
$hxClasses["motion.easing.ExpoEaseInOut"] = motion.easing.ExpoEaseInOut;
motion.easing.ExpoEaseInOut.__name__ = ["motion","easing","ExpoEaseInOut"];
motion.easing.ExpoEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.ExpoEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if(t == 0) return b;
		if(t == d) return b + c;
		if((t /= d / 2.0) < 1.0) return c / 2 * Math.pow(2,10 * (t - 1)) + b;
		return c / 2 * (2 - Math.pow(2,-10 * --t)) + b;
	}
	,calculate: function(k) {
		if(k == 0) return 0;
		if(k == 1) return 1;
		if((k /= 0.5) < 1.0) return 0.5 * Math.pow(2,10 * (k - 1));
		return 0.5 * (2 - Math.pow(2,-10 * --k));
	}
	,__class__: motion.easing.ExpoEaseInOut
}
motion.easing.Linear = function() { }
$hxClasses["motion.easing.Linear"] = motion.easing.Linear;
motion.easing.Linear.__name__ = ["motion","easing","Linear"];
motion.easing.Linear.__properties__ = {get_easeNone:"get_easeNone"}
motion.easing.Linear.get_easeNone = function() {
	return new motion.easing.LinearEaseNone();
}
motion.easing.LinearEaseNone = function() {
};
$hxClasses["motion.easing.LinearEaseNone"] = motion.easing.LinearEaseNone;
motion.easing.LinearEaseNone.__name__ = ["motion","easing","LinearEaseNone"];
motion.easing.LinearEaseNone.__interfaces__ = [motion.easing.IEasing];
motion.easing.LinearEaseNone.prototype = {
	ease: function(t,b,c,d) {
		return c * t / d + b;
	}
	,calculate: function(k) {
		return k;
	}
	,__class__: motion.easing.LinearEaseNone
}
motion.easing.Quad = function() { }
$hxClasses["motion.easing.Quad"] = motion.easing.Quad;
motion.easing.Quad.__name__ = ["motion","easing","Quad"];
motion.easing.Quad.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Quad.get_easeIn = function() {
	return new motion.easing.QuadEaseIn();
}
motion.easing.Quad.get_easeInOut = function() {
	return new motion.easing.QuadEaseInOut();
}
motion.easing.Quad.get_easeOut = function() {
	return new motion.easing.QuadEaseOut();
}
motion.easing.QuadEaseIn = function() {
};
$hxClasses["motion.easing.QuadEaseIn"] = motion.easing.QuadEaseIn;
motion.easing.QuadEaseIn.__name__ = ["motion","easing","QuadEaseIn"];
motion.easing.QuadEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuadEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c * (t /= d) * t + b;
	}
	,calculate: function(k) {
		return k * k;
	}
	,__class__: motion.easing.QuadEaseIn
}
motion.easing.QuadEaseInOut = function() {
};
$hxClasses["motion.easing.QuadEaseInOut"] = motion.easing.QuadEaseInOut;
motion.easing.QuadEaseInOut.__name__ = ["motion","easing","QuadEaseInOut"];
motion.easing.QuadEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuadEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if((t /= d / 2) < 1) return c / 2 * t * t + b;
		return -c / 2 * (--t * (t - 2) - 1) + b;
	}
	,calculate: function(k) {
		if((k *= 2) < 1) return 0.5 * k * k;
		return -0.5 * (--k * (k - 2) - 1);
	}
	,__class__: motion.easing.QuadEaseInOut
}
motion.easing.QuadEaseOut = function() {
};
$hxClasses["motion.easing.QuadEaseOut"] = motion.easing.QuadEaseOut;
motion.easing.QuadEaseOut.__name__ = ["motion","easing","QuadEaseOut"];
motion.easing.QuadEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuadEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return -c * (t /= d) * (t - 2) + b;
	}
	,calculate: function(k) {
		return -k * (k - 2);
	}
	,__class__: motion.easing.QuadEaseOut
}
motion.easing.Quart = function() { }
$hxClasses["motion.easing.Quart"] = motion.easing.Quart;
motion.easing.Quart.__name__ = ["motion","easing","Quart"];
motion.easing.Quart.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Quart.get_easeIn = function() {
	return new motion.easing.QuartEaseIn();
}
motion.easing.Quart.get_easeInOut = function() {
	return new motion.easing.QuartEaseInOut();
}
motion.easing.Quart.get_easeOut = function() {
	return new motion.easing.QuartEaseOut();
}
motion.easing.QuartEaseIn = function() {
};
$hxClasses["motion.easing.QuartEaseIn"] = motion.easing.QuartEaseIn;
motion.easing.QuartEaseIn.__name__ = ["motion","easing","QuartEaseIn"];
motion.easing.QuartEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuartEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c * (t /= d) * t * t * t + b;
	}
	,calculate: function(k) {
		return k * k * k * k;
	}
	,__class__: motion.easing.QuartEaseIn
}
motion.easing.QuartEaseInOut = function() {
};
$hxClasses["motion.easing.QuartEaseInOut"] = motion.easing.QuartEaseInOut;
motion.easing.QuartEaseInOut.__name__ = ["motion","easing","QuartEaseInOut"];
motion.easing.QuartEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuartEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if((t /= d / 2) < 1) return c / 2 * t * t * t * t + b;
		return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
	}
	,calculate: function(k) {
		if((k *= 2) < 1) return 0.5 * k * k * k * k;
		return -0.5 * ((k -= 2) * k * k * k - 2);
	}
	,__class__: motion.easing.QuartEaseInOut
}
motion.easing.QuartEaseOut = function() {
};
$hxClasses["motion.easing.QuartEaseOut"] = motion.easing.QuartEaseOut;
motion.easing.QuartEaseOut.__name__ = ["motion","easing","QuartEaseOut"];
motion.easing.QuartEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuartEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return -c * ((t = t / d - 1) * t * t * t - 1) + b;
	}
	,calculate: function(k) {
		return -(--k * k * k * k - 1);
	}
	,__class__: motion.easing.QuartEaseOut
}
motion.easing.Quint = function() { }
$hxClasses["motion.easing.Quint"] = motion.easing.Quint;
motion.easing.Quint.__name__ = ["motion","easing","Quint"];
motion.easing.Quint.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Quint.get_easeIn = function() {
	return new motion.easing.QuintEaseIn();
}
motion.easing.Quint.get_easeInOut = function() {
	return new motion.easing.QuintEaseInOut();
}
motion.easing.Quint.get_easeOut = function() {
	return new motion.easing.QuintEaseOut();
}
motion.easing.QuintEaseIn = function() {
};
$hxClasses["motion.easing.QuintEaseIn"] = motion.easing.QuintEaseIn;
motion.easing.QuintEaseIn.__name__ = ["motion","easing","QuintEaseIn"];
motion.easing.QuintEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuintEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return c * (t /= d) * t * t * t * t + b;
	}
	,calculate: function(k) {
		return k * k * k * k * k;
	}
	,__class__: motion.easing.QuintEaseIn
}
motion.easing.QuintEaseInOut = function() {
};
$hxClasses["motion.easing.QuintEaseInOut"] = motion.easing.QuintEaseInOut;
motion.easing.QuintEaseInOut.__name__ = ["motion","easing","QuintEaseInOut"];
motion.easing.QuintEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuintEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		if((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b;
		return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
	}
	,calculate: function(k) {
		if((k *= 2) < 1) return 0.5 * k * k * k * k * k;
		return 0.5 * ((k -= 2) * k * k * k * k + 2);
	}
	,__class__: motion.easing.QuintEaseInOut
}
motion.easing.QuintEaseOut = function() {
};
$hxClasses["motion.easing.QuintEaseOut"] = motion.easing.QuintEaseOut;
motion.easing.QuintEaseOut.__name__ = ["motion","easing","QuintEaseOut"];
motion.easing.QuintEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.QuintEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
	}
	,calculate: function(k) {
		return --k * k * k * k * k + 1;
	}
	,__class__: motion.easing.QuintEaseOut
}
motion.easing.Sine = function() { }
$hxClasses["motion.easing.Sine"] = motion.easing.Sine;
motion.easing.Sine.__name__ = ["motion","easing","Sine"];
motion.easing.Sine.__properties__ = {get_easeOut:"get_easeOut",get_easeInOut:"get_easeInOut",get_easeIn:"get_easeIn"}
motion.easing.Sine.get_easeIn = function() {
	return new motion.easing.SineEaseIn();
}
motion.easing.Sine.get_easeInOut = function() {
	return new motion.easing.SineEaseInOut();
}
motion.easing.Sine.get_easeOut = function() {
	return new motion.easing.SineEaseOut();
}
motion.easing.SineEaseIn = function() {
};
$hxClasses["motion.easing.SineEaseIn"] = motion.easing.SineEaseIn;
motion.easing.SineEaseIn.__name__ = ["motion","easing","SineEaseIn"];
motion.easing.SineEaseIn.__interfaces__ = [motion.easing.IEasing];
motion.easing.SineEaseIn.prototype = {
	ease: function(t,b,c,d) {
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
	}
	,calculate: function(k) {
		return 1 - Math.cos(k * (Math.PI / 2));
	}
	,__class__: motion.easing.SineEaseIn
}
motion.easing.SineEaseInOut = function() {
};
$hxClasses["motion.easing.SineEaseInOut"] = motion.easing.SineEaseInOut;
motion.easing.SineEaseInOut.__name__ = ["motion","easing","SineEaseInOut"];
motion.easing.SineEaseInOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.SineEaseInOut.prototype = {
	ease: function(t,b,c,d) {
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
	}
	,calculate: function(k) {
		return -(Math.cos(Math.PI * k) - 1) / 2;
	}
	,__class__: motion.easing.SineEaseInOut
}
motion.easing.SineEaseOut = function() {
};
$hxClasses["motion.easing.SineEaseOut"] = motion.easing.SineEaseOut;
motion.easing.SineEaseOut.__name__ = ["motion","easing","SineEaseOut"];
motion.easing.SineEaseOut.__interfaces__ = [motion.easing.IEasing];
motion.easing.SineEaseOut.prototype = {
	ease: function(t,b,c,d) {
		return c * Math.sin(t / d * (Math.PI / 2)) + b;
	}
	,calculate: function(k) {
		return Math.sin(k * (Math.PI / 2));
	}
	,__class__: motion.easing.SineEaseOut
}
var msignal = {}
msignal.Signal = function(valueClasses) {
	if(valueClasses == null) valueClasses = [];
	this.valueClasses = valueClasses;
	this.slots = msignal.SlotList.NIL;
	this.priorityBased = false;
};
$hxClasses["msignal.Signal"] = msignal.Signal;
msignal.Signal.__name__ = ["msignal","Signal"];
msignal.Signal.prototype = {
	get_numListeners: function() {
		return this.slots.get_length();
	}
	,createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return null;
	}
	,registrationPossible: function(listener,once) {
		if(!this.slots.nonEmpty) return true;
		var existingSlot = this.slots.find(listener);
		if(existingSlot == null) return true;
		if(existingSlot.once != once) throw "You cannot addOnce() then add() the same listener without removing the relationship first.";
		return false;
	}
	,registerListener: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		if(this.registrationPossible(listener,once)) {
			var newSlot = this.createSlot(listener,once,priority);
			if(!this.priorityBased && priority != 0) this.priorityBased = true;
			if(!this.priorityBased && priority == 0) this.slots = this.slots.prepend(newSlot); else this.slots = this.slots.insertWithPriority(newSlot);
			return newSlot;
		}
		return this.slots.find(listener);
	}
	,removeAll: function() {
		this.slots = msignal.SlotList.NIL;
	}
	,remove: function(listener) {
		var slot = this.slots.find(listener);
		if(slot == null) return null;
		this.slots = this.slots.filterNot(listener);
		return slot;
	}
	,addOnceWithPriority: function(listener,priority) {
		if(priority == null) priority = 0;
		return this.registerListener(listener,true,priority);
	}
	,addWithPriority: function(listener,priority) {
		if(priority == null) priority = 0;
		return this.registerListener(listener,false,priority);
	}
	,addOnce: function(listener) {
		return this.registerListener(listener,true);
	}
	,add: function(listener) {
		return this.registerListener(listener);
	}
	,priorityBased: null
	,slots: null
	,numListeners: null
	,valueClasses: null
	,__class__: msignal.Signal
	,__properties__: {get_numListeners:"get_numListeners"}
}
msignal.EventSignal = function(target) {
	msignal.Signal.call(this,[msignal.Event]);
	this.target = target;
};
$hxClasses["msignal.EventSignal"] = msignal.EventSignal;
msignal.EventSignal.__name__ = ["msignal","EventSignal"];
msignal.EventSignal.__super__ = msignal.Signal;
msignal.EventSignal.prototype = $extend(msignal.Signal.prototype,{
	createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal.EventSlot(this,listener,once,priority);
	}
	,bubbleType: function(type) {
		this.bubble(new msignal.Event(type));
	}
	,bubble: function(event) {
		this.dispatch(event);
		var currentTarget = this.target;
		while(currentTarget != null && Reflect.hasField(currentTarget,"parent")) {
			currentTarget = Reflect.field(currentTarget,"parent");
			if(js.Boot.__instanceof(currentTarget,msignal.EventDispatcher)) {
				event.currentTarget = currentTarget;
				var dispatcher = js.Boot.__cast(currentTarget , msignal.EventDispatcher);
				if(!dispatcher.dispatchEvent(event)) break;
			}
		}
	}
	,dispatchType: function(type) {
		this.dispatch(new msignal.Event(type));
	}
	,dispatch: function(event) {
		if(event.target == null) {
			event.target = this.target;
			event.signal = this;
		}
		event.currentTarget = this.target;
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(event);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,target: null
	,__class__: msignal.EventSignal
});
msignal.Slot = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	this.signal = signal;
	this.set_listener(listener);
	this.once = once;
	this.priority = priority;
	this.enabled = true;
};
$hxClasses["msignal.Slot"] = msignal.Slot;
msignal.Slot.__name__ = ["msignal","Slot"];
msignal.Slot.prototype = {
	set_listener: function(value) {
		if(value == null) throw "listener cannot be null";
		return this.listener = value;
	}
	,remove: function() {
		this.signal.remove(this.listener);
	}
	,signal: null
	,enabled: null
	,priority: null
	,once: null
	,listener: null
	,__class__: msignal.Slot
	,__properties__: {set_listener:"set_listener"}
}
msignal.EventSlot = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal.Slot.call(this,signal,listener,once,priority);
};
$hxClasses["msignal.EventSlot"] = msignal.EventSlot;
msignal.EventSlot.__name__ = ["msignal","EventSlot"];
msignal.EventSlot.typeEq = function(a,b) {
	if(a == b) return true;
	var _g = Type["typeof"](a);
	switch( (_g)[1] ) {
	case 7:
		return msignal.EventSlot.enumTypeEq(a,b);
	default:
		return false;
	}
	return false;
}
msignal.EventSlot.enumTypeEq = function(a,b) {
	if(a == b) return true;
	if(Type.getEnum(a) != Type.getEnum(b)) return false;
	if(a[1] != b[1]) return false;
	var aParams = a.slice(2);
	if(aParams.length == 0) return true;
	var bParams = b.slice(2);
	var _g1 = 0, _g = aParams.length;
	while(_g1 < _g) {
		var i = _g1++;
		var aParam = aParams[i];
		var bParam = bParams[i];
		if(aParam == null) continue;
		if(!msignal.EventSlot.typeEq(aParam,bParam)) return false;
	}
	return true;
}
msignal.EventSlot.__super__ = msignal.Slot;
msignal.EventSlot.prototype = $extend(msignal.Slot.prototype,{
	forType: function(value) {
		this.filterType = value;
	}
	,execute: function(value1) {
		if(!this.enabled) return;
		if(this.filterType != null && !msignal.EventSlot.typeEq(this.filterType,value1.type)) return;
		if(this.once) this.remove();
		this.listener(value1);
	}
	,filterType: null
	,__class__: msignal.EventSlot
});
msignal.Event = function(type) {
	this.type = type;
};
$hxClasses["msignal.Event"] = msignal.Event;
msignal.Event.__name__ = ["msignal","Event"];
msignal.Event.prototype = {
	currentTarget: null
	,type: null
	,target: null
	,signal: null
	,__class__: msignal.Event
}
msignal.EventDispatcher = function() { }
$hxClasses["msignal.EventDispatcher"] = msignal.EventDispatcher;
msignal.EventDispatcher.__name__ = ["msignal","EventDispatcher"];
msignal.EventDispatcher.prototype = {
	dispatchEvent: null
	,__class__: msignal.EventDispatcher
}
msignal.Signal0 = function() {
	msignal.Signal.call(this);
};
$hxClasses["msignal.Signal0"] = msignal.Signal0;
msignal.Signal0.__name__ = ["msignal","Signal0"];
msignal.Signal0.__super__ = msignal.Signal;
msignal.Signal0.prototype = $extend(msignal.Signal.prototype,{
	createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal.Slot0(this,listener,once,priority);
	}
	,dispatch: function() {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute();
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,__class__: msignal.Signal0
});
msignal.Signal1 = function(type) {
	msignal.Signal.call(this,[type]);
};
$hxClasses["msignal.Signal1"] = msignal.Signal1;
msignal.Signal1.__name__ = ["msignal","Signal1"];
msignal.Signal1.__super__ = msignal.Signal;
msignal.Signal1.prototype = $extend(msignal.Signal.prototype,{
	createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal.Slot1(this,listener,once,priority);
	}
	,dispatch: function(value) {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(value);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,__class__: msignal.Signal1
});
msignal.Signal2 = function(type1,type2) {
	msignal.Signal.call(this,[type1,type2]);
};
$hxClasses["msignal.Signal2"] = msignal.Signal2;
msignal.Signal2.__name__ = ["msignal","Signal2"];
msignal.Signal2.__super__ = msignal.Signal;
msignal.Signal2.prototype = $extend(msignal.Signal.prototype,{
	createSlot: function(listener,once,priority) {
		if(priority == null) priority = 0;
		if(once == null) once = false;
		return new msignal.Slot2(this,listener,once,priority);
	}
	,dispatch: function(value1,value2) {
		var slotsToProcess = this.slots;
		while(slotsToProcess.nonEmpty) {
			slotsToProcess.head.execute(value1,value2);
			slotsToProcess = slotsToProcess.tail;
		}
	}
	,__class__: msignal.Signal2
});
msignal.Slot0 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal.Slot.call(this,signal,listener,once,priority);
};
$hxClasses["msignal.Slot0"] = msignal.Slot0;
msignal.Slot0.__name__ = ["msignal","Slot0"];
msignal.Slot0.__super__ = msignal.Slot;
msignal.Slot0.prototype = $extend(msignal.Slot.prototype,{
	execute: function() {
		if(!this.enabled) return;
		if(this.once) this.remove();
		this.listener();
	}
	,__class__: msignal.Slot0
});
msignal.Slot1 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal.Slot.call(this,signal,listener,once,priority);
};
$hxClasses["msignal.Slot1"] = msignal.Slot1;
msignal.Slot1.__name__ = ["msignal","Slot1"];
msignal.Slot1.__super__ = msignal.Slot;
msignal.Slot1.prototype = $extend(msignal.Slot.prototype,{
	execute: function(value1) {
		if(!this.enabled) return;
		if(this.once) this.remove();
		if(this.param != null) value1 = this.param;
		this.listener(value1);
	}
	,param: null
	,__class__: msignal.Slot1
});
msignal.Slot2 = function(signal,listener,once,priority) {
	if(priority == null) priority = 0;
	if(once == null) once = false;
	msignal.Slot.call(this,signal,listener,once,priority);
};
$hxClasses["msignal.Slot2"] = msignal.Slot2;
msignal.Slot2.__name__ = ["msignal","Slot2"];
msignal.Slot2.__super__ = msignal.Slot;
msignal.Slot2.prototype = $extend(msignal.Slot.prototype,{
	execute: function(value1,value2) {
		if(!this.enabled) return;
		if(this.once) this.remove();
		if(this.param1 != null) value1 = this.param1;
		if(this.param2 != null) value2 = this.param2;
		this.listener(value1,value2);
	}
	,param2: null
	,param1: null
	,__class__: msignal.Slot2
});
msignal.SlotList = function(head,tail) {
	this.nonEmpty = false;
	if(head == null && tail == null) {
		if(msignal.SlotList.NIL != null) throw "Parameters head and tail are null. Use the NIL element instead.";
		this.nonEmpty = false;
	} else if(head == null) throw "Parameter head cannot be null."; else {
		this.head = head;
		this.tail = tail == null?msignal.SlotList.NIL:tail;
		this.nonEmpty = true;
	}
};
$hxClasses["msignal.SlotList"] = msignal.SlotList;
msignal.SlotList.__name__ = ["msignal","SlotList"];
msignal.SlotList.prototype = {
	find: function(listener) {
		if(!this.nonEmpty) return null;
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) return p.head;
			p = p.tail;
		}
		return null;
	}
	,contains: function(listener) {
		if(!this.nonEmpty) return false;
		var p = this;
		while(p.nonEmpty) {
			if(Reflect.compareMethods(p.head.listener,listener)) return true;
			p = p.tail;
		}
		return false;
	}
	,filterNot: function(listener) {
		if(!this.nonEmpty || listener == null) return this;
		if(Reflect.compareMethods(this.head.listener,listener)) return this.tail;
		var wholeClone = new msignal.SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(Reflect.compareMethods(current.head.listener,listener)) {
				subClone.tail = current.tail;
				return wholeClone;
			}
			subClone = subClone.tail = new msignal.SlotList(current.head);
			current = current.tail;
		}
		return this;
	}
	,insertWithPriority: function(slot) {
		if(!this.nonEmpty) return new msignal.SlotList(slot);
		var priority = slot.priority;
		if(priority >= this.head.priority) return this.prepend(slot);
		var wholeClone = new msignal.SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			if(priority >= current.head.priority) {
				subClone.tail = current.prepend(slot);
				return wholeClone;
			}
			subClone = subClone.tail = new msignal.SlotList(current.head);
			current = current.tail;
		}
		subClone.tail = new msignal.SlotList(slot);
		return wholeClone;
	}
	,append: function(slot) {
		if(slot == null) return this;
		if(!this.nonEmpty) return new msignal.SlotList(slot);
		if(this.tail == msignal.SlotList.NIL) return new msignal.SlotList(slot).prepend(this.head);
		var wholeClone = new msignal.SlotList(this.head);
		var subClone = wholeClone;
		var current = this.tail;
		while(current.nonEmpty) {
			subClone = subClone.tail = new msignal.SlotList(current.head);
			current = current.tail;
		}
		subClone.tail = new msignal.SlotList(slot);
		return wholeClone;
	}
	,prepend: function(slot) {
		return new msignal.SlotList(slot,this);
	}
	,get_length: function() {
		if(!this.nonEmpty) return 0;
		if(this.tail == msignal.SlotList.NIL) return 1;
		var result = 0;
		var p = this;
		while(p.nonEmpty) {
			++result;
			p = p.tail;
		}
		return result;
	}
	,length: null
	,nonEmpty: null
	,tail: null
	,head: null
	,__class__: msignal.SlotList
	,__properties__: {get_length:"get_length"}
}
var nme = {}
nme.AssetData = function() { }
$hxClasses["nme.AssetData"] = nme.AssetData;
nme.AssetData.__name__ = ["nme","AssetData"];
nme.AssetData.initialize = function() {
	if(!nme.AssetData.initialized) {
		nme.AssetData.path.set("img/test.png","img/test.png");
		var value = Reflect.field(openfl.AssetType,"image".toUpperCase());
		nme.AssetData.type.set("img/test.png",value);
		nme.AssetData.initialized = true;
	}
}
var openfl = {}
openfl.Assets = function() { }
$hxClasses["openfl.Assets"] = openfl.Assets;
openfl.Assets.__name__ = ["openfl","Assets"];
openfl.Assets.__properties__ = {get_type:"get_type",get_path:"get_path",get_library:"get_library",get_id:"get_id"}
openfl.Assets.initialize = function() {
	if(!openfl.Assets.initialized) {
		nme.AssetData.initialize();
		openfl.Assets.initialized = true;
	}
}
openfl.Assets.getBitmapData = function(id,useCache) {
	if(useCache == null) useCache = true;
	openfl.Assets.initialize();
	if(nme.AssetData.type.exists(id) && nme.AssetData.type.get(id) == openfl.AssetType.IMAGE) {
		if(useCache && openfl.Assets.cachedBitmapData.exists(id)) return openfl.Assets.cachedBitmapData.get(id); else {
			var data = (js.Boot.__cast(ApplicationMain.loaders.get(nme.AssetData.path.get(id)).contentLoaderInfo.content , flash.display.Bitmap)).bitmapData;
			if(useCache) openfl.Assets.cachedBitmapData.set(id,data);
			return data;
		}
	} else if(id.indexOf(":") > -1) {
		var libraryName = HxOverrides.substr(id,0,id.indexOf(":"));
		var symbolName = HxOverrides.substr(id,id.indexOf(":") + 1,null);
		if(nme.AssetData.library.exists(libraryName)) {
		} else console.log("[openfl.Assets] There is no asset library named \"" + libraryName + "\"");
	} else console.log("[openfl.Assets] There is no BitmapData asset with an ID of \"" + id + "\"");
	return null;
}
openfl.Assets.getBytes = function(id) {
	openfl.Assets.initialize();
	if(nme.AssetData.type.exists(id)) {
		var bytes = null;
		var data = ApplicationMain.urlLoaders.get(nme.AssetData.path.get(id)).data;
		if(js.Boot.__instanceof(data,String)) {
			var bytes1 = new flash.utils.ByteArray();
			bytes1.writeUTFBytes(data);
		} else if(js.Boot.__instanceof(data,flash.utils.ByteArray)) bytes = data; else bytes = null;
		if(bytes != null) {
			bytes.position = 0;
			return bytes;
		} else return null;
	} else console.log("[openfl.Assets] There is no String or ByteArray asset with an ID of \"" + id + "\"");
	return null;
}
openfl.Assets.getFont = function(id) {
	openfl.Assets.initialize();
	if(nme.AssetData.type.exists(id) && nme.AssetData.type.get(id) == openfl.AssetType.FONT) return js.Boot.__cast(Type.createInstance(nme.AssetData.className.get(id),[]) , flash.text.Font); else console.log("[openfl.Assets] There is no Font asset with an ID of \"" + id + "\"");
	return null;
}
openfl.Assets.getMovieClip = function(id) {
	openfl.Assets.initialize();
	var libraryName = HxOverrides.substr(id,0,id.indexOf(":"));
	var symbolName = HxOverrides.substr(id,id.indexOf(":") + 1,null);
	if(nme.AssetData.library.exists(libraryName)) {
	} else console.log("[openfl.Assets] There is no asset library named \"" + libraryName + "\"");
	return null;
}
openfl.Assets.getSound = function(id) {
	openfl.Assets.initialize();
	if(nme.AssetData.type.exists(id)) {
		var type = nme.AssetData.type.get(id);
		if(type == openfl.AssetType.SOUND || type == openfl.AssetType.MUSIC) return new flash.media.Sound(new flash.net.URLRequest(nme.AssetData.path.get(id)));
	}
	console.log("[openfl.Assets] There is no Sound asset with an ID of \"" + id + "\"");
	return null;
}
openfl.Assets.getText = function(id) {
	var bytes = openfl.Assets.getBytes(id);
	if(bytes == null) return null; else return bytes.readUTFBytes(bytes.length);
}
openfl.Assets.resolveClass = function(name) {
	name = StringTools.replace(name,"native.","browser.");
	return Type.resolveClass(name);
}
openfl.Assets.resolveEnum = function(name) {
	name = StringTools.replace(name,"native.","browser.");
	return Type.resolveEnum(name);
}
openfl.Assets.get_id = function() {
	openfl.Assets.initialize();
	var ids = [];
	var $it0 = nme.AssetData.type.keys();
	while( $it0.hasNext() ) {
		var key = $it0.next();
		ids.push(key);
	}
	return ids;
}
openfl.Assets.get_library = function() {
	openfl.Assets.initialize();
	return nme.AssetData.library;
}
openfl.Assets.get_path = function() {
	openfl.Assets.initialize();
	return nme.AssetData.path;
}
openfl.Assets.get_type = function() {
	openfl.Assets.initialize();
	return nme.AssetData.type;
}
openfl.AssetType = $hxClasses["openfl.AssetType"] = { __ename__ : true, __constructs__ : ["BINARY","FONT","IMAGE","MUSIC","SOUND","TEXT"] }
openfl.AssetType.BINARY = ["BINARY",0];
openfl.AssetType.BINARY.toString = $estr;
openfl.AssetType.BINARY.__enum__ = openfl.AssetType;
openfl.AssetType.FONT = ["FONT",1];
openfl.AssetType.FONT.toString = $estr;
openfl.AssetType.FONT.__enum__ = openfl.AssetType;
openfl.AssetType.IMAGE = ["IMAGE",2];
openfl.AssetType.IMAGE.toString = $estr;
openfl.AssetType.IMAGE.__enum__ = openfl.AssetType;
openfl.AssetType.MUSIC = ["MUSIC",3];
openfl.AssetType.MUSIC.toString = $estr;
openfl.AssetType.MUSIC.__enum__ = openfl.AssetType;
openfl.AssetType.SOUND = ["SOUND",4];
openfl.AssetType.SOUND.toString = $estr;
openfl.AssetType.SOUND.__enum__ = openfl.AssetType;
openfl.AssetType.TEXT = ["TEXT",5];
openfl.AssetType.TEXT.toString = $estr;
openfl.AssetType.TEXT.__enum__ = openfl.AssetType;
openfl.LibraryType = $hxClasses["openfl.LibraryType"] = { __ename__ : true, __constructs__ : ["SWF","XFL"] }
openfl.LibraryType.SWF = ["SWF",0];
openfl.LibraryType.SWF.toString = $estr;
openfl.LibraryType.SWF.__enum__ = openfl.LibraryType;
openfl.LibraryType.XFL = ["XFL",1];
openfl.LibraryType.XFL.toString = $estr;
openfl.LibraryType.XFL.__enum__ = openfl.LibraryType;
openfl.display = {}
openfl.display.Tilesheet = function(image) {
	this.nmeBitmap = image;
	this.nmeCenterPoints = new Array();
	this.nmeTileRects = new Array();
};
$hxClasses["openfl.display.Tilesheet"] = openfl.display.Tilesheet;
openfl.display.Tilesheet.__name__ = ["openfl","display","Tilesheet"];
openfl.display.Tilesheet.prototype = {
	drawTiles: function(graphics,tileData,smooth,flags) {
		if(flags == null) flags = 0;
		if(smooth == null) smooth = false;
		graphics.drawTiles(this,tileData,smooth,flags);
	}
	,addTileRect: function(rectangle,centerPoint) {
		this.nmeTileRects.push(rectangle);
		if(centerPoint == null) centerPoint = new flash.geom.Point();
		this.nmeCenterPoints.push(centerPoint);
		return this.nmeTileRects.length - 1;
	}
	,nmeTileRects: null
	,nmeCenterPoints: null
	,nmeBitmap: null
	,__class__: openfl.display.Tilesheet
}
var pgr = {}
pgr.gconsole = {}
pgr.gconsole.GCCommands = function() {
};
$hxClasses["pgr.gconsole.GCCommands"] = pgr.gconsole.GCCommands;
pgr.gconsole.GCCommands.__name__ = ["pgr","gconsole","GCCommands"];
pgr.gconsole.GCCommands.registerVariable = function(object,name,alias,monitor) {
	var aliasAlreadyExists = pgr.gconsole.GCCommands.unregisterVariable(alias);
	pgr.gconsole.GCCommands._variables.push({ name : name, alias : alias, object : object, monitor : monitor});
	if(aliasAlreadyExists) return "" + "alias " + alias + " for variable " + name + " already exists and will be overriden."; else return "";
}
pgr.gconsole.GCCommands.unregisterVariable = function(alias) {
	var _g1 = 0, _g = pgr.gconsole.GCCommands._variables.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._variables[i].alias == alias) {
			pgr.gconsole.GCCommands._variables.splice(i,1);
			return true;
		}
	}
	return false;
}
pgr.gconsole.GCCommands.registerFunction = function(object,name,alias,monitor) {
	var aliasAlreadyExists = pgr.gconsole.GCCommands.unregisterFunction(alias);
	pgr.gconsole.GCCommands._functions.push({ name : name, alias : alias, object : object, monitor : monitor});
	if(aliasAlreadyExists) return "" + "alias " + alias + " for function " + name + " already exists and will be overriden"; else return "";
}
pgr.gconsole.GCCommands.unregisterFunction = function(alias) {
	var _g1 = 0, _g = pgr.gconsole.GCCommands._functions.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._functions[i].alias == alias) {
			pgr.gconsole.GCCommands._functions.splice(i,1);
			return false;
		}
	}
	return false;
}
pgr.gconsole.GCCommands.clearRegistry = function() {
	pgr.gconsole.GCCommands._variables = new Array();
	pgr.gconsole.GCCommands._functions = new Array();
}
pgr.gconsole.GCCommands.showHelp = function() {
	var output = "";
	output += "\n";
	output += "GAME CONSOLE v1.0\n\n";
	output += "Type \"commands\" to view availible commands.\n";
	output += "Use 'PAGEUP' or 'PAGEDOWN' to scroll this console text.\n";
	output += "Use 'UP' or 'DOWN' keys to view recent commands history.\n";
	output += "Use 'CTRL' + 'CONSOLE SCKEY' to toggle monitor on/off.\n";
	return output;
}
pgr.gconsole.GCCommands.showCommands = function() {
	var output = "";
	output += "\n";
	output += "CLEAR                       clears console view.\n";
	output += "HELP                        shows help menu.\n";
	output += "MONITOR                     toggles monitor on or off.\n";
	output += "VARS                        lists availible variables.\n";
	output += "FCNS                        lists availible functions.\n";
	output += "SET [variable] [value]      assigns value to variable.\n";
	output += "CALL [function] [args]*     calls function.\n";
	return output;
}
pgr.gconsole.GCCommands.setVar = function(args) {
	if(args.length != 3) return pgr.gconsole.GCCommands.logIncorrectNumberArguments();
	var _g1 = 0, _g = pgr.gconsole.GCCommands._variables.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._variables[i].alias == args[1]) {
			Reflect.setProperty(pgr.gconsole.GCCommands._variables[i].object,pgr.gconsole.GCCommands._variables[i].name,args[2]);
			return "ok";
		}
	}
	return "" + "variable not found.";
}
pgr.gconsole.GCCommands.callFunction = function(args) {
	if(args.length < 2) return pgr.gconsole.GCCommands.logIncorrectNumberArguments();
	var _g1 = 0, _g = pgr.gconsole.GCCommands._functions.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._functions[i].alias == args[1]) {
			args.splice(0,2);
			Reflect.getProperty(pgr.gconsole.GCCommands._functions[i].object,pgr.gconsole.GCCommands._functions[i].name).apply(null,args);
			return "ok";
		}
	}
	return "function " + args[1] + " not found";
}
pgr.gconsole.GCCommands.listVars = function() {
	var logMessage = "";
	var _g1 = 0, _g = pgr.gconsole.GCCommands._variables.length;
	while(_g1 < _g) {
		var i = _g1++;
		logMessage += pgr.gconsole.GCCommands._variables[i].alias + "=" + Std.string(Reflect.getProperty(pgr.gconsole.GCCommands._variables[i].object,pgr.gconsole.GCCommands._variables[i].name)) + "  |  ";
	}
	return logMessage;
}
pgr.gconsole.GCCommands.listFunctions = function() {
	var list = "";
	var _g1 = 0, _g = pgr.gconsole.GCCommands._functions.length;
	while(_g1 < _g) {
		var i = _g1++;
		list += pgr.gconsole.GCCommands._functions[i].alias + "" + "\n";
	}
	return list;
}
pgr.gconsole.GCCommands.getMonitorOutput = function() {
	var output = "";
	var _g1 = 0, _g = pgr.gconsole.GCCommands._variables.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._variables[i].monitor) output += pgr.gconsole.GCCommands._variables[i].alias + ":" + Std.string(Reflect.getProperty(pgr.gconsole.GCCommands._variables[i].object,pgr.gconsole.GCCommands._variables[i].name)) + "\n";
	}
	var _g1 = 0, _g = pgr.gconsole.GCCommands._functions.length;
	while(_g1 < _g) {
		var i = _g1++;
		if(pgr.gconsole.GCCommands._functions[i].monitor) output += pgr.gconsole.GCCommands._functions[i].alias + ":" + Std.string(Reflect.getProperty(pgr.gconsole.GCCommands._functions[i].object,pgr.gconsole.GCCommands._functions[i].name).apply(null,null)) + "\n";
	}
	return output;
}
pgr.gconsole.GCCommands.logIncorrectNumberArguments = function() {
	return "" + "incorrect number of arguments.";
}
pgr.gconsole.GCCommands.prototype = {
	__class__: pgr.gconsole.GCCommands
}
pgr.gconsole.GCInterface = function(height,align,theme) {
	flash.display.Sprite.call(this);
	this._width = flash.Lib.get_current().get_stage().get_stageWidth();
	this._height = flash.Lib.get_current().get_stage().get_stageHeight() * height | 0;
	if(align == "DOWN") this._yOffset = flash.Lib.get_current().get_stage().get_stageHeight() - this._height; else this._yOffset = 0;
	if(theme == null) this._theme = pgr.gconsole.GCThemes.DEFAULT_THEME; else this._theme = theme;
	this.createMonitor();
	this._bg = new flash.display.Sprite();
	this.addChild(this._bg);
	this._promptBg = new flash.display.Sprite();
	this.addChild(this._promptBg);
	this._border = new flash.display.Sprite();
	this.addChild(this._border);
	this.txtPrompt = new flash.text.TextField();
	this.txtPrompt.set_type(flash.text.TextFieldType.INPUT);
	this.txtPrompt.selectable = false;
	this.txtPrompt.multiline = false;
	this.txtPrompt.alpha = this._theme.consTxtAlpha;
	this.setPromptFont();
	this.addChild(this.txtPrompt);
	this.txtConsole = new flash.text.TextField();
	this.txtConsole.selectable = false;
	this.txtConsole.multiline = true;
	this.txtConsole.set_wordWrap(true);
	this.txtConsole.alpha = this._theme.consTxtAlpha;
	this.setConsoleFont();
	this.addChild(this.txtConsole);
	this.drawUI();
	this.resizeTextFields();
};
$hxClasses["pgr.gconsole.GCInterface"] = pgr.gconsole.GCInterface;
pgr.gconsole.GCInterface.__name__ = ["pgr","gconsole","GCInterface"];
pgr.gconsole.GCInterface.__super__ = flash.display.Sprite;
pgr.gconsole.GCInterface.prototype = $extend(flash.display.Sprite.prototype,{
	toggleConsoleOn: function(turnOn) {
		this._bg.set_visible(turnOn);
		this._promptBg.set_visible(turnOn);
		this._border.set_visible(turnOn);
		this.txtConsole.set_visible(turnOn);
		this.txtPrompt.set_visible(turnOn);
	}
	,toggleMonitor: function(turnOn) {
		this._monitorBg.set_visible(turnOn);
		this.txtMonitorLeft.set_visible(turnOn);
		this.txtMonitorRight.set_visible(turnOn);
	}
	,resizeTextFields: function() {
		if(this.txtConsole == null || this.txtPrompt == null) return;
		this.txtConsole.set_x(0);
		this.txtConsole.set_y(this._yOffset);
		this.txtConsole.set_width(this._width);
		this.txtConsole.set_height(this._height - this._promptFontYOffset);
		this.txtPrompt.set_x(5);
		this.txtPrompt.set_y(this._height - this._promptFontYOffset + this._yOffset);
		this.txtPrompt.set_width(this._width);
		this.txtPrompt.set_height(32);
	}
	,drawUI: function() {
		($_=this._bg.get_graphics(),$bind($_,$_.clear));
		this._bg.get_graphics().beginFill(this._theme.consBgColor,1);
		this._bg.get_graphics().drawRect(0,0,this._width,this._height);
		this._bg.get_graphics().endFill();
		this._promptBg.get_graphics().clear();
		this._promptBg.get_graphics().beginFill(this._theme.promptBgColor);
		this._promptBg.get_graphics().drawRect(0,0,this._width,20);
		this._promptBg.get_graphics().endFill();
		this._promptBg.get_graphics().lineStyle(3,this._theme.promptTxtColor);
		this._promptBg.get_graphics().moveTo(5,6);
		this._promptBg.get_graphics().lineTo(6,7);
		this._promptBg.get_graphics().moveTo(5,14);
		this._promptBg.get_graphics().lineTo(6,15);
		this._bg.set_y(this._yOffset);
		this._promptBg.set_y(this._height - 20 + this._yOffset);
		this._bg.alpha = this._theme.consBgAlpha;
		this._promptBg.alpha = this._theme.consBgAlpha;
		this._border.get_graphics().clear();
		this._border.get_graphics().lineStyle(1,13421772);
		this._border.get_graphics().moveTo(0,0);
		this._border.get_graphics().lineTo(this._width,0);
		this._border.get_graphics().lineStyle(1,6710886);
		this._border.get_graphics().moveTo(0,1);
		this._border.get_graphics().lineTo(this._width,1);
		this._border.alpha = this._theme.consBgAlpha;
		if(this._yOffset == 0) {
			this._border.set_y(this._promptBg.get_y() + 20 + 2);
			this._border.set_scaleY(-1);
		} else this._border.set_y(this._bg.get_y() - 2);
	}
	,setMonitorFont: function(font,embed,size,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(size == null) size = 14;
		if(embed == null) embed = false;
		if(font == null) font = "Consolas";
		if(embed) this.txtMonitorLeft.embedFonts = true; else this.txtMonitorLeft.embedFonts = false;
		if(embed) this.txtMonitorRight.embedFonts = true; else this.txtMonitorRight.embedFonts = false;
		this.txtMonitorLeft.set_defaultTextFormat(new flash.text.TextFormat(font,size,this._theme.monTxtColor,bold,italic,underline,"","",flash.text.TextFormatAlign.LEFT,10,10));
		this.txtMonitorRight.set_defaultTextFormat(new flash.text.TextFormat(font,size,this._theme.monTxtColor,bold,italic,underline,"","",flash.text.TextFormatAlign.LEFT,10,10));
	}
	,setPromptFont: function(font,embed,size,yOffset,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(yOffset == null) yOffset = 22;
		if(size == null) size = 16;
		if(embed == null) embed = false;
		if(font == null) font = "Consolas";
		this._promptFontYOffset = yOffset;
		if(embed) this.txtPrompt.embedFonts = true; else this.txtPrompt.embedFonts = false;
		this.txtPrompt.set_defaultTextFormat(new flash.text.TextFormat(font,size,this._theme.promptTxtColor,bold,italic,underline,"","",flash.text.TextFormatAlign.LEFT,10,10));
		this.resizeTextFields();
	}
	,setConsoleFont: function(font,embed,size,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(size == null) size = 14;
		if(embed == null) embed = false;
		if(font == null) font = "Consolas";
		if(embed) this.txtConsole.embedFonts = true; else this.txtConsole.embedFonts = false;
		this.txtConsole.set_defaultTextFormat(new flash.text.TextFormat(font,size,this._theme.consTxtColor,bold,italic,underline,"","",flash.text.TextFormatAlign.LEFT,10,10));
	}
	,createMonitor: function() {
		this._monitorBg = new flash.display.Sprite();
		this._monitorBg.get_graphics().beginFill(this._theme.monBgColor,this._theme.monBgAlpha);
		this._monitorBg.get_graphics().drawRect(0,0,flash.Lib.get_current().get_stage().get_stageWidth(),flash.Lib.get_current().get_stage().get_stageHeight());
		this._monitorBg.get_graphics().endFill();
		this.addChild(this._monitorBg);
		this.txtMonitorLeft = new flash.text.TextField();
		this.txtMonitorLeft.selectable = false;
		this.txtMonitorLeft.multiline = true;
		this.txtMonitorLeft.alpha = this._theme.monTxtAlpha;
		this.txtMonitorLeft.set_x(0);
		this.txtMonitorLeft.set_width(this._width / 2);
		this.txtMonitorLeft.set_height(this._height);
		this.addChild(this.txtMonitorLeft);
		this.txtMonitorRight = new flash.text.TextField();
		this.txtMonitorRight.selectable = false;
		this.txtMonitorRight.multiline = true;
		this.txtMonitorRight.alpha = this._theme.monTxtAlpha;
		this.txtMonitorRight.set_x(this._width / 2);
		this.txtMonitorRight.set_width(this._width / 2);
		this.txtMonitorRight.set_height(this._height);
		this.addChild(this.txtMonitorRight);
		this.setMonitorFont();
	}
	,txtMonitorRight: null
	,txtMonitorLeft: null
	,txtPrompt: null
	,txtConsole: null
	,_yOffset: null
	,_width: null
	,_theme: null
	,_promptFontYOffset: null
	,_border: null
	,_monitorBg: null
	,_promptBg: null
	,_height: null
	,_bg: null
	,__class__: pgr.gconsole.GCInterface
});
pgr.gconsole.GCThemes = function() {
};
$hxClasses["pgr.gconsole.GCThemes"] = pgr.gconsole.GCThemes;
pgr.gconsole.GCThemes.__name__ = ["pgr","gconsole","GCThemes"];
pgr.gconsole.GCThemes.prototype = {
	__class__: pgr.gconsole.GCThemes
}
pgr.gconsole.GConsole = function(height,align,theme,monitorRate) {
	if(monitorRate == null) monitorRate = 10;
	if(align == null) align = "DOWN";
	if(height == null) height = 0.33;
	flash.display.Sprite.call(this);
	if(height > 1) height = 1;
	if(height < 0.1) height = 0.1;
	this._interface = new pgr.gconsole.GCInterface(height,align,theme);
	this.addChild(this._interface);
	this._monitorRate = monitorRate;
	this._consoleScKey = 9;
	this._historyArray = new Array();
	this._historyIndex = -1;
	this._historyMaxSz = 100;
	this._firstLine = true;
	this.enable();
	this.hideConsole();
	this.hideMonitor();
	pgr.gconsole.GConsole.instance = this;
	pgr.gconsole.GameConsole.log("~~~~~~~~~~ GAME CONSOLE ~~~~~~~~~~");
};
$hxClasses["pgr.gconsole.GConsole"] = pgr.gconsole.GConsole;
pgr.gconsole.GConsole.__name__ = ["pgr","gconsole","GConsole"];
pgr.gconsole.GConsole.__super__ = flash.display.Sprite;
pgr.gconsole.GConsole.prototype = $extend(flash.display.Sprite.prototype,{
	historyMaxSz: null
	,set_historyMaxSz: function(value) {
		return this._historyMaxSz = value;
	}
	,processMonitorOutput: function(input) {
		if(input.length == 0) return;
		var str1;
		var str2;
		var splitPoint = (input.length / 2 | 0) - 1;
		while(splitPoint < input.length) {
			if(input.charAt(splitPoint) == "\n") break;
			splitPoint++;
		}
		this._interface.txtMonitorLeft.set_text(HxOverrides.substr(input,0,splitPoint));
		this._interface.txtMonitorRight.set_text(HxOverrides.substr(input,splitPoint + 1,null));
	}
	,updateMonitor: function(e) {
		this._elapsedFrames++;
		if(this._elapsedFrames > this._monitorRate) {
			this.processMonitorOutput(pgr.gconsole.GCCommands.getMonitorOutput());
			this._elapsedFrames = 0;
		}
	}
	,parseInput: function(input) {
		var args = input.split(" ");
		var argsLC = input.toLowerCase().split(" ");
		var _g = argsLC[0];
		switch(_g) {
		case "clear":
			this.clearConsole();
			break;
		case "monitor":
			if(this._isMonitorOn) this.hideMonitor(); else this.showMonitor();
			break;
		case "help":
			this.log(pgr.gconsole.GCCommands.showHelp());
			break;
		case "commands":
			this.log(pgr.gconsole.GCCommands.showCommands());
			break;
		case "vars":
			this.log(pgr.gconsole.GCCommands.listVars());
			break;
		case "fcns":
			this.log(pgr.gconsole.GCCommands.listFunctions());
			break;
		case "set":
			this.log(pgr.gconsole.GCCommands.setVar(args));
			break;
		case "call":
			this.log(pgr.gconsole.GCCommands.callFunction(args));
			break;
		}
	}
	,processInputLine: function() {
		if(this._interface.txtPrompt.get_text() == "") return;
		var temp = this._interface.txtPrompt.get_text();
		this._historyArray.splice(0,0,this._interface.txtPrompt.get_text());
		this._historyIndex = -1;
		if(this._historyArray.length > this._historyMaxSz) this._historyArray.splice(this._historyArray.length - 1,1);
		this.log(": " + this._interface.txtPrompt.get_text());
		this._interface.txtPrompt.set_text("");
		this.parseInput(temp);
	}
	,nextHistory: function() {
		if(this._historyIndex + 1 > this._historyArray.length - 1) return;
		this._historyIndex++;
		this._interface.txtPrompt.set_text(this._historyArray[this._historyIndex]);
		this._interface.txtPrompt.setSelection(this._interface.txtPrompt.length,this._interface.txtPrompt.length);
	}
	,prevHistory: function() {
		this._historyIndex--;
		if(this._historyIndex < 0) this._historyIndex = 0;
		if(this._historyIndex > this._historyArray.length - 1) return;
		this._interface.txtPrompt.set_text(this._historyArray[this._historyIndex]);
		this._interface.txtPrompt.setSelection(this._interface.txtPrompt.length,this._interface.txtPrompt.length);
	}
	,onKeyUp: function(e) {
		if(e.ctrlKey && js.Boot.__cast(e.keyCode , Int) == this._consoleScKey) {
			if(this._isMonitorOn) this.hideMonitor(); else this.showMonitor();
			return;
		}
		if(js.Boot.__cast(e.keyCode , Int) == this._consoleScKey) {
			if(this._isConsoleOn) this.hideConsole(); else this.showConsole();
			return;
		}
		if(!this._isConsoleOn) return;
		if(e.keyCode == 13) this.processInputLine(); else if(e.keyCode == 33) {
			this._interface.txtConsole.scrollV -= this._interface.txtConsole.get_bottomScrollV() - this._interface.txtConsole.scrollV + 1;
			if(this._interface.txtConsole.scrollV < 0) this._interface.txtConsole.scrollV = 0;
		} else if(e.keyCode == 34) {
			this._interface.txtConsole.scrollV += this._interface.txtConsole.get_bottomScrollV() - this._interface.txtConsole.scrollV + 1;
			if(this._interface.txtConsole.scrollV > this._interface.txtConsole.get_maxScrollV()) this._interface.txtConsole.scrollV = this._interface.txtConsole.get_maxScrollV();
		} else if(e.keyCode == 38) this.nextHistory(); else if(e.keyCode == 40) this.prevHistory(); else this._historyIndex = -1;
		e.stopImmediatePropagation();
	}
	,onKeyDown: function(e) {
		if(this._isConsoleOn) e.stopImmediatePropagation();
	}
	,clearRegistry: function() {
		pgr.gconsole.GCCommands.clearRegistry();
	}
	,clearConsole: function() {
		this._interface.txtConsole.set_text("");
		this._firstLine = true;
	}
	,unregisterFunction: function(alias) {
		if(pgr.gconsole.GCCommands.unregisterFunction(alias)) this.log("function " + alias + " unregistered."); else this.log("function " + alias + " not found.");
	}
	,registerFunction: function(object,name,alias,monitor) {
		if(monitor == null) monitor = false;
		if(!Reflect.hasField(object,name)) {
			console.log("gc_error: " + name + " field was not found in object passed.");
			return;
		}
		if(!Reflect.isFunction(Reflect.field(object,name))) {
			console.log("gc_error: " + "could not find function: " + name + " in object passed.");
			return;
		}
		this.log(pgr.gconsole.GCCommands.registerFunction(object,name,alias,monitor));
	}
	,unregisterVariable: function(alias) {
		if(pgr.gconsole.GCCommands.unregisterVariable(alias)) this.log("variable " + alias + " unregistered."); else this.log("variable " + alias + " not found.");
	}
	,registerVariable: function(object,name,alias,monitor) {
		if(monitor == null) monitor = false;
		if(!Reflect.isObject(object)) {
			console.log("gc_error: " + "dynamic passed with the field: " + name + " is not an object.");
			return;
		}
		if(!Reflect.hasField(object,name)) {
			console.log("gc_error: " + name + " field was not found in object passed.");
			return;
		}
		this.log(pgr.gconsole.GCCommands.registerVariable(object,name,alias,monitor));
	}
	,log: function(data) {
		if(data == "") return;
		if(this._firstLine) this._firstLine = false; else {
			var _g = this._interface.txtConsole;
			_g.set_text(_g.get_text() + "\n");
		}
		var _g = this._interface.txtConsole;
		_g.set_text(_g.get_text() + Std.string(data.toString()));
		this._interface.txtConsole.scrollV = this._interface.txtConsole.get_maxScrollV();
	}
	,setShortcutKeyCode: function(key) {
		this._consoleScKey = key;
	}
	,disable: function() {
		if(this._isMonitorOn) this.hideMonitor();
		if(this._isConsoleOn) this.hideConsole();
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.KeyboardEvent.KEY_UP,$bind(this,this.onKeyUp),false);
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.KeyboardEvent.KEY_DOWN,$bind(this,this.onKeyDown),false);
		this.set_visible(false);
	}
	,enable: function() {
		this.set_visible(true);
		flash.Lib.get_current().get_stage().addEventListener(flash.events.KeyboardEvent.KEY_UP,$bind(this,this.onKeyUp),false);
		flash.Lib.get_current().get_stage().addEventListener(flash.events.KeyboardEvent.KEY_DOWN,$bind(this,this.onKeyDown),false);
	}
	,hideMonitor: function() {
		this._isMonitorOn = false;
		this._interface.toggleMonitor(false);
		this.removeEventListener(flash.events.Event.ENTER_FRAME,$bind(this,this.updateMonitor));
	}
	,showMonitor: function() {
		this._isMonitorOn = true;
		this._interface.toggleMonitor(true);
		this.addEventListener(flash.events.Event.ENTER_FRAME,$bind(this,this.updateMonitor));
		this._elapsedFrames = this._monitorRate + 1;
		this.updateMonitor(null);
	}
	,hideConsole: function() {
		if(!this.get_visible()) return;
		this._isConsoleOn = false;
		this._interface.toggleConsoleOn(false);
	}
	,showConsole: function() {
		if(!this.get_visible()) return;
		flash.Lib.get_current().get_stage().set_focus(this._interface.txtPrompt);
		this._isConsoleOn = true;
		this._interface.toggleConsoleOn(true);
	}
	,setMonitorFont: function(font,embed,size,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(size == null) size = 14;
		if(embed == null) embed = true;
		this._interface.setMonitorFont(font,embed,size,bold,italic,underline);
	}
	,setPromptFont: function(font,embed,size,yOffset,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(yOffset == null) yOffset = 22;
		if(size == null) size = 16;
		if(embed == null) embed = true;
		this._interface.setPromptFont(font,embed,size,yOffset,bold,italic,underline);
	}
	,setConsoleFont: function(font,embed,size,bold,italic,underline) {
		if(underline == null) underline = false;
		if(italic == null) italic = false;
		if(bold == null) bold = false;
		if(size == null) size = 14;
		if(embed == null) embed = true;
		this._interface.setConsoleFont(font,embed,size,bold,italic,underline);
	}
	,_isConsoleOn: null
	,_isMonitorOn: null
	,_consoleScKey: null
	,_monitorRate: null
	,_elapsedFrames: null
	,_interface: null
	,_historyMaxSz: null
	,_historyIndex: null
	,_historyArray: null
	,_firstLine: null
	,__class__: pgr.gconsole.GConsole
	,__properties__: $extend(flash.display.Sprite.prototype.__properties__,{set_historyMaxSz:"set_historyMaxSz"})
});
pgr.gconsole.GameConsole = function() { }
$hxClasses["pgr.gconsole.GameConsole"] = pgr.gconsole.GameConsole;
pgr.gconsole.GameConsole.__name__ = ["pgr","gconsole","GameConsole"];
pgr.gconsole.GameConsole.init = function(height,align,theme,monitorRate) {
	if(monitorRate == null) monitorRate = 10;
	if(align == null) align = "DOWN";
	if(height == null) height = 0.33;
	if(pgr.gconsole.GConsole.instance != null) return;
	flash.Lib.get_current().get_stage().addChild(new pgr.gconsole.GConsole(height,align,theme,monitorRate));
}
pgr.gconsole.GameConsole.setConsoleFont = function(font,embed,size,bold,italic,underline) {
	if(underline == null) underline = false;
	if(italic == null) italic = false;
	if(bold == null) bold = false;
	if(size == null) size = 14;
	if(embed == null) embed = true;
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.setConsoleFont(font,embed,size,bold,italic,underline);
}
pgr.gconsole.GameConsole.setPromptFont = function(font,embed,size,yOffset,bold,italic,underline) {
	if(underline == null) underline = false;
	if(italic == null) italic = false;
	if(bold == null) bold = false;
	if(yOffset == null) yOffset = 22;
	if(size == null) size = 16;
	if(embed == null) embed = true;
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.setPromptFont(font,embed,size,yOffset,bold,italic,underline);
}
pgr.gconsole.GameConsole.setMonitorFont = function(font,embed,size,bold,italic,underline) {
	if(underline == null) underline = false;
	if(italic == null) italic = false;
	if(bold == null) bold = false;
	if(size == null) size = 14;
	if(embed == null) embed = true;
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.setMonitorFont(font,embed,size,bold,italic,underline);
}
pgr.gconsole.GameConsole.showConsole = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.showConsole();
}
pgr.gconsole.GameConsole.hideConsole = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.showConsole();
}
pgr.gconsole.GameConsole.showMonitor = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.showMonitor();
}
pgr.gconsole.GameConsole.hideMonitor = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.hideMonitor();
}
pgr.gconsole.GameConsole.enable = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.enable();
}
pgr.gconsole.GameConsole.disable = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.disable();
}
pgr.gconsole.GameConsole.setShortcutKeyCode = function(key) {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.setShortcutKeyCode(key);
}
pgr.gconsole.GameConsole.log = function(data) {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.log(data);
}
pgr.gconsole.GameConsole.registerVariable = function(object,name,alias,monitor) {
	if(monitor == null) monitor = false;
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.registerVariable(object,name,alias,monitor);
}
pgr.gconsole.GameConsole.unregisterVariable = function(alias) {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.unregisterVariable(alias);
}
pgr.gconsole.GameConsole.registerFunction = function(object,name,alias,monitor) {
	if(monitor == null) monitor = false;
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.registerFunction(object,name,alias,monitor);
}
pgr.gconsole.GameConsole.unregisterFunction = function(alias) {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.unregisterFunction(alias);
}
pgr.gconsole.GameConsole.clearConsole = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GConsole.instance.clearConsole();
}
pgr.gconsole.GameConsole.clearRegistry = function() {
	pgr.gconsole.GameConsole.checkInstance();
	pgr.gconsole.GCCommands.clearRegistry();
}
pgr.gconsole.GameConsole.toFront = function() {
	flash.Lib.get_current().get_stage().swapChildren(pgr.gconsole.GConsole.instance,flash.Lib.get_current().get_stage().getChildAt(flash.Lib.get_current().get_stage().nmeChildren.length - 1));
}
pgr.gconsole.GameConsole.checkInstance = function() {
	if(pgr.gconsole.GConsole.instance == null) pgr.gconsole.GameConsole.init();
}
var ru = {}
ru.stablex = {}
ru.stablex.Assets = function() { }
$hxClasses["ru.stablex.Assets"] = ru.stablex.Assets;
ru.stablex.Assets.__name__ = ["ru","stablex","Assets"];
ru.stablex.Assets.getBitmapData = function(src,useCache) {
	if(useCache == null) useCache = true;
	return openfl.Assets.getBitmapData(src,useCache);
}
ru.stablex.Assets.getBytes = function(src) {
	return openfl.Assets.getBytes(src);
}
ru.stablex.Assets.getFont = function(src) {
	return openfl.Assets.getFont(src);
}
ru.stablex.Assets.getSound = function(src) {
	return openfl.Assets.getSound(src);
}
ru.stablex.Assets.getText = function(src) {
	return openfl.Assets.getText(src);
}
ru.stablex.DynamicList = function(cls) {
	this._hash = new haxe.ds.StringMap();
	this._cls = cls;
};
$hxClasses["ru.stablex.DynamicList"] = ru.stablex.DynamicList;
ru.stablex.DynamicList.__name__ = ["ru","stablex","DynamicList"];
ru.stablex.DynamicList.prototype = {
	exists: function(key) {
		return this._hash.exists(key);
	}
	,get: function(key) {
		return this.resolve(key);
	}
	,resolve: function(key) {
		var value = this._hash.get(key);
		if(value == null) {
			value = Type.createInstance(this._cls,[]);
			this._hash.set(key,value);
		}
		return value;
	}
	,_hash: null
	,_cls: null
	,__class__: ru.stablex.DynamicList
}
ru.stablex.Err = function() {
};
$hxClasses["ru.stablex.Err"] = ru.stablex.Err;
ru.stablex.Err.__name__ = ["ru","stablex","Err"];
ru.stablex.Err.trigger = function(msg) {
	throw msg;
}
ru.stablex.Err.prototype = {
	__class__: ru.stablex.Err
}
ru.stablex.TweenSprite = function() {
	flash.display.Sprite.call(this);
};
$hxClasses["ru.stablex.TweenSprite"] = ru.stablex.TweenSprite;
ru.stablex.TweenSprite.__name__ = ["ru","stablex","TweenSprite"];
ru.stablex.TweenSprite.__super__ = flash.display.Sprite;
ru.stablex.TweenSprite.prototype = $extend(flash.display.Sprite.prototype,{
	freeChildren: function(recursive) {
		if(recursive == null) recursive = true;
		var child;
		while(this.nmeChildren.length > 0) {
			child = this.removeChildAt(0);
			if(recursive && js.Boot.__instanceof(child,ru.stablex.TweenSprite)) (js.Boot.__cast(child , ru.stablex.TweenSprite)).free(true);
		}
	}
	,free: function(recursive) {
		if(recursive == null) recursive = true;
		this.tweenStop();
		if(this._listeners != null) {
			var $it0 = this._listeners.keys();
			while( $it0.hasNext() ) {
				var event = $it0.next();
				var listeners = this._listeners.get(event);
				while(!listeners.isEmpty()) this.removeEventListener(event,listeners.first());
			}
		}
		this.freeChildren(recursive);
		if(this.parent != null) this.parent.removeChild(this);
	}
	,tweenStop: function(properties,complete,sendEvent) {
		if(sendEvent == null) sendEvent = false;
		if(complete == null) complete = false;
		motion.Actuate.stop(this,properties,complete,sendEvent);
	}
	,tween: function(duration,properties,easing,overwrite,customActuator) {
		if(overwrite == null) overwrite = true;
		if(easing == null) easing = "Linear.easeNone";
		switch(easing) {
		case "Quad.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quad.get_easeInOut());
		case "Quad.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quad.get_easeOut());
		case "Quad.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quad.get_easeIn());
		case "Expo.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Expo.get_easeInOut());
		case "Expo.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Expo.get_easeOut());
		case "Expo.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Expo.get_easeIn());
		case "Bounce.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Bounce.get_easeInOut());
		case "Bounce.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Bounce.get_easeOut());
		case "Bounce.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Bounce.get_easeIn());
		case "Quint.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quint.get_easeInOut());
		case "Quint.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quint.get_easeOut());
		case "Quint.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quint.get_easeIn());
		case "Elastic.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Elastic.get_easeInOut());
		case "Elastic.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Elastic.get_easeOut());
		case "Elastic.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Elastic.get_easeIn());
		case "Back.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Back.get_easeInOut());
		case "Back.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Back.get_easeOut());
		case "Back.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Back.get_easeIn());
		case "Quart.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quart.get_easeInOut());
		case "Quart.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quart.get_easeOut());
		case "Quart.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Quart.get_easeIn());
		case "Cubic.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Cubic.get_easeInOut());
		case "Cubic.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Cubic.get_easeOut());
		case "Cubic.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Cubic.get_easeIn());
		case "Sine.easeInOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Sine.get_easeInOut());
		case "Sine.easeOut":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Sine.get_easeOut());
		case "Sine.easeIn":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Sine.get_easeIn());
		case "Linear.easeNone":
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Linear.get_easeNone());
		default:
			return motion.Actuate.tween(this,duration,properties,overwrite,customActuator).ease(motion.easing.Linear.get_easeNone());
		}
	}
	,hasListener: function(event,listener) {
		if(this._listeners == null) return false;
		var lst = this._listeners.get(event);
		if(lst == null) return false;
		var $it0 = lst.iterator();
		while( $it0.hasNext() ) {
			var l = $it0.next();
			if(l == listener) return true;
		}
		return false;
	}
	,clearEvent: function(type) {
		if(this._listeners != null) {
			var listeners = this._listeners.get(type);
			if(listeners != null) while(listeners.length > 0) this.removeEventListener(type,listeners.first());
		}
	}
	,removeEventListener: function(type,listener,useCapture) {
		if(useCapture == null) useCapture = false;
		if(this._listeners != null) {
			if(this._listeners.exists(type)) this._listeners.get(type).remove(listener);
		}
		flash.display.Sprite.prototype.removeEventListener.call(this,type,listener,false);
	}
	,addUniqueListener: function(type,listener,useCapture,priority,useWeakReference) {
		if(useWeakReference == null) useWeakReference = false;
		if(priority == null) priority = 0;
		if(useCapture == null) useCapture = false;
		if(this.hasListener(type,listener)) return false;
		this.addEventListener(type,listener,useCapture,priority,useWeakReference);
		return true;
	}
	,addEventListener: function(type,listener,useCapture,priority,useWeakReference) {
		if(useWeakReference == null) useWeakReference = false;
		if(priority == null) priority = 0;
		if(useCapture == null) useCapture = false;
		if(this._listeners == null) this._listeners = new haxe.ds.StringMap();
		var listeners = this._listeners.get(type);
		if(listeners == null) {
			listeners = new List();
			listeners.add(listener);
			this._listeners.set(type,listeners);
		} else listeners.add(listener);
		flash.display.Sprite.prototype.addEventListener.call(this,type,listener,false,priority,useWeakReference);
	}
	,_listeners: null
	,__class__: ru.stablex.TweenSprite
});
ru.stablex.ui = {}
ru.stablex.ui.UIBuilder = function() { }
$hxClasses["ru.stablex.ui.UIBuilder"] = ru.stablex.ui.UIBuilder;
ru.stablex.ui.UIBuilder.__name__ = ["ru","stablex","ui","UIBuilder"];
ru.stablex.ui.UIBuilder.createId = function() {
	return "__widget__" + Std.string(ru.stablex.ui.UIBuilder._nextId++);
}
ru.stablex.ui.UIBuilder.create = function(cls,properties) {
	var obj = Type.createInstance(cls,[]);
	obj.defaults = Reflect.field(properties,"defaults");
	if(obj.defaults == null) obj.defaults = "Default";
	ru.stablex.ui.UIBuilder.applyDefaults(obj);
	var children = Reflect.field(properties,"children");
	if(children != null) Reflect.deleteField(properties,"children");
	if(properties != null) ru.stablex.ui.UIBuilder.apply(obj,properties);
	obj._onInitialize();
	if(children != null) {
		var _g1 = 0, _g = children.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(js.Boot.__instanceof(children[i],ru.stablex.ui.widgets.Widget)) obj.addChild(children[i]);
		}
	}
	obj._onCreate();
	return obj;
}
ru.stablex.ui.UIBuilder.apply = function(obj,properties) {
	var _g = 0, _g1 = Reflect.fields(properties);
	while(_g < _g1.length) {
		var property = _g1[_g];
		++_g;
		if(Type["typeof"](Reflect.field(properties,property)) == ValueType.TObject) ru.stablex.ui.UIBuilder.apply(Reflect.field(obj,property),Reflect.field(properties,property)); else Reflect.setProperty(obj,property,Reflect.field(properties,property));
	}
}
ru.stablex.ui.UIBuilder.applyDefaults = function(obj) {
	var clsName = Type.getClassName(Type.getClass(obj));
	var widgetDefaults = ru.stablex.ui.UIBuilder.defaults.get(HxOverrides.substr(clsName,clsName.lastIndexOf(".",clsName.length - 1) + 1,null));
	if(widgetDefaults != null) {
		var defs = obj.defaults.split(",");
		var _g1 = 0, _g = defs.length;
		while(_g1 < _g) {
			var i = _g1++;
			var defaultsFn = widgetDefaults.get(defs[i]);
			if(defaultsFn != null) defaultsFn(obj);
		}
	}
}
ru.stablex.ui.UIBuilder.skin = function(skinName) {
	return ru.stablex.ui.UIBuilder.skins.get(skinName);
}
ru.stablex.ui.UIBuilder.get = function(id) {
	return ru.stablex.ui.UIBuilder._objects.get(id);
}
ru.stablex.ui.UIBuilder.getAs = function(id,cls) {
	var w = ru.stablex.ui.UIBuilder._objects.get(id);
	return js.Boot.__instanceof(w,cls)?w:null;
}
ru.stablex.ui.UIBuilder.save = function(obj) {
	if(ru.stablex.ui.UIBuilder._objects.exists(obj.id)) throw "Widget id \"" + obj.id + "\" is already used"; else ru.stablex.ui.UIBuilder._objects.set(obj.id,obj);
}
ru.stablex.ui.UIBuilder.forget = function(id) {
	ru.stablex.ui.UIBuilder._objects.remove(id);
}
ru.stablex.ui.UIBuilder.queueSkin = function(w) {
	if(w.skin != null && !w._skinQueued) {
		ru.stablex.ui.UIBuilder._skinQueue.add(w);
		w._skinQueued = true;
	}
}
ru.stablex.ui.UIBuilder.skinQueue = function(e) {
	if(ru.stablex.ui.UIBuilder._skinQueue.length > 0) {
		var lst = ru.stablex.ui.UIBuilder._skinQueue;
		ru.stablex.ui.UIBuilder._skinQueue = new List();
		var $it0 = lst.iterator();
		while( $it0.hasNext() ) {
			var w = $it0.next();
			w.applySkin();
			w._skinQueued = false;
		}
	}
}
ru.stablex.ui.events = {}
ru.stablex.ui.events.ScrollEvent = function(type,source) {
	this.canceled = false;
	flash.events.Event.call(this,type);
	this.srcEvent = source;
};
$hxClasses["ru.stablex.ui.events.ScrollEvent"] = ru.stablex.ui.events.ScrollEvent;
ru.stablex.ui.events.ScrollEvent.__name__ = ["ru","stablex","ui","events","ScrollEvent"];
ru.stablex.ui.events.ScrollEvent.__super__ = flash.events.Event;
ru.stablex.ui.events.ScrollEvent.prototype = $extend(flash.events.Event.prototype,{
	srcAs: function(cls) {
		return js.Boot.__instanceof(this.srcEvent,cls)?this.srcEvent:null;
	}
	,cancel: function() {
		this.canceled = true;
	}
	,srcEvent: null
	,canceled: null
	,__class__: ru.stablex.ui.events.ScrollEvent
});
ru.stablex.ui.events.WidgetEvent = function(inType,inBubbles,inCancelable) {
	flash.events.Event.call(this,inType,inBubbles,inCancelable);
};
$hxClasses["ru.stablex.ui.events.WidgetEvent"] = ru.stablex.ui.events.WidgetEvent;
ru.stablex.ui.events.WidgetEvent.__name__ = ["ru","stablex","ui","events","WidgetEvent"];
ru.stablex.ui.events.WidgetEvent.__super__ = flash.events.Event;
ru.stablex.ui.events.WidgetEvent.prototype = $extend(flash.events.Event.prototype,{
	__class__: ru.stablex.ui.events.WidgetEvent
});
ru.stablex.ui.layouts = {}
ru.stablex.ui.layouts.Layout = function() {
};
$hxClasses["ru.stablex.ui.layouts.Layout"] = ru.stablex.ui.layouts.Layout;
ru.stablex.ui.layouts.Layout.__name__ = ["ru","stablex","ui","layouts","Layout"];
ru.stablex.ui.layouts.Layout.prototype = {
	'as': function(cls) {
		return js.Boot.__instanceof(this,cls)?this:null;
	}
	,arrangeChildren: function(Widget) {
	}
	,__class__: ru.stablex.ui.layouts.Layout
}
ru.stablex.ui.misc = {}
ru.stablex.ui.misc.BtnState = function() {
};
$hxClasses["ru.stablex.ui.misc.BtnState"] = ru.stablex.ui.misc.BtnState;
ru.stablex.ui.misc.BtnState.__name__ = ["ru","stablex","ui","misc","BtnState"];
ru.stablex.ui.misc.BtnState.prototype = {
	set_skinName: function(s) {
		this.skin = (ru.stablex.ui.UIBuilder.skins.get(s))();
		return this.skinName = s;
	}
	,set_ico: function(ico) {
		if(this._ico != null) this._ico.free();
		return this._ico = ico;
	}
	,get_ico: function() {
		if(this._ico == null) this._ico = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Bmp);
		return this._ico;
	}
	,skin: null
	,skinName: null
	,_ico: null
	,text: null
	,__class__: ru.stablex.ui.misc.BtnState
	,__properties__: {set_ico:"set_ico",get_ico:"get_ico",set_skinName:"set_skinName"}
}
ru.stablex.ui.skins = {}
ru.stablex.ui.skins.Skin = function() {
	this.clear = true;
};
$hxClasses["ru.stablex.ui.skins.Skin"] = ru.stablex.ui.skins.Skin;
ru.stablex.ui.skins.Skin.__name__ = ["ru","stablex","ui","skins","Skin"];
ru.stablex.ui.skins.Skin.prototype = {
	'as': function(cls) {
		return js.Boot.__instanceof(this,cls)?this:null;
	}
	,draw: function(w) {
	}
	,apply: function(w) {
		if(this.clear) w.get_graphics().clear();
		this.draw(w);
	}
	,clear: null
	,__class__: ru.stablex.ui.skins.Skin
}
ru.stablex.ui.skins.Rect = function() {
	this.paddingLeft = 0;
	this.paddingBottom = 0;
	this.paddingRight = 0;
	this.paddingTop = 0;
	this.borderAlpha = 1;
	this.borderColor = 0;
	this.border = 0;
	ru.stablex.ui.skins.Skin.call(this);
};
$hxClasses["ru.stablex.ui.skins.Rect"] = ru.stablex.ui.skins.Rect;
ru.stablex.ui.skins.Rect.__name__ = ["ru","stablex","ui","skins","Rect"];
ru.stablex.ui.skins.Rect.__super__ = ru.stablex.ui.skins.Skin;
ru.stablex.ui.skins.Rect.prototype = $extend(ru.stablex.ui.skins.Skin.prototype,{
	draw: function(w) {
		var width = w.get_w() - this.paddingLeft - this.paddingRight;
		var height = w.get_h() - this.paddingTop - this.paddingBottom;
		if(width <= 0 || height <= 0) return;
		if(this.border > 0) w.get_graphics().lineStyle(this.border,this.borderColor,this.borderAlpha);
		if(this.corners == null || this.corners.length == 0) w.get_graphics().drawRect(this.paddingLeft,this.paddingTop,width,height); else if(this.corners.length > 0) w.get_graphics().drawRoundRect(this.paddingLeft,this.paddingTop,width,height,this.corners[0],this.corners.length > 1?this.corners[1]:this.corners[0]);
	}
	,set_padding: function(p) {
		this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
		return p;
	}
	,paddingLeft: null
	,paddingBottom: null
	,paddingRight: null
	,paddingTop: null
	,corners: null
	,borderAlpha: null
	,borderColor: null
	,border: null
	,__class__: ru.stablex.ui.skins.Rect
	,__properties__: {set_padding:"set_padding"}
});
ru.stablex.ui.skins.Paint = function() {
	this.alpha = 1;
	this.color = -1;
	ru.stablex.ui.skins.Rect.call(this);
};
$hxClasses["ru.stablex.ui.skins.Paint"] = ru.stablex.ui.skins.Paint;
ru.stablex.ui.skins.Paint.__name__ = ["ru","stablex","ui","skins","Paint"];
ru.stablex.ui.skins.Paint.__super__ = ru.stablex.ui.skins.Rect;
ru.stablex.ui.skins.Paint.prototype = $extend(ru.stablex.ui.skins.Rect.prototype,{
	draw: function(w) {
		if(this.color >= 0) w.get_graphics().beginFill(this.color,this.alpha);
		ru.stablex.ui.skins.Rect.prototype.draw.call(this,w);
		if(this.color >= 0) w.get_graphics().endFill();
	}
	,alpha: null
	,color: null
	,__class__: ru.stablex.ui.skins.Paint
});
ru.stablex.ui.widgets = {}
ru.stablex.ui.widgets.Widget = function() {
	this.overflow = true;
	this._skinQueued = false;
	this._bottomPercent = 0;
	this._bottom = 0;
	this._topPercent = 0;
	this._top = 0;
	this._yUse = 5;
	this._xUse = 1;
	this._rightPercent = 0;
	this._right = 0;
	this._leftPercent = 0;
	this._left = 0;
	this._resizing = false;
	this._silentResize = false;
	this._heightUsePercent = false;
	this._heightPercent = 0;
	this._height = 0;
	this._widthUsePercent = false;
	this._widthPercent = 0;
	this._width = 0;
	this.destroyed = false;
	this.created = false;
	this.initialized = false;
	this.defaults = "Default";
	ru.stablex.TweenSprite.call(this);
	this.set_id("__widget__" + Std.string(ru.stablex.ui.UIBuilder._nextId++));
};
$hxClasses["ru.stablex.ui.widgets.Widget"] = ru.stablex.ui.widgets.Widget;
ru.stablex.ui.widgets.Widget.__name__ = ["ru","stablex","ui","widgets","Widget"];
ru.stablex.ui.widgets.Widget.__super__ = ru.stablex.TweenSprite;
ru.stablex.ui.widgets.Widget.prototype = $extend(ru.stablex.TweenSprite.prototype,{
	set_tip: function(tip) {
		if(this.tip != null) this.tip.free();
		tip.bindTo(this);
		return this.tip = tip;
	}
	,set_id: function(id) {
		if(id == null) throw "Widget id cannot be null";
		if(this.id != null) ru.stablex.ui.UIBuilder._objects.remove(this.id);
		this.id = id;
		if(ru.stablex.ui.UIBuilder._objects.exists(this.id)) throw "Widget id \"" + this.id + "\" is already used"; else ru.stablex.ui.UIBuilder._objects.set(this.id,this);
		return id;
	}
	,get_heightPt: function() {
		if(this._heightUsePercent) return this._heightPercent; else if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height != 0) return this._height / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * 100; else return 0;
	}
	,set_heightPt: function(hp) {
		this._heightPercent = hp;
		this._heightUsePercent = true;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) {
			this._height = (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * hp / 100;
			if(!this._silentResize) this._onResize();
		}
		return hp;
	}
	,get_widthPt: function() {
		if(this._widthUsePercent) return this._widthPercent; else if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width != 0) return this.get_w() / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * 100; else return 0;
	}
	,set_widthPt: function(wp) {
		this._widthPercent = wp;
		this._widthUsePercent = true;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) {
			this._width = (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * wp / 100;
			if(!this._silentResize) this._onResize();
		}
		return wp;
	}
	,get_h: function() {
		return this._height;
	}
	,set_h: function(h) {
		this._height = h;
		this._heightUsePercent = false;
		if(!this._silentResize) this._onResize();
		return h;
	}
	,get_w: function() {
		return this._width;
	}
	,set_w: function(w) {
		this._width = w;
		this._widthUsePercent = false;
		if(!this._silentResize) this._onResize();
		return w;
	}
	,get_bottomPt: function() {
		if(this._yUse == 8) return this._bottomPercent;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height != 0) return ((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - this.get_y() - this._height) / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * 100;
		return 0;
	}
	,set_bottomPt: function(bp) {
		this._yUse = 8;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_y((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * bp / 100 - this.get_h());
		return this._bottomPercent = bp;
	}
	,get_topPt: function() {
		if(this._yUse == 6) return this._topPercent;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height != 0) return this.get_y() / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * 100;
		return 0;
	}
	,set_topPt: function(tp) {
		this._yUse = 6;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_y((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * tp / 100);
		return this._topPercent = tp;
	}
	,get_bottom: function() {
		if(this._yUse == 7) return this._bottom;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) return (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - this.get_y() - this.get_h();
		return 0;
	}
	,set_bottom: function(b) {
		this._yUse = 7;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_y((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - b - this.get_h());
		return this._bottom = b;
	}
	,get_top: function() {
		return this.get_y();
	}
	,set_top: function(t) {
		this._yUse = 5;
		this.set_y(t);
		return this._top = t;
	}
	,get_rightPt: function() {
		if(this._xUse == 4) return this._rightPercent;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width != 0) return ((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - this.get_x() - this._width) / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * 100;
		return 0;
	}
	,set_rightPt: function(rp) {
		this._xUse = 4;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_x((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * rp / 100 - this.get_w());
		return this._rightPercent = rp;
	}
	,get_leftPt: function() {
		if(this._xUse == 2) return this._leftPercent;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null && (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width != 0) return this.get_x() / (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * 100;
		return 0;
	}
	,set_leftPt: function(lp) {
		this._xUse = 2;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_x((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * lp / 100);
		return this._leftPercent = lp;
	}
	,get_right: function() {
		if(this._xUse == 3) return this._right;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) return (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - this.get_x() - this.get_w();
		return 0;
	}
	,set_right: function(r) {
		this._xUse = 3;
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) this.set_x((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - r - this.get_w());
		return this._right = r;
	}
	,get_left: function() {
		return this.get_x();
	}
	,set_left: function(l) {
		this._xUse = 1;
		this.set_x(l);
		return this._left = l;
	}
	,get_wparent: function() {
		return js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null;
	}
	,set_skinName: function(sn) {
		this.skin = (ru.stablex.ui.UIBuilder.skins.get(sn))();
		if(this.created) {
			if(this.skin != null && !this._skinQueued) {
				ru.stablex.ui.UIBuilder._skinQueue.add(this);
				this._skinQueued = true;
			}
		}
		return this.skinName = sn;
	}
	,set_overflow: function(o) {
		if(!o) this.set_scrollRect(new flash.geom.Rectangle(0,0,this._width,this._height)); else this.set_scrollRect(null);
		return this.overflow = o;
	}
	,'as': function(cls) {
		return js.Boot.__instanceof(this,cls)?this:null;
	}
	,getParentAs: function(name,cls) {
		var p = js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null;
		while(p != null && p.name != name) p = js.Boot.__instanceof(p.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(p.parent , ru.stablex.ui.widgets.Widget):null;
		return js.Boot.__instanceof(p,cls)?p:null;
	}
	,getParent: function(name) {
		var p = js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null;
		while(p != null && p.name != name) p = js.Boot.__instanceof(p.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(p.parent , ru.stablex.ui.widgets.Widget):null;
		return p;
	}
	,_findChildWidget: function(name) {
		var child = null;
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			child = this.getChildAt(i);
			if(child.name == name) break;
			if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
				child = (js.Boot.__cast(child , ru.stablex.ui.widgets.Widget))._findChildWidget(name);
				if(child != null) break;
			}
			child = null;
		}
		return js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(child , ru.stablex.ui.widgets.Widget):null;
	}
	,getChild: function(name) {
		return this._findChildWidget(name);
	}
	,getChildAs: function(name,cls) {
		var w = this._findChildWidget(name);
		return js.Boot.__instanceof(w,cls)?w:null;
	}
	,removeChildAt: function(idx) {
		var child = this.getChildAt(idx);
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			this.removeEventListener("widgetResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
			this.removeEventListener("widgetInitialResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
		}
		return ru.stablex.TweenSprite.prototype.removeChildAt.call(this,idx);
	}
	,removeChild: function(child) {
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			this.removeEventListener("widgetResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
			this.removeEventListener("widgetInitialResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
		}
		return ru.stablex.TweenSprite.prototype.removeChild.call(this,child);
	}
	,addChildAt: function(child,idx) {
		if(child.parent != null) child.parent.removeChild(child);
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget))._newParent(this);
			this.addUniqueListener("widgetResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
			this.addUniqueListener("widgetInitialResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
		}
		return ru.stablex.TweenSprite.prototype.addChildAt.call(this,child,idx);
	}
	,addChild: function(child) {
		if(child.parent != null) child.parent.removeChild(child);
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget))._newParent(this);
			this.addUniqueListener("widgetResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
			this.addUniqueListener("widgetInitialResize",($_=(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)),$bind($_,$_._onParentResize)));
		}
		return ru.stablex.TweenSprite.prototype.addChild.call(this,child);
	}
	,onResize: function() {
	}
	,_onResize: function() {
		if((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null) != null) {
			var _g = this;
			switch(_g._xUse) {
			case 3:
				this.set_x((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - this._right - this._width);
				break;
			case 4:
				this.set_x((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width - (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._width * this._rightPercent / 100 - this._width);
				break;
			}
			var _g1 = this;
			switch(_g1._yUse) {
			case 7:
				this.set_y((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - this._bottom - this._height);
				break;
			case 8:
				this.set_y((js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height - (js.Boot.__instanceof(this.parent,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(this.parent , ru.stablex.ui.widgets.Widget):null)._height * this._bottomPercent / 100 - this._height);
				break;
			}
		}
		if(!this.overflow) this.set_scrollRect(new flash.geom.Rectangle(0,0,this._width,this._height));
		if(!this._resizing) {
			this._resizing = true;
			if(this.created) this.onResize();
			if(this.initialized) this.refresh();
			this._resizing = false;
		}
		this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent(this.created?"widgetResize":"widgetInitialResize"));
	}
	,resize: function(width,height,keepPercentage) {
		if(keepPercentage == null) keepPercentage = false;
		if(!keepPercentage) {
			this._silentResize = true;
			this.set_w(width);
			this.set_h(height);
			this._silentResize = false;
		} else {
			this._width = width;
			this._height = height;
		}
		this._onResize();
	}
	,_onParentResize: function(e) {
		var parent = js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Widget);
		if(this._widthUsePercent || this._heightUsePercent) this.resize(this._widthUsePercent?parent._width * this._widthPercent / 100:this._width,this._heightUsePercent?parent._height * this._heightPercent / 100:this._height,true);
		var _g = this;
		switch(_g._xUse) {
		case 3:
			this.set_x(parent._width - this._right - this._width);
			break;
		case 4:
			this.set_x(parent._width - parent._width * this._rightPercent / 100 - this.get_w());
			break;
		case 2:
			this.set_x(parent._width * this._leftPercent / 100);
			break;
		}
		var _g1 = this;
		switch(_g1._yUse) {
		case 7:
			this.set_y(parent._height - this._bottom - this._height);
			break;
		case 8:
			this.set_y(parent._height - parent._height * this._bottomPercent / 100 - this._height);
			break;
		case 6:
			this.set_y(parent._height * this._topPercent / 100);
			break;
		}
	}
	,onNewParent: function(newParent) {
		if(this._widthUsePercent || this._heightUsePercent) this.resize(this._widthUsePercent?newParent._width * this._widthPercent / 100:this._width,this._heightUsePercent?newParent._height * this._heightPercent / 100:this._height,true);
		var _g = this;
		switch(_g._xUse) {
		case 3:
			this.set_x(newParent._width - this._right - this._width);
			break;
		case 4:
			this.set_x(newParent._width - newParent._width * this._rightPercent / 100 - this._width);
			break;
		case 2:
			this.set_x(newParent._width * this._leftPercent / 100);
			break;
		}
		var _g1 = this;
		switch(_g1._yUse) {
		case 7:
			this.set_y(newParent._height - this._bottom - this._height);
			break;
		case 8:
			this.set_y(newParent._height - newParent._height * this._bottomPercent / 100 - this._height);
			break;
		case 6:
			this.set_y(newParent._height * this._topPercent / 100);
			break;
		}
	}
	,_newParent: function(newParent) {
		if(newParent != this.parent) this.onNewParent(newParent);
	}
	,refresh: function() {
		if(this.skin != null && !this._skinQueued) {
			ru.stablex.ui.UIBuilder._skinQueue.add(this);
			this._skinQueued = true;
		}
		this.applyLayout();
	}
	,applyLayout: function() {
		if(this.layout != null) this.layout.arrangeChildren(this);
	}
	,applySkin: function() {
		if(this.initialized && this.skin != null) this.skin.apply(this);
	}
	,free: function(recursive) {
		if(recursive == null) recursive = true;
		this.destroyed = true;
		this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetFree"));
		ru.stablex.TweenSprite.prototype.free.call(this,recursive);
		ru.stablex.ui.UIBuilder._objects.remove(this.id);
	}
	,onCreate: function() {
	}
	,_onCreate: function() {
		this.clearEvent("widgetInitialResize");
		this.onCreate();
		this.refresh();
		this.created = true;
		this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetCreate"));
	}
	,onInitialize: function() {
	}
	,_onInitialize: function() {
		this.onInitialize();
		this.initialized = true;
	}
	,layout: null
	,tip: null
	,overflow: null
	,skinName: null
	,_skinQueued: null
	,skin: null
	,_bottomPercent: null
	,_bottom: null
	,_topPercent: null
	,_top: null
	,_yUse: null
	,_xUse: null
	,_rightPercent: null
	,_right: null
	,_leftPercent: null
	,_left: null
	,id: null
	,_resizing: null
	,_silentResize: null
	,_heightUsePercent: null
	,_heightPercent: null
	,_height: null
	,_widthUsePercent: null
	,_widthPercent: null
	,_width: null
	,destroyed: null
	,created: null
	,initialized: null
	,defaults: null
	,__class__: ru.stablex.ui.widgets.Widget
	,__properties__: $extend(ru.stablex.TweenSprite.prototype.__properties__,{set_w:"set_w",get_w:"get_w",set_widthPt:"set_widthPt",get_widthPt:"get_widthPt",set_h:"set_h",get_h:"get_h",set_heightPt:"set_heightPt",get_heightPt:"get_heightPt",set_id:"set_id",set_left:"set_left",get_left:"get_left",set_leftPt:"set_leftPt",get_leftPt:"get_leftPt",set_right:"set_right",get_right:"get_right",set_rightPt:"set_rightPt",get_rightPt:"get_rightPt",get_wparent:"get_wparent",set_top:"set_top",get_top:"get_top",set_topPt:"set_topPt",get_topPt:"get_topPt",set_bottom:"set_bottom",get_bottom:"get_bottom",set_bottomPt:"set_bottomPt",get_bottomPt:"get_bottomPt",set_skinName:"set_skinName",set_overflow:"set_overflow",set_tip:"set_tip"})
});
ru.stablex.ui.widgets.Bmp = function() {
	this.drawPortion = false;
	this.yOffset = 0;
	this.xOffset = 0;
	this._bitmapData = null;
	this.autoHeight = true;
	this.autoWidth = true;
	this.smooth = true;
	this._src = null;
	ru.stablex.ui.widgets.Widget.call(this);
};
$hxClasses["ru.stablex.ui.widgets.Bmp"] = ru.stablex.ui.widgets.Bmp;
ru.stablex.ui.widgets.Bmp.__name__ = ["ru","stablex","ui","widgets","Bmp"];
ru.stablex.ui.widgets.Bmp.__super__ = ru.stablex.ui.widgets.Widget;
ru.stablex.ui.widgets.Bmp.prototype = $extend(ru.stablex.ui.widgets.Widget.prototype,{
	set_h: function(h) {
		this.autoHeight = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_h.call(this,h);
	}
	,set_heightPt: function(hp) {
		this.autoHeight = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_heightPt.call(this,hp);
	}
	,set_widthPt: function(wp) {
		this.autoWidth = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_widthPt.call(this,wp);
	}
	,set_w: function(w) {
		this.autoWidth = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_w.call(this,w);
	}
	,set_yOffset: function(y) {
		this.drawPortion = true;
		return this.yOffset = y >= 0?y:0;
	}
	,set_xOffset: function(x) {
		this.drawPortion = true;
		return this.xOffset = x >= 0?x:0;
	}
	,set_autoSize: function($as) {
		return this.autoWidth = this.autoHeight = $as;
	}
	,set_bitmapData: function(bitmapData) {
		if(bitmapData != null) this._src = null;
		return this._bitmapData = bitmapData;
	}
	,get_bitmapData: function() {
		return this._bitmapData;
	}
	,set_src: function(src) {
		if(src != null) this._bitmapData = null;
		return this._src = src;
	}
	,get_src: function() {
		return this._src;
	}
	,_draw: function(bmp) {
		this.get_graphics().clear();
		if(this.drawPortion) {
			var width = this.autoWidth?bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0:this._width > (bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) - this.xOffset?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) - this.xOffset:this._width;
			var height = this.autoHeight?bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0:this._height > (bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0) - this.yOffset?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0) - this.yOffset:this._height | 0;
			if(width <= 0 || height <= 0) return; else {
				var mx = new flash.geom.Matrix();
				var dest = new flash.display.BitmapData(width | 0,height | 0);
				dest.copyPixels(bmp,new flash.geom.Rectangle(this.xOffset,this.yOffset,width,height),new flash.geom.Point(0,0));
				bmp = dest;
				this.get_graphics().beginBitmapFill(bmp,mx,false,this.smooth);
				this.get_graphics().drawRect(0,0,width,height);
				this.get_graphics().endFill();
			}
		} else {
			this.get_graphics().beginBitmapFill(bmp,null,false,this.smooth);
			this.get_graphics().drawRect(0,0,bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0,bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0);
			this.get_graphics().endFill();
		}
	}
	,refresh: function() {
		var bmp = this._bitmapData;
		if(bmp == null && this._src != null) {
			bmp = ru.stablex.Assets.getBitmapData(this._src);
			if(bmp == null) throw "Bitmap not found: " + this._src;
		}
		if(bmp != null) {
			if(this.autoWidth && this.autoHeight && (this._width != (this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) - this.xOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) || this._height != (this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0) - this.yOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0))) this.resize(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0,bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0); else if(this.autoWidth && this._width != (this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) - this.xOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0)) this.set_w(this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0) - this.xOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.width:0); else if(this.autoHeight && this._height != (this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0) - this.yOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0)) this.set_h(this.drawPortion?(bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0) - this.yOffset:bmp._nmeTextureBuffer != null?bmp._nmeTextureBuffer.height:0);
			ru.stablex.ui.widgets.Widget.prototype.refresh.call(this);
			this._draw(bmp);
		} else ru.stablex.ui.widgets.Widget.prototype.refresh.call(this);
	}
	,drawPortion: null
	,yOffset: null
	,xOffset: null
	,_bitmapData: null
	,autoHeight: null
	,autoWidth: null
	,smooth: null
	,_src: null
	,__class__: ru.stablex.ui.widgets.Bmp
	,__properties__: $extend(ru.stablex.ui.widgets.Widget.prototype.__properties__,{set_src:"set_src",get_src:"get_src",set_autoSize:"set_autoSize",set_bitmapData:"set_bitmapData",get_bitmapData:"get_bitmapData",set_xOffset:"set_xOffset",set_yOffset:"set_yOffset"})
});
ru.stablex.ui.widgets.Box = function() {
	this.unifyChildren = false;
	this.autoHeight = true;
	this.autoWidth = true;
	this.align = "center,middle";
	this.childPadding = 0;
	this.paddingBottom = 0;
	this.paddingTop = 0;
	this.paddingRight = 0;
	this.paddingLeft = 0;
	this.vertical = true;
	ru.stablex.ui.widgets.Widget.call(this);
};
$hxClasses["ru.stablex.ui.widgets.Box"] = ru.stablex.ui.widgets.Box;
ru.stablex.ui.widgets.Box.__name__ = ["ru","stablex","ui","widgets","Box"];
ru.stablex.ui.widgets.Box._objWidth = function(obj) {
	if(js.Boot.__instanceof(obj,ru.stablex.ui.widgets.Widget)) return (js.Boot.__cast(obj , ru.stablex.ui.widgets.Widget)).get_w(); else if(js.Boot.__instanceof(obj,flash.text.TextField)) return (js.Boot.__cast(obj , flash.text.TextField)).get_textWidth() + 4; else return obj.get_width();
}
ru.stablex.ui.widgets.Box._objHeight = function(obj) {
	if(js.Boot.__instanceof(obj,ru.stablex.ui.widgets.Widget)) return (js.Boot.__cast(obj , ru.stablex.ui.widgets.Widget)).get_h(); else if(js.Boot.__instanceof(obj,flash.text.TextField)) return (js.Boot.__cast(obj , flash.text.TextField)).get_textHeight() + 4; else return obj.get_height();
}
ru.stablex.ui.widgets.Box._setObjX = function(obj,x) {
	obj.set_x(js.Boot.__instanceof(obj,flash.text.TextField)?obj.set_x(x + 2):x);
}
ru.stablex.ui.widgets.Box._setObjY = function(obj,y) {
	obj.set_y(js.Boot.__instanceof(obj,flash.text.TextField)?obj.set_y(y + 2):y);
}
ru.stablex.ui.widgets.Box.__super__ = ru.stablex.ui.widgets.Widget;
ru.stablex.ui.widgets.Box.prototype = $extend(ru.stablex.ui.widgets.Widget.prototype,{
	set_padding: function(p) {
		this.paddingTop = this.paddingBottom = this.paddingRight = this.paddingLeft = p;
		return p;
	}
	,set_h: function(h) {
		this.autoHeight = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_h.call(this,h);
	}
	,set_heightPt: function(hp) {
		this.autoHeight = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_heightPt.call(this,hp);
	}
	,set_widthPt: function(wp) {
		this.autoWidth = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_widthPt.call(this,wp);
	}
	,set_w: function(w) {
		this.autoWidth = false;
		return ru.stablex.ui.widgets.Widget.prototype.set_w.call(this,w);
	}
	,set_autoSize: function($as) {
		return this.autoWidth = this.autoHeight = $as;
	}
	,_onChildResize: function(e) {
		if(this.created) {
			if(this.autoWidth || this.autoHeight) {
				if(e != null) {
					var child = js.Boot.__instanceof(e.currentTarget,ru.stablex.ui.widgets.Widget)?js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Widget):null;
					if(child != null && child.get_visible() != false && !(this.autoWidth && child._widthUsePercent) && !(this.autoHeight && child._heightUsePercent)) this.refresh();
				} else this.refresh();
			} else this.alignElements();
		}
	}
	,removeChildAt: function(idx) {
		var child = ru.stablex.ui.widgets.Widget.prototype.removeChildAt.call(this,idx);
		child.removeEventListener("widgetResize",$bind(this,this._onChildResize));
		if(!this.destroyed) this._onChildResize();
		return child;
	}
	,removeChild: function(child) {
		ru.stablex.ui.widgets.Widget.prototype.removeChild.call(this,child);
		child.removeEventListener("widgetResize",$bind(this,this._onChildResize));
		if(!this.destroyed) this._onChildResize();
		return child;
	}
	,addChildAt: function(child,idx) {
		ru.stablex.ui.widgets.Widget.prototype.addChildAt.call(this,child,idx);
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).addUniqueListener("widgetResize",$bind(this,this._onChildResize));
			this._onChildResize();
		}
		return child;
	}
	,addChild: function(child) {
		ru.stablex.ui.widgets.Widget.prototype.addChild.call(this,child);
		if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
			(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).addUniqueListener("widgetResize",$bind(this,this._onChildResize));
			this._onChildResize();
		}
		return child;
	}
	,_hAlignCenter: function() {
		if(this.vertical) {
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				ru.stablex.ui.widgets.Box._setObjX(child,(this.get_w() - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width())) / 2);
			}
		} else {
			var child;
			var width = 0;
			var visibleChildren = 0;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				visibleChildren++;
				width += js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width();
			}
			width += (visibleChildren - 1) * this.childPadding;
			var lastX = (this.get_w() - width) / 2;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				child.set_x(js.Boot.__instanceof(child,flash.text.TextField)?child.set_x(lastX + 2):lastX);
				lastX += (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width()) + this.childPadding;
			}
		}
	}
	,_hAlignRight: function() {
		if(this.vertical) {
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				ru.stablex.ui.widgets.Box._setObjX(child,this.get_w() - this.paddingRight - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width()));
			}
		} else {
			var lastX = this.get_w() - this.paddingRight;
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(this.nmeChildren.length - 1 - i);
				if(!child.get_visible()) continue;
				ru.stablex.ui.widgets.Box._setObjX(child,lastX - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width()));
				lastX = child.get_x() - (js.Boot.__instanceof(child,flash.text.TextField)?2:0) - this.childPadding;
			}
		}
	}
	,_hAlignLeft: function() {
		if(this.vertical) {
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				ru.stablex.ui.widgets.Box._setObjX(this.getChildAt(i),this.paddingLeft);
			}
		} else {
			var lastX = this.paddingLeft;
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				child.set_x(js.Boot.__instanceof(child,flash.text.TextField)?child.set_x(lastX + 2):lastX);
				lastX += (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width()) + this.childPadding;
			}
		}
	}
	,_vAlignBottom: function() {
		if(this.vertical) {
			var lastY = this.get_h() - this.paddingBottom;
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(this.nmeChildren.length - 1 - i);
				if(!child.get_visible()) continue;
				ru.stablex.ui.widgets.Box._setObjY(child,lastY - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height()));
				lastY = child.get_y() - this.childPadding - (js.Boot.__instanceof(child,flash.text.TextField)?2:0);
			}
		} else {
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				ru.stablex.ui.widgets.Box._setObjY(child,this.get_h() - this.paddingBottom - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height()));
			}
		}
	}
	,_vAlignMiddle: function() {
		if(this.vertical) {
			var height = 0;
			var child;
			var visibleChildren = 0;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				visibleChildren++;
				height += js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height();
			}
			height += (visibleChildren - 1) * this.childPadding;
			var lastY = (this.get_h() - height) / 2;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				child.set_y(js.Boot.__instanceof(child,flash.text.TextField)?child.set_y(lastY + 2):lastY);
				lastY += (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height()) + this.childPadding;
			}
		} else {
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				ru.stablex.ui.widgets.Box._setObjY(child,(this.get_h() - (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height())) / 2);
			}
		}
	}
	,_vAlignTop: function() {
		if(this.vertical) {
			var lastY = this.paddingTop;
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(!child.get_visible()) continue;
				child.set_y(js.Boot.__instanceof(child,flash.text.TextField)?child.set_y(lastY + 2):lastY);
				lastY += (js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height()) + this.childPadding;
			}
		} else {
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				ru.stablex.ui.widgets.Box._setObjY(this.getChildAt(i),this.paddingTop);
			}
		}
	}
	,_unifyChildren: function() {
		var visibleChildren = 0;
		var _g1 = 0, _g = this.nmeChildren.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.getChildAt(i).get_visible()) visibleChildren++;
		}
		var child;
		if(this.vertical) {
			var childWidth = this._width - this.paddingLeft - this.paddingRight;
			var childHeight = (this._height - this.paddingTop - this.paddingBottom - this.childPadding * (visibleChildren - 1)) / visibleChildren;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).removeEventListener("widgetResize",$bind(this,this._onChildResize));
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).resize(childWidth,childHeight);
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).addUniqueListener("widgetResize",$bind(this,this._onChildResize));
				}
			}
		} else {
			var childWidth = (this._width - this.paddingLeft - this.paddingRight - this.childPadding * (visibleChildren - 1)) / visibleChildren;
			var childHeight = this._height - this.paddingTop - this.paddingBottom;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) {
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).removeEventListener("widgetResize",$bind(this,this._onChildResize));
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).resize(childWidth,childHeight);
					(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).addUniqueListener("widgetResize",$bind(this,this._onChildResize));
				}
			}
		}
	}
	,alignElements: function() {
		if(this.unifyChildren) this._unifyChildren();
		if(this.nmeChildren.length == 0) return;
		var alignments = this.align.split(",");
		var _g = 0;
		while(_g < alignments.length) {
			var align = alignments[_g];
			++_g;
			switch(align) {
			case "top":
				this._vAlignTop();
				break;
			case "middle":
				this._vAlignMiddle();
				break;
			case "bottom":
				this._vAlignBottom();
				break;
			case "left":
				this._hAlignLeft();
				break;
			case "center":
				this._hAlignCenter();
				break;
			case "right":
				this._hAlignRight();
				break;
			}
		}
	}
	,_calcHeight: function() {
		if(this.vertical) {
			var h = this.paddingTop + this.paddingBottom;
			var child;
			var visibleChildren = 0;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(child.get_visible()) {
					h += js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height();
					visibleChildren++;
				}
			}
			return h + (visibleChildren - 1) * this.childPadding;
		} else {
			var h = 0;
			var childH = 0;
			var child;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(child.get_visible()) {
					childH = js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_h():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textHeight() + 4:child.get_height();
					if(childH > h) h = childH;
				}
			}
			return h + this.paddingTop + this.paddingBottom;
		}
	}
	,_calcWidth: function() {
		if(this.vertical) {
			var w = 0;
			var child;
			var childW = 0;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				child = this.getChildAt(i);
				if(child.get_visible()) {
					childW = js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width();
					if(childW > w) w = childW;
				}
			}
			return w + this.paddingLeft + this.paddingRight;
		} else {
			var w = this.paddingLeft + this.paddingRight;
			var child;
			var visibleChildren = 0;
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(child.get_visible()) {
					w += js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)?(js.Boot.__cast(child , ru.stablex.ui.widgets.Widget)).get_w():js.Boot.__instanceof(child,flash.text.TextField)?(js.Boot.__cast(child , flash.text.TextField)).get_textWidth() + 4:child.get_width();
					visibleChildren++;
				}
			}
			return w + (visibleChildren - 1) * this.childPadding;
		}
	}
	,refresh: function() {
		if(this.autoWidth || this.autoHeight) {
			var w = this.autoWidth?this._calcWidth():this._width;
			var h = this.autoHeight?this._calcHeight():this._height;
			if(this._width != w || this._height != h) {
				this._width = w;
				this._height = h;
				this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetResize"));
			}
		}
		ru.stablex.ui.widgets.Widget.prototype.refresh.call(this);
		if(this.layout == null) this.alignElements();
	}
	,unifyChildren: null
	,autoHeight: null
	,autoWidth: null
	,align: null
	,childPadding: null
	,paddingBottom: null
	,paddingTop: null
	,paddingRight: null
	,paddingLeft: null
	,vertical: null
	,__class__: ru.stablex.ui.widgets.Box
	,__properties__: $extend(ru.stablex.ui.widgets.Widget.prototype.__properties__,{set_padding:"set_padding",set_autoSize:"set_autoSize"})
});
ru.stablex.ui.widgets.Text = function() {
	this.highlighted = false;
	ru.stablex.ui.widgets.Box.call(this);
	this.label = js.Boot.__cast(this.addChild(new flash.text.TextField()) , flash.text.TextField);
	this.label.set_autoSize("LEFT");
	this.label.multiline = true;
	this.format = this.label.get_defaultTextFormat();
	this.align = "top,left";
};
$hxClasses["ru.stablex.ui.widgets.Text"] = ru.stablex.ui.widgets.Text;
ru.stablex.ui.widgets.Text.__name__ = ["ru","stablex","ui","widgets","Text"];
ru.stablex.ui.widgets.Text.__super__ = ru.stablex.ui.widgets.Box;
ru.stablex.ui.widgets.Text.prototype = $extend(ru.stablex.ui.widgets.Box.prototype,{
	set_text: function(txt) {
		this.label.set_text(txt);
		if(this.autoWidth || this.autoHeight) this.refresh(); else this.alignElements();
		return txt;
	}
	,get_text: function() {
		return this.label.get_text();
	}
	,unhighlight: function() {
		this.highlighted = false;
		ru.stablex.ui.widgets.Box.prototype.refresh.call(this);
	}
	,highlight: function() {
		this.highlighted = true;
		ru.stablex.ui.widgets.Box.prototype.refresh.call(this);
	}
	,refresh: function() {
		if(this.highlighted) {
			this.label.set_defaultTextFormat(this.get_highlightFormat());
			if(this.label.get_text().length > 0) this.label.setTextFormat(this.get_highlightFormat());
		} else {
			this.label.set_defaultTextFormat(this.format);
			if(this.label.get_text().length > 0) this.label.setTextFormat(this.format);
		}
		if(!this.autoWidth && this.label.get_wordWrap()) this.label.set_width(this._width);
		ru.stablex.ui.widgets.Box.prototype.refresh.call(this);
	}
	,set_highlightFormat: function(hl) {
		return this._hightlightFormat = hl;
	}
	,get_highlightFormat: function() {
		if(this._hightlightFormat == null) this._hightlightFormat = new flash.text.TextFormat(this.format.font,this.format.size,this.format.color,this.format.bold,this.format.italic,this.format.underline,this.format.url,this.format.target,this.format.align,this.format.leftMargin | 0,this.format.rightMargin | 0,this.format.indent | 0,this.format.leading | 0);
		return this._hightlightFormat;
	}
	,highlighted: null
	,_hightlightFormat: null
	,format: null
	,label: null
	,__class__: ru.stablex.ui.widgets.Text
	,__properties__: $extend(ru.stablex.ui.widgets.Box.prototype.__properties__,{set_highlightFormat:"set_highlightFormat",get_highlightFormat:"get_highlightFormat",set_text:"set_text",get_text:"get_text"})
});
ru.stablex.ui.widgets.Button = function() {
	this.apart = false;
	this.icoBeforeLabel = true;
	this.hovered = false;
	this.pressed = false;
	ru.stablex.ui.widgets.Text.call(this);
	this.vertical = false;
	this.set_padding(2);
	this.childPadding = 5;
	this.label.selectable = false;
	this.buttonMode = this.set_useHandCursor(true);
	this.mouseChildren = false;
	this.addEventListener(flash.events.MouseEvent.MOUSE_OVER,ru.stablex.ui.widgets.Button._onHover);
	this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,ru.stablex.ui.widgets.Button._onHout);
	this.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,ru.stablex.ui.widgets.Button._onPress);
	this.addEventListener(flash.events.MouseEvent.MOUSE_OUT,ru.stablex.ui.widgets.Button._onRelease);
	this.addEventListener(flash.events.MouseEvent.MOUSE_UP,ru.stablex.ui.widgets.Button._onRelease);
	this.pressed = false;
	this.hovered = false;
	this.align = "center,middle";
};
$hxClasses["ru.stablex.ui.widgets.Button"] = ru.stablex.ui.widgets.Button;
ru.stablex.ui.widgets.Button.__name__ = ["ru","stablex","ui","widgets","Button"];
ru.stablex.ui.widgets.Button._onHover = function(e) {
	var btn = js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Button);
	if(btn.hovered) return;
	btn._switchIco(btn._icoHovered);
	btn._switchSkin(btn.skinHovered);
	btn.hovered = true;
	btn.onHover(e);
}
ru.stablex.ui.widgets.Button._onHout = function(e) {
	var btn = js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Button);
	if(!btn.hovered) return;
	btn._switchIco(btn._ico);
	btn._switchSkin(btn.skin);
	btn.hovered = false;
	btn.onHout(e);
}
ru.stablex.ui.widgets.Button._onPress = function(e) {
	var btn = js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Button);
	if(btn.pressed) return;
	btn._switchIco(btn._icoPressed);
	btn._switchSkin(btn.skinPressed);
	btn.pressed = true;
	btn.onPress(e);
}
ru.stablex.ui.widgets.Button._onRelease = function(e) {
	var btn = js.Boot.__cast(e.currentTarget , ru.stablex.ui.widgets.Button);
	if(!btn.pressed) return;
	if(btn.hovered) btn._switchIco(btn._icoHovered); else btn._switchIco(btn._ico);
	if(btn.hovered) btn._switchSkin(btn.skinHovered); else btn._switchSkin(btn.skin);
	btn.pressed = false;
	btn.onRelease(e);
}
ru.stablex.ui.widgets.Button.__super__ = ru.stablex.ui.widgets.Text;
ru.stablex.ui.widgets.Button.prototype = $extend(ru.stablex.ui.widgets.Text.prototype,{
	_moveApart: function() {
		var child;
		if(this.icoBeforeLabel) {
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Bmp)) (js.Boot.__cast(child , ru.stablex.ui.widgets.Bmp)).set_left(this.paddingLeft);
			}
			ru.stablex.ui.widgets.Box._setObjX(this.label,this._width - this.paddingRight - ru.stablex.ui.widgets.Box._objWidth(this.label));
		} else {
			var _g1 = 0, _g = this.nmeChildren.length;
			while(_g1 < _g) {
				var i = _g1++;
				child = this.getChildAt(i);
				if(js.Boot.__instanceof(child,ru.stablex.ui.widgets.Bmp)) (js.Boot.__cast(child , ru.stablex.ui.widgets.Bmp)).set_right(this.paddingRight);
			}
			ru.stablex.ui.widgets.Box._setObjX(this.label,this.paddingLeft);
		}
	}
	,alignElements: function() {
		ru.stablex.ui.widgets.Text.prototype.alignElements.call(this);
		if(this.apart) this._moveApart();
	}
	,refresh: function() {
		this._appliedSkin = this.skin;
		if(this._ico != null) this._ico.refresh();
		if(this._icoHovered != null) this._icoHovered.refresh();
		if(this._icoPressed != null) this._icoPressed.refresh();
		ru.stablex.ui.widgets.Text.prototype.refresh.call(this);
	}
	,_switchSkin: function(skin) {
		if(this._appliedSkin != skin && skin != null) {
			skin.apply(this);
			this._appliedSkin = skin;
		} else if(skin == null && this.skin != null) {
			this.skin.apply(this);
			this._appliedSkin = skin;
		}
	}
	,_switchIco: function(ico) {
		if(this._ico != null) this._ico.set_visible(false);
		if(this._icoHovered != null) this._icoHovered.set_visible(false);
		if(this._icoPressed != null) this._icoPressed.set_visible(false);
		if(ico != null) ico.set_visible(true); else if(this._ico != null) this._ico.set_visible(true);
		this.alignElements();
	}
	,_addIco: function(ico) {
		if(this.icoBeforeLabel) this.addChildAt(ico,0); else this.addChild(ico);
	}
	,set_skinPressedName: function(s) {
		this.skinPressed = (ru.stablex.ui.UIBuilder.skins.get(s))();
		return this.skinPressedName = s;
	}
	,set_skinHoveredName: function(s) {
		this.skinHovered = (ru.stablex.ui.UIBuilder.skins.get(s))();
		return this.skinHoveredName = s;
	}
	,set_icoPressed: function(ico) {
		if(this._icoPressed != null) this._icoPressed.free();
		if(ico != null) {
			if(this.icoBeforeLabel) this.addChildAt(ico,0); else this.addChild(ico);
		}
		return this._icoPressed = ico;
	}
	,get_icoPressed: function() {
		if(this._icoPressed == null) {
			this._icoPressed = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Bmp);
			this._icoPressed.set_visible(false);
			this._addIco(this._icoPressed);
		}
		return this._icoPressed;
	}
	,set_icoHovered: function(ico) {
		if(this._icoHovered != null) this._icoHovered.free();
		if(ico != null) {
			if(this.icoBeforeLabel) this.addChildAt(ico,0); else this.addChild(ico);
		}
		return this._icoHovered = ico;
	}
	,get_icoHovered: function() {
		if(this._icoHovered == null) {
			this._icoHovered = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Bmp);
			this._icoHovered.set_visible(false);
			this._addIco(this._icoHovered);
		}
		return this._icoHovered;
	}
	,set_ico: function(ico) {
		if(this._ico != null) this._ico.free();
		if(ico != null) {
			if(this.icoBeforeLabel) this.addChildAt(ico,0); else this.addChild(ico);
		}
		return this._ico = ico;
	}
	,get_ico: function() {
		if(this._ico == null) {
			this._ico = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Bmp);
			this._addIco(this._ico);
		}
		return this._ico;
	}
	,set_icoBeforeLabel: function(ibl) {
		if(ibl) this.setChildIndex(this.label,this.nmeChildren.length - 1); else this.setChildIndex(this.label,0);
		return this.icoBeforeLabel = ibl;
	}
	,onHout: function(e) {
	}
	,onHover: function(e) {
	}
	,onRelease: function(e) {
	}
	,onPress: function(e) {
	}
	,apart: null
	,_appliedSkin: null
	,skinPressed: null
	,skinPressedName: null
	,skinHovered: null
	,skinHoveredName: null
	,icoBeforeLabel: null
	,_icoPressed: null
	,_icoHovered: null
	,_ico: null
	,hovered: null
	,pressed: null
	,__class__: ru.stablex.ui.widgets.Button
	,__properties__: $extend(ru.stablex.ui.widgets.Text.prototype.__properties__,{set_ico:"set_ico",get_ico:"get_ico",set_icoHovered:"set_icoHovered",get_icoHovered:"get_icoHovered",set_icoPressed:"set_icoPressed",get_icoPressed:"get_icoPressed",set_icoBeforeLabel:"set_icoBeforeLabel",set_skinHoveredName:"set_skinHoveredName",set_skinPressedName:"set_skinPressedName"})
});
ru.stablex.ui.widgets.Floating = function() {
	this.renderTo = null;
	this.shown = false;
	ru.stablex.ui.widgets.Box.call(this);
	this.set_visible(false);
};
$hxClasses["ru.stablex.ui.widgets.Floating"] = ru.stablex.ui.widgets.Floating;
ru.stablex.ui.widgets.Floating.__name__ = ["ru","stablex","ui","widgets","Floating"];
ru.stablex.ui.widgets.Floating.__super__ = ru.stablex.ui.widgets.Box;
ru.stablex.ui.widgets.Floating.prototype = $extend(ru.stablex.ui.widgets.Box.prototype,{
	free: function(recursive) {
		if(recursive == null) recursive = true;
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.Event.RESIZE,$bind(this,this._onStageResize));
		ru.stablex.ui.widgets.Box.prototype.free.call(this,recursive);
	}
	,_onStageResize: function(e) {
		if(this.parent != flash.Lib.get_current().get_stage()) return;
		var width = flash.Lib.get_current().get_stage().get_stageWidth();
		var height = flash.Lib.get_current().get_stage().get_stageHeight();
		if(this._widthUsePercent && this._heightUsePercent) this.resize(width * this._widthPercent / 100,height * this._heightPercent / 100,true); else if(this._widthUsePercent) this.resize(width * this._widthPercent / 100,this._height,true); else if(this._heightUsePercent) this.resize(this._width,height * this._heightPercent / 100,true);
		var _g = this;
		switch(_g._xUse) {
		case 3:
			this.set_x(width - this._right - this._width);
			break;
		case 4:
			this.set_x(width - width * this._rightPercent / 100 - this.get_w());
			break;
		case 2:
			this.set_x(width * this._leftPercent / 100);
			break;
		}
		var _g1 = this;
		switch(_g1._yUse) {
		case 7:
			this.set_y(height - this._bottom - this._height);
			break;
		case 8:
			this.set_y(height - height * this._bottomPercent / 100 - this._height);
			break;
		case 6:
			this.set_y(height * this._topPercent / 100);
			break;
		}
	}
	,_usingParentSize: function() {
		return this._widthUsePercent || this._heightUsePercent || this._xUse == 2 || this._xUse == 4 || this._xUse == 3 || this._yUse == 6 || this._yUse == 8 || this._yUse == 7;
	}
	,hide: function() {
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.Event.RESIZE,$bind(this,this._onStageResize));
		if(this.parent != null) this.parent.removeChild(this);
		this.set_visible(this.shown = false);
	}
	,show: function() {
		if(this.renderTo == null) {
			this.set_visible(this.shown = true);
			if(this._widthUsePercent || this._heightUsePercent || this._xUse == 2 || this._xUse == 4 || this._xUse == 3 || this._yUse == 6 || this._yUse == 8 || this._yUse == 7) {
				flash.Lib.get_current().get_stage().removeEventListener(flash.events.Event.RESIZE,$bind(this,this._onStageResize));
				flash.Lib.get_current().get_stage().addEventListener(flash.events.Event.RESIZE,$bind(this,this._onStageResize));
			}
			if(this.parent == flash.Lib.get_current()) flash.Lib.get_current().get_stage().setChildIndex(this,flash.Lib.get_current().get_stage().nmeChildren.length - 1); else flash.Lib.get_current().get_stage().addChild(this);
			this._onStageResize();
		} else {
			var to = ru.stablex.ui.UIBuilder._objects.get(this.renderTo);
			if(to != null) {
				this.set_visible(this.shown = true);
				if(this.parent == to) to.setChildIndex(this,to.nmeChildren.length - 1); else to.addChild(this);
			}
		}
	}
	,renderTo: null
	,shown: null
	,__class__: ru.stablex.ui.widgets.Floating
});
ru.stablex.ui.widgets.HBox = function() {
	ru.stablex.ui.widgets.Box.call(this);
	this.vertical = false;
};
$hxClasses["ru.stablex.ui.widgets.HBox"] = ru.stablex.ui.widgets.HBox;
ru.stablex.ui.widgets.HBox.__name__ = ["ru","stablex","ui","widgets","HBox"];
ru.stablex.ui.widgets.HBox.__super__ = ru.stablex.ui.widgets.Box;
ru.stablex.ui.widgets.HBox.prototype = $extend(ru.stablex.ui.widgets.Box.prototype,{
	__class__: ru.stablex.ui.widgets.HBox
});
ru.stablex.ui.widgets.InputText = function() {
	var _g = this;
	ru.stablex.ui.widgets.Text.call(this);
	this.addEventListener(flash.events.Event.ADDED_TO_STAGE,function(e) {
		_g.label.set_type(flash.text.TextFieldType.INPUT);
		Reflect.field(_g.label,"nmeGraphics").nmeSurface.style.width = _g.get_w() + "px";
		Reflect.field(_g.label,"nmeGraphics").nmeSurface.style.height = _g.get_h() + "px";
		Reflect.field(_g.label,"nmeGraphics").nmeSurface.style.overflow = "hidden";
		if(_g.label.get_wordWrap()) Reflect.field(_g.label,"nmeGraphics").nmeSurface.style.whiteSpace = "normal"; else Reflect.field(_g.label,"nmeGraphics").nmeSurface.style.whiteSpace = "nowrap";
	});
	this.label.set_autoSize("NONE");
	this.format.align = flash.text.TextFormatAlign.LEFT;
};
$hxClasses["ru.stablex.ui.widgets.InputText"] = ru.stablex.ui.widgets.InputText;
ru.stablex.ui.widgets.InputText.__name__ = ["ru","stablex","ui","widgets","InputText"];
ru.stablex.ui.widgets.InputText.__super__ = ru.stablex.ui.widgets.Text;
ru.stablex.ui.widgets.InputText.prototype = $extend(ru.stablex.ui.widgets.Text.prototype,{
	get_text: function() {
		return this.label.get_type() == flash.text.TextFieldType.INPUT?StringTools.replace(Reflect.field(this.label,"nmeGraphics").nmeSurface.innerHTML,"&nbsp;"," "):this.label.get_text();
	}
	,refresh: function() {
		this.label.set_width(this.get_w() - this.paddingLeft - this.paddingRight);
		this.label.set_height(this.get_h() - this.paddingTop - this.paddingBottom);
		ru.stablex.ui.widgets.Text.prototype.refresh.call(this);
		Reflect.field(this.label,"nmeGraphics").nmeSurface.style.width = this.get_w() + "px";
		Reflect.field(this.label,"nmeGraphics").nmeSurface.style.height = this.get_h() + "px";
		if(this.label.get_wordWrap()) Reflect.field(this.label,"nmeGraphics").nmeSurface.style.whiteSpace = "normal"; else Reflect.field(this.label,"nmeGraphics").nmeSurface.style.whiteSpace = "nowrap";
	}
	,__class__: ru.stablex.ui.widgets.InputText
});
ru.stablex.ui.widgets.Options = function() {
	this._selectedIdx = 0;
	this._rebuildList = true;
	this.alignList = true;
	this.optionDefaults = "Default";
	ru.stablex.ui.widgets.Button.call(this);
	this.list = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Floating);
	this.box = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Box);
	this.list.addChild(this.box);
	this.box.unifyChildren = true;
	this.addEventListener(flash.events.MouseEvent.CLICK,$bind(this,this.toggleList));
	this.list.addEventListener(flash.events.MouseEvent.CLICK,$bind(this,this.toggleList));
};
$hxClasses["ru.stablex.ui.widgets.Options"] = ru.stablex.ui.widgets.Options;
ru.stablex.ui.widgets.Options.__name__ = ["ru","stablex","ui","widgets","Options"];
ru.stablex.ui.widgets.Options.__super__ = ru.stablex.ui.widgets.Button;
ru.stablex.ui.widgets.Options.prototype = $extend(ru.stablex.ui.widgets.Button.prototype,{
	free: function(recursive) {
		if(recursive == null) recursive = true;
		this.list.free();
		ru.stablex.ui.widgets.Button.prototype.free.call(this,recursive);
	}
	,_onSelectOption: function(e) {
		var obj = e.currentTarget;
		if(obj != null) {
			var idx = Std.parseInt(obj.name);
			if(this.options != null && this.options.length > idx) {
				this.set__selectedIdx(idx);
				this.set_text(this.options[idx][0]);
			}
		}
	}
	,_buildList: function() {
		if(this.options == null) return;
		this.box.freeChildren();
		var _g1 = 0, _g = this.options.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.box.addChild(ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Toggle,{ defaults : this.optionDefaults, selected : this._selectedIdx == i, name : Std.string(i), text : this.options[i][0]})).addEventListener(flash.events.MouseEvent.CLICK,$bind(this,this._onSelectOption));
		}
		this.box.refresh();
		this.list.refresh();
	}
	,toggleList: function(e) {
		if(this.list.shown) this.list.hide(); else {
			if(this._rebuildList) {
				this._buildList();
				this._rebuildList = false;
			}
			if(this.alignList) {
				var rect = this.getRect(flash.Lib.get_current());
				this.list.set_left(rect.x + (this.get_w() - this.list.get_w()) / 2);
				this.list.set_top(rect.y + this.get_h());
				if(this.list.get_left() + this.list.get_w() > flash.Lib.get_current().get_stage().get_stageWidth()) this.list.set_left(flash.Lib.get_current().get_stage().get_stageWidth() - this.list.get_w()); else if(this.list.get_left() < 0) this.list.set_left(0);
				if(this.list.get_top() + this.list.get_h() > flash.Lib.get_current().get_stage().get_stageHeight()) this.list.set_top(flash.Lib.get_current().get_stage().get_stageHeight() - this.list.get_h()); else if(this.list.get_top() < 0) this.list.set_top(0);
			}
			this.list.renderTo = null;
			this.list.show();
		}
	}
	,set_value: function(v) {
		if(this.options != null) {
			var _g1 = 0, _g = this.options.length;
			while(_g1 < _g) {
				var i = _g1++;
				if(this.options[i][1] == v) {
					this.set__selectedIdx(i);
					break;
				}
			}
		}
		return v;
	}
	,get_value: function() {
		if(this.options == null || this.options.length <= this._selectedIdx) return null; else return this.options[this._selectedIdx][1];
	}
	,set_options: function(o) {
		if(o == null || o.length == 0) throw "Option list must not be null or empty";
		var _g1 = 0, _g = o.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(o[i].length != 2 || !js.Boot.__instanceof(o[i][0],String)) throw "Wrong options list format. Should be [[String,Dynamic], [String,Dynamic], ...] instead of " + Std.string(o);
		}
		this.set__selectedIdx(0);
		this.set_text(o[this._selectedIdx][0]);
		return this.options = o;
	}
	,set__selectedIdx: function(idx) {
		if(idx != this._selectedIdx) {
			this._rebuildList = true;
			this._selectedIdx = idx;
			this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
		}
		return idx;
	}
	,_selectedIdx: null
	,_rebuildList: null
	,alignList: null
	,optionDefaults: null
	,box: null
	,list: null
	,options: null
	,__class__: ru.stablex.ui.widgets.Options
	,__properties__: $extend(ru.stablex.ui.widgets.Button.prototype.__properties__,{set_options:"set_options",set_value:"set_value",get_value:"get_value",set__selectedIdx:"set__selectedIdx"})
});
ru.stablex.ui.widgets.Scroll = function() {
	this._processingDrag = false;
	this.wheelScrollSpeed = 10;
	this.dragScroll = true;
	this.hScrollKey = "alt";
	this.wheelScroll = true;
	this.hScroll = true;
	this.vScroll = true;
	ru.stablex.ui.widgets.Widget.call(this);
	this.set_overflow(false);
	this.set_vBar(ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Slider,{ vertical : true, right : 0, top : 0, heightPt : 100, w : 10, slider : { widthPt : 100}}));
	this.set_hBar(ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Slider,{ vertical : false, bottom : 0, left : 0, widthPt : 100, h : 10, slider : { heightPt : 100}}));
	this.addUniqueListener(flash.events.MouseEvent.MOUSE_WHEEL,$bind(this,this._beforeScroll));
	this.addUniqueListener(flash.events.MouseEvent.MOUSE_DOWN,$bind(this,this._beforeScroll));
};
$hxClasses["ru.stablex.ui.widgets.Scroll"] = ru.stablex.ui.widgets.Scroll;
ru.stablex.ui.widgets.Scroll.__name__ = ["ru","stablex","ui","widgets","Scroll"];
ru.stablex.ui.widgets.Scroll.__super__ = ru.stablex.ui.widgets.Widget;
ru.stablex.ui.widgets.Scroll.prototype = $extend(ru.stablex.ui.widgets.Widget.prototype,{
	_wheelScroll: function(e) {
		if(this.hScroll && (e.altKey && this.hScrollKey == "alt" || e.shiftKey && this.hScrollKey == "shift" || e.ctrlKey && this.hScrollKey == "ctrl")) {
			this.tweenStop();
			var _g = this;
			_g.set_scrollX(_g.get_scrollX() + e.delta * this.wheelScrollSpeed);
		} else if(this.vScroll) {
			this.tweenStop();
			var _g = this;
			_g.set_scrollY(_g.get_scrollY() + e.delta * this.wheelScrollSpeed);
		}
	}
	,_dragScroll: function(e) {
		var _g = this;
		if(this._processingDrag) return;
		this._processingDrag = true;
		var dx = this.get_mouseX() - this.get_scrollX();
		var dy = this.get_mouseY() - this.get_scrollY();
		var lastX = this.get_mouseX();
		var lastY = this.get_mouseY();
		var lastDx = 0;
		var lastDy = 0;
		var startX = this.get_mouseX();
		var startY = this.get_mouseY();
		var scrolled = false;
		var vScroll = this.vScroll && this.get_box().get_h() > this.get_h();
		var hScroll = this.hScroll && this.get_box().get_w() > this.get_w();
		this.tweenStop(["scrollX","scrollY"],false,true);
		var blocker = new flash.display.Sprite();
		blocker.get_graphics().beginFill(0,0);
		blocker.get_graphics().drawRect(0,0,this.get_w(),this.get_h());
		blocker.get_graphics().endFill();
		var fn = function(e1) {
			if(scrolled) {
				if(hScroll) _g.set_scrollX(_g.get_mouseX() - dx);
				if(vScroll) _g.set_scrollY(_g.get_mouseY() - dy);
			} else if(hScroll && !scrolled && Math.abs(_g.get_mouseX() - startX) >= 5 || vScroll && !scrolled && Math.abs(_g.get_mouseY() - startY) >= 5) {
				_g.addChild(blocker);
				scrolled = true;
				_g.get_box().mouseEnabled = false;
				_g.get_box().mouseChildren = false;
				_g.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetScrollStart"));
			}
			lastDx = _g.get_mouseX() - lastX;
			lastDy = _g.get_mouseY() - lastY;
			lastX = _g.get_mouseX();
			lastY = _g.get_mouseY();
		};
		this.addUniqueListener(flash.events.Event.ENTER_FRAME,fn);
		var fnStop = null;
		fnStop = function(e1) {
			_g._processingDrag = false;
			_g.removeEventListener(flash.events.Event.ENTER_FRAME,fn);
			flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_UP,fnStop);
			if(scrolled) {
				var finish = function() {
					_g.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetScrollStop"));
				};
				if(vScroll && hScroll) _g.tween(2,{ scrollX : _g.get_scrollX() + lastDx * 20, scrollY : _g.get_scrollY() + lastDy * 20},"Expo.easeOut").onComplete(finish); else if(vScroll) _g.tween(2,{ scrollY : _g.get_scrollY() + lastDy * 20},"Expo.easeOut").onComplete(finish); else _g.tween(2,{ scrollX : _g.get_scrollX() + lastDx * 20},"Expo.easeOut").onComplete(finish);
				if(blocker.parent == _g) _g.removeChild(blocker);
				_g.get_box().mouseEnabled = true;
				_g.get_box().mouseChildren = true;
			}
		};
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_UP,fnStop);
		flash.Lib.get_current().get_stage().addEventListener(flash.events.MouseEvent.MOUSE_UP,fnStop);
	}
	,_startScroll: function(e) {
		this.removeEventListener("scrollBefore",$bind(this,this._startScroll));
		if(e.canceled) return;
		if(e.srcEvent.type == flash.events.MouseEvent.MOUSE_DOWN && this.dragScroll) this._dragScroll(js.Boot.__instanceof(e.srcEvent,flash.events.MouseEvent)?e.srcEvent:null); else if(e.srcEvent.type == flash.events.MouseEvent.MOUSE_WHEEL && this.wheelScroll) this._wheelScroll(js.Boot.__instanceof(e.srcEvent,flash.events.MouseEvent)?e.srcEvent:null);
	}
	,_beforeScroll: function(e) {
		if(e.target == this.vBar || e.target == this.hBar || this.vBar != null && e.target == this.vBar.slider || this.hBar != null && e.target == this.hBar.slider) return;
		this.addUniqueListener("scrollBefore",$bind(this,this._startScroll));
		var e1 = new ru.stablex.ui.events.ScrollEvent("scrollBefore",e);
		this.dispatchEvent(e1);
	}
	,_onHBarChange: function(e) {
		if(Math.abs(this.get_scrollX() + this.hBar.get_value()) >= 1) {
			this.tweenStop();
			this.set_scrollX(-this.hBar.get_value());
		}
	}
	,_onVBarChange: function(e) {
		if(Math.abs(this.get_scrollY() - this.vBar.get_value()) >= 1) {
			this.tweenStop();
			this.set_scrollY(this.vBar.get_value());
		}
	}
	,refresh: function() {
		this.get_box().refresh();
		ru.stablex.ui.widgets.Widget.prototype.refresh.call(this);
		if(this.vBar != null) {
			this.addChildAt(this.vBar,1);
			this.vBar.min = this.get_h() - this.get_box().get_h() < 0?this.get_h() - this.get_box().get_h():0;
			this.vBar.max = 0;
			var k = this.vBar.get_h() / this.get_box().get_h();
			if(k > 1) k = 1;
			this.vBar.slider.set_h(this.get_h() * k);
			this.vBar.refresh();
			this.vBar.addUniqueListener("widgetChange",$bind(this,this._onVBarChange));
		}
		if(this.hBar != null) {
			this.addChildAt(this.hBar,1);
			this.hBar.max = -(this.get_w() - this.get_box().get_w() < 0?this.get_w() - this.get_box().get_w():0);
			this.hBar.min = 0;
			var k = this.hBar.get_w() / this.get_box().get_w();
			if(k > 1) k = 1;
			this.hBar.slider.set_w(this.hBar.get_w() * k);
			this.hBar.refresh();
			this.hBar.addUniqueListener("widgetChange",$bind(this,this._onHBarChange));
		}
	}
	,set_hBar: function(bar) {
		if(bar == null && this.hBar != null) this.hBar.free();
		return this.hBar = bar;
	}
	,set_vBar: function(bar) {
		if(bar == null && this.vBar != null) this.vBar.free();
		return this.vBar = bar;
	}
	,get_scrollY: function() {
		return this.get_box().get_top();
	}
	,set_scrollY: function(y) {
		if(this.get_box()._height > this._height) {
			if(y > 0) y = 0;
			if(y + this.get_box()._height < this._height) y = this._height - this.get_box()._height;
			this.get_box().set_top(y);
			if(this.vBar != null && Math.abs(this.vBar.get_value() - y) >= 1) this.vBar.set_value(y);
		}
		return y;
	}
	,get_scrollX: function() {
		return this.get_box().get_left();
	}
	,set_scrollX: function(x) {
		if(this.get_box()._width > this._width) {
			if(x > 0) x = 0;
			if(x + this.get_box()._width < this._width) x = this._width - this.get_box()._width;
			this.get_box().set_left(x);
			if(this.hBar != null && Math.abs(this.hBar.get_value() + x) >= 1) this.hBar.set_value(-x);
		}
		return x;
	}
	,get_box: function() {
		if(this.nmeChildren.length == 0) {
			throw "Scroll widget must have at least one child.";
			return null;
		} else {
			var child = this.getChildAt(0);
			if(!js.Boot.__instanceof(child,ru.stablex.ui.widgets.Widget)) throw "Instance of Widget must be the first child for Scroll widget";
			return js.Boot.__cast(child , ru.stablex.ui.widgets.Widget);
		}
	}
	,_processingDrag: null
	,hBar: null
	,vBar: null
	,wheelScrollSpeed: null
	,dragScroll: null
	,hScrollKey: null
	,wheelScroll: null
	,hScroll: null
	,vScroll: null
	,__class__: ru.stablex.ui.widgets.Scroll
	,__properties__: $extend(ru.stablex.ui.widgets.Widget.prototype.__properties__,{get_box:"get_box",set_scrollX:"set_scrollX",get_scrollX:"get_scrollX",set_scrollY:"set_scrollY",get_scrollY:"get_scrollY",set_vBar:"set_vBar",set_hBar:"set_hBar"})
});
ru.stablex.ui.widgets.Slider = function() {
	this.vertical = false;
	this._value = 0;
	this.max = 100;
	this.min = -100;
	ru.stablex.ui.widgets.Widget.call(this);
	this.slider = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Widget);
	this.addChild(this.slider);
	this.slider.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,$bind(this,this._slide));
	this.addEventListener(flash.events.MouseEvent.CLICK,$bind(this,this._set));
};
$hxClasses["ru.stablex.ui.widgets.Slider"] = ru.stablex.ui.widgets.Slider;
ru.stablex.ui.widgets.Slider.__name__ = ["ru","stablex","ui","widgets","Slider"];
ru.stablex.ui.widgets.Slider.__super__ = ru.stablex.ui.widgets.Widget;
ru.stablex.ui.widgets.Slider.prototype = $extend(ru.stablex.ui.widgets.Widget.prototype,{
	_slideHorizontally: function() {
		var _g = this;
		var dx = this.get_mouseX() - this.slider.get_left();
		var fn = function(e) {
			var x = _g.get_mouseX() - dx < 0?0:_g.get_mouseX() - dx + _g.slider._width > _g._width?_g._width - _g.slider._width:_g.get_mouseX() - dx;
			if(x != _g.slider.get_left()) {
				_g.slider.set_left(x);
				_g._value = x / (_g._width - _g.slider._width) * (_g.max - _g.min) + _g.min;
				_g.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
			}
		};
		this.addEventListener(flash.events.Event.ENTER_FRAME,fn);
		var fnRelease = null;
		fnRelease = function(e) {
			_g.removeEventListener(flash.events.Event.ENTER_FRAME,fn);
			flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_UP,fnRelease);
		};
		flash.Lib.get_current().get_stage().addEventListener(flash.events.MouseEvent.MOUSE_UP,fnRelease);
	}
	,_slideVertically: function() {
		var _g = this;
		var dy = this.get_mouseY() - this.slider.get_top();
		var fn = function(e) {
			var y = _g.get_mouseY() - dy < 0?0:_g.get_mouseY() - dy + _g.slider._height > _g._height?_g._height - _g.slider._height:_g.get_mouseY() - dy;
			if(y != _g.slider.get_top()) {
				_g.slider.set_top(y);
				_g._value = (1 - y / (_g._height - _g.slider._height)) * (_g.max - _g.min) + _g.min;
				_g.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
			}
		};
		this.addEventListener(flash.events.Event.ENTER_FRAME,fn);
		var fnRelease = null;
		fnRelease = function(e) {
			_g.removeEventListener(flash.events.Event.ENTER_FRAME,fn);
			flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_UP,fnRelease);
		};
		flash.Lib.get_current().get_stage().addEventListener(flash.events.MouseEvent.MOUSE_UP,fnRelease);
	}
	,_slide: function(e) {
		if(this.vertical) this._slideVertically(); else this._slideHorizontally();
	}
	,_set: function(e) {
		if(e.target != this.slider) {
			if(this.vertical) {
				var y = this.get_mouseY() - this.slider._height / 2 < 0?0:this.get_mouseY() + this.slider._height / 2 > this._height?this._height - this.slider._height:this.get_mouseY() - this.slider._height / 2;
				this.slider.tween(0.25,{ top : y},"Quad.easeOut");
				this._value = (1 - y / (this._height - this.slider._height)) * (this.max - this.min) + this.min;
			} else {
				var x = this.get_mouseX() - this.slider._width / 2 < 0?0:this.get_mouseX() + this.slider._width / 2 > this._width?this._width - this.slider._width:this.get_mouseX() - this.slider._width / 2;
				this.slider.tween(0.25,{ left : x},"Quad.easeOut");
				this._value = x / (this._width - this.slider._width) * (this.max - this.min) + this.min;
			}
			this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
		}
	}
	,refresh: function() {
		ru.stablex.ui.widgets.Widget.prototype.refresh.call(this);
		this.slider.refresh();
		this._updateSliderPos();
	}
	,_updateSliderPos: function() {
		var pt = (this._value - this.min) / (this.max - this.min);
		if(pt < 0) pt = 0; else if(pt > 1) pt = 1;
		if(this.vertical) this.slider.set_top((this._height - this.slider._height) * (1 - pt)); else this.slider.set_left((this._width - this.slider._width) * pt);
	}
	,set_value: function(v) {
		this._value = v;
		this._updateSliderPos();
		if(this.created) this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
		return v;
	}
	,get_value: function() {
		return this._value < this.min?this.min:this._value > this.max?this.max:this._value;
	}
	,vertical: null
	,slider: null
	,_value: null
	,max: null
	,min: null
	,__class__: ru.stablex.ui.widgets.Slider
	,__properties__: $extend(ru.stablex.ui.widgets.Widget.prototype.__properties__,{set_value:"set_value",get_value:"get_value"})
});
ru.stablex.ui.widgets.StateButton = function() {
	this._currentIdx = 0;
	ru.stablex.ui.widgets.Button.call(this);
	this.states = new ru.stablex.DynamicList(ru.stablex.ui.misc.BtnState);
	this.addEventListener(flash.events.MouseEvent.CLICK,$bind(this,this.nextState));
};
$hxClasses["ru.stablex.ui.widgets.StateButton"] = ru.stablex.ui.widgets.StateButton;
ru.stablex.ui.widgets.StateButton.__name__ = ["ru","stablex","ui","widgets","StateButton"];
ru.stablex.ui.widgets.StateButton.__super__ = ru.stablex.ui.widgets.Button;
ru.stablex.ui.widgets.StateButton.prototype = $extend(ru.stablex.ui.widgets.Button.prototype,{
	onInitialize: function() {
		this.updateState();
		ru.stablex.ui.widgets.Button.prototype.onInitialize.call(this);
	}
	,updateState: function() {
		if(this.order != null && this.order.length > 0) {
			var state = this.states.resolve(this.get_state());
			this.label.set_text(state.text == null?this.get_text() == null?this.get_state():this.get_text():state.text);
			if(state.skin != null) this.skin = state.skin;
			if(state._ico != null) this.set_ico(state._ico);
			if(this.created) this.refresh();
		}
	}
	,set: function(state) {
		if(this.order == null || this.order.length == 0) return;
		var _g1 = 0, _g = this.order.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.order[i] == state) {
				this.set__currentIdx(i);
				break;
			}
		}
		if(this.created) this.updateState();
	}
	,nextState: function(e) {
		if(this.order == null || this.order.length == 0) return;
		if(this.order.length <= this._currentIdx + 1) this.set__currentIdx(0); else {
			var _g = this, _g1 = _g._currentIdx;
			_g.set__currentIdx(_g1 + 1);
			_g1;
		}
		this.updateState();
	}
	,set_state: function(s) {
		this.set(s);
		return s;
	}
	,get_state: function() {
		if(this.order == null || this.order.length == 0) return null;
		return this.order[this._currentIdx];
	}
	,set__currentIdx: function(idx) {
		if(idx != this._currentIdx) {
			this._currentIdx = idx;
			if(this.created) this.dispatchEvent(new ru.stablex.ui.events.WidgetEvent("widgetChange"));
		}
		return idx;
	}
	,_currentIdx: null
	,order: null
	,states: null
	,__class__: ru.stablex.ui.widgets.StateButton
	,__properties__: $extend(ru.stablex.ui.widgets.Button.prototype.__properties__,{set_state:"set_state",get_state:"get_state",set__currentIdx:"set__currentIdx"})
});
ru.stablex.ui.widgets.Tip = function() {
	ru.stablex.ui.widgets.Floating.call(this);
	this.label = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Text);
	this.addChild(this.label);
	this.mouseEnabled = false;
	this.mouseChildren = false;
};
$hxClasses["ru.stablex.ui.widgets.Tip"] = ru.stablex.ui.widgets.Tip;
ru.stablex.ui.widgets.Tip.__name__ = ["ru","stablex","ui","widgets","Tip"];
ru.stablex.ui.widgets.Tip.__super__ = ru.stablex.ui.widgets.Floating;
ru.stablex.ui.widgets.Tip.prototype = $extend(ru.stablex.ui.widgets.Floating.prototype,{
	refresh: function() {
		this.label.refresh();
		ru.stablex.ui.widgets.Floating.prototype.refresh.call(this);
	}
	,free: function(recursive) {
		if(recursive == null) recursive = true;
		this._removeTargetListeners();
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_MOVE,$bind(this,this.moveTooltip));
		ru.stablex.ui.widgets.Floating.prototype.free.call(this,recursive);
	}
	,_removeTargetListeners: function() {
		if(this.target != null) {
			this.target.removeEventListener(flash.events.MouseEvent.MOUSE_OUT,$bind(this,this.hideTooltip));
			this.target.removeEventListener(flash.events.MouseEvent.MOUSE_OVER,$bind(this,this.showTooltip));
			this.target.removeEventListener("widgetFree",$bind(this,this.freeTooltip));
		}
	}
	,freeTooltip: function(e) {
		this.free(true);
	}
	,_adjustPosition: function() {
		this.set_left(flash.Lib.get_current().get_mouseX() + 10 + this.get_w() <= flash.Lib.get_current().get_stage().get_stageWidth()?flash.Lib.get_current().get_mouseX() + 10:flash.Lib.get_current().get_stage().get_stageWidth() - this.get_w());
		this.set_top(flash.Lib.get_current().get_mouseY() + 10 + this.get_h() <= flash.Lib.get_current().get_stage().get_stageHeight()?flash.Lib.get_current().get_mouseY() + 10:flash.Lib.get_current().get_mouseY() - 10 - this.get_h());
	}
	,hideTooltip: function(e) {
		this.target.removeEventListener(flash.events.MouseEvent.MOUSE_OUT,$bind(this,this.hideTooltip));
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_MOVE,$bind(this,this.moveTooltip));
		this.hide();
	}
	,moveTooltip: function(e) {
		this.set_left(flash.Lib.get_current().get_mouseX() + 10 + this.get_w() <= flash.Lib.get_current().get_stage().get_stageWidth()?flash.Lib.get_current().get_mouseX() + 10:flash.Lib.get_current().get_stage().get_stageWidth() - this.get_w());
		this.set_top(flash.Lib.get_current().get_mouseY() + 10 + this.get_h() <= flash.Lib.get_current().get_stage().get_stageHeight()?flash.Lib.get_current().get_mouseY() + 10:flash.Lib.get_current().get_mouseY() - 10 - this.get_h());
	}
	,showTooltip: function(e) {
		this.target.addUniqueListener(flash.events.MouseEvent.MOUSE_OUT,$bind(this,this.hideTooltip));
		flash.Lib.get_current().get_stage().removeEventListener(flash.events.MouseEvent.MOUSE_MOVE,$bind(this,this.moveTooltip));
		flash.Lib.get_current().get_stage().addEventListener(flash.events.MouseEvent.MOUSE_MOVE,$bind(this,this.moveTooltip));
		this.renderTo = null;
		this.refresh();
		this.set_left(flash.Lib.get_current().get_mouseX() + 10 + this.get_w() <= flash.Lib.get_current().get_stage().get_stageWidth()?flash.Lib.get_current().get_mouseX() + 10:flash.Lib.get_current().get_stage().get_stageWidth() - this.get_w());
		this.set_top(flash.Lib.get_current().get_mouseY() + 10 + this.get_h() <= flash.Lib.get_current().get_stage().get_stageHeight()?flash.Lib.get_current().get_mouseY() + 10:flash.Lib.get_current().get_mouseY() - 10 - this.get_h());
		this.show();
	}
	,bindTo: function(w) {
		this._removeTargetListeners();
		this.target = w;
		this.target.addUniqueListener(flash.events.MouseEvent.MOUSE_OVER,$bind(this,this.showTooltip));
		this.target.addUniqueListener("widgetFree",$bind(this,this.freeTooltip));
	}
	,set_text: function(s) {
		return this.label.set_text(s);
	}
	,get_text: function() {
		return this.label.get_text();
	}
	,label: null
	,target: null
	,__class__: ru.stablex.ui.widgets.Tip
	,__properties__: $extend(ru.stablex.ui.widgets.Floating.prototype.__properties__,{set_text:"set_text",get_text:"get_text"})
});
ru.stablex.ui.widgets.Toggle = function() {
	this.selected = false;
	this.highlightOnSelect = false;
	ru.stablex.ui.widgets.StateButton.call(this);
	this.order = ["up","down"];
};
$hxClasses["ru.stablex.ui.widgets.Toggle"] = ru.stablex.ui.widgets.Toggle;
ru.stablex.ui.widgets.Toggle.__name__ = ["ru","stablex","ui","widgets","Toggle"];
ru.stablex.ui.widgets.Toggle.__super__ = ru.stablex.ui.widgets.StateButton;
ru.stablex.ui.widgets.Toggle.prototype = $extend(ru.stablex.ui.widgets.StateButton.prototype,{
	refresh: function() {
		if(this.highlightOnSelect && this.get_state() == "down") this.highlight(); else if(this.highlightOnSelect) this.unhighlight();
		ru.stablex.ui.widgets.StateButton.prototype.refresh.call(this);
	}
	,toggle: function() {
		this.nextState();
	}
	,down: function() {
		this.set("down");
	}
	,up: function() {
		this.set("up");
	}
	,set_selected: function(s) {
		if(s) this.down(); else this.up();
		return s;
	}
	,get_selected: function() {
		return this.get_state() == "down";
	}
	,selected: null
	,highlightOnSelect: null
	,__class__: ru.stablex.ui.widgets.Toggle
	,__properties__: $extend(ru.stablex.ui.widgets.StateButton.prototype.__properties__,{set_selected:"set_selected",get_selected:"get_selected"})
});
scorx.setup = {}
scorx.setup.InitApp = function() {
	this.InitConfig();
	this.initConsole();
	this.initUI();
};
$hxClasses["scorx.setup.InitApp"] = scorx.setup.InitApp;
scorx.setup.InitApp.__name__ = ["scorx","setup","InitApp"];
scorx.setup.InitApp.prototype = {
	InitConfig: function() {
		cx.ConfigTools.loadFlashVars(Config);
		Config.buildDate = new Date(2013,6,29,8,57,49);
		console.log([Config.productId,Config.userId]);
	}
	,initUI: function() {
		(function() {
			flash.Lib.get_current().get_stage().removeEventListener(flash.events.Event.ENTER_FRAME,ru.stablex.ui.UIBuilder.skinQueue);
			flash.Lib.get_current().get_stage().addEventListener(flash.events.Event.ENTER_FRAME,ru.stablex.ui.UIBuilder.skinQueue);
			if(!ru.stablex.ui.UIBuilder.defaults.exists("Text")) ru.stablex.ui.UIBuilder.defaults.set("Text",new haxe.ds.StringMap());
			ru.stablex.ui.UIBuilder.defaults.get("Text").set("Default",function(__ui__widget0) {
				var __ui__widget1 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.Text);
				__ui__widget1.format.color = 0;
				__ui__widget1.format.font = "Arial";
				__ui__widget1.format.size = 14;
				__ui__widget1.label.selectable = false;
			});
			if(!ru.stablex.ui.UIBuilder.defaults.exists("InputText")) ru.stablex.ui.UIBuilder.defaults.set("InputText",new haxe.ds.StringMap());
			ru.stablex.ui.UIBuilder.defaults.get("InputText").set("Default",function(__ui__widget0) {
				var __ui__widget1 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.InputText);
				__ui__widget1.format.color = 0;
				__ui__widget1.format.font = "Arial";
				__ui__widget1.format.size = 14;
				__ui__widget1.label.selectable = true;
			});
			if(!ru.stablex.ui.UIBuilder.defaults.exists("Button")) ru.stablex.ui.UIBuilder.defaults.set("Button",new haxe.ds.StringMap());
			ru.stablex.ui.UIBuilder.defaults.get("Button").set("Default",function(__ui__widget0) {
				var __ui__widget1 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.Button);
				__ui__widget1.set_skinHoveredName("buttonHovered");
				__ui__widget1.format.color = 0;
				__ui__widget1.set_skinPressedName("buttonPressed");
				__ui__widget1.format.font = "Arial";
				__ui__widget1.format.size = 14;
				__ui__widget1.label.embedFonts = false;
				__ui__widget1.set_h(32);
				__ui__widget1.set_w(100);
				__ui__widget1.set_skinName("button");
			});
			ru.stablex.ui.UIBuilder.defaults.get("Button").set("Test",function(__ui__widget0) {
				var __ui__widget1 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.Button);
				__ui__widget1.set_skinHoveredName("buttonTestHovered");
				__ui__widget1.set_skinPressedName("buttonTestPressed");
				__ui__widget1.set_skinName("buttonTest");
			});
			if(!ru.stablex.ui.UIBuilder.defaults.exists("Options")) ru.stablex.ui.UIBuilder.defaults.set("Options",new haxe.ds.StringMap());
			ru.stablex.ui.UIBuilder.defaults.get("Options").set("Default",function(__ui__widget0) {
				var __ui__widget1 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.Options);
				__ui__widget1.set_padding(12);
				__ui__widget1.format.color = 16777215;
				__ui__widget1.format.font = "Arial";
				__ui__widget1.format.size = 14;
				__ui__widget1.box.set_padding(5);
				__ui__widget1.box.childPadding = 5;
				__ui__widget1.set_h(32);
				__ui__widget1.set_w(300);
				__ui__widget1.align = "left";
				__ui__widget1.box.set_w(300);
				if(!js.Boot.__instanceof(__ui__widget1.skin,ru.stablex.ui.skins.Paint)) {
					__ui__widget1.skin = new ru.stablex.ui.skins.Paint();
					if(js.Boot.__instanceof(__ui__widget1.skin,ru.stablex.ui.widgets.Widget)) {
						var __tmp__ = js.Boot.__cast(__ui__widget1.skin , ru.stablex.ui.widgets.Widget);
						ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
						__tmp__._onInitialize();
						__tmp__._onCreate();
					}
				}
				(js.Boot.__cast(__ui__widget1.skin , ru.stablex.ui.skins.Paint)).color = 497887;
				if(!js.Boot.__instanceof(__ui__widget1.box.skin,ru.stablex.ui.skins.Paint)) {
					__ui__widget1.box.skin = new ru.stablex.ui.skins.Paint();
					if(js.Boot.__instanceof(__ui__widget1.box.skin,ru.stablex.ui.widgets.Widget)) {
						var __tmp__ = js.Boot.__cast(__ui__widget1.box.skin , ru.stablex.ui.widgets.Widget);
						ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
						__tmp__._onInitialize();
						__tmp__._onCreate();
					}
				}
				(js.Boot.__cast(__ui__widget1.box.skin , ru.stablex.ui.skins.Paint)).color = 16777215;
				(js.Boot.__cast(__ui__widget1.skin , ru.stablex.ui.skins.Paint)).corners = [8];
				(js.Boot.__cast(__ui__widget1.box.skin , ru.stablex.ui.skins.Paint)).corners = [8];
				(js.Boot.__cast(__ui__widget1.box.skin , ru.stablex.ui.skins.Paint)).alpha = 0.9;
			});
			if(!ru.stablex.ui.UIBuilder.defaults.exists("Scroll")) ru.stablex.ui.UIBuilder.defaults.set("Scroll",new haxe.ds.StringMap());
			ru.stablex.ui.UIBuilder.defaults.get("Scroll").set("Default",function(__ui__widget0) {
				var __ui__widget11 = js.Boot.__cast(__ui__widget0 , ru.stablex.ui.widgets.Scroll);
				__ui__widget11.vBar.set_w(3);
				__ui__widget11.vBar.set_visible(false);
				__ui__widget11.vBar.set_right(2);
				__ui__widget11.addEventListener("widgetScrollStop",function(event) {
					__ui__widget11.vBar.set_visible(false);
				});
				__ui__widget11.addEventListener("widgetScrollStart",function(event) {
					__ui__widget11.vBar.set_visible(true);
				});
				if(!js.Boot.__instanceof(__ui__widget11.skin,ru.stablex.ui.skins.Paint)) {
					__ui__widget11.skin = new ru.stablex.ui.skins.Paint();
					if(js.Boot.__instanceof(__ui__widget11.skin,ru.stablex.ui.widgets.Widget)) {
						var __tmp__ = js.Boot.__cast(__ui__widget11.skin , ru.stablex.ui.widgets.Widget);
						ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
						__tmp__._onInitialize();
						__tmp__._onCreate();
					}
				}
				(js.Boot.__cast(__ui__widget11.skin , ru.stablex.ui.skins.Paint)).color = 15724527;
				if(!js.Boot.__instanceof(__ui__widget11.vBar.slider.skin,ru.stablex.ui.skins.Paint)) {
					__ui__widget11.vBar.slider.skin = new ru.stablex.ui.skins.Paint();
					if(js.Boot.__instanceof(__ui__widget11.vBar.slider.skin,ru.stablex.ui.widgets.Widget)) {
						var __tmp__ = js.Boot.__cast(__ui__widget11.vBar.slider.skin , ru.stablex.ui.widgets.Widget);
						ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
						__tmp__._onInitialize();
						__tmp__._onCreate();
					}
				}
				(js.Boot.__cast(__ui__widget11.vBar.slider.skin , ru.stablex.ui.skins.Paint)).color = 11184810;
				if(!js.Boot.__instanceof(__ui__widget11.vBar.skin,ru.stablex.ui.skins.Paint)) {
					__ui__widget11.vBar.skin = new ru.stablex.ui.skins.Paint();
					if(js.Boot.__instanceof(__ui__widget11.vBar.skin,ru.stablex.ui.widgets.Widget)) {
						var __tmp__ = js.Boot.__cast(__ui__widget11.vBar.skin , ru.stablex.ui.widgets.Widget);
						ru.stablex.ui.UIBuilder.applyDefaults(__tmp__);
						__tmp__._onInitialize();
						__tmp__._onCreate();
					}
				}
				(js.Boot.__cast(__ui__widget11.vBar.skin , ru.stablex.ui.skins.Paint)).alpha = 0.5;
				(js.Boot.__cast(__ui__widget11.vBar.skin , ru.stablex.ui.skins.Paint)).color = 16777215;
			});
		})();
		(function() {
			ru.stablex.ui.UIBuilder.skins.set("button",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16763174;
				skin.corners = [8];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonHovered",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16767073;
				skin.corners = [8];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonPressed",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16761352;
				skin.corners = [8];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonTest",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16711680;
				skin.corners = [20,40];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonTestHovered",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16729156;
				skin.corners = [8];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonTestPressed",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16711680;
				skin.corners = [8];
				return skin;
			});
			ru.stablex.ui.UIBuilder.skins.set("buttonPlay",function() {
				var skin = new ru.stablex.ui.skins.Paint();
				skin.color = 16711680;
				skin.corners = [8];
				return skin;
			});
		})();
	}
	,initConsole: function() {
		pgr.gconsole.GameConsole.init(0.33,"DOWN");
		pgr.gconsole.GameConsole.log("Log this message");
		pgr.gconsole.GameConsole.registerVariable(Config,"productId","productId",true);
	}
	,__class__: scorx.setup.InitApp
}
scorx.setup.UITest = function() {
	cx.layout.UIManager.call(this);
	var sxScroll = new scorx.ui.SxScroll();
	var scroll = sxScroll.getScroll();
	this.addChild(scroll);
	var item = new cx.layout.WidgetItem(scroll,cx.layout.Horizontal.STRETCH_MARGIN(0,0),cx.layout.Vertical.STRETCH_MARGIN(0,0));
	item.afterResize = $bind(sxScroll,sxScroll.afterResize);
	this.manager.add(item);
	var btnFullscreen = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Button);
	btnFullscreen.set_text("F");
	btnFullscreen.set_h(40);
	btnFullscreen.set_w(40);
	this.addChild(btnFullscreen);
	this.manager.add(new cx.layout.WidgetItem(btnFullscreen,cx.layout.Horizontal.RIGHT_MARGIN(0),cx.layout.Vertical.TOP_MARGIN(10)));
	btnFullscreen.onPress = function(e) {
		flash.Lib.get_current().get_stage().set_displayState(flash.Lib.get_current().get_stage().displayState == flash.display.StageDisplayState.NORMAL?flash.display.StageDisplayState.FULL_SCREEN:flash.display.StageDisplayState.NORMAL);
	};
	var btnZoom40 = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Button);
	btnZoom40.set_text("40");
	btnZoom40.set_h(40);
	btnZoom40.set_w(40);
	this.addChild(btnZoom40);
	this.manager.add(new cx.layout.WidgetItem(btnZoom40,cx.layout.Horizontal.RIGHT_MARGIN(0),cx.layout.Vertical.TOP_MARGIN(60)));
	btnZoom40.onPress = function(e) {
		sxScroll.setZoom(scorx.ui.SxScrollZoom.Zoom40);
	};
	var btnZoomFullHeight = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Button);
	btnZoomFullHeight.set_text("Height");
	btnZoomFullHeight.set_h(40);
	btnZoomFullHeight.set_w(40);
	this.addChild(btnZoomFullHeight);
	this.manager.add(new cx.layout.WidgetItem(btnZoomFullHeight,cx.layout.Horizontal.RIGHT_MARGIN(0),cx.layout.Vertical.TOP_MARGIN(110)));
	btnZoomFullHeight.onPress = function(e) {
		sxScroll.setZoom(scorx.ui.SxScrollZoom.ZoomFullHeight);
	};
	this.manager.resize();
	var loader = new sx.data.ScoreLoader(Config.productId,Config.userId);
	sxScroll.initPages(5);
	loader.onPageLoaded = function(pageNr,nrOfPages,data,type) {
		switch(pageNr) {
		case 0:
			sxScroll.initPages(nrOfPages);
			break;
		default:
			sxScroll.addPage(pageNr,nrOfPages,data);
		}
	};
};
$hxClasses["scorx.setup.UITest"] = scorx.setup.UITest;
scorx.setup.UITest.__name__ = ["scorx","setup","UITest"];
scorx.setup.UITest.__super__ = cx.layout.UIManager;
scorx.setup.UITest.prototype = $extend(cx.layout.UIManager.prototype,{
	__class__: scorx.setup.UITest
});
scorx.ui = {}
scorx.ui.SxScrollZoom = $hxClasses["scorx.ui.SxScrollZoom"] = { __ename__ : true, __constructs__ : ["ZoomFullWidth","ZoomFullHeight","Zoom40","Zoom60","Zoom80","Zoom100"] }
scorx.ui.SxScrollZoom.ZoomFullWidth = ["ZoomFullWidth",0];
scorx.ui.SxScrollZoom.ZoomFullWidth.toString = $estr;
scorx.ui.SxScrollZoom.ZoomFullWidth.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScrollZoom.ZoomFullHeight = ["ZoomFullHeight",1];
scorx.ui.SxScrollZoom.ZoomFullHeight.toString = $estr;
scorx.ui.SxScrollZoom.ZoomFullHeight.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScrollZoom.Zoom40 = ["Zoom40",2];
scorx.ui.SxScrollZoom.Zoom40.toString = $estr;
scorx.ui.SxScrollZoom.Zoom40.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScrollZoom.Zoom60 = ["Zoom60",3];
scorx.ui.SxScrollZoom.Zoom60.toString = $estr;
scorx.ui.SxScrollZoom.Zoom60.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScrollZoom.Zoom80 = ["Zoom80",4];
scorx.ui.SxScrollZoom.Zoom80.toString = $estr;
scorx.ui.SxScrollZoom.Zoom80.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScrollZoom.Zoom100 = ["Zoom100",5];
scorx.ui.SxScrollZoom.Zoom100.toString = $estr;
scorx.ui.SxScrollZoom.Zoom100.__enum__ = scorx.ui.SxScrollZoom;
scorx.ui.SxScroll = function() {
	this.zoom = scorx.ui.SxScrollZoom.ZoomFullHeight;
};
$hxClasses["scorx.ui.SxScroll"] = scorx.ui.SxScroll;
scorx.ui.SxScroll.__name__ = ["scorx","ui","SxScroll"];
scorx.ui.SxScroll.prototype = {
	getZoomSize: function(zoom,width,height) {
		var w = 1;
		var h = 1;
		var _g = this;
		switch( (_g.zoom)[1] ) {
		case 1:
			h = Math.max(297,Math.min(891,height - 20));
			w = 210 / 297 * h;
			break;
		case 0:
			w = Math.max(210,Math.min(630,width - 20));
			h = 297 / 210 * w;
			break;
		case 2:
			w = 252.;
			h = 891 * 0.4;
			break;
		case 3:
			w = 378.;
			h = 534.6;
			break;
		case 4:
			w = 504.;
			h = 891 * 0.8;
			break;
		case 5:
			w = 630;
			h = 891;
			break;
		}
		return new flash.geom.Point(w,h);
	}
	,addPage: function(pageNr,nrOfPages,data) {
		var size = this.getZoomSize(this.zoom,this.scroll.get_w(),this.scroll.get_h());
		var bmp = js.Boot.__cast(this.widget.getChildAt(pageNr - 1) , ru.stablex.ui.widgets.Bmp);
		if(data != null) bmp._src = null;
		bmp._bitmapData = data;
		bmp.set_w(size.x);
		bmp.set_h(size.y);
		var child = this.widget.getChildAt(pageNr - 1);
		child.set_width(size.x);
		child.set_height(size.y);
		bmp.removeChildAt(0);
		bmp.removeChildAt(0);
	}
	,clearPages: function() {
		while(this.widget.nmeChildren.length > 0) this.widget.removeChildAt(0);
	}
	,initPages: function(nrOfPages) {
		this.clearPages();
		var _g = 0;
		while(_g < nrOfPages) {
			var i = _g++;
			this.widget.addChild(this.getTest());
		}
		this.resize(0,0,this.scroll.get_w(),this.scroll.get_h());
		this.widget.refresh();
	}
	,setZoom: function(zoom) {
		this.zoom = zoom;
		this.resize();
	}
	,getTest: function() {
		var bmp = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Bmp);
		var size = this.getZoomSize(this.zoom,this.scroll.get_w(),this.scroll.get_h());
		var s = new flash.display.Sprite();
		bmp.addChild(s);
		s.get_graphics().beginFill(14540253);
		s.get_graphics().drawRect(0,0,size.x,size.y);
		var child = bmp;
		bmp.set_w(s.set_width(child.set_width(size.x)));
		bmp.set_h(s.set_height(child.set_height(size.y)));
		var progress = new cx.flash.ui.UIProgress(10,10,50,50,15658734,13421772,0,6);
		progress.spin();
		bmp.addChild(progress);
		return bmp;
	}
	,resize: function(x,y,width,height) {
		if(height == null) height = 0;
		if(width == null) width = 0;
		if(y == null) y = 0;
		if(x == null) x = 0;
		if(width == 0) width = this.scroll.get_w();
		if(height == 0) height = this.scroll.get_h();
		var size = this.getZoomSize(this.zoom,width,height);
		this.pageSize = cx.flash.layout.DocumentLayout.arrange(this.widget,width,size.x,size.y);
		this.scroll.refresh();
	}
	,afterResize: function(x,y,width,height) {
		var _g = this;
		cx.TimerTools.timeout(function() {
			_g.resize(x,y,width,height);
		},200);
	}
	,getScroll: function() {
		this.widget = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Widget);
		this.widget.set_w(100);
		this.widget.set_h(100);
		this.scroll = ru.stablex.ui.UIBuilder.create(ru.stablex.ui.widgets.Scroll,{ children : [this.widget]});
		this.scroll.refresh();
		return this.scroll;
	}
	,zoom: null
	,pageSize: null
	,scroll: null
	,widget: null
	,__class__: scorx.ui.SxScroll
}
var sx = {}
sx.data = {}
sx.data.ImageLoaderExt = function(url,idx) {
	this.idx = idx;
	mloader.ImageLoader.call(this,url);
};
$hxClasses["sx.data.ImageLoaderExt"] = sx.data.ImageLoaderExt;
sx.data.ImageLoaderExt.__name__ = ["sx","data","ImageLoaderExt"];
sx.data.ImageLoaderExt.__super__ = mloader.ImageLoader;
sx.data.ImageLoaderExt.prototype = $extend(mloader.ImageLoader.prototype,{
	idx: null
	,__class__: sx.data.ImageLoaderExt
});
sx.data.ScoreLoadingType = $hxClasses["sx.data.ScoreLoadingType"] = { __ename__ : true, __constructs__ : ["screen","print","thumb"] }
sx.data.ScoreLoadingType.screen = ["screen",0];
sx.data.ScoreLoadingType.screen.toString = $estr;
sx.data.ScoreLoadingType.screen.__enum__ = sx.data.ScoreLoadingType;
sx.data.ScoreLoadingType.print = ["print",1];
sx.data.ScoreLoadingType.print.toString = $estr;
sx.data.ScoreLoadingType.print.__enum__ = sx.data.ScoreLoadingType;
sx.data.ScoreLoadingType.thumb = ["thumb",2];
sx.data.ScoreLoadingType.thumb.toString = $estr;
sx.data.ScoreLoadingType.thumb.__enum__ = sx.data.ScoreLoadingType;
sx.data.ScoreLoader = function(productId,userId) {
	if(userId == null) userId = 0;
	this.productId = productId;
	this.userId = userId;
};
$hxClasses["sx.data.ScoreLoader"] = sx.data.ScoreLoader;
sx.data.ScoreLoader.__name__ = ["sx","data","ScoreLoader"];
sx.data.ScoreLoader.prototype = {
	onPageLoaded: function(pageNr,nrOfPages,data,type) {
		console.log("onPageLoaded " + pageNr + " / " + nrOfPages + " ");
	}
	,queueOtherPagesComplete: function(event) {
	}
	,queueFirstPageComplete: function(event) {
	}
	,loadOtherPages: function(nrOfPages) {
		if(nrOfPages < 2) throw "This shouldn't happen!";
		var queue = new mloader.LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.loaded.addOnce($bind(this,this.queueOtherPagesComplete)).forType(mloader.LoaderEventType.Complete);
		var _g = 1;
		while(_g < nrOfPages) {
			var pageNr = _g++;
			queue.add(this.getPageLoader(pageNr));
		}
		queue.load();
	}
	,onImageLoaded: function(event) {
		var content = event.target.content;
		var loader = js.Boot.__cast(event.target , sx.data.ImageLoaderExt);
		var bitmapData = loader.content;
		var pageNr = loader.idx;
		this.onPageLoaded(pageNr + 1,this.nrOfPages,bitmapData,this.typeString);
	}
	,onCountComplete: function(event) {
		var nrOfPages = Std.parseInt(event.target.content);
		this.nrOfPages = nrOfPages;
		this.onPageLoaded(0,this.nrOfPages,null,this.typeString);
		if(nrOfPages > 1) this.loadOtherPages(nrOfPages);
	}
	,getCountLoader: function() {
		var url = sx.data.ScoreLoader.HOST + ("media/" + this.typeString + "/count/" + this.productId + "?ext=.txt");
		var countLoader = new mloader.StringLoader(url);
		countLoader.loaded.addOnce($bind(this,this.onCountComplete)).forType(mloader.LoaderEventType.Complete);
		return countLoader;
	}
	,getPageLoader: function(pageNr) {
		var url = sx.data.ScoreLoader.HOST + ("media/" + this.typeString + "/" + this.productId + "/" + pageNr + "/" + this.userId + "?ext=.png");
		var imageLoader = new sx.data.ImageLoaderExt(url,pageNr);
		imageLoader.loaded.addOnce($bind(this,this.onImageLoaded)).forType(mloader.LoaderEventType.Complete);
		return imageLoader;
	}
	,loadFirstPageAndCount: function() {
		var queue = new mloader.LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.loaded.addOnce($bind(this,this.queueFirstPageComplete)).forType(mloader.LoaderEventType.Complete);
		queue.add(this.getCountLoader());
		queue.add(this.getPageLoader(0));
		queue.load();
	}
	,loadPages: function(type) {
		if(type == null) type = sx.data.ScoreLoadingType.screen;
		this.typeString = Std.string(type);
		this.loadFirstPageAndCount();
	}
	,typeString: null
	,nrOfPages: null
	,userId: null
	,productId: null
	,__class__: sx.data.ScoreLoader
}
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; };
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; };
if(Array.prototype.indexOf) HxOverrides.remove = function(a,o) {
	var i = a.indexOf(o);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
Math.__name__ = ["Math"];
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
$hxClasses.Math = Math;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i) {
	return isNaN(i);
};
String.prototype.__class__ = $hxClasses.String = String;
String.__name__ = ["String"];
Array.prototype.__class__ = $hxClasses.Array = Array;
Array.__name__ = ["Array"];
Date.prototype.__class__ = $hxClasses.Date = Date;
Date.__name__ = ["Date"];
var Int = $hxClasses.Int = { __name__ : ["Int"]};
var Dynamic = $hxClasses.Dynamic = { __name__ : ["Dynamic"]};
var Float = $hxClasses.Float = Number;
Float.__name__ = ["Float"];
var Bool = $hxClasses.Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = $hxClasses.Class = { __name__ : ["Class"]};
var Enum = { };
Xml.Element = "element";
Xml.PCData = "pcdata";
Xml.CData = "cdata";
Xml.Comment = "comment";
Xml.DocType = "doctype";
Xml.ProcessingInstruction = "processingInstruction";
Xml.Document = "document";
if(typeof(JSON) != "undefined") haxe.Json = JSON;
haxe.Resource.content = [];
msignal.SlotList.NIL = new msignal.SlotList(null,null);
Config.host = "http://scorxdev.azurewebsites.net/";
Config.pageMethod = "media/screen/";
Config.pageCountMethod = "media/screencount/";
Config.productId = 1;
Config.userId = 1;
flash.display.DisplayObject.GRAPHICS_INVALID = 2;
flash.display.DisplayObject.MATRIX_INVALID = 4;
flash.display.DisplayObject.MATRIX_CHAIN_INVALID = 8;
flash.display.DisplayObject.MATRIX_OVERRIDDEN = 16;
flash.display.DisplayObject.TRANSFORM_INVALID = 32;
flash.display.DisplayObject.BOUNDS_INVALID = 64;
flash.display.DisplayObject.RENDER_VALIDATE_IN_PROGRESS = 1024;
flash.display.DisplayObject.ALL_RENDER_FLAGS = 98;
cx.ConfigTools.missingFields = new Array();
cx.flash.graphic.GraphicTools.CIRCLE_SEGMENT_MAX = 6.3;
cx.flash.graphic.GraphicTools.CIRCLE_SEGMENT_ROTATE = 270;
cx.flash.ui.UIProgress.SEGMENT_MAX = 6.3;
flash.Lib.HTML_ACCELEROMETER_EVENT_TYPE = "devicemotion";
flash.Lib.HTML_ORIENTATION_EVENT_TYPE = "orientationchange";
flash.Lib.DEFAULT_HEIGHT = 500;
flash.Lib.DEFAULT_WIDTH = 500;
flash.Lib.HTML_DIV_EVENT_TYPES = ["resize","mouseover","mouseout","mousewheel","dblclick","click"];
flash.Lib.HTML_TOUCH_EVENT_TYPES = ["touchstart","touchmove","touchend"];
flash.Lib.HTML_TOUCH_ALT_EVENT_TYPES = ["mousedown","mousemove","mouseup"];
flash.Lib.HTML_WINDOW_EVENT_TYPES = ["keyup","keypress","keydown","resize","blur","focus"];
flash.Lib.NME_IDENTIFIER = "haxe:jeash";
flash.Lib.VENDOR_HTML_TAG = "data-";
flash.Lib.starttime = haxe.Timer.stamp();
flash.display._BitmapData.MinstdGenerator.a = 16807;
flash.display._BitmapData.MinstdGenerator.m = -2147483648 - 1;
flash.display.BitmapDataChannel.ALPHA = 8;
flash.display.BitmapDataChannel.BLUE = 4;
flash.display.BitmapDataChannel.GREEN = 2;
flash.display.BitmapDataChannel.RED = 1;
flash.display.Graphics.TILE_SCALE = 1;
flash.display.Graphics.TILE_ROTATION = 2;
flash.display.Graphics.TILE_RGB = 4;
flash.display.Graphics.TILE_ALPHA = 8;
flash.display.Graphics.TILE_TRANS_2x2 = 16;
flash.display.Graphics.TILE_BLEND_NORMAL = 0;
flash.display.Graphics.TILE_BLEND_ADD = 65536;
flash.display.Graphics.BMP_REPEAT = 16;
flash.display.Graphics.BMP_SMOOTH = 65536;
flash.display.Graphics.CORNER_ROUND = 0;
flash.display.Graphics.CORNER_MITER = 4096;
flash.display.Graphics.CORNER_BEVEL = 8192;
flash.display.Graphics.CURVE = 2;
flash.display.Graphics.END_NONE = 0;
flash.display.Graphics.END_ROUND = 256;
flash.display.Graphics.END_SQUARE = 512;
flash.display.Graphics.LINE = 1;
flash.display.Graphics.MOVE = 0;
flash.display.Graphics.NME_MAX_DIM = 5000;
flash.display.Graphics.PIXEL_HINTING = 16384;
flash.display.Graphics.RADIAL = 1;
flash.display.Graphics.SCALE_HORIZONTAL = 2;
flash.display.Graphics.SCALE_NONE = 0;
flash.display.Graphics.SCALE_NORMAL = 3;
flash.display.Graphics.SCALE_VERTICAL = 1;
flash.display.Graphics.SPREAD_REPEAT = 2;
flash.display.Graphics.SPREAD_REFLECT = 4;
flash.display.GraphicsPathCommand.LINE_TO = 2;
flash.display.GraphicsPathCommand.MOVE_TO = 1;
flash.display.GraphicsPathCommand.CURVE_TO = 3;
flash.display.GraphicsPathCommand.WIDE_LINE_TO = 5;
flash.display.GraphicsPathCommand.WIDE_MOVE_TO = 4;
flash.display.GraphicsPathCommand.NO_OP = 0;
flash.display.GraphicsPathCommand.CUBIC_CURVE_TO = 6;
flash.events.Event.ACTIVATE = "activate";
flash.events.Event.ADDED = "added";
flash.events.Event.ADDED_TO_STAGE = "addedToStage";
flash.events.Event.CANCEL = "cancel";
flash.events.Event.CHANGE = "change";
flash.events.Event.CLOSE = "close";
flash.events.Event.COMPLETE = "complete";
flash.events.Event.CONNECT = "connect";
flash.events.Event.CONTEXT3D_CREATE = "context3DCreate";
flash.events.Event.DEACTIVATE = "deactivate";
flash.events.Event.ENTER_FRAME = "enterFrame";
flash.events.Event.ID3 = "id3";
flash.events.Event.INIT = "init";
flash.events.Event.MOUSE_LEAVE = "mouseLeave";
flash.events.Event.OPEN = "open";
flash.events.Event.REMOVED = "removed";
flash.events.Event.REMOVED_FROM_STAGE = "removedFromStage";
flash.events.Event.RENDER = "render";
flash.events.Event.RESIZE = "resize";
flash.events.Event.SCROLL = "scroll";
flash.events.Event.SELECT = "select";
flash.events.Event.TAB_CHILDREN_CHANGE = "tabChildrenChange";
flash.events.Event.TAB_ENABLED_CHANGE = "tabEnabledChange";
flash.events.Event.TAB_INDEX_CHANGE = "tabIndexChange";
flash.events.Event.UNLOAD = "unload";
flash.events.Event.SOUND_COMPLETE = "soundComplete";
flash.events.MouseEvent.CLICK = "click";
flash.events.MouseEvent.DOUBLE_CLICK = "doubleClick";
flash.events.MouseEvent.MOUSE_DOWN = "mouseDown";
flash.events.MouseEvent.MOUSE_MOVE = "mouseMove";
flash.events.MouseEvent.MOUSE_OUT = "mouseOut";
flash.events.MouseEvent.MOUSE_OVER = "mouseOver";
flash.events.MouseEvent.MOUSE_UP = "mouseUp";
flash.events.MouseEvent.MOUSE_WHEEL = "mouseWheel";
flash.events.MouseEvent.RIGHT_CLICK = "rightClick";
flash.events.MouseEvent.RIGHT_MOUSE_DOWN = "rightMouseDown";
flash.events.MouseEvent.RIGHT_MOUSE_UP = "rightMouseUp";
flash.events.MouseEvent.ROLL_OUT = "rollOut";
flash.events.MouseEvent.ROLL_OVER = "rollOver";
flash.display.Stage.NAME = "Stage";
flash.display.Stage.nmeAcceleration = { x : 0.0, y : 1.0, z : 0.0};
flash.display.Stage.OrientationPortrait = 1;
flash.display.Stage.OrientationPortraitUpsideDown = 2;
flash.display.Stage.OrientationLandscapeRight = 3;
flash.display.Stage.OrientationLandscapeLeft = 4;
flash.display.Stage.DEFAULT_FRAMERATE = 0.0;
flash.display.Stage.UI_EVENTS_QUEUE_MAX = 1000;
flash.display.Stage.nmeMouseChanges = [flash.events.MouseEvent.MOUSE_OUT,flash.events.MouseEvent.MOUSE_OVER,flash.events.MouseEvent.ROLL_OUT,flash.events.MouseEvent.ROLL_OVER];
flash.display.Stage.nmeTouchChanges = ["touchOut","touchOver","touchRollOut","touchRollOver"];
flash.display.StageQuality.BEST = "best";
flash.display.StageQuality.HIGH = "high";
flash.display.StageQuality.MEDIUM = "medium";
flash.display.StageQuality.LOW = "low";
flash.errors.Error.DEFAULT_TO_STRING = "Error";
flash.events.TextEvent.LINK = "link";
flash.events.TextEvent.TEXT_INPUT = "textInput";
flash.events.ErrorEvent.ERROR = "error";
flash.events.Listener.sIDs = 1;
flash.events.EventPhase.CAPTURING_PHASE = 0;
flash.events.EventPhase.AT_TARGET = 1;
flash.events.EventPhase.BUBBLING_PHASE = 2;
flash.events.FocusEvent.FOCUS_IN = "focusIn";
flash.events.FocusEvent.FOCUS_OUT = "focusOut";
flash.events.FocusEvent.KEY_FOCUS_CHANGE = "keyFocusChange";
flash.events.FocusEvent.MOUSE_FOCUS_CHANGE = "mouseFocusChange";
flash.events.HTTPStatusEvent.HTTP_RESPONSE_STATUS = "httpResponseStatus";
flash.events.HTTPStatusEvent.HTTP_STATUS = "httpStatus";
flash.events.IOErrorEvent.IO_ERROR = "ioError";
flash.events.KeyboardEvent.KEY_DOWN = "keyDown";
flash.events.KeyboardEvent.KEY_UP = "keyUp";
flash.events.ProgressEvent.PROGRESS = "progress";
flash.events.ProgressEvent.SOCKET_DATA = "socketData";
flash.events.SecurityErrorEvent.SECURITY_ERROR = "securityError";
flash.events.TouchEvent.TOUCH_BEGIN = "touchBegin";
flash.events.TouchEvent.TOUCH_END = "touchEnd";
flash.events.TouchEvent.TOUCH_MOVE = "touchMove";
flash.events.TouchEvent.TOUCH_OUT = "touchOut";
flash.events.TouchEvent.TOUCH_OVER = "touchOver";
flash.events.TouchEvent.TOUCH_ROLL_OUT = "touchRollOut";
flash.events.TouchEvent.TOUCH_ROLL_OVER = "touchRollOver";
flash.events.TouchEvent.TOUCH_TAP = "touchTap";
flash.filters.DropShadowFilter.DEGREES_FULL_RADIUS = 360.0;
flash.geom.Transform.DEG_TO_RAD = Math.PI / 180.0;
flash.media.Sound.EXTENSION_MP3 = "mp3";
flash.media.Sound.EXTENSION_OGG = "ogg";
flash.media.Sound.EXTENSION_WAV = "wav";
flash.media.Sound.EXTENSION_AAC = "aac";
flash.media.Sound.MEDIA_TYPE_MP3 = "audio/mpeg";
flash.media.Sound.MEDIA_TYPE_OGG = "audio/ogg; codecs=\"vorbis\"";
flash.media.Sound.MEDIA_TYPE_WAV = "audio/wav; codecs=\"1\"";
flash.media.Sound.MEDIA_TYPE_AAC = "audio/mp4; codecs=\"mp4a.40.2\"";
flash.net.URLRequestMethod.DELETE = "DELETE";
flash.net.URLRequestMethod.GET = "GET";
flash.net.URLRequestMethod.HEAD = "HEAD";
flash.net.URLRequestMethod.OPTIONS = "OPTIONS";
flash.net.URLRequestMethod.POST = "POST";
flash.net.URLRequestMethod.PUT = "PUT";
flash.system.ApplicationDomain.currentDomain = new flash.system.ApplicationDomain(null);
flash.system.SecurityDomain.currentDomain = new flash.system.SecurityDomain();
flash.text.Font.DEFAULT_FONT_DATA = "q:55oy6:ascentd950.5y4:dataad84d277.5d564d277.5d564d320.5d293d1024d187.5d1024d442.5d362.5d84d362.5d84d277.5hy6:_widthd651.5y4:xMaxd564y4:xMind84y4:yMaxd746.5y4:yMind0y7:_heightd662.5y7:leadingd168y7:descentd241.5y8:charCodei55y15:leftsideBearingd84y12:advanceWidthd651.5y8:commandsai1i2i2i2i2i2i2i2hg:111oR0d950.5R1ad313.5d528.5d239.5d528.5d196.5d586.25d153.5d644d153.5d744.5d153.5d845d196.25d902.75d239d960.5d313.5d960.5d387d960.5d430d902.5d473d844.5d473d744.5d473d645d430d586.75d387d528.5d313.5d528.5d313.5d450.5d433.5d450.5d502d528.5d570.5d606.5d570.5d744.5d570.5d882d502d960.25d433.5d1038.5d313.5d1038.5d193d1038.5d124.75d960.25d56.5d882d56.5d744.5d56.5d606.5d124.75d528.5d193d450.5d313.5d450.5hR2d626.5R3d570.5R4d56.5R5d573.5R6d-14.5R7d517R8d168R9d241.5R10i111R11d56.5R12d626.5R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:54oR0d950.5R1ad338d610.5d270d610.5d230.25d657d190.5d703.5d190.5d784.5d190.5d865d230.25d911.75d270d958.5d338d958.5d406d958.5d445.75d911.75d485.5d865d485.5d784.5d485.5d703.5d445.75d657d406d610.5d338d610.5d538.5d294d538.5d386d500.5d368d461.75d358.5d423d349d385d349d285d349d232.25d416.5d179.5d484d172d620.5d201.5d577d246d553.75d290.5d530.5d344d530.5d456.5d530.5d521.75d598.75d587d667d587d784.5d587d899.5d519d969d451d1038.5d338d1038.5d208.5d1038.5d140d939.25d71.5d840d71.5d651.5d71.5d474.5d155.5d369.25d239.5d264d381d264d419d264d457.75d271.5d496.5d279d538.5d294hR2d651.5R3d587R4d71.5R5d760R6d-14.5R7d688.5R8d168R9d241.5R10i54R11d71.5R12d651.5R13ai1i3i3i3i3i3i3i3i3i1i2i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3hg:110oR0d950.5R1ad562d686d562d1024d470d1024d470d689d470d609.5d439d570d408d530.5d346d530.5d271.5d530.5d228.5d578d185.5d625.5d185.5d707.5d185.5d1024d93d1024d93d464d185.5d464d185.5d551d218.5d500.5d263.25d475.5d308d450.5d366.5d450.5d463d450.5d512.5d510.25d562d570d562d686hR2d649R3d562R4d93R5d573.5R6d0R7d480.5R8d168R9d241.5R10i110R11d93R12d649R13ai1i2i2i2i3i3i3i3i2i2i2i2i2i3i3i3i3hg:53oR0d950.5R1ad110.5d277.5d507d277.5d507d362.5d203d362.5d203d545.5d225d538d247d534.25d269d530.5d291d530.5d416d530.5d489d599d562d667.5d562d784.5d562d905d487d971.75d412d1038.5d275.5d1038.5d228.5d1038.5d179.75d1030.5d131d1022.5d79d1006.5d79d905d124d929.5d172d941.5d220d953.5d273.5d953.5d360d953.5d410.5d908d461d862.5d461d784.5d461d706.5d410.5d661d360d615.5d273.5d615.5d233d615.5d192.75d624.5d152.5d633.5d110.5d652.5d110.5d277.5hR2d651.5R3d562R4d79R5d746.5R6d-14.5R7d667.5R8d168R9d241.5R10i53R11d79R12d651.5R13ai1i2i2i2i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3i2hg:109oR0d950.5R1ad532.5d571.5d567d509.5d615d480d663d450.5d728d450.5d815.5d450.5d863d511.75d910.5d573d910.5d686d910.5d1024d818d1024d818d689d818d608.5d789.5d569.5d761d530.5d702.5d530.5d631d530.5d589.5d578d548d625.5d548d707.5d548d1024d455.5d1024d455.5d689d455.5d608d427d569.25d398.5d530.5d339d530.5d268.5d530.5d227d578.25d185.5d626d185.5d707.5d185.5d1024d93d1024d93d464d185.5d464d185.5d551d217d499.5d261d475d305d450.5d365.5d450.5d426.5d450.5d469.25d481.5d512d512.5d532.5d571.5hR2d997.5R3d910.5R4d93R5d573.5R6d0R7d480.5R8d168R9d241.5R10i109R11d93R12d997.5R13ai1i3i3i3i3i2i2i2i3i3i3i3i2i2i2i3i3i3i3i2i2i2i2i2i3i3i3i3hg:52oR0d950.5R1ad387d365.5d132d764d387d764d387d365.5d360.5d277.5d487.5d277.5d487.5d764d594d764d594d848d487.5d848d487.5d1024d387d1024d387d848d50d848d50d750.5d360.5d277.5hR2d651.5R3d594R4d50R5d746.5R6d0R7d696.5R8d168R9d241.5R10i52R11d50R12d651.5R13ai1i2i2i2i1i2i2i2i2i2i2i2i2i2i2i2hg:108oR0d950.5R1ad96.5d246d188.5d246d188.5d1024d96.5d1024d96.5d246hR2d284.5R3d188.5R4d96.5R5d778R6d0R7d681.5R8d168R9d241.5R10i108R11d96.5R12d284.5R13ai1i2i2i2i2hg:51oR0d950.5R1ad415.5d621.5d488d637d528.75d686d569.5d735d569.5d807d569.5d917.5d493.5d978d417.5d1038.5d277.5d1038.5d230.5d1038.5d180.75d1029.25d131d1020d78d1001.5d78d904d120d928.5d170d941d220d953.5d274.5d953.5d369.5d953.5d419.25d916d469d878.5d469d807d469d741d422.75d703.75d376.5d666.5d294d666.5d207d666.5d207d583.5d298d583.5d372.5d583.5d412d553.75d451.5d524d451.5d468d451.5d410.5d410.75d379.75d370d349d294d349d252.5d349d205d358d157.5d367d100.5d386d100.5d296d158d280d208.25d272d258.5d264d303d264d418d264d485d316.25d552d368.5d552d457.5d552d519.5d516.5d562.25d481d605d415.5d621.5hR2d651.5R3d569.5R4d78R5d760R6d-14.5R7d682R8d168R9d241.5R10i51R11d78R12d651.5R13ai1i3i3i3i3i3i3i2i3i3i3i3i3i3i2i2i2i3i3i3i3i3i3i2i3i3i3i3i3i3hg:107oR0d950.5R1ad93d246d185.5d246d185.5d705.5d460d464d577.5d464d280.5d726d590d1024d470d1024d185.5d750.5d185.5d1024d93d1024d93d246hR2d593R3d590R4d93R5d778R6d0R7d685R8d168R9d241.5R10i107R11d93R12d593R13ai1i2i2i2i2i2i2i2i2i2i2i2hg:50oR0d950.5R1ad196.5d939d549d939d549d1024d75d1024d75d939d132.5d879.5d231.75d779.25d331d679d356.5d650d405d595.5d424.25d557.75d443.5d520d443.5d483.5d443.5d424d401.75d386.5d360d349d293d349d245.5d349d192.75d365.5d140d382d80d415.5d80d313.5d141d289d194d276.5d247d264d291d264d407d264d476d322d545d380d545d477d545d523d527.75d564.25d510.5d605.5d465d661.5d452.5d676d385.5d745.25d318.5d814.5d196.5d939hR2d651.5R3d549R4d75R5d760R6d0R7d685R8d168R9d241.5R10i50R11d75R12d651.5R13ai1i2i2i2i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3hg:106oR0d950.5R1ad96.5d464d188.5d464d188.5d1034d188.5d1141d147.75d1189d107d1237d16.5d1237d-18.5d1237d-18.5d1159d6d1159d58.5d1159d77.5d1134.75d96.5d1110.5d96.5d1034d96.5d464d96.5d246d188.5d246d188.5d362.5d96.5d362.5d96.5d246hR2d284.5R3d188.5R4d-18.5R5d778R6d-213R7d796.5R8d168R9d241.5R10i106R11d-18.5R12d284.5R13ai1i2i2i3i3i2i2i2i3i3i2i1i2i2i2i2hg:49oR0d950.5R1ad127d939d292d939d292d369.5d112.5d405.5d112.5d313.5d291d277.5d392d277.5d392d939d557d939d557d1024d127d1024d127d939hR2d651.5R3d557R4d112.5R5d746.5R6d0R7d634R8d168R9d241.5R10i49R11d112.5R12d651.5R13ai1i2i2i2i2i2i2i2i2i2i2i2hg:105oR0d950.5R1ad96.5d464d188.5d464d188.5d1024d96.5d1024d96.5d464d96.5d246d188.5d246d188.5d362.5d96.5d362.5d96.5d246hR2d284.5R3d188.5R4d96.5R5d778R6d0R7d681.5R8d168R9d241.5R10i105R11d96.5R12d284.5R13ai1i2i2i2i2i1i2i2i2i2hg:48oR0d950.5R1ad325.5d344d247.5d344d208.25d420.75d169d497.5d169d651.5d169d805d208.25d881.75d247.5d958.5d325.5d958.5d404d958.5d443.25d881.75d482.5d805d482.5d651.5d482.5d497.5d443.25d420.75d404d344d325.5d344d325.5d264d451d264d517.25d363.25d583.5d462.5d583.5d651.5d583.5d840d517.25d939.25d451d1038.5d325.5d1038.5d200d1038.5d133.75d939.25d67.5d840d67.5d651.5d67.5d462.5d133.75d363.25d200d264d325.5d264hR2d651.5R3d583.5R4d67.5R5d760R6d-14.5R7d692.5R8d168R9d241.5R10i48R11d67.5R12d651.5R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:104oR0d950.5R1ad562d686d562d1024d470d1024d470d689d470d609.5d439d570d408d530.5d346d530.5d271.5d530.5d228.5d578d185.5d625.5d185.5d707.5d185.5d1024d93d1024d93d246d185.5d246d185.5d551d218.5d500.5d263.25d475.5d308d450.5d366.5d450.5d463d450.5d512.5d510.25d562d570d562d686hR2d649R3d562R4d93R5d778R6d0R7d685R8d168R9d241.5R10i104R11d93R12d649R13ai1i2i2i2i3i3i3i3i2i2i2i2i2i3i3i3i3hg:47oR0d950.5R1ad260d277.5d345d277.5d85d1119d0d1119d260d277.5hR2d345R3d345R4d0R5d746.5R6d-95R7d746.5R8d168R9d241.5R10i47R11d0R12d345R13ai1i2i2i2i2hg:103oR0d950.5R1ad465d737.5d465d637.5d423.75d582.5d382.5d527.5d308d527.5d234d527.5d192.75d582.5d151.5d637.5d151.5d737.5d151.5d837d192.75d892d234d947d308d947d382.5d947d423.75d892d465d837d465d737.5d557d954.5d557d1097.5d493.5d1167.25d430d1237d299d1237d250.5d1237d207.5d1229.75d164.5d1222.5d124d1207.5d124d1118d164.5d1140d204d1150.5d243.5d1161d284.5d1161d375d1161d420d1113.75d465d1066.5d465d971d465d925.5d436.5d975d392d999.5d347.5d1024d285.5d1024d182.5d1024d119.5d945.5d56.5d867d56.5d737.5d56.5d607.5d119.5d529d182.5d450.5d285.5d450.5d347.5d450.5d392d475d436.5d499.5d465d549d465d464d557d464d557d954.5hR2d650R3d557R4d56.5R5d573.5R6d-213R7d517R8d168R9d241.5R10i103R11d56.5R12d650R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i2i3i3i3i3i2i3i3i3i3i3i3i3i3i2i2i2hg:46oR0d950.5R1ad109.5d897d215d897d215d1024d109.5d1024d109.5d897hR2d325.5R3d215R4d109.5R5d127R6d0R7d17.5R8d168R9d241.5R10i46R11d109.5R12d325.5R13ai1i2i2i2i2hg:102oR0d950.5R1ad380d246d380d322.5d292d322.5d242.5d322.5d223.25d342.5d204d362.5d204d414.5d204d464d355.5d464d355.5d535.5d204d535.5d204d1024d111.5d1024d111.5d535.5d23.5d535.5d23.5d464d111.5d464d111.5d425d111.5d331.5d155d288.75d198.5d246d293d246d380d246hR2d360.5R3d380R4d23.5R5d778R6d0R7d754.5R8d168R9d241.5R10i102R11d23.5R12d360.5R13ai1i2i2i3i3i2i2i2i2i2i2i2i2i2i2i2i3i3i2hg:45oR0d950.5R1ad50d702.5d319.5d702.5d319.5d784.5d50d784.5d50d702.5hR2d369.5R3d319.5R4d50R5d321.5R6d239.5R7d271.5R8d168R9d241.5R10i45R11d50R12d369.5R13ai1i2i2i2i2hg:101oR0d950.5R1ad575.5d721d575.5d766d152.5d766d158.5d861d209.75d910.75d261d960.5d352.5d960.5d405.5d960.5d455.25d947.5d505d934.5d554d908.5d554d995.5d504.5d1016.5d452.5d1027.5d400.5d1038.5d347d1038.5d213d1038.5d134.75d960.5d56.5d882.5d56.5d749.5d56.5d612d130.75d531.25d205d450.5d331d450.5d444d450.5d509.75d523.25d575.5d596d575.5d721d483.5d694d482.5d618.5d441.25d573.5d400d528.5d332d528.5d255d528.5d208.75d572d162.5d615.5d155.5d694.5d483.5d694hR2d630R3d575.5R4d56.5R5d573.5R6d-14.5R7d517R8d168R9d241.5R10i101R11d56.5R12d630R13ai1i2i2i3i3i3i3i2i3i3i3i3i3i3i3i3i1i3i3i3i3i2hg:44oR0d950.5R1ad120d897d225.5d897d225.5d983d143.5d1143d79d1143d120d983d120d897hR2d325.5R3d225.5R4d79R5d127R6d-119R7d48R8d168R9d241.5R10i44R11d79R12d325.5R13ai1i2i2i2i2i2i2hg:100oR0d950.5R1ad465d549d465d246d557d246d557d1024d465d1024d465d940d436d990d391.75d1014.25d347.5d1038.5d285.5d1038.5d184d1038.5d120.25d957.5d56.5d876.5d56.5d744.5d56.5d612.5d120.25d531.5d184d450.5d285.5d450.5d347.5d450.5d391.75d474.75d436d499d465d549d151.5d744.5d151.5d846d193.25d903.75d235d961.5d308d961.5d381d961.5d423d903.75d465d846d465d744.5d465d643d423d585.25d381d527.5d308d527.5d235d527.5d193.25d585.25d151.5d643d151.5d744.5hR2d650R3d557R4d56.5R5d778R6d-14.5R7d721.5R8d168R9d241.5R10i100R11d56.5R12d650R13ai1i2i2i2i2i2i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:43oR0d950.5R1ad471d382d471d660.5d749.5d660.5d749.5d745.5d471d745.5d471d1024d387d1024d387d745.5d108.5d745.5d108.5d660.5d387d660.5d387d382d471d382hR2d858R3d749.5R4d108.5R5d642R6d0R7d533.5R8d168R9d241.5R10i43R11d108.5R12d858R13ai1i2i2i2i2i2i2i2i2i2i2i2i2hg:99oR0d950.5R1ad499.5d485.5d499.5d571.5d460.5d550d421.25d539.25d382d528.5d342d528.5d252.5d528.5d203d585.25d153.5d642d153.5d744.5d153.5d847d203d903.75d252.5d960.5d342d960.5d382d960.5d421.25d949.75d460.5d939d499.5d917.5d499.5d1002.5d461d1020.5d419.75d1029.5d378.5d1038.5d332d1038.5d205.5d1038.5d131d959d56.5d879.5d56.5d744.5d56.5d607.5d131.75d529d207d450.5d338d450.5d380.5d450.5d421d459.25d461.5d468d499.5d485.5hR2d563R3d499.5R4d56.5R5d573.5R6d-14.5R7d517R8d168R9d241.5R10i99R11d56.5R12d563R13ai1i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3hg:42oR0d950.5R1ad481.5d400.5d302d497.5d481.5d595d452.5d644d284.5d542.5d284.5d731d227.5d731d227.5d542.5d59.5d644d30.5d595d210d497.5d30.5d400.5d59.5d351d227.5d452.5d227.5d264d284.5d264d284.5d452.5d452.5d351d481.5d400.5hR2d512R3d481.5R4d30.5R5d760R6d293R7d729.5R8d168R9d241.5R10i42R11d30.5R12d512R13ai1i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2hg:98oR0d950.5R1ad498.5d744.5d498.5d643d456.75d585.25d415d527.5d342d527.5d269d527.5d227.25d585.25d185.5d643d185.5d744.5d185.5d846d227.25d903.75d269d961.5d342d961.5d415d961.5d456.75d903.75d498.5d846d498.5d744.5d185.5d549d214.5d499d258.75d474.75d303d450.5d364.5d450.5d466.5d450.5d530.25d531.5d594d612.5d594d744.5d594d876.5d530.25d957.5d466.5d1038.5d364.5d1038.5d303d1038.5d258.75d1014.25d214.5d990d185.5d940d185.5d1024d93d1024d93d246d185.5d246d185.5d549hR2d650R3d594R4d93R5d778R6d-14.5R7d685R8d168R9d241.5R10i98R11d93R12d650R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i2i2i2i2i2hg:41oR0d950.5R1ad82d247d162d247d237d365d274.25d478d311.5d591d311.5d702.5d311.5d814.5d274.25d928d237d1041.5d162d1159d82d1159d148.5d1044.5d181.25d931.25d214d818d214d702.5d214d587d181.25d474.5d148.5d362d82d247hR2d399.5R3d311.5R4d82R5d777R6d-135R7d695R8d168R9d241.5R10i41R11d82R12d399.5R13ai1i2i3i3i3i3i2i3i3i3i3hg:97oR0d950.5R1ad351d742.5d239.5d742.5d196.5d768d153.5d793.5d153.5d855d153.5d904d185.75d932.75d218d961.5d273.5d961.5d350d961.5d396.25d907.25d442.5d853d442.5d763d442.5d742.5d351d742.5d534.5d704.5d534.5d1024d442.5d1024d442.5d939d411d990d364d1014.25d317d1038.5d249d1038.5d163d1038.5d112.25d990.25d61.5d942d61.5d861d61.5d766.5d124.75d718.5d188d670.5d313.5d670.5d442.5d670.5d442.5d661.5d442.5d598d400.75d563.25d359d528.5d283.5d528.5d235.5d528.5d190d540d144.5d551.5d102.5d574.5d102.5d489.5d153d470d200.5d460.25d248d450.5d293d450.5d414.5d450.5d474.5d513.5d534.5d576.5d534.5d704.5hR2d627.5R3d534.5R4d61.5R5d573.5R6d-14.5R7d512R8d168R9d241.5R10i97R11d61.5R12d627.5R13ai1i3i3i3i3i3i3i2i2i1i2i2i2i3i3i3i3i3i3i2i2i3i3i3i3i2i3i3i3i3hg:40oR0d950.5R1ad317.5d247d250.5d362d218d474.5d185.5d587d185.5d702.5d185.5d818d218.25d931.25d251d1044.5d317.5d1159d237.5d1159d162.5d1041.5d125.25d928d88d814.5d88d702.5d88d591d125d478d162d365d237.5d247d317.5d247hR2d399.5R3d317.5R4d88R5d777R6d-135R7d689R8d168R9d241.5R10i40R11d88R12d399.5R13ai1i3i3i3i3i2i3i3i3i3i2hg:96oR0d950.5R1ad183.5d205d324.5d392d248d392d85d205d183.5d205hR2d512R3d324.5R4d85R5d819R6d632R7d734R8d168R9d241.5R10i96R11d85R12d512R13ai1i2i2i2i2hg:39oR0d950.5R1ad183.5d277.5d183.5d555d98.5d555d98.5d277.5d183.5d277.5hR2d281.5R3d183.5R4d98.5R5d746.5R6d469R7d648R8d168R9d241.5R10i39R11d98.5R12d281.5R13ai1i2i2i2i2hg:95oR0d950.5R1ad522d1194d522d1265.5d-10d1265.5d-10d1194d522d1194hR2d512R3d522R4d-10R5d-170R6d-241.5R7d-160R8d168R9d241.5R10i95R11d-10R12d512R13ai1i2i2i2i2hg:38oR0d950.5R1ad249d622.5d203.5d663d182.25d703.25d161d743.5d161d787.5d161d860.5d214d909d267d957.5d347d957.5d394.5d957.5d436d941.75d477.5d926d514d894d249d622.5d319.5d566.5d573.5d826.5d603d782d619.5d731.25d636d680.5d639d623.5d732d623.5d726d689.5d700d754d674d818.5d627.5d881.5d767d1024d641d1024d569.5d950.5d517.5d995d460.5d1016.75d403.5d1038.5d338d1038.5d217.5d1038.5d141d969.75d64.5d901d64.5d793.5d64.5d729.5d98d673.25d131.5d617d198.5d567.5d174.5d536d162d504.75d149.5d473.5d149.5d443.5d149.5d362.5d205d313.25d260.5d264d352.5d264d394d264d435.25d273d476.5d282d519d300d519d391d475.5d367.5d436d355.25d396.5d343d362.5d343d310d343d277.25d370.75d244.5d398.5d244.5d442.5d244.5d468d259.25d493.75d274d519.5d319.5d566.5hR2d798.5R3d767R4d64.5R5d760R6d-14.5R7d695.5R8d168R9d241.5R10i38R11d64.5R12d798.5R13ai1i3i3i3i3i3i3i2i1i2i3i3i2i3i3i2i2i2i3i3i3i3i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3hg:94oR0d950.5R1ad478d277.5d749.5d556d649d556d429d358.5d209d556d108.5d556d380d277.5d478d277.5hR2d858R3d749.5R4d108.5R5d746.5R6d468R7d638R8d168R9d241.5R10i94R11d108.5R12d858R13ai1i2i2i2i2i2i2i2hg:37oR0d950.5R1ad744.5d695.5d701d695.5d676.25d732.5d651.5d769.5d651.5d835.5d651.5d900.5d676.25d937.75d701d975d744.5d975d787d975d811.75d937.75d836.5d900.5d836.5d835.5d836.5d770d811.75d732.75d787d695.5d744.5d695.5d744.5d632d823.5d632d870d687d916.5d742d916.5d835.5d916.5d929d869.75d983.75d823d1038.5d744.5d1038.5d664.5d1038.5d618d983.75d571.5d929d571.5d835.5d571.5d741.5d618.25d686.75d665d632d744.5d632d228.5d327.5d185.5d327.5d160.75d364.75d136d402d136d467d136d533d160.5d570d185d607d228.5d607d272d607d296.75d570d321.5d533d321.5d467d321.5d402.5d296.5d365d271.5d327.5d228.5d327.5d680d264d760d264d293d1038.5d213d1038.5d680d264d228.5d264d307.5d264d354.5d318.75d401.5d373.5d401.5d467d401.5d561.5d354.75d616d308d670.5d228.5d670.5d149d670.5d102.75d615.75d56.5d561d56.5d467d56.5d374d103d319d149.5d264d228.5d264hR2d973R3d916.5R4d56.5R5d760R6d-14.5R7d703.5R8d168R9d241.5R10i37R11d56.5R12d973R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i1i2i2i2i2i1i3i3i3i3i3i3i3i3hg:93oR0d950.5R1ad311.5d246d311.5d1159d99.5d1159d99.5d1087.5d219d1087.5d219d317.5d99.5d317.5d99.5d246d311.5d246hR2d399.5R3d311.5R4d99.5R5d778R6d-135R7d678.5R8d168R9d241.5R10i93R11d99.5R12d399.5R13ai1i2i2i2i2i2i2i2i2hg:36oR0d950.5R1ad346d1174.5d296d1174.5d295.5d1024d243d1023d190.5d1011.75d138d1000.5d85d978d85d888d136d920d188.25d936.25d240.5d952.5d296d953d296d725d185.5d707d135.25d664d85d621d85d546d85d464.5d139.5d417.5d194d370.5d296d363.5d296d246d346d246d346d362d392.5d364d436d371.75d479.5d379.5d521d393d521d480.5d479.5d459.5d435.75d448d392d436.5d346d434.5d346d648d459.5d665.5d513d710.5d566.5d755.5d566.5d833.5d566.5d918d509.75d966.75d453d1015.5d346d1023d346d1174.5d296d639d296d434d238d440.5d207.5d467d177d493.5d177d537.5d177d580.5d205.25d604.5d233.5d628.5d296d639d346d735d346d951.5d409.5d943d441.75d915.5d474d888d474d843d474d799d443.25d773d412.5d747d346d735hR2d651.5R3d566.5R4d85R5d778R6d-150.5R7d693R8d168R9d241.5R10i36R11d85R12d651.5R13ai1i2i2i3i3i2i3i3i2i3i3i3i3i2i2i2i3i3i2i3i3i2i3i3i3i3i2i1i2i3i3i3i3i1i2i3i3i3i3hg:92oR0d950.5R1ad85d277.5d345d1119d260d1119d0d277.5d85d277.5hR2d345R3d345R4d0R5d746.5R6d-95R7d746.5R8d168R9d241.5R10i92R11d0R12d345R13ai1i2i2i2i2hg:35oR0d950.5R1ad523.5d573.5d378d573.5d336d740.5d482.5d740.5d523.5d573.5d448.5d289d396.5d496.5d542.5d496.5d595d289d675d289d623.5d496.5d779.5d496.5d779.5d573.5d604d573.5d563d740.5d722d740.5d722d817d543.5d817d491.5d1024d411.5d1024d463d817d316.5d817d265d1024d184.5d1024d236.5d817d79d817d79d740.5d255d740.5d297d573.5d136d573.5d136d496.5d316.5d496.5d367.5d289d448.5d289hR2d858R3d779.5R4d79R5d735R6d0R7d656R8d168R9d241.5R10i35R11d79R12d858R13ai1i2i2i2i2i1i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2i2hg:91oR0d950.5R1ad88d246d300d246d300d317.5d180d317.5d180d1087.5d300d1087.5d300d1159d88d1159d88d246hR2d399.5R3d300R4d88R5d778R6d-135R7d690R8d168R9d241.5R10i91R11d88R12d399.5R13ai1i2i2i2i2i2i2i2i2hg:34oR0d950.5R1ad183.5d277.5d183.5d555d98.5d555d98.5d277.5d183.5d277.5d372.5d277.5d372.5d555d287.5d555d287.5d277.5d372.5d277.5hR2d471R3d372.5R4d98.5R5d746.5R6d469R7d648R8d168R9d241.5R10i34R11d98.5R12d471R13ai1i2i2i2i2i1i2i2i2i2hg:90oR0d950.5R1ad57.5d277.5d644d277.5d644d354.5d172d939d655.5d939d655.5d1024d46d1024d46d947d518d362.5d57.5d362.5d57.5d277.5hR2d701.5R3d655.5R4d46R5d746.5R6d0R7d700.5R8d168R9d241.5R10i90R11d46R12d701.5R13ai1i2i2i2i2i2i2i2i2i2i2hg:33oR0d950.5R1ad154.5d897d256d897d256d1024d154.5d1024d154.5d897d154.5d277.5d256d277.5d256d605d246d783.5d165d783.5d154.5d605d154.5d277.5hR2d410.5R3d256R4d154.5R5d746.5R6d0R7d592R8d168R9d241.5R10i33R11d154.5R12d410.5R13ai1i2i2i2i2i1i2i2i2i2i2i2hg:89oR0d950.5R1ad-2d277.5d106.5d277.5d313.5d584.5d519d277.5d627.5d277.5d363.5d668.5d363.5d1024d262d1024d262d668.5d-2d277.5hR2d625.5R3d627.5R4d-2R5d746.5R6d0R7d748.5R8d168R9d241.5R10i89R11d-2R12d625.5R13ai1i2i2i2i2i2i2i2i2i2hg:32oR0d950.5R1ahR2d325.5R3d0R4d0R5d0R6d0R7d0R8d168R9d241.5R10i32R11d0R12d325.5R13ahg:88oR0d950.5R1ad64.5d277.5d173d277.5d358.5d555d545d277.5d653.5d277.5d413.5d636d669.5d1024d561d1024d351d706.5d139.5d1024d30.5d1024d297d625.5d64.5d277.5hR2d701.5R3d669.5R4d30.5R5d746.5R6d0R7d716R8d168R9d241.5R10i88R11d30.5R12d701.5R13ai1i2i2i2i2i2i2i2i2i2i2i2i2hg:87oR0d950.5R1ad34d277.5d136d277.5d293d908.5d449.5d277.5d563d277.5d720d908.5d876.5d277.5d979d277.5d791.5d1024d664.5d1024d507d376d348d1024d221d1024d34d277.5hR2d1012.5R3d979R4d34R5d746.5R6d0R7d712.5R8d168R9d241.5R10i87R11d34R12d1012.5R13ai1i2i2i2i2i2i2i2i2i2i2i2i2i2hg:86oR0d950.5R1ad293d1024d8d277.5d113.5d277.5d350d906d587d277.5d692d277.5d407.5d1024d293d1024hR2d700.5R3d692R4d8R5d746.5R6d0R7d738.5R8d168R9d241.5R10i86R11d8R12d700.5R13ai1i2i2i2i2i2i2i2hg:85oR0d950.5R1ad89d277.5d190.5d277.5d190.5d731d190.5d851d234d903.75d277.5d956.5d375d956.5d472d956.5d515.5d903.75d559d851d559d731d559d277.5d660.5d277.5d660.5d743.5d660.5d889.5d588.25d964d516d1038.5d375d1038.5d233.5d1038.5d161.25d964d89d889.5d89d743.5d89d277.5hR2d749.5R3d660.5R4d89R5d746.5R6d-14.5R7d657.5R8d168R9d241.5R10i85R11d89R12d749.5R13ai1i2i2i3i3i3i3i2i2i2i3i3i3i3i2hg:84oR0d950.5R1ad-3d277.5d628.5d277.5d628.5d362.5d363.5d362.5d363.5d1024d262d1024d262d362.5d-3d362.5d-3d277.5hR2d625.5R3d628.5R4d-3R5d746.5R6d0R7d749.5R8d168R9d241.5R10i84R11d-3R12d625.5R13ai1i2i2i2i2i2i2i2i2hg:83oR0d950.5R1ad548d302d548d400.5d490.5d373d439.5d359.5d388.5d346d341d346d258.5d346d213.75d378d169d410d169d469d169d518.5d198.75d543.75d228.5d569d311.5d584.5d372.5d597d485.5d618.5d539.25d672.75d593d727d593d818d593d926.5d520.25d982.5d447.5d1038.5d307d1038.5d254d1038.5d194.25d1026.5d134.5d1014.5d70.5d991d70.5d887d132d921.5d191d939d250d956.5d307d956.5d393.5d956.5d440.5d922.5d487.5d888.5d487.5d825.5d487.5d770.5d453.75d739.5d420d708.5d343d693d281.5d681d168.5d658.5d118d610.5d67.5d562.5d67.5d477d67.5d378d137.25d321d207d264d329.5d264d382d264d436.5d273.5d491d283d548d302hR2d650R3d593R4d67.5R5d760R6d-14.5R7d692.5R8d168R9d241.5R10i83R11d67.5R12d650R13ai1i2i3i3i3i3i3i3i2i3i3i3i3i3i3i2i3i3i3i3i3i3i2i3i3i3i3i3i3hg:82oR0d950.5R1ad454.5d674d487d685d517.75d721d548.5d757d579.5d820d682d1024d573.5d1024d478d832.5d441d757.5d406.25d733d371.5d708.5d311.5d708.5d201.5d708.5d201.5d1024d100.5d1024d100.5d277.5d328.5d277.5d456.5d277.5d519.5d331d582.5d384.5d582.5d492.5d582.5d563d549.75d609.5d517d656d454.5d674d201.5d360.5d201.5d625.5d328.5d625.5d401.5d625.5d438.75d591.75d476d558d476d492.5d476d427d438.75d393.75d401.5d360.5d328.5d360.5d201.5d360.5hR2d711.5R3d682R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i82R11d100.5R12d711.5R13ai1i3i3i2i2i2i3i3i2i2i2i2i2i3i3i3i3i1i2i2i3i3i3i3i2hg:81oR0d950.5R1ad403.5d346d293.5d346d228.75d428d164d510d164d651.5d164d792.5d228.75d874.5d293.5d956.5d403.5d956.5d513.5d956.5d577.75d874.5d642d792.5d642d651.5d642d510d577.75d428d513.5d346d403.5d346d545d1010.5d678d1156d556d1156d445.5d1036.5d429d1037.5d420.25d1038d411.5d1038.5d403.5d1038.5d246d1038.5d151.75d933.25d57.5d828d57.5d651.5d57.5d474.5d151.75d369.25d246d264d403.5d264d560.5d264d654.5d369.25d748.5d474.5d748.5d651.5d748.5d781.5d696.25d874d644d966.5d545d1010.5hR2d806R3d748.5R4d57.5R5d760R6d-132R7d702.5R8d168R9d241.5R10i81R11d57.5R12d806R13ai1i3i3i3i3i3i3i3i3i1i2i2i2i3i3i3i3i3i3i3i3i3i3hg:80oR0d950.5R1ad201.5d360.5d201.5d641d328.5d641d399d641d437.5d604.5d476d568d476d500.5d476d433.5d437.5d397d399d360.5d328.5d360.5d201.5d360.5d100.5d277.5d328.5d277.5d454d277.5d518.25d334.25d582.5d391d582.5d500.5d582.5d611d518.25d667.5d454d724d328.5d724d201.5d724d201.5d1024d100.5d1024d100.5d277.5hR2d617.5R3d582.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i80R11d100.5R12d617.5R13ai1i2i2i3i3i3i3i2i1i2i3i3i3i3i2i2i2i2hg:79oR0d950.5R1ad403.5d346d293.5d346d228.75d428d164d510d164d651.5d164d792.5d228.75d874.5d293.5d956.5d403.5d956.5d513.5d956.5d577.75d874.5d642d792.5d642d651.5d642d510d577.75d428d513.5d346d403.5d346d403.5d264d560.5d264d654.5d369.25d748.5d474.5d748.5d651.5d748.5d828d654.5d933.25d560.5d1038.5d403.5d1038.5d246d1038.5d151.75d933.5d57.5d828.5d57.5d651.5d57.5d474.5d151.75d369.25d246d264d403.5d264hR2d806R3d748.5R4d57.5R5d760R6d-14.5R7d702.5R8d168R9d241.5R10i79R11d57.5R12d806R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:78oR0d950.5R1ad100.5d277.5d236.5d277.5d567.5d902d567.5d277.5d665.5d277.5d665.5d1024d529.5d1024d198.5d399.5d198.5d1024d100.5d1024d100.5d277.5hR2d766R3d665.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i78R11d100.5R12d766R13ai1i2i2i2i2i2i2i2i2i2i2hg:77oR0d950.5R1ad100.5d277.5d251d277.5d441.5d785.5d633d277.5d783.5d277.5d783.5d1024d685d1024d685d368.5d492.5d880.5d391d880.5d198.5d368.5d198.5d1024d100.5d1024d100.5d277.5hR2d883.5R3d783.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i77R11d100.5R12d883.5R13ai1i2i2i2i2i2i2i2i2i2i2i2i2i2hg:76oR0d950.5R1ad100.5d277.5d201.5d277.5d201.5d939d565d939d565d1024d100.5d1024d100.5d277.5hR2d570.5R3d565R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i76R11d100.5R12d570.5R13ai1i2i2i2i2i2i2hg:75oR0d950.5R1ad100.5d277.5d201.5d277.5d201.5d593d536.5d277.5d666.5d277.5d296d625.5d693d1024d560d1024d201.5d664.5d201.5d1024d100.5d1024d100.5d277.5hR2d671.5R3d693R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i75R11d100.5R12d671.5R13ai1i2i2i2i2i2i2i2i2i2i2i2hg:74oR0d950.5R1ad100.5d277.5d201.5d277.5d201.5d972d201.5d1107d150.25d1168d99d1229d-14.5d1229d-53d1229d-53d1144d-21.5d1144d45.5d1144d73d1106.5d100.5d1069d100.5d972d100.5d277.5hR2d302R3d201.5R4d-53R5d746.5R6d-205R7d799.5R8d168R9d241.5R10i74R11d-53R12d302R13ai1i2i2i3i3i2i2i2i3i3i2hg:73oR0d950.5R1ad100.5d277.5d201.5d277.5d201.5d1024d100.5d1024d100.5d277.5hR2d302R3d201.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i73R11d100.5R12d302R13ai1i2i2i2i2hg:72oR0d950.5R1ad100.5d277.5d201.5d277.5d201.5d583.5d568.5d583.5d568.5d277.5d669.5d277.5d669.5d1024d568.5d1024d568.5d668.5d201.5d668.5d201.5d1024d100.5d1024d100.5d277.5hR2d770R3d669.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i72R11d100.5R12d770R13ai1i2i2i2i2i2i2i2i2i2i2i2i2hg:71oR0d950.5R1ad609.5d917.5d609.5d717d444.5d717d444.5d634d709.5d634d709.5d954.5d651d996d580.5d1017.25d510d1038.5d430d1038.5d255d1038.5d156.25d936.25d57.5d834d57.5d651.5d57.5d468.5d156.25d366.25d255d264d430d264d503d264d568.75d282d634.5d300d690d335d690d442.5d634d395d571d371d508d347d438.5d347d301.5d347d232.75d423.5d164d500d164d651.5d164d802.5d232.75d879d301.5d955.5d438.5d955.5d492d955.5d534d946.25d576d937d609.5d917.5hR2d793.5R3d709.5R4d57.5R5d760R6d-14.5R7d702.5R8d168R9d241.5R10i71R11d57.5R12d793.5R13ai1i2i2i2i2i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3hg:70oR0d950.5R1ad100.5d277.5d529.5d277.5d529.5d362.5d201.5d362.5d201.5d582.5d497.5d582.5d497.5d667.5d201.5d667.5d201.5d1024d100.5d1024d100.5d277.5hR2d589R3d529.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i70R11d100.5R12d589R13ai1i2i2i2i2i2i2i2i2i2i2hg:126oR0d950.5R1ad749.5d615.5d749.5d704.5d697d744d652.25d761d607.5d778d559d778d504d778d431d748.5d425.5d746.5d423d745.5d419.5d744d412d741.5d334.5d710.5d287.5d710.5d243.5d710.5d200.5d729.75d157.5d749d108.5d790.5d108.5d701.5d161d662d205.75d644.75d250.5d627.5d299d627.5d354d627.5d427.5d657.5d432.5d659.5d435d660.5d439d662d446d664.5d523.5d695.5d570.5d695.5d613.5d695.5d655.75d676.5d698d657.5d749.5d615.5hR2d858R3d749.5R4d108.5R5d408.5R6d233.5R7d300R8d168R9d241.5R10i126R11d108.5R12d858R13ai1i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3hg:69oR0d950.5R1ad100.5d277.5d572.5d277.5d572.5d362.5d201.5d362.5d201.5d583.5d557d583.5d557d668.5d201.5d668.5d201.5d939d581.5d939d581.5d1024d100.5d1024d100.5d277.5hR2d647R3d581.5R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i69R11d100.5R12d647R13ai1i2i2i2i2i2i2i2i2i2i2i2i2hg:125oR0d950.5R1ad128d1119d163d1119d233d1119d254.25d1097.5d275.5d1076d275.5d1004.5d275.5d880.5d275.5d802.5d298d767d320.5d731.5d376d718d320.5d705.5d298d670d275.5d634.5d275.5d556d275.5d432d275.5d361d254.25d339.25d233d317.5d163d317.5d128d317.5d128d246d159.5d246d284d246d325.75d282.75d367.5d319.5d367.5d430d367.5d550d367.5d624.5d394.5d653.25d421.5d682d492.5d682d523.5d682d523.5d753.5d492.5d753.5d421.5d753.5d394.5d782.5d367.5d811.5d367.5d887d367.5d1006.5d367.5d1117d325.75d1154d284d1191d159.5d1191d128d1191d128d1119hR2d651.5R3d523.5R4d128R5d778R6d-167R7d650R8d168R9d241.5R10i125R11d128R12d651.5R13ai1i2i3i3i2i3i3i3i3i2i3i3i2i2i2i3i3i2i3i3i2i2i2i3i3i2i3i3i2i2hg:68oR0d950.5R1ad201.5d360.5d201.5d941d323.5d941d478d941d549.75d871d621.5d801d621.5d650d621.5d500d549.75d430.25d478d360.5d323.5d360.5d201.5d360.5d100.5d277.5d308d277.5d525d277.5d626.5d367.75d728d458d728d650d728d843d626d933.5d524d1024d308d1024d100.5d1024d100.5d277.5hR2d788.5R3d728R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i68R11d100.5R12d788.5R13ai1i2i2i3i3i3i3i2i1i2i3i3i3i3i2i2hg:124oR0d950.5R1ad215d241.5d215d1265.5d130d1265.5d130d241.5d215d241.5hR2d345R3d215R4d130R5d782.5R6d-241.5R7d652.5R8d168R9d241.5R10i124R11d130R12d345R13ai1i2i2i2i2hg:67oR0d950.5R1ad659.5d335d659.5d441.5d608.5d394d550.75d370.5d493d347d428d347d300d347d232d425.25d164d503.5d164d651.5d164d799d232d877.25d300d955.5d428d955.5d493d955.5d550.75d932d608.5d908.5d659.5d861d659.5d966.5d606.5d1002.5d547.25d1020.5d488d1038.5d422d1038.5d252.5d1038.5d155d934.75d57.5d831d57.5d651.5d57.5d471.5d155d367.75d252.5d264d422d264d489d264d548.25d281.75d607.5d299.5d659.5d335hR2d715R3d659.5R4d57.5R5d760R6d-14.5R7d702.5R8d168R9d241.5R10i67R11d57.5R12d715R13ai1i2i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3hg:123oR0d950.5R1ad523.5d1119d523.5d1191d492.5d1191d368d1191d325.75d1154d283.5d1117d283.5d1006.5d283.5d887d283.5d811.5d256.5d782.5d229.5d753.5d158.5d753.5d128d753.5d128d682d158.5d682d230d682d256.75d653.25d283.5d624.5d283.5d550d283.5d430d283.5d319.5d325.75d282.75d368d246d492.5d246d523.5d246d523.5d317.5d489.5d317.5d419d317.5d397.5d339.5d376d361.5d376d432d376d556d376d634.5d353.25d670d330.5d705.5d275.5d718d331d731.5d353.5d767d376d802.5d376d880.5d376d1004.5d376d1075d397.5d1097d419d1119d489.5d1119d523.5d1119hR2d651.5R3d523.5R4d128R5d778R6d-167R7d650R8d168R9d241.5R10i123R11d128R12d651.5R13ai1i2i2i3i3i2i3i3i2i2i2i3i3i2i3i3i2i2i2i3i3i2i3i3i3i3i2i3i3i2hg:66oR0d950.5R1ad201.5d667.5d201.5d941d363.5d941d445d941d484.25d907.25d523.5d873.5d523.5d804d523.5d734d484.25d700.75d445d667.5d363.5d667.5d201.5d667.5d201.5d360.5d201.5d585.5d351d585.5d425d585.5d461.25d557.75d497.5d530d497.5d473d497.5d416.5d461.25d388.5d425d360.5d351d360.5d201.5d360.5d100.5d277.5d358.5d277.5d474d277.5d536.5d325.5d599d373.5d599d462d599d530.5d567d571d535d611.5d473d621.5d547.5d637.5d588.75d688.25d630d739d630d815d630d915d562d969.5d494d1024d368.5d1024d100.5d1024d100.5d277.5hR2d702.5R3d630R4d100.5R5d746.5R6d0R7d646R8d168R9d241.5R10i66R11d100.5R12d702.5R13ai1i2i2i3i3i3i3i2i1i2i2i3i3i3i3i2i1i2i3i3i3i3i3i3i3i3i2i2hg:122oR0d950.5R1ad56.5d464d493.5d464d493.5d548d147.5d950.5d493.5d950.5d493.5d1024d44d1024d44d940d390d537.5d56.5d537.5d56.5d464hR2d537.5R3d493.5R4d44R5d560R6d0R7d516R8d168R9d241.5R10i122R11d44R12d537.5R13ai1i2i2i2i2i2i2i2i2i2i2hg:65oR0d950.5R1ad350d377d213d748.5d487.5d748.5d350d377d293d277.5d407.5d277.5d692d1024d587d1024d519d832.5d182.5d832.5d114.5d1024d8d1024d293d277.5hR2d700.5R3d692R4d8R5d746.5R6d0R7d738.5R8d168R9d241.5R10i65R11d8R12d700.5R13ai1i2i2i2i1i2i2i2i2i2i2i2i2hg:121oR0d950.5R1ad329.5d1076d290.5d1176d253.5d1206.5d216.5d1237d154.5d1237d81d1237d81d1160d135d1160d173d1160d194d1142d215d1124d240.5d1057d257d1015d30.5d464d128d464d303d902d478d464d575.5d464d329.5d1076hR2d606R3d575.5R4d30.5R5d560R6d-213R7d529.5R8d168R9d241.5R10i121R11d30.5R12d606R13ai1i3i3i2i2i2i3i3i2i2i2i2i2i2i2hg:64oR0d950.5R1ad381d755.5d381d827d416.5d867.75d452d908.5d514d908.5d575.5d908.5d610.75d867.5d646d826.5d646d755.5d646d685.5d610d644.25d574d603d513d603d452.5d603d416.75d644d381d685d381d755.5d653.5d905d623.5d943.5d584.75d961.75d546d980d494.5d980d408.5d980d354.75d917.75d301d855.5d301d755.5d301d655.5d355d593d409d530.5d494.5d530.5d546d530.5d585d549.25d624d568d653.5d606d653.5d540.5d725d540.5d725d908.5d798d897.5d839.25d841.75d880.5d786d880.5d697.5d880.5d644d864.75d597d849d550d817d510d765d444.5d690.25d409.75d615.5d375d527.5d375d466d375d409.5d391.25d353d407.5d305d439.5d226.5d490.5d182.25d573.25d138d656d138d752.5d138d832d166.75d901.5d195.5d971d250d1024d302.5d1076d371.5d1103.25d440.5d1130.5d519d1130.5d583.5d1130.5d645.75d1108.75d708d1087d760d1046.5d805d1102d742.5d1150.5d668.75d1176.25d595d1202d519d1202d426.5d1202d344.5d1169.25d262.5d1136.5d198.5d1074d134.5d1011.5d101d929.25d67.5d847d67.5d752.5d67.5d661.5d101.5d579d135.5d496.5d198.5d434d263d370.5d347.5d336.75d432d303d526.5d303d632.5d303d723.25d346.5d814d390d875.5d470d913d519d932.75d576.5d952.5d634d952.5d695.5d952.5d827d873d903d793.5d979d653.5d982d653.5d905hR2d1024R3d952.5R4d67.5R5d721R6d-178R7d653.5R8d168R9d241.5R10i64R11d67.5R12d1024R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i2i2i2i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i2i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i2hg:120oR0d950.5R1ad562d464d359.5d736.5d572.5d1024d464d1024d301d804d138d1024d29.5d1024d247d731d48d464d156.5d464d305d663.5d453.5d464d562d464hR2d606R3d572.5R4d29.5R5d560R6d0R7d530.5R8d168R9d241.5R10i120R11d29.5R12d606R13ai1i2i2i2i2i2i2i2i2i2i2i2i2hg:63oR0d950.5R1ad195.5d897d297d897d297d1024d195.5d1024d195.5d897d294d823.5d198.5d823.5d198.5d746.5d198.5d696d212.5d663.5d226.5d631d271.5d588d316.5d543.5d345d517d357.75d493.5d370.5d470d370.5d445.5d370.5d401d337.75d373.5d305d346d251d346d211.5d346d166.75d363.5d122d381d73.5d414.5d73.5d320.5d120.5d292d168.75d278d217d264d268.5d264d360.5d264d416.25d312.5d472d361d472d440.5d472d478.5d454d512.75d436d547d391d590d347d633d323.5d656.5d313.75d669.75d304d683d300d695.5d297d706d295.5d721d294d736d294d762d294d823.5hR2d543.5R3d472R4d73.5R5d760R6d0R7d686.5R8d168R9d241.5R10i63R11d73.5R12d543.5R13ai1i2i2i2i2i1i2i2i3i3i2i3i3i3i3i3i3i2i3i3i3i3i3i3i2i3i3i3i3i2hg:119oR0d950.5R1ad43d464d135d464d250d901d364.5d464d473d464d588d901d702.5d464d794.5d464d648d1024d539.5d1024d419d565d298d1024d189.5d1024d43d464hR2d837.5R3d794.5R4d43R5d560R6d0R7d517R8d168R9d241.5R10i119R11d43R12d837.5R13ai1i2i2i2i2i2i2i2i2i2i2i2i2i2hg:62oR0d950.5R1ad108.5d520d108.5d429d749.5d661.5d749.5d744.5d108.5d977d108.5d886d623.5d703.5d108.5d520hR2d858R3d749.5R4d108.5R5d595R6d47R7d486.5R8d168R9d241.5R10i62R11d108.5R12d858R13ai1i2i2i2i2i2i2i2hg:118oR0d950.5R1ad30.5d464d128d464d303d934d478d464d575.5d464d365.5d1024d240.5d1024d30.5d464hR2d606R3d575.5R4d30.5R5d560R6d0R7d529.5R8d168R9d241.5R10i118R11d30.5R12d606R13ai1i2i2i2i2i2i2i2hg:61oR0d950.5R1ad108.5d559d749.5d559d749.5d643d108.5d643d108.5d559d108.5d763d749.5d763d749.5d848d108.5d848d108.5d763hR2d858R3d749.5R4d108.5R5d465R6d176R7d356.5R8d168R9d241.5R10i61R11d108.5R12d858R13ai1i2i2i2i2i1i2i2i2i2hg:117oR0d950.5R1ad87d803d87d464d179d464d179d799.5d179d879d210d918.75d241d958.5d303d958.5d377.5d958.5d420.75d911d464d863.5d464d781.5d464d464d556d464d556d1024d464d1024d464d938d430.5d989d386.25d1013.75d342d1038.5d283.5d1038.5d187d1038.5d137d978.5d87d918.5d87d803hR2d649R3d556R4d87R5d560R6d-14.5R7d473R8d168R9d241.5R10i117R11d87R12d649R13ai1i2i2i2i3i3i3i3i2i2i2i2i2i3i3i3i3hg:60oR0d950.5R1ad749.5d520d233.5d703.5d749.5d886d749.5d977d108.5d744.5d108.5d661.5d749.5d429d749.5d520hR2d858R3d749.5R4d108.5R5d595R6d47R7d486.5R8d168R9d241.5R10i60R11d108.5R12d858R13ai1i2i2i2i2i2i2i2hg:116oR0d950.5R1ad187.5d305d187.5d464d377d464d377d535.5d187.5d535.5d187.5d839.5d187.5d908d206.25d927.5d225d947d282.5d947d377d947d377d1024d282.5d1024d176d1024d135.5d984.25d95d944.5d95d839.5d95d535.5d27.5d535.5d27.5d464d95d464d95d305d187.5d305hR2d401.5R3d377R4d27.5R5d719R6d0R7d691.5R8d168R9d241.5R10i116R11d27.5R12d401.5R13ai1i2i2i2i2i2i3i3i2i2i2i3i3i2i2i2i2i2i2hg:59oR0d950.5R1ad120d494.5d225.5d494.5d225.5d621.5d120d621.5d120d494.5d120d897d225.5d897d225.5d983d143.5d1143d79d1143d120d983d120d897hR2d345R3d225.5R4d79R5d529.5R6d-119R7d450.5R8d168R9d241.5R10i59R11d79R12d345R13ai1i2i2i2i2i1i2i2i2i2i2i2hg:115oR0d950.5R1ad453.5d480.5d453.5d567.5d414.5d547.5d372.5d537.5d330.5d527.5d285.5d527.5d217d527.5d182.75d548.5d148.5d569.5d148.5d611.5d148.5d643.5d173d661.75d197.5d680d271.5d696.5d303d703.5d401d724.5d442.25d762.75d483.5d801d483.5d869.5d483.5d947.5d421.75d993d360d1038.5d252d1038.5d207d1038.5d158.25d1029.75d109.5d1021d55.5d1003.5d55.5d908.5d106.5d935d156d948.25d205.5d961.5d254d961.5d319d961.5d354d939.25d389d917d389d876.5d389d839d363.75d819d338.5d799d253d780.5d221d773d135.5d755d97.5d717.75d59.5d680.5d59.5d615.5d59.5d536.5d115.5d493.5d171.5d450.5d274.5d450.5d325.5d450.5d370.5d458d415.5d465.5d453.5d480.5hR2d533.5R3d483.5R4d55.5R5d573.5R6d-14.5R7d518R8d168R9d241.5R10i115R11d55.5R12d533.5R13ai1i2i3i3i3i3i3i3i2i3i3i3i3i3i3i2i3i3i3i3i3i3i2i3i3i3i3i3i3hg:58oR0d950.5R1ad120d897d225.5d897d225.5d1024d120d1024d120d897d120d494.5d225.5d494.5d225.5d621.5d120d621.5d120d494.5hR2d345R3d225.5R4d120R5d529.5R6d0R7d409.5R8d168R9d241.5R10i58R11d120R12d345R13ai1i2i2i2i2i1i2i2i2i2hg:114oR0d950.5R1ad421d550d405.5d541d387.25d536.75d369d532.5d347d532.5d269d532.5d227.25d583.25d185.5d634d185.5d729d185.5d1024d93d1024d93d464d185.5d464d185.5d551d214.5d500d261d475.25d307.5d450.5d374d450.5d383.5d450.5d395d451.75d406.5d453d420.5d455.5d421d550hR2d421R3d421R4d93R5d573.5R6d0R7d480.5R8d168R9d241.5R10i114R11d93R12d421R13ai1i3i3i3i3i2i2i2i2i2i3i3i3i3i2hg:57oR0d950.5R1ad112.5d1008.5d112.5d916.5d150.5d934.5d189.5d944d228.5d953.5d266d953.5d366d953.5d418.75d886.25d471.5d819d479d682d450d725d405.5d748d361d771d307d771d195d771d129.75d703.25d64.5d635.5d64.5d518d64.5d403d132.5d333.5d200.5d264d313.5d264d443d264d511.25d363.25d579.5d462.5d579.5d651.5d579.5d828d495.75d933.25d412d1038.5d270.5d1038.5d232.5d1038.5d193.5d1031d154.5d1023.5d112.5d1008.5d313.5d692d381.5d692d421.25d645.5d461d599d461d518d461d437.5d421.25d390.75d381.5d344d313.5d344d245.5d344d205.75d390.75d166d437.5d166d518d166d599d205.75d645.5d245.5d692d313.5d692hR2d651.5R3d579.5R4d64.5R5d760R6d-14.5R7d695.5R8d168R9d241.5R10i57R11d64.5R12d651.5R13ai1i2i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:113oR0d950.5R1ad151.5d744.5d151.5d846d193.25d903.75d235d961.5d308d961.5d381d961.5d423d903.75d465d846d465d744.5d465d643d423d585.25d381d527.5d308d527.5d235d527.5d193.25d585.25d151.5d643d151.5d744.5d465d940d436d990d391.75d1014.25d347.5d1038.5d285.5d1038.5d184d1038.5d120.25d957.5d56.5d876.5d56.5d744.5d56.5d612.5d120.25d531.5d184d450.5d285.5d450.5d347.5d450.5d391.75d474.75d436d499d465d549d465d464d557d464d557d1237d465d1237d465d940hR2d650R3d557R4d56.5R5d573.5R6d-213R7d517R8d168R9d241.5R10i113R11d56.5R12d650R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i2i2i2i2i2hg:56oR0d950.5R1ad325.5d669.5d253.5d669.5d212.25d708d171d746.5d171d814d171d881.5d212.25d920d253.5d958.5d325.5d958.5d397.5d958.5d439d919.75d480.5d881d480.5d814d480.5d746.5d439.25d708d398d669.5d325.5d669.5d224.5d626.5d159.5d610.5d123.25d566d87d521.5d87d457.5d87d368d150.75d316d214.5d264d325.5d264d437d264d500.5d316d564d368d564d457.5d564d521.5d527.75d566d491.5d610.5d427d626.5d500d643.5d540.75d693d581.5d742.5d581.5d814d581.5d922.5d515.25d980.5d449d1038.5d325.5d1038.5d202d1038.5d135.75d980.5d69.5d922.5d69.5d814d69.5d742.5d110.5d693d151.5d643.5d224.5d626.5d187.5d467d187.5d525d223.75d557.5d260d590d325.5d590d390.5d590d427.25d557.5d464d525d464d467d464d409d427.25d376.5d390.5d344d325.5d344d260d344d223.75d376.5d187.5d409d187.5d467hR2d651.5R3d581.5R4d69.5R5d760R6d-14.5R7d690.5R8d168R9d241.5R10i56R11d69.5R12d651.5R13ai1i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hg:112oR0d950.5R1ad185.5d940d185.5d1237d93d1237d93d464d185.5d464d185.5d549d214.5d499d258.75d474.75d303d450.5d364.5d450.5d466.5d450.5d530.25d531.5d594d612.5d594d744.5d594d876.5d530.25d957.5d466.5d1038.5d364.5d1038.5d303d1038.5d258.75d1014.25d214.5d990d185.5d940d498.5d744.5d498.5d643d456.75d585.25d415d527.5d342d527.5d269d527.5d227.25d585.25d185.5d643d185.5d744.5d185.5d846d227.25d903.75d269d961.5d342d961.5d415d961.5d456.75d903.75d498.5d846d498.5d744.5hR2d650R3d594R4d93R5d573.5R6d-213R7d480.5R8d168R9d241.5R10i112R11d93R12d650R13ai1i2i2i2i2i2i3i3i3i3i3i3i3i3i1i3i3i3i3i3i3i3i3hgh";
flash.text.Font.DEFAULT_FONT_SCALE = 9.0;
flash.text.Font.DEFAULT_FONT_NAME = "Bitstream_Vera_Sans";
flash.text.Font.DEFAULT_CLASS_NAME = "flash.text.Font";
flash.text.Font.nmeRegisteredFonts = new Array();
flash.text.TextField.mDefaultFont = "Bitstream_Vera_Sans";
flash.text.FontInstance.mSolidFonts = new haxe.ds.StringMap();
flash.text.TextFieldAutoSize.CENTER = "CENTER";
flash.text.TextFieldAutoSize.LEFT = "LEFT";
flash.text.TextFieldAutoSize.NONE = "NONE";
flash.text.TextFieldAutoSize.RIGHT = "RIGHT";
flash.text.TextFieldType.DYNAMIC = "DYNAMIC";
flash.text.TextFieldType.INPUT = "INPUT";
flash.ui.Keyboard.NUMBER_0 = 48;
flash.ui.Keyboard.NUMBER_1 = 49;
flash.ui.Keyboard.NUMBER_2 = 50;
flash.ui.Keyboard.NUMBER_3 = 51;
flash.ui.Keyboard.NUMBER_4 = 52;
flash.ui.Keyboard.NUMBER_5 = 53;
flash.ui.Keyboard.NUMBER_6 = 54;
flash.ui.Keyboard.NUMBER_7 = 55;
flash.ui.Keyboard.NUMBER_8 = 56;
flash.ui.Keyboard.NUMBER_9 = 57;
flash.ui.Keyboard.A = 65;
flash.ui.Keyboard.B = 66;
flash.ui.Keyboard.C = 67;
flash.ui.Keyboard.D = 68;
flash.ui.Keyboard.E = 69;
flash.ui.Keyboard.F = 70;
flash.ui.Keyboard.G = 71;
flash.ui.Keyboard.H = 72;
flash.ui.Keyboard.I = 73;
flash.ui.Keyboard.J = 74;
flash.ui.Keyboard.K = 75;
flash.ui.Keyboard.L = 76;
flash.ui.Keyboard.M = 77;
flash.ui.Keyboard.N = 78;
flash.ui.Keyboard.O = 79;
flash.ui.Keyboard.P = 80;
flash.ui.Keyboard.Q = 81;
flash.ui.Keyboard.R = 82;
flash.ui.Keyboard.S = 83;
flash.ui.Keyboard.T = 84;
flash.ui.Keyboard.U = 85;
flash.ui.Keyboard.V = 86;
flash.ui.Keyboard.W = 87;
flash.ui.Keyboard.X = 88;
flash.ui.Keyboard.Y = 89;
flash.ui.Keyboard.Z = 90;
flash.ui.Keyboard.NUMPAD_0 = 96;
flash.ui.Keyboard.NUMPAD_1 = 97;
flash.ui.Keyboard.NUMPAD_2 = 98;
flash.ui.Keyboard.NUMPAD_3 = 99;
flash.ui.Keyboard.NUMPAD_4 = 100;
flash.ui.Keyboard.NUMPAD_5 = 101;
flash.ui.Keyboard.NUMPAD_6 = 102;
flash.ui.Keyboard.NUMPAD_7 = 103;
flash.ui.Keyboard.NUMPAD_8 = 104;
flash.ui.Keyboard.NUMPAD_9 = 105;
flash.ui.Keyboard.NUMPAD_MULTIPLY = 106;
flash.ui.Keyboard.NUMPAD_ADD = 107;
flash.ui.Keyboard.NUMPAD_ENTER = 108;
flash.ui.Keyboard.NUMPAD_SUBTRACT = 109;
flash.ui.Keyboard.NUMPAD_DECIMAL = 110;
flash.ui.Keyboard.NUMPAD_DIVIDE = 111;
flash.ui.Keyboard.F1 = 112;
flash.ui.Keyboard.F2 = 113;
flash.ui.Keyboard.F3 = 114;
flash.ui.Keyboard.F4 = 115;
flash.ui.Keyboard.F5 = 116;
flash.ui.Keyboard.F6 = 117;
flash.ui.Keyboard.F7 = 118;
flash.ui.Keyboard.F8 = 119;
flash.ui.Keyboard.F9 = 120;
flash.ui.Keyboard.F10 = 121;
flash.ui.Keyboard.F11 = 122;
flash.ui.Keyboard.F12 = 123;
flash.ui.Keyboard.F13 = 124;
flash.ui.Keyboard.F14 = 125;
flash.ui.Keyboard.F15 = 126;
flash.ui.Keyboard.BACKSPACE = 8;
flash.ui.Keyboard.TAB = 9;
flash.ui.Keyboard.ENTER = 13;
flash.ui.Keyboard.SHIFT = 16;
flash.ui.Keyboard.CONTROL = 17;
flash.ui.Keyboard.CAPS_LOCK = 18;
flash.ui.Keyboard.ESCAPE = 27;
flash.ui.Keyboard.SPACE = 32;
flash.ui.Keyboard.PAGE_UP = 33;
flash.ui.Keyboard.PAGE_DOWN = 34;
flash.ui.Keyboard.END = 35;
flash.ui.Keyboard.HOME = 36;
flash.ui.Keyboard.LEFT = 37;
flash.ui.Keyboard.RIGHT = 39;
flash.ui.Keyboard.UP = 38;
flash.ui.Keyboard.DOWN = 40;
flash.ui.Keyboard.INSERT = 45;
flash.ui.Keyboard.DELETE = 46;
flash.ui.Keyboard.NUMLOCK = 144;
flash.ui.Keyboard.BREAK = 19;
flash.ui.Keyboard.SEMICOLON = 186;
flash.ui.Keyboard.EQUAL = 187;
flash.ui.Keyboard.COMMA = 188;
flash.ui.Keyboard.MINUS = 189;
flash.ui.Keyboard.PERIOD = 190;
flash.ui.Keyboard.SLASH = 191;
flash.ui.Keyboard.BACKQUOTE = 192;
flash.ui.Keyboard.LEFTBRACKET = 219;
flash.ui.Keyboard.BACKSLASH = 220;
flash.ui.Keyboard.RIGHTBRACKET = 221;
flash.ui.Keyboard.DOM_VK_CANCEL = 3;
flash.ui.Keyboard.DOM_VK_HELP = 6;
flash.ui.Keyboard.DOM_VK_BACK_SPACE = 8;
flash.ui.Keyboard.DOM_VK_TAB = 9;
flash.ui.Keyboard.DOM_VK_CLEAR = 12;
flash.ui.Keyboard.DOM_VK_RETURN = 13;
flash.ui.Keyboard.DOM_VK_ENTER = 14;
flash.ui.Keyboard.DOM_VK_SHIFT = 16;
flash.ui.Keyboard.DOM_VK_CONTROL = 17;
flash.ui.Keyboard.DOM_VK_ALT = 18;
flash.ui.Keyboard.DOM_VK_PAUSE = 19;
flash.ui.Keyboard.DOM_VK_CAPS_LOCK = 20;
flash.ui.Keyboard.DOM_VK_ESCAPE = 27;
flash.ui.Keyboard.DOM_VK_SPACE = 32;
flash.ui.Keyboard.DOM_VK_PAGE_UP = 33;
flash.ui.Keyboard.DOM_VK_PAGE_DOWN = 34;
flash.ui.Keyboard.DOM_VK_END = 35;
flash.ui.Keyboard.DOM_VK_HOME = 36;
flash.ui.Keyboard.DOM_VK_LEFT = 37;
flash.ui.Keyboard.DOM_VK_UP = 38;
flash.ui.Keyboard.DOM_VK_RIGHT = 39;
flash.ui.Keyboard.DOM_VK_DOWN = 40;
flash.ui.Keyboard.DOM_VK_PRINTSCREEN = 44;
flash.ui.Keyboard.DOM_VK_INSERT = 45;
flash.ui.Keyboard.DOM_VK_DELETE = 46;
flash.ui.Keyboard.DOM_VK_0 = 48;
flash.ui.Keyboard.DOM_VK_1 = 49;
flash.ui.Keyboard.DOM_VK_2 = 50;
flash.ui.Keyboard.DOM_VK_3 = 51;
flash.ui.Keyboard.DOM_VK_4 = 52;
flash.ui.Keyboard.DOM_VK_5 = 53;
flash.ui.Keyboard.DOM_VK_6 = 54;
flash.ui.Keyboard.DOM_VK_7 = 55;
flash.ui.Keyboard.DOM_VK_8 = 56;
flash.ui.Keyboard.DOM_VK_9 = 57;
flash.ui.Keyboard.DOM_VK_SEMICOLON = 59;
flash.ui.Keyboard.DOM_VK_EQUALS = 61;
flash.ui.Keyboard.DOM_VK_A = 65;
flash.ui.Keyboard.DOM_VK_B = 66;
flash.ui.Keyboard.DOM_VK_C = 67;
flash.ui.Keyboard.DOM_VK_D = 68;
flash.ui.Keyboard.DOM_VK_E = 69;
flash.ui.Keyboard.DOM_VK_F = 70;
flash.ui.Keyboard.DOM_VK_G = 71;
flash.ui.Keyboard.DOM_VK_H = 72;
flash.ui.Keyboard.DOM_VK_I = 73;
flash.ui.Keyboard.DOM_VK_J = 74;
flash.ui.Keyboard.DOM_VK_K = 75;
flash.ui.Keyboard.DOM_VK_L = 76;
flash.ui.Keyboard.DOM_VK_M = 77;
flash.ui.Keyboard.DOM_VK_N = 78;
flash.ui.Keyboard.DOM_VK_O = 79;
flash.ui.Keyboard.DOM_VK_P = 80;
flash.ui.Keyboard.DOM_VK_Q = 81;
flash.ui.Keyboard.DOM_VK_R = 82;
flash.ui.Keyboard.DOM_VK_S = 83;
flash.ui.Keyboard.DOM_VK_T = 84;
flash.ui.Keyboard.DOM_VK_U = 85;
flash.ui.Keyboard.DOM_VK_V = 86;
flash.ui.Keyboard.DOM_VK_W = 87;
flash.ui.Keyboard.DOM_VK_X = 88;
flash.ui.Keyboard.DOM_VK_Y = 89;
flash.ui.Keyboard.DOM_VK_Z = 90;
flash.ui.Keyboard.DOM_VK_CONTEXT_MENU = 93;
flash.ui.Keyboard.DOM_VK_NUMPAD0 = 96;
flash.ui.Keyboard.DOM_VK_NUMPAD1 = 97;
flash.ui.Keyboard.DOM_VK_NUMPAD2 = 98;
flash.ui.Keyboard.DOM_VK_NUMPAD3 = 99;
flash.ui.Keyboard.DOM_VK_NUMPAD4 = 100;
flash.ui.Keyboard.DOM_VK_NUMPAD5 = 101;
flash.ui.Keyboard.DOM_VK_NUMPAD6 = 102;
flash.ui.Keyboard.DOM_VK_NUMPAD7 = 103;
flash.ui.Keyboard.DOM_VK_NUMPAD8 = 104;
flash.ui.Keyboard.DOM_VK_NUMPAD9 = 105;
flash.ui.Keyboard.DOM_VK_MULTIPLY = 106;
flash.ui.Keyboard.DOM_VK_ADD = 107;
flash.ui.Keyboard.DOM_VK_SEPARATOR = 108;
flash.ui.Keyboard.DOM_VK_SUBTRACT = 109;
flash.ui.Keyboard.DOM_VK_DECIMAL = 110;
flash.ui.Keyboard.DOM_VK_DIVIDE = 111;
flash.ui.Keyboard.DOM_VK_F1 = 112;
flash.ui.Keyboard.DOM_VK_F2 = 113;
flash.ui.Keyboard.DOM_VK_F3 = 114;
flash.ui.Keyboard.DOM_VK_F4 = 115;
flash.ui.Keyboard.DOM_VK_F5 = 116;
flash.ui.Keyboard.DOM_VK_F6 = 117;
flash.ui.Keyboard.DOM_VK_F7 = 118;
flash.ui.Keyboard.DOM_VK_F8 = 119;
flash.ui.Keyboard.DOM_VK_F9 = 120;
flash.ui.Keyboard.DOM_VK_F10 = 121;
flash.ui.Keyboard.DOM_VK_F11 = 122;
flash.ui.Keyboard.DOM_VK_F12 = 123;
flash.ui.Keyboard.DOM_VK_F13 = 124;
flash.ui.Keyboard.DOM_VK_F14 = 125;
flash.ui.Keyboard.DOM_VK_F15 = 126;
flash.ui.Keyboard.DOM_VK_F16 = 127;
flash.ui.Keyboard.DOM_VK_F17 = 128;
flash.ui.Keyboard.DOM_VK_F18 = 129;
flash.ui.Keyboard.DOM_VK_F19 = 130;
flash.ui.Keyboard.DOM_VK_F20 = 131;
flash.ui.Keyboard.DOM_VK_F21 = 132;
flash.ui.Keyboard.DOM_VK_F22 = 133;
flash.ui.Keyboard.DOM_VK_F23 = 134;
flash.ui.Keyboard.DOM_VK_F24 = 135;
flash.ui.Keyboard.DOM_VK_NUM_LOCK = 144;
flash.ui.Keyboard.DOM_VK_SCROLL_LOCK = 145;
flash.ui.Keyboard.DOM_VK_COMMA = 188;
flash.ui.Keyboard.DOM_VK_PERIOD = 190;
flash.ui.Keyboard.DOM_VK_SLASH = 191;
flash.ui.Keyboard.DOM_VK_BACK_QUOTE = 192;
flash.ui.Keyboard.DOM_VK_OPEN_BRACKET = 219;
flash.ui.Keyboard.DOM_VK_BACK_SLASH = 220;
flash.ui.Keyboard.DOM_VK_CLOSE_BRACKET = 221;
flash.ui.Keyboard.DOM_VK_QUOTE = 222;
flash.ui.Keyboard.DOM_VK_META = 224;
flash.ui.Keyboard.DOM_VK_KANA = 21;
flash.ui.Keyboard.DOM_VK_HANGUL = 21;
flash.ui.Keyboard.DOM_VK_JUNJA = 23;
flash.ui.Keyboard.DOM_VK_FINAL = 24;
flash.ui.Keyboard.DOM_VK_HANJA = 25;
flash.ui.Keyboard.DOM_VK_KANJI = 25;
flash.ui.Keyboard.DOM_VK_CONVERT = 28;
flash.ui.Keyboard.DOM_VK_NONCONVERT = 29;
flash.ui.Keyboard.DOM_VK_ACEPT = 30;
flash.ui.Keyboard.DOM_VK_MODECHANGE = 31;
flash.ui.Keyboard.DOM_VK_SELECT = 41;
flash.ui.Keyboard.DOM_VK_PRINT = 42;
flash.ui.Keyboard.DOM_VK_EXECUTE = 43;
flash.ui.Keyboard.DOM_VK_SLEEP = 95;
flash.utils.Endian.BIG_ENDIAN = "bigEndian";
flash.utils.Endian.LITTLE_ENDIAN = "littleEndian";
flash.utils.Uuid.UID_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
haxe.Template.splitter = new EReg("(::[A-Za-z0-9_ ()&|!+=/><*.\"-]+::|\\$\\$([A-Za-z0-9_-]+)\\()","");
haxe.Template.expr_splitter = new EReg("(\\(|\\)|[ \r\n\t]*\"[^\"]*\"[ \r\n\t]*|[!+=/><*.&|-]+)","");
haxe.Template.expr_trim = new EReg("^[ ]*([^ ]+)[ ]*$","");
haxe.Template.expr_int = new EReg("^[0-9]+$","");
haxe.Template.expr_float = new EReg("^([+-]?)(?=\\d|,\\d)\\d*(,\\d*)?([Ee]([+-]?\\d+))?$","");
haxe.Template.globals = { };
haxe.Unserializer.DEFAULT_RESOLVER = Type;
haxe.Unserializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:";
haxe.ds.ObjectMap.count = 0;
js.Browser.window = typeof window != "undefined" ? window : null;
js.Browser.document = typeof window != "undefined" ? window.document : null;
mloader.LoaderQueue.DEFAULT_MAX_LOADING = 8;
motion.actuators.SimpleActuator.actuators = new Array();
motion.actuators.SimpleActuator.actuatorsLength = 0;
motion.actuators.SimpleActuator.addedEvent = false;
motion.Actuate.defaultActuator = motion.actuators.SimpleActuator;
motion.Actuate.defaultEase = motion.easing.Expo.get_easeOut();
motion.Actuate.targetLibraries = new haxe.ds.ObjectMap();
nme.AssetData.className = new haxe.ds.StringMap();
nme.AssetData.library = new haxe.ds.StringMap();
nme.AssetData.path = new haxe.ds.StringMap();
nme.AssetData.type = new haxe.ds.StringMap();
nme.AssetData.initialized = false;
openfl.Assets.cachedBitmapData = new haxe.ds.StringMap();
openfl.Assets.initialized = false;
openfl.display.Tilesheet.TILE_SCALE = 1;
openfl.display.Tilesheet.TILE_ROTATION = 2;
openfl.display.Tilesheet.TILE_RGB = 4;
openfl.display.Tilesheet.TILE_ALPHA = 8;
openfl.display.Tilesheet.TILE_TRANS_2x2 = 16;
openfl.display.Tilesheet.TILE_BLEND_NORMAL = 0;
openfl.display.Tilesheet.TILE_BLEND_ADD = 65536;
openfl.display.Tilesheet.TILE_BLEND_MULTIPLY = 131072;
openfl.display.Tilesheet.TILE_BLEND_SCREEN = 262144;
pgr.gconsole.GCCommands.GC_LOG_ERR = "";
pgr.gconsole.GCCommands.GC_LOG_WAR = "";
pgr.gconsole.GCCommands._variables = new Array();
pgr.gconsole.GCCommands._functions = new Array();
pgr.gconsole.GCThemes.YELLOW_THEME = { consBgColor : 139, promptBgColor : 0, consTxtColor : 16766720, promptTxtColor : 16766720, monTxtColor : 16776960, monBgColor : 36, consBgAlpha : .7, consTxtAlpha : .7, monBgAlpha : .7, monTxtAlpha : .7};
pgr.gconsole.GCThemes.GREEN_THEME = { consBgColor : 0, promptBgColor : 0, consTxtColor : 65280, promptTxtColor : 65280, monTxtColor : 5635925, monBgColor : 0, consBgAlpha : .7, consTxtAlpha : .7, monBgAlpha : .7, monTxtAlpha : .7};
pgr.gconsole.GCThemes.BLUE_THEME = { consBgColor : 0, promptBgColor : 0, consTxtColor : 65535, promptTxtColor : 65535, monTxtColor : 5592575, monBgColor : 0, consBgAlpha : .7, consTxtAlpha : .7, monBgAlpha : .7, monTxtAlpha : .7};
pgr.gconsole.GCThemes.DEFAULT_THEME = { consBgColor : 10066329, promptBgColor : 10066329, consTxtColor : 0, promptTxtColor : 0, monTxtColor : 16777215, monBgColor : 0, consBgAlpha : .7, consTxtAlpha : .7, monBgAlpha : .7, monTxtAlpha : .7};
pgr.gconsole.GConsole.GC_TRC_ERR = "gc_error: ";
pgr.gconsole.GConsole.ALIGN_DOWN = "DOWN";
pgr.gconsole.GConsole.ALIGN_UP = "UP";
pgr.gconsole.GameConsole.ALIGN_DOWN = "DOWN";
pgr.gconsole.GameConsole.ALIGN_UP = "UP";
ru.stablex.ui.UIBuilder.defaults = new haxe.ds.StringMap();
ru.stablex.ui.UIBuilder._objects = new haxe.ds.StringMap();
ru.stablex.ui.UIBuilder.skins = new haxe.ds.StringMap();
ru.stablex.ui.UIBuilder._nextId = 0;
ru.stablex.ui.UIBuilder._skinQueue = new List();
ru.stablex.ui.events.ScrollEvent.BEFORE_SCROLL = "scrollBefore";
ru.stablex.ui.events.WidgetEvent.CREATE = "widgetCreate";
ru.stablex.ui.events.WidgetEvent.FREE = "widgetFree";
ru.stablex.ui.events.WidgetEvent.RESIZE = "widgetResize";
ru.stablex.ui.events.WidgetEvent.INITIAL_RESIZE = "widgetInitialResize";
ru.stablex.ui.events.WidgetEvent.CHANGE = "widgetChange";
ru.stablex.ui.events.WidgetEvent.SCROLL_START = "widgetScrollStart";
ru.stablex.ui.events.WidgetEvent.SCROLL_STOP = "widgetScrollStop";
ru.stablex.ui.widgets.Widget._X_USE_LEFT = 1;
ru.stablex.ui.widgets.Widget._X_USE_LEFT_PERCENT = 2;
ru.stablex.ui.widgets.Widget._X_USE_RIGHT = 3;
ru.stablex.ui.widgets.Widget._X_USE_RIGHT_PERCENT = 4;
ru.stablex.ui.widgets.Widget._Y_USE_TOP = 5;
ru.stablex.ui.widgets.Widget._Y_USE_TOP_PERCENT = 6;
ru.stablex.ui.widgets.Widget._Y_USE_BOTTOM = 7;
ru.stablex.ui.widgets.Widget._Y_USE_BOTTOM_PERCENT = 8;
sx.data.ScoreLoader.HOST = "http://scorxdev.azurewebsites.net/";
ApplicationMain.main();
})();

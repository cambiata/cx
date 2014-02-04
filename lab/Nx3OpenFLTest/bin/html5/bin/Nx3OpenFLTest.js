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
	var resourcePrefix = "__ASSET__:bitmap_";
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
			var loader = ApplicationMain.loaders.get(path);
			loader.contentLoaderInfo.addEventListener("complete",ApplicationMain.loader_onComplete);
			loader.load(new flash.net.URLRequest(path));
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
	if(Reflect.field(nx3.test.openfl.Main,"main") == null) {
		var mainDisplayObj = Type.createInstance(DocumentClass,[]);
		if(js.Boot.__instanceof(mainDisplayObj,flash.display.DisplayObject)) flash.Lib.get_current().addChild(mainDisplayObj);
	} else Reflect.field(nx3.test.openfl.Main,"main").apply(nx3.test.openfl.Main,[]);
}
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
	if(target != null) this.__target = target; else this.__target = this;
	this.__eventMap = [];
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
		this.__eventMap[type] = list;
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
		return this.__eventMap[type];
	}
	,existList: function(type) {
		return this.__eventMap != null && this.__eventMap[type] != undefined;
	}
	,dispatchEvent: function(event) {
		if(event.target == null) event.target = this.__target;
		var capture = event.eventPhase == flash.events.EventPhase.CAPTURING_PHASE;
		if(this.existList(event.type)) {
			var list = this.getList(event.type);
			var idx = 0;
			while(idx < list.length) {
				var listener = list[idx];
				if(listener.mUseCapture == capture) {
					listener.dispatchEvent(event);
					if(event.__getIsCancelledNow()) return true;
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
	,__eventMap: null
	,__target: null
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
	this.___id = flash.utils.Uuid.uuid();
	this.set_parent(null);
	this.set_transform(new flash.geom.Transform(this));
	this.__x = 0.0;
	this.__y = 0.0;
	this.__scaleX = 1.0;
	this.__scaleY = 1.0;
	this.__rotation = 0.0;
	this.__width = 0.0;
	this.__height = 0.0;
	this.set_visible(true);
	this.alpha = 1.0;
	this.__filters = new Array();
	this.__boundsRect = new flash.geom.Rectangle();
	this.__scrollRect = null;
	this.__mask = null;
	this.__maskingObj = null;
	this.set___combinedVisible(this.get_visible());
};
$hxClasses["flash.display.DisplayObject"] = flash.display.DisplayObject;
flash.display.DisplayObject.__name__ = ["flash","display","DisplayObject"];
flash.display.DisplayObject.__interfaces__ = [flash.display.IBitmapDrawable];
flash.display.DisplayObject.__super__ = flash.events.EventDispatcher;
flash.display.DisplayObject.prototype = $extend(flash.events.EventDispatcher.prototype,{
	__srUpdateDivs: function() {
		var gfx = this.__getGraphics();
		if(gfx == null || this.parent == null) return;
		if(this.__scrollRect == null) {
			if(this._srAxes != null && gfx.__surface.parentNode == this._srAxes && this._srWindow.parentNode != null) this._srWindow.parentNode.replaceChild(gfx.__surface,this._srWindow);
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
		this._srWindow.style.width = this.__scrollRect.width + "px";
		this._srWindow.style.height = this.__scrollRect.height + "px";
		this._srAxes.style.left = -pnt.x - this.__scrollRect.x + "px";
		this._srAxes.style.top = -pnt.y - this.__scrollRect.y + "px";
		if(gfx.__surface.parentNode != this._srAxes && gfx.__surface.parentNode != null) {
			gfx.__surface.parentNode.insertBefore(this._srWindow,gfx.__surface);
			flash.Lib.__removeSurface(gfx.__surface);
			this._srAxes.appendChild(gfx.__surface);
		}
	}
	,__getSrWindow: function() {
		return this._srWindow;
	}
	,set_width: function(inValue) {
		if(this.get__boundsInvalid()) this.validateBounds();
		var w = this.__boundsRect.width;
		if(this.__scaleX * w != inValue) {
			if(w == 0) {
				this.__scaleX = 1;
				this.__invalidateMatrix(true);
				this.___renderFlags |= 64;
				if(this.parent != null) this.parent.___renderFlags |= 64;
				w = this.__boundsRect.width;
			}
			if(w <= 0) return 0;
			this.__scaleX = inValue / w;
			this.__invalidateMatrix(true);
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
		}
		return inValue;
	}
	,get_width: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.__width;
	}
	,set_y: function(inValue) {
		if(this.__y != inValue) {
			this.__y = inValue;
			this.__invalidateMatrix(true);
			if(this.parent != null) this.parent.__invalidateBounds();
		}
		return inValue;
	}
	,get_y: function() {
		return this.__y;
	}
	,set_x: function(inValue) {
		if(this.__x != inValue) {
			this.__x = inValue;
			this.__invalidateMatrix(true);
			if(this.parent != null) this.parent.__invalidateBounds();
		}
		return inValue;
	}
	,get_x: function() {
		return this.__x;
	}
	,set_visible: function(inValue) {
		if(this.__visible != inValue) {
			this.__visible = inValue;
			this.setSurfaceVisible(inValue);
		}
		return this.__visible;
	}
	,get_visible: function() {
		return this.__visible;
	}
	,set_transform: function(inValue) {
		this.transform = inValue;
		this.__x = this.transform.get_matrix().tx;
		this.__y = this.transform.get_matrix().ty;
		this.__invalidateMatrix(true);
		return inValue;
	}
	,get__topmostSurface: function() {
		var gfx = this.__getGraphics();
		if(gfx != null) return gfx.__surface;
		return null;
	}
	,get_stage: function() {
		var gfx = this.__getGraphics();
		if(gfx != null) return flash.Lib.__getStage();
		return null;
	}
	,set_scrollRect: function(inValue) {
		this.__scrollRect = inValue;
		this.__srUpdateDivs();
		return inValue;
	}
	,get_scrollRect: function() {
		if(this.__scrollRect == null) return null;
		return this.__scrollRect.clone();
	}
	,set_scaleY: function(inValue) {
		if(this.__scaleY != inValue) {
			this.__scaleY = inValue;
			this.__invalidateMatrix(true);
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
		}
		return inValue;
	}
	,get_scaleY: function() {
		return this.__scaleY;
	}
	,set_scaleX: function(inValue) {
		if(this.__scaleX != inValue) {
			this.__scaleX = inValue;
			this.__invalidateMatrix(true);
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
		}
		return inValue;
	}
	,get_scaleX: function() {
		return this.__scaleX;
	}
	,set_rotation: function(inValue) {
		if(this.__rotation != inValue) {
			this.__rotation = inValue;
			this.__invalidateMatrix(true);
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
		}
		return inValue;
	}
	,get_rotation: function() {
		return this.__rotation;
	}
	,set_parent: function(inValue) {
		if(inValue == this.parent) return inValue;
		this.__invalidateMatrix();
		if(this.parent != null) {
			HxOverrides.remove(this.parent.__children,this);
			this.parent.__invalidateBounds();
		}
		if(inValue != null) {
			inValue.___renderFlags |= 64;
			if(inValue.parent != null) inValue.parent.___renderFlags |= 64;
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
	,set___combinedVisible: function(inValue) {
		if(this.__combinedVisible != inValue) {
			this.__combinedVisible = inValue;
			this.setSurfaceVisible(inValue);
		}
		return this.__combinedVisible;
	}
	,get_mouseY: function() {
		return this.globalToLocal(new flash.geom.Point(0,this.get_stage().get_mouseY())).y;
	}
	,get_mouseX: function() {
		return this.globalToLocal(new flash.geom.Point(this.get_stage().get_mouseX(),0)).x;
	}
	,get__matrixInvalid: function() {
		return (this.___renderFlags & 4) != 0;
	}
	,get__matrixChainInvalid: function() {
		return (this.___renderFlags & 8) != 0;
	}
	,set_mask: function(inValue) {
		if(this.__mask != null) this.__mask.__maskingObj = null;
		this.__mask = inValue;
		if(this.__mask != null) this.__mask.__maskingObj = this;
		return this.__mask;
	}
	,get_mask: function() {
		return this.__mask;
	}
	,set_height: function(inValue) {
		if(this.get__boundsInvalid()) this.validateBounds();
		var h = this.__boundsRect.height;
		if(this.__scaleY * h != inValue) {
			if(h == 0) {
				this.__scaleY = 1;
				this.__invalidateMatrix(true);
				this.___renderFlags |= 64;
				if(this.parent != null) this.parent.___renderFlags |= 64;
				h = this.__boundsRect.height;
			}
			if(h <= 0) return 0;
			this.__scaleY = inValue / h;
			this.__invalidateMatrix(true);
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
		}
		return inValue;
	}
	,get_height: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.__height;
	}
	,set_filters: function(filters) {
		var oldFilterCount = this.__filters == null?0:this.__filters.length;
		if(filters == null) {
			this.__filters = null;
			if(oldFilterCount > 0) this.invalidateGraphics();
		} else {
			this.__filters = new Array();
			var _g = 0;
			while(_g < filters.length) {
				var filter = filters[_g];
				++_g;
				this.__filters.push(filter.clone());
			}
			this.invalidateGraphics();
		}
		return filters;
	}
	,get__boundsInvalid: function() {
		var gfx = this.__getGraphics();
		if(gfx == null) return (this.___renderFlags & 64) != 0; else return (this.___renderFlags & 64) != 0 || gfx.boundsDirty;
	}
	,get_filters: function() {
		if(this.__filters == null) return [];
		var result = new Array();
		var _g = 0, _g1 = this.__filters;
		while(_g < _g1.length) {
			var filter = _g1[_g];
			++_g;
			result.push(filter.clone());
		}
		return result;
	}
	,get__bottommostSurface: function() {
		var gfx = this.__getGraphics();
		if(gfx != null) return gfx.__surface;
		return null;
	}
	,__validateMatrix: function() {
		var parentMatrixInvalid = (this.___renderFlags & 8) != 0 && this.parent != null;
		if((this.___renderFlags & 4) != 0 || parentMatrixInvalid) {
			if(parentMatrixInvalid) this.parent.__validateMatrix();
			var m = this.transform.get_matrix();
			if((this.___renderFlags & 16) != 0) this.___renderFlags &= -5;
			if((this.___renderFlags & 4) != 0) {
				m.identity();
				m.scale(this.__scaleX,this.__scaleY);
				var rad = this.__rotation * flash.geom.Transform.DEG_TO_RAD;
				if(rad != 0.0) m.rotate(rad);
				m.translate(this.__x,this.__y);
				this.transform._matrix.copy(m);
				m;
			}
			var cm = this.transform.__getFullMatrix(null);
			var fm = this.parent == null?m:this.parent.transform.__getFullMatrix(m);
			this._fullScaleX = fm._sx;
			this._fullScaleY = fm._sy;
			if(cm.a != fm.a || cm.b != fm.b || cm.c != fm.c || cm.d != fm.d || cm.tx != fm.tx || cm.ty != fm.ty) {
				this.transform.__setFullMatrix(fm);
				this.___renderFlags |= 32;
			}
			this.___renderFlags &= -29;
		}
	}
	,__unifyChildrenWithDOM: function(lastMoveObj) {
		var gfx = this.__getGraphics();
		if(gfx != null && lastMoveObj != null && this != lastMoveObj) {
			var ogfx = lastMoveObj.__getGraphics();
			if(ogfx != null) flash.Lib.__setSurfaceZIndexAfter(this.__scrollRect == null?gfx.__surface:this._srWindow,lastMoveObj.__scrollRect == null?ogfx.__surface:lastMoveObj == this.parent?ogfx.__surface:lastMoveObj._srWindow);
		}
		if(gfx == null) return lastMoveObj; else return this;
	}
	,__testFlag: function(mask) {
		return (this.___renderFlags & mask) != 0;
	}
	,__setMatrix: function(inValue) {
		this.transform._matrix.copy(inValue);
		return inValue;
	}
	,__setFullMatrix: function(inValue) {
		return this.transform.__setFullMatrix(inValue);
	}
	,__setFlagToValue: function(mask,value) {
		if(value) this.___renderFlags |= mask; else this.___renderFlags &= ~mask;
	}
	,__setFlag: function(mask) {
		this.___renderFlags |= mask;
	}
	,__setDimensions: function() {
		if(this.scale9Grid != null) {
			this.__boundsRect.width *= this.__scaleX;
			this.__boundsRect.height *= this.__scaleY;
			this.__width = this.__boundsRect.width;
			this.__height = this.__boundsRect.height;
		} else {
			this.__width = this.__boundsRect.width * this.__scaleX;
			this.__height = this.__boundsRect.height * this.__scaleY;
		}
	}
	,__render: function(inMask,clipRect) {
		if(!this.__combinedVisible) return;
		var gfx = this.__getGraphics();
		if(gfx == null) return;
		if((this.___renderFlags & 4) != 0 || (this.___renderFlags & 8) != 0) this.__validateMatrix();
		if(gfx.__render(inMask,this.__filters,1,1)) {
			this.___renderFlags |= 64;
			if(this.parent != null) this.parent.___renderFlags |= 64;
			this.__applyFilters(gfx.__surface);
			this.___renderFlags |= 32;
		}
		var fullAlpha = (this.parent != null?this.parent.__combinedAlpha:1) * this.alpha;
		if(inMask != null) {
			var m = this.getSurfaceTransform(gfx);
			flash.Lib.__drawToSurface(gfx.__surface,inMask,m,fullAlpha,clipRect);
		} else {
			if((this.___renderFlags & 32) != 0) {
				var m = this.getSurfaceTransform(gfx);
				flash.Lib.__setSurfaceTransform(gfx.__surface,m);
				this.___renderFlags &= -33;
				this.__srUpdateDivs();
			}
			flash.Lib.__setSurfaceOpacity(gfx.__surface,fullAlpha);
		}
	}
	,__removeFromStage: function() {
		var gfx = this.__getGraphics();
		if(gfx != null && flash.Lib.__isOnStage(gfx.__surface)) {
			flash.Lib.__removeSurface(gfx.__surface);
			var evt = new flash.events.Event(flash.events.Event.REMOVED_FROM_STAGE,false,false);
			this.dispatchEvent(evt);
		}
	}
	,__matrixOverridden: function() {
		this.__x = this.transform.get_matrix().tx;
		this.__y = this.transform.get_matrix().ty;
		this.___renderFlags |= 16;
		this.___renderFlags |= 4;
		this.___renderFlags |= 64;
		if(this.parent != null) this.parent.___renderFlags |= 64;
	}
	,__isOnStage: function() {
		var gfx = this.__getGraphics();
		if(gfx != null && flash.Lib.__isOnStage(gfx.__surface)) return true;
		return false;
	}
	,__invalidateMatrix: function(local) {
		if(local == null) local = false;
		if(local) this.___renderFlags |= 4; else this.___renderFlags |= 8;
	}
	,__invalidateBounds: function() {
		this.___renderFlags |= 64;
		if(this.parent != null) this.parent.___renderFlags |= 64;
	}
	,__getSurface: function() {
		var gfx = this.__getGraphics();
		var surface = null;
		if(gfx != null) surface = gfx.__surface;
		return surface;
	}
	,__getObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null;
		var gfx = this.__getGraphics();
		if(gfx != null) {
			gfx.__render();
			var extX = gfx.__extent.x;
			var extY = gfx.__extent.y;
			var local = this.globalToLocal(point);
			if(local.x - extX <= 0 || local.y - extY <= 0 || (local.x - extX) * this.get_scaleX() > this.get_width() || (local.y - extY) * this.get_scaleY() > this.get_height()) return null;
			if(gfx.__hitTest(local.x,local.y)) return this;
		}
		return null;
	}
	,__getMatrix: function() {
		return this.transform.get_matrix();
	}
	,__getInteractiveObjectStack: function(outStack) {
		var io = this;
		if(io != null) outStack.push(io);
		if(this.parent != null) this.parent.__getInteractiveObjectStack(outStack);
	}
	,__getGraphics: function() {
		return null;
	}
	,__getFullMatrix: function(localMatrix) {
		return this.transform.__getFullMatrix(localMatrix);
	}
	,__fireEvent: function(event) {
		var stack = [];
		if(this.parent != null) this.parent.__getInteractiveObjectStack(stack);
		var l = stack.length;
		if(l > 0) {
			event.__setPhase(flash.events.EventPhase.CAPTURING_PHASE);
			stack.reverse();
			var _g = 0;
			while(_g < stack.length) {
				var obj = stack[_g];
				++_g;
				event.currentTarget = obj;
				obj.__dispatchEvent(event);
				if(event.__getIsCancelled()) return;
			}
		}
		event.__setPhase(flash.events.EventPhase.AT_TARGET);
		event.currentTarget = this;
		this.__dispatchEvent(event);
		if(event.__getIsCancelled()) return;
		if(event.bubbles) {
			event.__setPhase(flash.events.EventPhase.BUBBLING_PHASE);
			stack.reverse();
			var _g = 0;
			while(_g < stack.length) {
				var obj = stack[_g];
				++_g;
				event.currentTarget = obj;
				obj.__dispatchEvent(event);
				if(event.__getIsCancelled()) return;
			}
		}
	}
	,__dispatchEvent: function(event) {
		if(event.target == null) event.target = this;
		event.currentTarget = this;
		return flash.events.EventDispatcher.prototype.dispatchEvent.call(this,event);
	}
	,__contains: function(child) {
		return false;
	}
	,__clearFlag: function(mask) {
		this.___renderFlags &= ~mask;
	}
	,__broadcast: function(event) {
		this.__dispatchEvent(event);
	}
	,__applyFilters: function(surface) {
		if(this.__filters != null) {
			var _g = 0, _g1 = this.__filters;
			while(_g < _g1.length) {
				var filter = _g1[_g];
				++_g;
				filter.__applyFilter(surface);
			}
		}
	}
	,__addToStage: function(newParent,beforeSibling) {
		var gfx = this.__getGraphics();
		if(gfx == null) return;
		if(newParent.__getGraphics() != null) {
			flash.Lib.__setSurfaceId(gfx.__surface,this.___id);
			if(beforeSibling != null && beforeSibling.__getGraphics() != null) flash.Lib.__appendSurface(gfx.__surface,beforeSibling.get__bottommostSurface()); else {
				var stageChildren = [];
				var _g = 0, _g1 = newParent.__children;
				while(_g < _g1.length) {
					var child = _g1[_g];
					++_g;
					if(child.get_stage() != null) stageChildren.push(child);
				}
				if(stageChildren.length < 1) flash.Lib.__appendSurface(gfx.__surface,null,newParent.get__topmostSurface()); else {
					var nextSibling = stageChildren[stageChildren.length - 1];
					var container;
					while(js.Boot.__instanceof(nextSibling,flash.display.DisplayObjectContainer)) {
						container = js.Boot.__cast(nextSibling , flash.display.DisplayObjectContainer);
						if(container.__children.length > 0) nextSibling = container.__children[container.__children.length - 1]; else break;
					}
					if(nextSibling.__getGraphics() != gfx) flash.Lib.__appendSurface(gfx.__surface,null,nextSibling.get__topmostSurface()); else flash.Lib.__appendSurface(gfx.__surface);
				}
			}
			flash.Lib.__setSurfaceTransform(gfx.__surface,this.getSurfaceTransform(gfx));
		} else if(newParent.name == "Stage") flash.Lib.__appendSurface(gfx.__surface);
		if(this.__isOnStage()) {
			this.__srUpdateDivs();
			var evt = new flash.events.Event(flash.events.Event.ADDED_TO_STAGE,false,false);
			this.dispatchEvent(evt);
		}
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			var gfx = this.__getGraphics();
			if(gfx == null) {
				this.__boundsRect.x = this.get_x();
				this.__boundsRect.y = this.get_y();
				this.__boundsRect.width = 0;
				this.__boundsRect.height = 0;
			} else {
				this.__boundsRect = gfx.__extent.clone();
				if(this.scale9Grid != null) {
					this.__boundsRect.width *= this.__scaleX;
					this.__boundsRect.height *= this.__scaleY;
					this.__width = this.__boundsRect.width;
					this.__height = this.__boundsRect.height;
				} else {
					this.__width = this.__boundsRect.width * this.__scaleX;
					this.__height = this.__boundsRect.height * this.__scaleY;
				}
				gfx.boundsDirty = false;
			}
			this.___renderFlags &= -65;
		}
	}
	,toString: function() {
		return "[DisplayObject name=" + this.name + " id=" + this.___id + "]";
	}
	,setSurfaceVisible: function(inValue) {
		var gfx = this.__getGraphics();
		if(gfx != null && gfx.__surface != null) flash.Lib.__setSurfaceVisible(gfx.__surface,inValue);
	}
	,localToGlobal: function(point) {
		if((this.___renderFlags & 4) != 0 || (this.___renderFlags & 8) != 0) this.__validateMatrix();
		return this.transform.__getFullMatrix(null).transformPoint(point);
	}
	,invalidateGraphics: function() {
		var gfx = this.__getGraphics();
		if(gfx != null) {
			gfx.__changed = true;
			gfx.__clearNextCycle = true;
		}
	}
	,hitTestPoint: function(x,y,shapeFlag) {
		if(shapeFlag == null) shapeFlag = false;
		var boundingBox = shapeFlag == null?true:!shapeFlag;
		if(!boundingBox) return this.__getObjectUnderPoint(new flash.geom.Point(x,y)) != null; else {
			var gfx = this.__getGraphics();
			if(gfx != null) {
				var extX = gfx.__extent.x;
				var extY = gfx.__extent.y;
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
		this.___renderFlags |= 64;
		if(this.parent != null) this.parent.___renderFlags |= 64;
		this.__applyFilters(gfx.__surface);
		this.___renderFlags |= 32;
	}
	,globalToLocal: function(inPos) {
		if((this.___renderFlags & 4) != 0 || (this.___renderFlags & 8) != 0) this.__validateMatrix();
		return this.transform.__getFullMatrix(null).invert().transformPoint(inPos);
	}
	,getSurfaceTransform: function(gfx) {
		var extent = gfx.__extentWithFilters;
		var fm = this.transform.__getFullMatrix(null);
		fm.__translateTransformed(extent.get_topLeft());
		return fm;
	}
	,getScreenBounds: function() {
		if(this.get__boundsInvalid()) this.validateBounds();
		return this.__boundsRect.clone();
	}
	,getRect: function(targetCoordinateSpace) {
		return this.getBounds(targetCoordinateSpace);
	}
	,getBounds: function(targetCoordinateSpace) {
		if((this.___renderFlags & 4) != 0 || (this.___renderFlags & 8) != 0) this.__validateMatrix();
		if(this.get__boundsInvalid()) this.validateBounds();
		var m = this.transform.__getFullMatrix(null);
		if(targetCoordinateSpace != null) m.concat(targetCoordinateSpace.transform.__getFullMatrix(null).invert());
		var rect = this.__boundsRect.transform(m);
		return rect;
	}
	,drawToSurface: function(inSurface,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		var oldAlpha = this.alpha;
		this.alpha = 1;
		this.__render(inSurface,clipRect);
		this.alpha = oldAlpha;
	}
	,dispatchEvent: function(event) {
		var result = this.__dispatchEvent(event);
		if(event.__getIsCancelled()) return true;
		if(event.bubbles && this.parent != null) this.parent.dispatchEvent(event);
		return result;
	}
	,_srAxes: null
	,_srWindow: null
	,_topmostSurface: null
	,___renderFlags: null
	,___id: null
	,_fullScaleY: null
	,_fullScaleX: null
	,_bottommostSurface: null
	,__y: null
	,__x: null
	,__width: null
	,__visible: null
	,__scrollRect: null
	,__scaleY: null
	,__scaleX: null
	,__rotation: null
	,__maskingObj: null
	,__mask: null
	,__height: null
	,__filters: null
	,__boundsRect: null
	,__combinedVisible: null
	,transform: null
	,scale9Grid: null
	,parent: null
	,name: null
	,loaderInfo: null
	,cacheAsBitmap: null
	,blendMode: null
	,alpha: null
	,accessibilityProperties: null
	,__class__: flash.display.DisplayObject
	,__properties__: {set_filters:"set_filters",get_filters:"get_filters",set_height:"set_height",get_height:"get_height",set_mask:"set_mask",get_mask:"get_mask",get_mouseX:"get_mouseX",get_mouseY:"get_mouseY",set_parent:"set_parent",set_rotation:"set_rotation",get_rotation:"get_rotation",set_scaleX:"set_scaleX",get_scaleX:"get_scaleX",set_scaleY:"set_scaleY",get_scaleY:"get_scaleY",set_scrollRect:"set_scrollRect",get_scrollRect:"get_scrollRect",get_stage:"get_stage",set_transform:"set_transform",set_visible:"set_visible",get_visible:"get_visible",set_width:"set_width",get_width:"get_width",set_x:"set_x",get_x:"get_x",set_y:"set_y",get_y:"get_y",set___combinedVisible:"set___combinedVisible",get__bottommostSurface:"get__bottommostSurface",get__boundsInvalid:"get__boundsInvalid",get__matrixChainInvalid:"get__matrixChainInvalid",get__matrixInvalid:"get__matrixInvalid",get__topmostSurface:"get__topmostSurface"}
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
		return this.__tabIndex = inIndex;
	}
	,get_tabIndex: function() {
		return this.__tabIndex;
	}
	,__getObjectUnderPoint: function(point) {
		if(!this.mouseEnabled) return null; else return flash.display.DisplayObject.prototype.__getObjectUnderPoint.call(this,point);
	}
	,toString: function() {
		return "[InteractiveObject name=" + this.name + " id=" + this.___id + "]";
	}
	,__tabIndex: null
	,__doubleClickEnabled: null
	,tabEnabled: null
	,mouseEnabled: null
	,focusRect: null
	,doubleClickEnabled: null
	,__class__: flash.display.InteractiveObject
	,__properties__: $extend(flash.display.DisplayObject.prototype.__properties__,{set_tabIndex:"set_tabIndex",get_tabIndex:"get_tabIndex"})
});
flash.display.DisplayObjectContainer = function() {
	this.__children = new Array();
	this.mouseChildren = true;
	this.tabChildren = true;
	flash.display.InteractiveObject.call(this);
	this.__combinedAlpha = this.alpha;
};
$hxClasses["flash.display.DisplayObjectContainer"] = flash.display.DisplayObjectContainer;
flash.display.DisplayObjectContainer.__name__ = ["flash","display","DisplayObjectContainer"];
flash.display.DisplayObjectContainer.__super__ = flash.display.InteractiveObject;
flash.display.DisplayObjectContainer.prototype = $extend(flash.display.InteractiveObject.prototype,{
	set_scrollRect: function(inValue) {
		inValue = flash.display.InteractiveObject.prototype.set_scrollRect.call(this,inValue);
		this.__unifyChildrenWithDOM();
		return inValue;
	}
	,set_visible: function(inVal) {
		this.set___combinedVisible(this.parent != null?this.parent.__combinedVisible && inVal:inVal);
		return flash.display.InteractiveObject.prototype.set_visible.call(this,inVal);
	}
	,get_numChildren: function() {
		return this.__children.length;
	}
	,set___combinedVisible: function(inVal) {
		if(inVal != this.__combinedVisible) {
			var _g = 0, _g1 = this.__children;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				child.set___combinedVisible(child.get_visible() && inVal);
			}
		}
		return flash.display.InteractiveObject.prototype.set___combinedVisible.call(this,inVal);
	}
	,set_filters: function(filters) {
		flash.display.InteractiveObject.prototype.set_filters.call(this,filters);
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.set_filters(filters);
		}
		return filters;
	}
	,__unifyChildrenWithDOM: function(lastMoveObj) {
		var obj = flash.display.InteractiveObject.prototype.__unifyChildrenWithDOM.call(this,lastMoveObj);
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			obj = child.__unifyChildrenWithDOM(obj);
			if(child.get_scrollRect() != null) obj = child;
		}
		return obj;
	}
	,__swapSurface: function(c1,c2) {
		if(this.__children[c1] == null) throw "Null element at index " + c1 + " length " + this.__children.length;
		if(this.__children[c2] == null) throw "Null element at index " + c2 + " length " + this.__children.length;
		var gfx1 = this.__children[c1].__getGraphics();
		var gfx2 = this.__children[c2].__getGraphics();
		if(gfx1 != null && gfx2 != null) {
			var surface1 = this.__children[c1].__scrollRect == null?gfx1.__surface:this.__children[c1].__getSrWindow();
			var surface2 = this.__children[c2].__scrollRect == null?gfx2.__surface:this.__children[c2].__getSrWindow();
			if(surface1 != null && surface2 != null) flash.Lib.__swapSurface(surface1,surface2);
		}
	}
	,__render: function(inMask,clipRect) {
		if(!this.__visible) return;
		if(clipRect == null && this.__scrollRect != null) clipRect = this.__scrollRect;
		flash.display.InteractiveObject.prototype.__render.call(this,inMask,clipRect);
		this.__combinedAlpha = this.parent != null?this.parent.__combinedAlpha * this.alpha:this.alpha;
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.__visible) {
				if(clipRect != null) {
					if((child.___renderFlags & 4) != 0 || (child.___renderFlags & 8) != 0) child.__validateMatrix();
				}
				child.__render(inMask,clipRect);
			}
		}
		if(this.__addedChildren) {
			this.__unifyChildrenWithDOM();
			this.__addedChildren = false;
		}
	}
	,__removeFromStage: function() {
		flash.display.InteractiveObject.prototype.__removeFromStage.call(this);
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.__removeFromStage();
		}
	}
	,__removeChild: function(child) {
		HxOverrides.remove(this.__children,child);
		child.__removeFromStage();
		child.set_parent(null);
		if(this.getChildIndex(child) >= 0) throw "Not removed properly";
		return child;
	}
	,__invalidateMatrix: function(local) {
		if(local == null) local = false;
		if(!((this.___renderFlags & 8) != 0) && !((this.___renderFlags & 4) != 0)) {
			var _g = 0, _g1 = this.__children;
			while(_g < _g1.length) {
				var child = _g1[_g];
				++_g;
				child.__invalidateMatrix();
			}
		}
		flash.display.InteractiveObject.prototype.__invalidateMatrix.call(this,local);
	}
	,__getObjectsUnderPoint: function(point,stack) {
		var l = this.__children.length - 1;
		var _g1 = 0, _g = this.__children.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = this.__children[l - i].__getObjectUnderPoint(point);
			if(result != null) stack.push(result);
		}
	}
	,__getObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null;
		var l = this.__children.length - 1;
		var _g1 = 0, _g = this.__children.length;
		while(_g1 < _g) {
			var i = _g1++;
			var result = null;
			if(this.mouseEnabled) result = this.__children[l - i].__getObjectUnderPoint(point);
			if(result != null) return this.mouseChildren?result:this;
		}
		return flash.display.InteractiveObject.prototype.__getObjectUnderPoint.call(this,point);
	}
	,__contains: function(child) {
		if(child == null) return false;
		if(this == child) return true;
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c == child || c.__contains(child)) return true;
		}
		return false;
	}
	,__broadcast: function(event) {
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			child.__broadcast(event);
		}
		this.dispatchEvent(event);
	}
	,__addToStage: function(newParent,beforeSibling) {
		flash.display.InteractiveObject.prototype.__addToStage.call(this,newParent,beforeSibling);
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.__getGraphics() == null || !child.__isOnStage()) child.__addToStage(this);
		}
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.InteractiveObject.prototype.validateBounds.call(this);
			var _g = 0, _g1 = this.__children;
			while(_g < _g1.length) {
				var obj = _g1[_g];
				++_g;
				if(obj.get_visible()) {
					var r = obj.getBounds(this);
					if(r.width != 0 || r.height != 0) {
						if(this.__boundsRect.width == 0 && this.__boundsRect.height == 0) this.__boundsRect = r.clone(); else this.__boundsRect.extendBounds(r);
					}
				}
			}
			if(this.scale9Grid != null) {
				this.__boundsRect.width *= this.__scaleX;
				this.__boundsRect.height *= this.__scaleY;
				this.__width = this.__boundsRect.width;
				this.__height = this.__boundsRect.height;
			} else {
				this.__width = this.__boundsRect.width * this.__scaleX;
				this.__height = this.__boundsRect.height * this.__scaleY;
			}
		}
	}
	,toString: function() {
		return "[DisplayObjectContainer name=" + this.name + " id=" + this.___id + "]";
	}
	,swapChildrenAt: function(child1,child2) {
		var swap = this.__children[child1];
		this.__children[child1] = this.__children[child2];
		this.__children[child2] = swap;
		swap = null;
	}
	,swapChildren: function(child1,child2) {
		var c1 = -1;
		var c2 = -1;
		var swap;
		var _g1 = 0, _g = this.__children.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.__children[i] == child1) c1 = i; else if(this.__children[i] == child2) c2 = i;
		}
		if(c1 != -1 && c2 != -1) {
			swap = this.__children[c1];
			this.__children[c1] = this.__children[c2];
			this.__children[c2] = swap;
			swap = null;
			this.__swapSurface(c1,c2);
			child1.__unifyChildrenWithDOM();
			child2.__unifyChildrenWithDOM();
		}
	}
	,setChildIndex: function(child,index) {
		if(index > this.__children.length) throw "Invalid index position " + index;
		var oldIndex = this.getChildIndex(child);
		if(oldIndex < 0) {
			var msg = "setChildIndex : object " + child.name + " not found.";
			if(child.parent == this) {
				var realindex = -1;
				var _g1 = 0, _g = this.__children.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(this.__children[i] == child) {
						realindex = i;
						break;
					}
				}
				if(realindex != -1) msg += "Internal error: Real child index was " + Std.string(realindex); else msg += "Internal error: Child was not in __children array!";
			}
			throw msg;
		}
		if(index < oldIndex) {
			var i = oldIndex;
			while(i > index) {
				this.swapChildren(this.__children[i],this.__children[i - 1]);
				i--;
			}
		} else if(oldIndex < index) {
			var i = oldIndex;
			while(i < index) {
				this.swapChildren(this.__children[i],this.__children[i + 1]);
				i++;
			}
		}
	}
	,removeChildAt: function(index) {
		if(index >= 0 && index < this.__children.length) return this.__removeChild(this.__children[index]);
		throw "removeChildAt(" + index + ") : none found?";
	}
	,removeChild: function(inChild) {
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child == inChild) return (function($this) {
				var $r;
				HxOverrides.remove($this.__children,child);
				child.__removeFromStage();
				child.set_parent(null);
				if($this.getChildIndex(child) >= 0) throw "Not removed properly";
				$r = child;
				return $r;
			}(this));
		}
		throw "removeChild : none found?";
	}
	,getObjectsUnderPoint: function(point) {
		var result = new Array();
		this.__getObjectsUnderPoint(point,result);
		return result;
	}
	,getChildIndex: function(inChild) {
		var _g1 = 0, _g = this.__children.length;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.__children[i] == inChild) return i;
		}
		return -1;
	}
	,getChildByName: function(inName) {
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child.name == inName) return child;
		}
		return null;
	}
	,getChildAt: function(index) {
		if(index >= 0 && index < this.__children.length) return this.__children[index];
		throw "getChildAt : index out of bounds " + index + "/" + this.__children.length;
		return null;
	}
	,contains: function(child) {
		return this.__contains(child);
	}
	,addChildAt: function(object,index) {
		if(index > this.__children.length || index < 0) throw "Invalid index position " + index;
		this.__addedChildren = true;
		if(object.parent == this) {
			this.setChildIndex(object,index);
			return object;
		}
		if(index == this.__children.length) return this.addChild(object); else {
			if(this.__isOnStage()) object.__addToStage(this,this.__children[index]);
			this.__children.splice(index,0,object);
			object.set_parent(this);
		}
		return object;
	}
	,addChild: function(object) {
		if(object == null) throw "DisplayObjectContainer asked to add null child object";
		if(object == this) throw "Adding to self";
		this.__addedChildren = true;
		if(object.parent == this) {
			this.setChildIndex(object,this.__children.length - 1);
			return object;
		}
		var _g = 0, _g1 = this.__children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			if(child == object) throw "Internal error: child already existed at index " + this.getChildIndex(object);
		}
		object.set_parent(this);
		if(this.__isOnStage()) object.__addToStage(this);
		if(this.__children == null) this.__children = new Array();
		this.__children.push(object);
		return object;
	}
	,__addedChildren: null
	,__combinedAlpha: null
	,__children: null
	,tabChildren: null
	,mouseChildren: null
	,__class__: flash.display.DisplayObjectContainer
	,__properties__: $extend(flash.display.InteractiveObject.prototype.__properties__,{get_numChildren:"get_numChildren"})
});
flash.display.Sprite = function() {
	flash.display.DisplayObjectContainer.call(this);
	this.__graphics = new flash.display.Graphics();
	this.buttonMode = false;
};
$hxClasses["flash.display.Sprite"] = flash.display.Sprite;
flash.display.Sprite.__name__ = ["flash","display","Sprite"];
flash.display.Sprite.__super__ = flash.display.DisplayObjectContainer;
flash.display.Sprite.prototype = $extend(flash.display.DisplayObjectContainer.prototype,{
	set_useHandCursor: function(cursor) {
		if(cursor == this.useHandCursor) return cursor;
		if(this.__cursorCallbackOver != null) this.removeEventListener(flash.events.MouseEvent.ROLL_OVER,this.__cursorCallbackOver);
		if(this.__cursorCallbackOut != null) this.removeEventListener(flash.events.MouseEvent.ROLL_OUT,this.__cursorCallbackOut);
		if(!cursor) flash.Lib.__setCursor(flash._Lib.CursorType.Default); else {
			this.__cursorCallbackOver = function(_) {
				flash.Lib.__setCursor(flash._Lib.CursorType.Pointer);
			};
			this.__cursorCallbackOut = function(_) {
				flash.Lib.__setCursor(flash._Lib.CursorType.Default);
			};
			this.addEventListener(flash.events.MouseEvent.ROLL_OVER,this.__cursorCallbackOver);
			this.addEventListener(flash.events.MouseEvent.ROLL_OUT,this.__cursorCallbackOut);
		}
		this.useHandCursor = cursor;
		return cursor;
	}
	,get_graphics: function() {
		return this.__graphics;
	}
	,get_dropTarget: function() {
		return this.__dropTarget;
	}
	,__getGraphics: function() {
		return this.__graphics;
	}
	,toString: function() {
		return "[Sprite name=" + this.name + " id=" + this.___id + "]";
	}
	,stopDrag: function() {
		if(this.__isOnStage()) {
			this.get_stage().__stopDrag(this);
			var l = this.parent.__children.length - 1;
			var obj = this.get_stage();
			var _g1 = 0, _g = this.parent.__children.length;
			while(_g1 < _g) {
				var i = _g1++;
				var result = this.parent.__children[l - i].__getObjectUnderPoint(new flash.geom.Point(this.get_stage().get_mouseX(),this.get_stage().get_mouseY()));
				if(result != null) obj = result;
			}
			if(obj != this) this.__dropTarget = obj; else this.__dropTarget = this.get_stage();
		}
	}
	,startDrag: function(lockCenter,bounds) {
		if(lockCenter == null) lockCenter = false;
		if(this.__isOnStage()) this.get_stage().__startDrag(this,lockCenter,bounds);
	}
	,__graphics: null
	,__dropTarget: null
	,__cursorCallbackOver: null
	,__cursorCallbackOut: null
	,useHandCursor: null
	,buttonMode: null
	,__class__: flash.display.Sprite
	,__properties__: $extend(flash.display.DisplayObjectContainer.prototype.__properties__,{get_dropTarget:"get_dropTarget",get_graphics:"get_graphics",set_useHandCursor:"set_useHandCursor"})
});
var nx3 = {}
nx3.test = {}
nx3.test.openfl = {}
nx3.test.openfl.Main = function() {
	flash.display.Sprite.call(this);
	this.addEventListener(flash.events.Event.ADDED_TO_STAGE,$bind(this,this.added));
};
$hxClasses["nx3.test.openfl.Main"] = nx3.test.openfl.Main;
nx3.test.openfl.Main.__name__ = ["nx3","test","openfl","Main"];
nx3.test.openfl.Main.main = function() {
	flash.Lib.get_current().get_stage().align = flash.display.StageAlign.TOP_LEFT;
	flash.Lib.get_current().get_stage().scaleMode = flash.display.StageScaleMode.NO_SCALE;
	flash.Lib.get_current().addChild(new nx3.test.openfl.Main());
}
nx3.test.openfl.Main.__super__ = flash.display.Sprite;
nx3.test.openfl.Main.prototype = $extend(flash.display.Sprite.prototype,{
	added: function(e) {
		this.removeEventListener(flash.events.Event.ADDED_TO_STAGE,$bind(this,this.added));
		this.get_stage().addEventListener(flash.events.Event.RESIZE,$bind(this,this.resize));
		this.init();
	}
	,init: function() {
		if(this.inited) return;
		this.inited = true;
		var runner = new haxe.unit.TestRunner();
		runner.add(new nx3.test.TestQ());
		runner.add(new nx3.test.TestN());
		runner.add(new nx3.test.TestV());
		runner.add(new nx3.test.TestVRender());
		var success = runner.run();
	}
	,resize: function(e) {
		if(!this.inited) this.init();
	}
	,inited: null
	,__class__: nx3.test.openfl.Main
});
var DocumentClass = function() {
	nx3.test.openfl.Main.call(this);
};
$hxClasses["DocumentClass"] = DocumentClass;
DocumentClass.__name__ = ["DocumentClass"];
DocumentClass.__super__ = nx3.test.openfl.Main;
DocumentClass.prototype = $extend(nx3.test.openfl.Main.prototype,{
	get_stage: function() {
		return flash.Lib.get_current().get_stage();
	}
	,__class__: DocumentClass
});
var CleverSort = function() { }
$hxClasses["CleverSort"] = CleverSort;
CleverSort.__name__ = ["CleverSort"];
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
Lambda.array = function(it) {
	var a = new Array();
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var i = $it0.next();
		a.push(i);
	}
	return a;
}
Lambda.map = function(it,f) {
	var l = new List();
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		l.add(f(x));
	}
	return l;
}
Lambda.has = function(it,elt) {
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(x == elt) return true;
	}
	return false;
}
Lambda.indexOf = function(it,v) {
	var i = 0;
	var $it0 = $iterator(it)();
	while( $it0.hasNext() ) {
		var v2 = $it0.next();
		if(v == v2) return i;
		i++;
	}
	return -1;
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
		var width = 800;
		if(width > 0) return width; else return flash.Lib.get_current().get_stage().get_stageWidth();
	}
	,getHeight: function() {
		var height = 480;
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
Reflect.getProperty = function(o,field) {
	var tmp;
	return o == null?null:o.__properties__ && (tmp = o.__properties__["get_" + field])?o[tmp]():o[field];
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
Reflect.compare = function(a,b) {
	return a == b?0:a > b?1:-1;
}
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
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
Std.random = function(x) {
	return x <= 0?0:Math.floor(Math.random() * x);
}
var StringBuf = function() {
	this.b = "";
};
$hxClasses["StringBuf"] = StringBuf;
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype = {
	addSub: function(s,pos,len) {
		this.b += len == null?HxOverrides.substr(s,pos,null):HxOverrides.substr(s,pos,len);
	}
	,b: null
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
StringTools.htmlEscape = function(s,quotes) {
	s = s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
	return quotes?s.split("\"").join("&quot;").split("'").join("&#039;"):s;
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
var Type = function() { }
$hxClasses["Type"] = Type;
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	return o.__class__;
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
var XmlType = $hxClasses["XmlType"] = { __ename__ : true, __constructs__ : [] }
var Xml = function() {
};
$hxClasses["Xml"] = Xml;
Xml.__name__ = ["Xml"];
Xml.parse = function(str) {
	return haxe.xml.Parser.parse(str);
}
Xml.createElement = function(name) {
	var r = new Xml();
	r.nodeType = Xml.Element;
	r._children = new Array();
	r._attributes = new haxe.ds.StringMap();
	r.set_nodeName(name);
	return r;
}
Xml.createPCData = function(data) {
	var r = new Xml();
	r.nodeType = Xml.PCData;
	r.set_nodeValue(data);
	return r;
}
Xml.createCData = function(data) {
	var r = new Xml();
	r.nodeType = Xml.CData;
	r.set_nodeValue(data);
	return r;
}
Xml.createComment = function(data) {
	var r = new Xml();
	r.nodeType = Xml.Comment;
	r.set_nodeValue(data);
	return r;
}
Xml.createDocType = function(data) {
	var r = new Xml();
	r.nodeType = Xml.DocType;
	r.set_nodeValue(data);
	return r;
}
Xml.createProcessingInstruction = function(data) {
	var r = new Xml();
	r.nodeType = Xml.ProcessingInstruction;
	r.set_nodeValue(data);
	return r;
}
Xml.createDocument = function() {
	var r = new Xml();
	r.nodeType = Xml.Document;
	r._children = new Array();
	return r;
}
Xml.prototype = {
	toString: function() {
		if(this.nodeType == Xml.PCData) return StringTools.htmlEscape(this._nodeValue);
		if(this.nodeType == Xml.CData) return "<![CDATA[" + this._nodeValue + "]]>";
		if(this.nodeType == Xml.Comment) return "<!--" + this._nodeValue + "-->";
		if(this.nodeType == Xml.DocType) return "<!DOCTYPE " + this._nodeValue + ">";
		if(this.nodeType == Xml.ProcessingInstruction) return "<?" + this._nodeValue + "?>";
		var s = new StringBuf();
		if(this.nodeType == Xml.Element) {
			s.b += "<";
			s.b += Std.string(this._nodeName);
			var $it0 = this._attributes.keys();
			while( $it0.hasNext() ) {
				var k = $it0.next();
				s.b += " ";
				s.b += Std.string(k);
				s.b += "=\"";
				s.b += Std.string(this._attributes.get(k));
				s.b += "\"";
			}
			if(this._children.length == 0) {
				s.b += "/>";
				return s.b;
			}
			s.b += ">";
		}
		var $it1 = this.iterator();
		while( $it1.hasNext() ) {
			var x = $it1.next();
			s.b += Std.string(x.toString());
		}
		if(this.nodeType == Xml.Element) {
			s.b += "</";
			s.b += Std.string(this._nodeName);
			s.b += ">";
		}
		return s.b;
	}
	,addChild: function(x) {
		if(this._children == null) throw "bad nodetype";
		if(x._parent != null) HxOverrides.remove(x._parent._children,x);
		x._parent = this;
		this._children.push(x);
	}
	,firstElement: function() {
		if(this._children == null) throw "bad nodetype";
		var cur = 0;
		var l = this._children.length;
		while(cur < l) {
			var n = this._children[cur];
			if(n.nodeType == Xml.Element) return n;
			cur++;
		}
		return null;
	}
	,elementsNamed: function(name) {
		if(this._children == null) throw "bad nodetype";
		return { cur : 0, x : this._children, hasNext : function() {
			var k = this.cur;
			var l = this.x.length;
			while(k < l) {
				var n = this.x[k];
				if(n.nodeType == Xml.Element && n._nodeName == name) break;
				k++;
			}
			this.cur = k;
			return k < l;
		}, next : function() {
			var k = this.cur;
			var l = this.x.length;
			while(k < l) {
				var n = this.x[k];
				k++;
				if(n.nodeType == Xml.Element && n._nodeName == name) {
					this.cur = k;
					return n;
				}
			}
			return null;
		}};
	}
	,iterator: function() {
		if(this._children == null) throw "bad nodetype";
		return { cur : 0, x : this._children, hasNext : function() {
			return this.cur < this.x.length;
		}, next : function() {
			return this.x[this.cur++];
		}};
	}
	,exists: function(att) {
		if(this.nodeType != Xml.Element) throw "bad nodeType";
		return this._attributes.exists(att);
	}
	,set: function(att,value) {
		if(this.nodeType != Xml.Element) throw "bad nodeType";
		this._attributes.set(att,value);
	}
	,get: function(att) {
		if(this.nodeType != Xml.Element) throw "bad nodeType";
		return this._attributes.get(att);
	}
	,set_nodeValue: function(v) {
		if(this.nodeType == Xml.Element || this.nodeType == Xml.Document) throw "bad nodeType";
		return this._nodeValue = v;
	}
	,set_nodeName: function(n) {
		if(this.nodeType != Xml.Element) throw "bad nodeType";
		return this._nodeName = n;
	}
	,get_nodeName: function() {
		if(this.nodeType != Xml.Element) throw "bad nodeType";
		return this._nodeName;
	}
	,_parent: null
	,_children: null
	,_attributes: null
	,_nodeValue: null
	,_nodeName: null
	,nodeType: null
	,__class__: Xml
}
var cx = {}
cx.ArrayTools = function() { }
$hxClasses["cx.ArrayTools"] = cx.ArrayTools;
cx.ArrayTools.__name__ = ["cx","ArrayTools"];
cx.ArrayTools.unique = function(arr) {
	var result = new Array();
	var _g = 0;
	while(_g < arr.length) {
		var item = arr[_g];
		++_g;
		if(!Lambda.has(result,item)) result.push(item);
	}
	result.sort(function(a,b) {
		return Reflect.compare(a,b);
	});
	return result;
}
cx.ArrayTools.fromIterator = function(it) {
	var result = [];
	while( it.hasNext() ) {
		var v = it.next();
		result.push(v);
	}
	return result;
}
cx.ArrayTools.fromIterables = function(it) {
	return cx.ArrayTools.fromIterator($iterator(it)());
}
cx.ArrayTools.fromHashKeys = function(it) {
	return cx.ArrayTools.fromIterator(it);
}
cx.ArrayTools.doOverlap = function(array1,array2) {
	var _g = 0;
	while(_g < array1.length) {
		var item = array1[_g];
		++_g;
		if(Lambda.has(array2,item)) return true;
	}
	return false;
}
cx.ArrayTools.overlap = function(array1,array2) {
	return Lambda.array(array1.filter(function(value1) {
		var ret = Lambda.has(array2,value1);
		return ret;
	}));
}
cx.ArrayTools.diff = function(array1,array2) {
	var result = new Array();
	var _g = 0;
	while(_g < array1.length) {
		var item = array1[_g];
		++_g;
		if(!Lambda.has(array2,item)) result.push(item);
	}
	var _g = 0;
	while(_g < array2.length) {
		var item = array2[_g];
		++_g;
		if(!Lambda.has(array1,item)) result.push(item);
	}
	return result;
}
cx.ArrayTools.first = function(array) {
	return array[0];
}
cx.ArrayTools.isFirst = function(array,item) {
	return array[0] == item;
}
cx.ArrayTools.last = function(array) {
	return array[array.length - 1];
}
cx.ArrayTools.isLast = function(array,item) {
	return array[array.length - 1] == item;
}
cx.ArrayTools.index = function(array,item) {
	return Lambda.indexOf(array,item);
}
cx.ArrayTools.shuffle = function(a) {
	var t = cx.ArrayTools.range(a.length);
	var arr = [];
	while(t.length > 0) {
		var pos = Std.random(t.length), index = t[pos];
		t.splice(pos,1);
		arr.push(a[index]);
	}
	return arr;
}
cx.ArrayTools.countItem = function(a,item) {
	var cnt = 0;
	var _g = 0;
	while(_g < a.length) {
		var ai = a[_g];
		++_g;
		if(ai == item) cnt++;
	}
	return cnt;
}
cx.ArrayTools.sorta = function(a) {
	a.sort(function(a1,b) {
		return Reflect.compare(a1,b);
	});
	return a;
}
cx.ArrayTools.range = function(start,stop,step) {
	if(step == null) step = 1;
	if(null == stop) {
		stop = start;
		start = 0;
	}
	if((stop - start) / step == Math.POSITIVE_INFINITY) throw "infinite range";
	var range = [], i = -1, j;
	if(step < 0) while((j = start + step * ++i) > stop) range.push(j); else while((j = start + step * ++i) < stop) range.push(j);
	return range;
}
cx.EnumTools = function() { }
$hxClasses["cx.EnumTools"] = cx.EnumTools;
cx.EnumTools.__name__ = ["cx","EnumTools"];
cx.EnumTools.createFromString = function(e,str) {
	try {
		var type = str;
		var params = [];
		if(cx.StrTools.has(str,"(")) {
			var parIdx = str.indexOf("(");
			type = HxOverrides.substr(str,0,parIdx);
			params = StringTools.replace(StringTools.replace(HxOverrides.substr(str,parIdx,null),"(",""),")","").split(",");
		}
		return Type.createEnum(e,type,params);
	} catch( e1 ) {
	}
	return null;
}
cx.StrTools = function() { }
$hxClasses["cx.StrTools"] = cx.StrTools;
cx.StrTools.__name__ = ["cx","StrTools"];
cx.StrTools.countSub = function(str,lookForStr) {
	return str.split(lookForStr).length - 1;
}
cx.StrTools.until = function(str,untilStr,includeUntilStr) {
	if(includeUntilStr == null) includeUntilStr = false;
	var pos = str.indexOf(untilStr);
	if(includeUntilStr) pos++;
	return str.substring(0,pos);
}
cx.StrTools.untilLast = function(str,untilStr,includeUntilStr) {
	if(includeUntilStr == null) includeUntilStr = false;
	var pos = str.lastIndexOf(untilStr);
	if(includeUntilStr) pos++;
	return str.substring(0,pos);
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
	if(idx == -1) return str;
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
cx.StrTools.toInt = function(str) {
	return Std.parseInt(str);
}
cx.StrTools.toFloat = function(str) {
	return Std.parseFloat(str);
}
var haxe = {}
haxe.Timer = function() { }
$hxClasses["haxe.Timer"] = haxe.Timer;
haxe.Timer.__name__ = ["haxe","Timer"];
haxe.Timer.stamp = function() {
	return new Date().getTime() / 1000;
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
flash.Lib.addCallback = function(functionName,closure) {
	flash.Lib.mMe.__scr[functionName] = closure;
}
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
	if(target == null) target = "_blank";
	window.open(request.url,target);
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
			if(attr.name == "data-" + "framerate") flash.Lib.__getStage().set_frameRate(Std.parseFloat(attr.value));
		}
	}
	var _g = 0, _g1 = flash.Lib.HTML_TOUCH_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		tgt.addEventListener(type,($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),true);
	}
	var _g = 0, _g1 = flash.Lib.HTML_TOUCH_ALT_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		tgt.addEventListener(type,($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),true);
	}
	var _g = 0, _g1 = flash.Lib.HTML_DIV_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		tgt.addEventListener(type,($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),true);
	}
	if(Reflect.hasField(js.Browser.window,"on" + "devicemotion")) js.Browser.window.addEventListener("devicemotion",($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),true);
	if(Reflect.hasField(js.Browser.window,"on" + "orientationchange")) js.Browser.window.addEventListener("orientationchange",($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),true);
	var _g = 0, _g1 = flash.Lib.HTML_WINDOW_EVENT_TYPES;
	while(_g < _g1.length) {
		var type = _g1[_g];
		++_g;
		js.Browser.window.addEventListener(type,($_=flash.Lib.__getStage(),$bind($_,$_.__queueStageEvent)),false);
	}
	if(tgt.style.backgroundColor != null && tgt.style.backgroundColor != "") flash.Lib.__getStage().set_backgroundColor(flash.Lib.__parseColor(tgt.style.backgroundColor,function(res,pos,cur) {
		return pos == 0?res | cur << 16:pos == 1?res | cur << 8:pos == 2?res | cur:(function($this) {
			var $r;
			throw "pos should be 0-2";
			return $r;
		}(this));
	})); else flash.Lib.__getStage().set_backgroundColor(16777215);
	flash.Lib.get_current().get_graphics().beginFill(flash.Lib.__getStage().get_backgroundColor());
	flash.Lib.get_current().get_graphics().drawRect(0,0,width,height);
	flash.Lib.__setSurfaceId(flash.Lib.get_current().get_graphics().__surface,"Root MovieClip");
	flash.Lib.__getStage().__updateNextWake();
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
flash.Lib.__appendSurface = function(surface,before,after) {
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
flash.Lib.__appendText = function(surface,container,text,wrap,isHtml) {
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
flash.Lib.__bootstrap = function() {
	if(flash.Lib.mMe == null) {
		var target = js.Browser.document.getElementById("haxe:openfl");
		if(target == null) target = js.Browser.document.createElement("div");
		var agent = navigator.userAgent;
		if(agent.indexOf("BlackBerry") > -1 && target.style.height == "100%") target.style.height = screen.height + "px";
		if(agent.indexOf("Android") > -1) {
			var version = Std.parseFloat(HxOverrides.substr(agent,agent.indexOf("Android") + 8,3));
			if(version <= 2.3) flash.Lib.mForce2DTransform = true;
		}
		flash.Lib.Run(target,flash.Lib.__getWidth(),flash.Lib.__getHeight());
	}
}
flash.Lib.__copyStyle = function(src,tgt) {
	tgt.id = src.id;
	var _g = 0, _g1 = ["left","top","transform","transform-origin","-moz-transform","-moz-transform-origin","-webkit-transform","-webkit-transform-origin","-o-transform","-o-transform-origin","opacity","display"];
	while(_g < _g1.length) {
		var prop = _g1[_g];
		++_g;
		tgt.style.setProperty(prop,src.style.getPropertyValue(prop),"");
	}
}
flash.Lib.__createSurfaceAnimationCSS = function(surface,data,template,templateFunc,fps,discrete,infinite) {
	if(infinite == null) infinite = false;
	if(discrete == null) discrete = false;
	if(fps == null) fps = 25;
	if(surface.id == null || surface.id == "") {
		flash.Lib.trace("Failed to create a CSS Style tag for a surface without an id attribute");
		return null;
	}
	var style = null;
	if(surface.getAttribute("data-openfl-anim") != null) style = js.Browser.document.getElementById(surface.getAttribute("data-openfl-anim")); else {
		style = flash.Lib.mMe.__scr.appendChild(js.Browser.document.createElement("style"));
		style.sheet.id = "__openfl_anim_" + surface.id + "__";
		surface.setAttribute("data-openfl-anim",style.sheet.id);
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
flash.Lib.__designMode = function(mode) {
	js.Browser.document.designMode = mode?"on":"off";
}
flash.Lib.__disableFullScreen = function() {
}
flash.Lib.__disableRightClick = function() {
	if(flash.Lib.mMe != null) try {
		flash.Lib.mMe.__scr.oncontextmenu = function() {
			return false;
		};
	} catch( e ) {
		flash.Lib.trace("Disable right click not supported in this browser.");
	}
}
flash.Lib.__drawClippedImage = function(surface,tgtCtx,clipRect) {
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
flash.Lib.__drawSurfaceRect = function(surface,tgt,x,y,rect) {
	var tgtCtx = tgt.getContext("2d");
	tgt.width = rect.width;
	tgt.height = rect.height;
	tgtCtx.drawImage(surface,rect.x,rect.y,rect.width,rect.height,0,0,rect.width,rect.height);
	tgt.style.left = x + "px";
	tgt.style.top = y + "px";
}
flash.Lib.__drawToSurface = function(surface,tgt,matrix,alpha,clipRect,smoothing) {
	if(smoothing == null) smoothing = true;
	if(alpha == null) alpha = 1.0;
	var srcCtx = surface.getContext("2d");
	var tgtCtx = tgt.getContext("2d");
	tgtCtx.globalAlpha = alpha;
	flash.Lib.__setImageSmoothing(tgtCtx,smoothing);
	if(surface.width > 0 && surface.height > 0) {
		if(matrix != null) {
			tgtCtx.save();
			if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1) tgtCtx.translate(matrix.tx,matrix.ty); else tgtCtx.setTransform(matrix.a,matrix.b,matrix.c,matrix.d,matrix.tx,matrix.ty);
			flash.Lib.__drawClippedImage(surface,tgtCtx,clipRect);
			tgtCtx.restore();
		} else flash.Lib.__drawClippedImage(surface,tgtCtx,clipRect);
	}
}
flash.Lib.__enableFullScreen = function() {
	if(flash.Lib.mMe != null) {
		var origWidth = flash.Lib.mMe.__scr.style.getPropertyValue("width");
		var origHeight = flash.Lib.mMe.__scr.style.getPropertyValue("height");
		flash.Lib.mMe.__scr.style.setProperty("width","100%","");
		flash.Lib.mMe.__scr.style.setProperty("height","100%","");
		flash.Lib.__disableFullScreen = function() {
			flash.Lib.mMe.__scr.style.setProperty("width",origWidth,"");
			flash.Lib.mMe.__scr.style.setProperty("height",origHeight,"");
		};
	}
}
flash.Lib.__enableRightClick = function() {
	if(flash.Lib.mMe != null) try {
		flash.Lib.mMe.__scr.oncontextmenu = null;
	} catch( e ) {
		flash.Lib.trace("Enable right click not supported in this browser.");
	}
}
flash.Lib.__fullScreenHeight = function() {
	return js.Browser.window.innerHeight;
}
flash.Lib.__fullScreenWidth = function() {
	return js.Browser.window.innerWidth;
}
flash.Lib.__getHeight = function() {
	var tgt = flash.Lib.mMe != null?flash.Lib.mMe.__scr:js.Browser.document.getElementById("haxe:openfl");
	return tgt != null && tgt.clientHeight > 0?tgt.clientHeight:500;
}
flash.Lib.__getStage = function() {
	if(flash.Lib.mStage == null) {
		var width = flash.Lib.__getWidth();
		var height = flash.Lib.__getHeight();
		flash.Lib.mStage = new flash.display.Stage(width,height);
	}
	return flash.Lib.mStage;
}
flash.Lib.__getWidth = function() {
	var tgt = flash.Lib.mMe != null?flash.Lib.mMe.__scr:js.Browser.document.getElementById("haxe:openfl");
	return tgt != null && tgt.clientWidth > 0?tgt.clientWidth:500;
}
flash.Lib.__isOnStage = function(surface) {
	var p = surface;
	while(p != null && p != flash.Lib.mMe.__scr) p = p.parentNode;
	return p == flash.Lib.mMe.__scr;
}
flash.Lib.__parseColor = function(str,cb) {
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
flash.Lib.__removeSurface = function(surface) {
	if(flash.Lib.mMe.__scr != null) {
		var anim = surface.getAttribute("data-openfl-anim");
		if(anim != null) {
			var style = js.Browser.document.getElementById(anim);
			if(style != null) flash.Lib.mMe.__scr.removeChild(style);
		}
		if(surface.parentNode != null) surface.parentNode.removeChild(surface);
	}
	return surface;
}
flash.Lib.__setSurfaceBorder = function(surface,color,size) {
	surface.style.setProperty("border-color","#" + StringTools.hex(color),"");
	surface.style.setProperty("border-style","solid","");
	surface.style.setProperty("border-width",size + "px","");
	surface.style.setProperty("border-collapse","collapse","");
}
flash.Lib.__setSurfaceClipping = function(surface,rect) {
}
flash.Lib.__setSurfaceFont = function(surface,font,bold,size,color,align,lineHeight) {
	surface.style.setProperty("font-family",font,"");
	surface.style.setProperty("font-weight",Std.string(bold),"");
	surface.style.setProperty("color","#" + StringTools.hex(color),"");
	surface.style.setProperty("font-size",size + "px","");
	surface.style.setProperty("text-align",align,"");
	surface.style.setProperty("line-height",lineHeight + "px","");
}
flash.Lib.__setSurfaceOpacity = function(surface,alpha) {
	surface.style.setProperty("opacity",Std.string(alpha),"");
}
flash.Lib.__setSurfacePadding = function(surface,padding,margin,display) {
	surface.style.setProperty("padding",padding + "px","");
	surface.style.setProperty("margin",margin + "px","");
	surface.style.setProperty("top",padding + 2 + "px","");
	surface.style.setProperty("right",padding + 1 + "px","");
	surface.style.setProperty("left",padding + 1 + "px","");
	surface.style.setProperty("bottom",padding + 1 + "px","");
	surface.style.setProperty("display",display?"inline":"block","");
}
flash.Lib.__setSurfaceTransform = function(surface,matrix) {
	if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1 && surface.getAttribute("data-openfl-anim") == null) {
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
flash.Lib.__setSurfaceZIndexAfter = function(surface1,surface2) {
	if(surface1 != null && surface2 != null) {
		if(surface1.parentNode != surface2.parentNode && surface2.parentNode != null) surface2.parentNode.appendChild(surface1);
		if(surface2.parentNode != null) {
			var nextSibling = surface2.nextSibling;
			if(surface1.previousSibling != surface2) {
				var swap = flash.Lib.__removeSurface(surface1);
				if(nextSibling == null) surface2.parentNode.appendChild(swap); else surface2.parentNode.insertBefore(swap,nextSibling);
			}
		}
	}
}
flash.Lib.__swapSurface = function(surface1,surface2) {
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
flash.Lib.__setContentEditable = function(surface,contentEditable) {
	if(contentEditable == null) contentEditable = true;
	surface.setAttribute("contentEditable",contentEditable?"true":"false");
}
flash.Lib.__setCursor = function(type) {
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
flash.Lib.__setImageSmoothing = function(context,enabled) {
	var _g = 0, _g1 = ["imageSmoothingEnabled","mozImageSmoothingEnabled","webkitImageSmoothingEnabled"];
	while(_g < _g1.length) {
		var variant = _g1[_g];
		++_g;
		context[variant] = enabled;
	}
}
flash.Lib.__setSurfaceAlign = function(surface,align) {
	surface.style.setProperty("text-align",align,"");
}
flash.Lib.__setSurfaceId = function(surface,name) {
	var regex = new EReg("[^a-zA-Z0-9\\-]","g");
	surface.id = regex.replace(name,"_");
}
flash.Lib.__setSurfaceRotation = function(surface,rotate) {
	surface.style.setProperty("transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-moz-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-webkit-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-o-transform","rotate(" + rotate + "deg)","");
	surface.style.setProperty("-ms-transform","rotate(" + rotate + "deg)","");
}
flash.Lib.__setSurfaceScale = function(surface,scale) {
	surface.style.setProperty("transform","scale(" + scale + ")","");
	surface.style.setProperty("-moz-transform","scale(" + scale + ")","");
	surface.style.setProperty("-webkit-transform","scale(" + scale + ")","");
	surface.style.setProperty("-o-transform","scale(" + scale + ")","");
	surface.style.setProperty("-ms-transform","scale(" + scale + ")","");
}
flash.Lib.__setSurfaceSpritesheetAnimation = function(surface,spec,fps) {
	if(spec.length == 0) return surface;
	var div = js.Browser.document.createElement("div");
	div.style.backgroundImage = "url(" + surface.toDataURL("image/png") + ")";
	div.id = surface.id;
	var keyframeTpl = new haxe.Template("background-position: ::left::px ::top::px; width: ::width::px; height: ::height::px; ");
	var templateFunc = function(frame) {
		return { left : -frame.x, top : -frame.y, width : frame.width, height : frame.height};
	};
	flash.Lib.__createSurfaceAnimationCSS(div,spec,keyframeTpl,templateFunc,fps,true,true);
	if(flash.Lib.__isOnStage(surface)) {
		flash.Lib.__appendSurface(div);
		flash.Lib.__copyStyle(surface,div);
		flash.Lib.__swapSurface(surface,div);
		flash.Lib.__removeSurface(surface);
	} else flash.Lib.__copyStyle(surface,div);
	return div;
}
flash.Lib.__setSurfaceVisible = function(surface,visible) {
	if(visible) surface.style.setProperty("display","block",""); else surface.style.setProperty("display","none","");
}
flash.Lib.__setTextDimensions = function(surface,width,height,align) {
	surface.style.setProperty("width",width + "px","");
	surface.style.setProperty("height",height + "px","");
	surface.style.setProperty("overflow","hidden","");
	surface.style.setProperty("text-align",align,"");
}
flash.Lib.__surfaceHitTest = function(surface,x,y) {
	var _g1 = 0, _g = surface.childNodes.length;
	while(_g1 < _g) {
		var i = _g1++;
		var node = surface.childNodes[i];
		if(x >= node.offsetLeft && x <= node.offsetLeft + node.offsetWidth && y >= node.offsetTop && y <= node.offsetTop + node.offsetHeight) return true;
	}
	return false;
}
flash.Lib.get_current = function() {
	if(flash.Lib.mMainClassRoot == null) {
		flash.Lib.mMainClassRoot = new flash.display.MovieClip();
		flash.Lib.mCurrent = flash.Lib.mMainClassRoot;
		flash.Lib.__getStage().addChild(flash.Lib.mCurrent);
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
		if(this.bitmapData.__referenceCount == 1) this.__graphics = new flash.display.Graphics(this.bitmapData.___textureBuffer);
	}
	if(this.pixelSnapping == null) this.pixelSnapping = flash.display.PixelSnapping.AUTO;
	if(this.__graphics == null) this.__graphics = new flash.display.Graphics();
	if(this.bitmapData != null) this.__render();
};
$hxClasses["flash.display.Bitmap"] = flash.display.Bitmap;
flash.display.Bitmap.__name__ = ["flash","display","Bitmap"];
flash.display.Bitmap.__super__ = flash.display.DisplayObject;
flash.display.Bitmap.prototype = $extend(flash.display.DisplayObject.prototype,{
	set_bitmapData: function(inBitmapData) {
		if(inBitmapData != this.bitmapData) {
			if(this.bitmapData != null) {
				this.bitmapData.__referenceCount--;
				if(this.__graphics.__surface == this.bitmapData.___textureBuffer) flash.Lib.__setSurfaceOpacity(this.bitmapData.___textureBuffer,0);
			}
			if(inBitmapData != null) inBitmapData.__referenceCount++;
		}
		this.___renderFlags |= 64;
		if(this.parent != null) this.parent.___renderFlags |= 64;
		this.bitmapData = inBitmapData;
		return inBitmapData;
	}
	,__render: function(inMask,clipRect) {
		if(!this.__combinedVisible) return;
		if(this.bitmapData == null) return;
		if((this.___renderFlags & 4) != 0 || (this.___renderFlags & 8) != 0) this.__validateMatrix();
		if(this.bitmapData.___textureBuffer != this.__graphics.__surface) {
			var imageDataLease = this.bitmapData.__lease;
			if(imageDataLease != null && (this.__currentLease == null || imageDataLease.seed != this.__currentLease.seed || imageDataLease.time != this.__currentLease.time)) {
				var srcCanvas = this.bitmapData.___textureBuffer;
				this.__graphics.__surface.width = srcCanvas.width;
				this.__graphics.__surface.height = srcCanvas.height;
				this.__graphics.clear();
				flash.Lib.__drawToSurface(srcCanvas,this.__graphics.__surface);
				this.__currentLease = imageDataLease.clone();
				this.___renderFlags |= 64;
				if(this.parent != null) this.parent.___renderFlags |= 64;
				this.__applyFilters(this.__graphics.__surface);
				this.___renderFlags |= 32;
			}
		}
		if(inMask != null) {
			this.__applyFilters(this.__graphics.__surface);
			var m = this.getBitmapSurfaceTransform(this.__graphics);
			flash.Lib.__drawToSurface(this.__graphics.__surface,inMask,m,(this.parent != null?this.parent.__combinedAlpha:1) * this.alpha,clipRect,this.smoothing);
		} else {
			if((this.___renderFlags & 32) != 0) {
				var m = this.getBitmapSurfaceTransform(this.__graphics);
				flash.Lib.__setSurfaceTransform(this.__graphics.__surface,m);
				this.___renderFlags &= -33;
			}
			if(!this.__init) {
				flash.Lib.__setSurfaceOpacity(this.__graphics.__surface,0);
				this.__init = true;
			} else flash.Lib.__setSurfaceOpacity(this.__graphics.__surface,(this.parent != null?this.parent.__combinedAlpha:1) * this.alpha);
		}
	}
	,__getObjectUnderPoint: function(point) {
		if(!this.get_visible()) return null; else if(this.bitmapData != null) {
			var local = this.globalToLocal(point);
			if(local.x < 0 || local.y < 0 || local.x > this.get_width() / this.get_scaleX() || local.y > this.get_height() / this.get_scaleY()) return null; else return this;
		} else return flash.display.DisplayObject.prototype.__getObjectUnderPoint.call(this,point);
	}
	,__getGraphics: function() {
		return this.__graphics;
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.DisplayObject.prototype.validateBounds.call(this);
			if(this.bitmapData != null) {
				var r = new flash.geom.Rectangle(0,0,this.bitmapData.get_width(),this.bitmapData.get_height());
				if(r.width != 0 || r.height != 0) {
					if(this.__boundsRect.width == 0 && this.__boundsRect.height == 0) this.__boundsRect = r.clone(); else this.__boundsRect.extendBounds(r);
				}
			}
			if(this.scale9Grid != null) {
				this.__boundsRect.width *= this.__scaleX;
				this.__boundsRect.height *= this.__scaleY;
				this.__width = this.__boundsRect.width;
				this.__height = this.__boundsRect.height;
			} else {
				this.__width = this.__boundsRect.width * this.__scaleX;
				this.__height = this.__boundsRect.height * this.__scaleY;
			}
		}
	}
	,toString: function() {
		return "[Bitmap name=" + this.name + " id=" + this.___id + "]";
	}
	,getBitmapSurfaceTransform: function(gfx) {
		var extent = gfx.__extentWithFilters;
		var fm = this.transform.__getFullMatrix(null);
		fm.__translateTransformed(extent.get_topLeft());
		return fm;
	}
	,__init: null
	,__currentLease: null
	,__graphics: null
	,smoothing: null
	,pixelSnapping: null
	,bitmapData: null
	,__class__: flash.display.Bitmap
	,__properties__: $extend(flash.display.DisplayObject.prototype.__properties__,{set_bitmapData:"set_bitmapData"})
});
flash.display.BitmapData = function(width,height,transparent,inFillColor) {
	if(inFillColor == null) inFillColor = -1;
	if(transparent == null) transparent = true;
	this.__locked = false;
	this.__referenceCount = 0;
	this.__leaseNum = 0;
	this.__lease = new flash.display.ImageDataLease();
	this.__lease.set(this.__leaseNum++,new Date().getTime());
	this.___textureBuffer = js.Browser.document.createElement("canvas");
	this.___textureBuffer.width = width;
	this.___textureBuffer.height = height;
	this.___id = flash.utils.Uuid.uuid();
	flash.Lib.__setSurfaceId(this.___textureBuffer,this.___id);
	this.__transparent = transparent;
	this.rect = new flash.geom.Rectangle(0,0,width,height);
	if(this.__transparent) {
		this.__transparentFiller = js.Browser.document.createElement("canvas");
		this.__transparentFiller.width = width;
		this.__transparentFiller.height = height;
		var ctx = this.__transparentFiller.getContext("2d");
		ctx.fillStyle = "rgba(0,0,0,0);";
		ctx.fill();
	}
	if(inFillColor != null && width > 0 && height > 0) {
		if(!this.__transparent) inFillColor |= -16777216;
		this.__initColor = inFillColor;
		this.__fillRect(this.rect,inFillColor);
	}
};
$hxClasses["flash.display.BitmapData"] = flash.display.BitmapData;
flash.display.BitmapData.__name__ = ["flash","display","BitmapData"];
flash.display.BitmapData.__interfaces__ = [flash.display.IBitmapDrawable];
flash.display.BitmapData.getRGBAPixels = function(bitmapData) {
	var p = bitmapData.getPixels(new flash.geom.Rectangle(0,0,bitmapData.___textureBuffer != null?bitmapData.___textureBuffer.width:0,bitmapData.___textureBuffer != null?bitmapData.___textureBuffer.height:0));
	var num = (bitmapData.___textureBuffer != null?bitmapData.___textureBuffer.width:0) * (bitmapData.___textureBuffer != null?bitmapData.___textureBuffer.height:0);
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
flash.display.BitmapData.loadFromBase64 = function(base64,type,onload) {
	var bitmapData = new flash.display.BitmapData(0,0);
	bitmapData.__loadFromBase64(base64,type,onload);
	return bitmapData;
}
flash.display.BitmapData.loadFromBytes = function(bytes,inRawAlpha,onload) {
	var bitmapData = new flash.display.BitmapData(0,0);
	bitmapData.__loadFromBytes(bytes,inRawAlpha,onload);
	return bitmapData;
}
flash.display.BitmapData.__base64Encode = function(bytes) {
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
flash.display.BitmapData.__createFromHandle = function(inHandle) {
	var result = new flash.display.BitmapData(0,0);
	result.___textureBuffer = inHandle;
	return result;
}
flash.display.BitmapData.__isJPG = function(bytes) {
	bytes.position = 0;
	return bytes.readByte() == 255 && bytes.readByte() == 216;
}
flash.display.BitmapData.__isPNG = function(bytes) {
	bytes.position = 0;
	return bytes.readByte() == 137 && bytes.readByte() == 80 && bytes.readByte() == 78 && bytes.readByte() == 71 && bytes.readByte() == 13 && bytes.readByte() == 10 && bytes.readByte() == 26 && bytes.readByte() == 10;
}
flash.display.BitmapData.prototype = {
	get_width: function() {
		if(this.___textureBuffer != null) return this.___textureBuffer.width; else return 0;
	}
	,get_transparent: function() {
		return this.__transparent;
	}
	,get_height: function() {
		if(this.___textureBuffer != null) return this.___textureBuffer.height; else return 0;
	}
	,__onLoad: function(data,e) {
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
		data.bitmapData.__buildLease();
		if(data.inLoader != null) {
			var e1 = new flash.events.Event(flash.events.Event.COMPLETE);
			e1.target = data.inLoader;
			data.inLoader.dispatchEvent(e1);
		}
	}
	,__loadFromFile: function(inFilename,inLoader) {
		var _g = this;
		var image = js.Browser.document.createElement("img");
		if(inLoader != null) {
			var data = { image : image, texture : this.___textureBuffer, inLoader : inLoader, bitmapData : this};
			image.addEventListener("load",(function(f,a1) {
				return function(e) {
					return f(a1,e);
				};
			})($bind(this,this.__onLoad),data),false);
			image.addEventListener("error",function(e) {
				if(!image.complete) _g.__onLoad(data,e);
			},false);
		}
		image.src = inFilename;
		if(image.complete) {
		}
	}
	,__incrNumRefBitmaps: function() {
		this.__assignedBitmaps++;
	}
	,__getNumRefBitmaps: function() {
		return this.__assignedBitmaps;
	}
	,__loadFromBytes: function(bytes,inRawAlpha,onload) {
		var _g = this;
		var type = "";
		if(flash.display.BitmapData.__isPNG(bytes)) type = "image/png"; else if(flash.display.BitmapData.__isJPG(bytes)) type = "image/jpeg"; else throw new flash.errors.IOError("BitmapData tried to read a PNG/JPG ByteArray, but found an invalid header.");
		if(inRawAlpha != null) this.__loadFromBase64(flash.display.BitmapData.__base64Encode(bytes),type,function(_) {
			var ctx = _g.___textureBuffer.getContext("2d");
			var pixels = ctx.getImageData(0,0,_g.___textureBuffer.width,_g.___textureBuffer.height);
			var _g2 = 0, _g1 = inRawAlpha.length;
			while(_g2 < _g1) {
				var i = _g2++;
				pixels.data[i * 4 + 3] = inRawAlpha.readUnsignedByte();
			}
			ctx.putImageData(pixels,0,0);
			if(onload != null) onload(_g);
		}); else this.__loadFromBase64(flash.display.BitmapData.__base64Encode(bytes),type,onload);
	}
	,__loadFromBase64: function(base64,type,onload) {
		var _g = this;
		var img = js.Browser.document.createElement("img");
		var canvas = this.___textureBuffer;
		var drawImage = function(_) {
			canvas.width = img.width;
			canvas.height = img.height;
			var ctx = canvas.getContext("2d");
			ctx.drawImage(img,0,0);
			_g.rect = new flash.geom.Rectangle(0,0,canvas.width,canvas.height);
			if(onload != null) onload(_g);
		};
		img.addEventListener("load",drawImage,false);
		img.src = "data:" + type + ";base64," + base64;
	}
	,__getLease: function() {
		return this.__lease;
	}
	,__fillRect: function(rect,color) {
		this.__lease.set(this.__leaseNum++,new Date().getTime());
		var ctx = this.___textureBuffer.getContext("2d");
		var r = (color & 16711680) >>> 16;
		var g = (color & 65280) >>> 8;
		var b = color & 255;
		var a = this.__transparent?color >>> 24:255;
		if(!this.__locked) {
			var style = "rgba(" + r + ", " + g + ", " + b + ", " + a / 255 + ")";
			ctx.fillStyle = style;
			ctx.fillRect(rect.x,rect.y,rect.width,rect.height);
		} else {
			var s = 4 * (Math.round(rect.x) + Math.round(rect.y) * this.__imageData.width);
			var offsetY;
			var offsetX;
			var _g1 = 0, _g = Math.round(rect.height);
			while(_g1 < _g) {
				var i = _g1++;
				offsetY = i * this.__imageData.width;
				var _g3 = 0, _g2 = Math.round(rect.width);
				while(_g3 < _g2) {
					var j = _g3++;
					offsetX = 4 * (j + offsetY);
					this.__imageData.data[s + offsetX] = r;
					this.__imageData.data[s + offsetX + 1] = g;
					this.__imageData.data[s + offsetX + 2] = b;
					this.__imageData.data[s + offsetX + 3] = a;
				}
			}
			this.__imageDataChanged = true;
		}
	}
	,__decrNumRefBitmaps: function() {
		this.__assignedBitmaps--;
	}
	,__clearCanvas: function() {
		var ctx = this.___textureBuffer.getContext("2d");
		ctx.clearRect(0,0,this.___textureBuffer.width,this.___textureBuffer.height);
	}
	,__buildLease: function() {
		this.__lease.set(this.__leaseNum++,new Date().getTime());
	}
	,unlock: function(changeRect) {
		this.__locked = false;
		var ctx = this.___textureBuffer.getContext("2d");
		if(this.__imageDataChanged) {
			if(changeRect != null) ctx.putImageData(this.__imageData,0,0,changeRect.x,changeRect.y,changeRect.width,changeRect.height); else ctx.putImageData(this.__imageData,0,0);
		}
		var _g = 0, _g1 = this.__copyPixelList;
		while(_g < _g1.length) {
			var copyCache = _g1[_g];
			++_g;
			if(this.__transparent && copyCache.transparentFiller != null) {
				var trpCtx = copyCache.transparentFiller.getContext("2d");
				var trpData = trpCtx.getImageData(copyCache.sourceX,copyCache.sourceY,copyCache.sourceWidth,copyCache.sourceHeight);
				ctx.putImageData(trpData,copyCache.destX,copyCache.destY);
			}
			ctx.drawImage(copyCache.handle,copyCache.sourceX,copyCache.sourceY,copyCache.sourceWidth,copyCache.sourceHeight,copyCache.destX,copyCache.destY,copyCache.sourceWidth,copyCache.sourceHeight);
		}
		this.__lease.set(this.__leaseNum++,new Date().getTime());
	}
	,threshold: function(sourceBitmapData,sourceRect,destPoint,operation,threshold,color,mask,copySource) {
		if(copySource == null) copySource = false;
		if(mask == null) mask = -1;
		if(color == null) color = 0;
		haxe.Log.trace("BitmapData.threshold not implemented",{ fileName : "BitmapData.hx", lineNumber : 1164, className : "flash.display.BitmapData", methodName : "threshold"});
		return 0;
	}
	,setPixels: function(rect,byteArray) {
		rect = this.clipRect(rect);
		if(rect == null) return;
		var len = Math.round(4 * rect.width * rect.height);
		if(!this.__locked) {
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.createImageData(rect.width,rect.height);
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				imageData.data[i] = byteArray.readByte();
			}
			ctx.putImageData(imageData,rect.x,rect.y);
		} else {
			var offset = Math.round(4 * this.__imageData.width * rect.y + rect.x * 4);
			var pos = offset;
			var boundR = Math.round(4 * (rect.x + rect.width));
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				if(pos % (this.__imageData.width * 4) > boundR - 1) pos += this.__imageData.width * 4 - boundR;
				this.__imageData.data[pos] = byteArray.readByte();
				pos++;
			}
			this.__imageDataChanged = true;
		}
	}
	,setPixel32: function(x,y,color) {
		if(x < 0 || y < 0 || x >= (this.___textureBuffer != null?this.___textureBuffer.width:0) || y >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) return;
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.createImageData(1,1);
			imageData.data[0] = (color & 16711680) >>> 16;
			imageData.data[1] = (color & 65280) >>> 8;
			imageData.data[2] = color & 255;
			if(this.__transparent) imageData.data[3] = (color & -16777216) >>> 24; else imageData.data[3] = 255;
			ctx.putImageData(imageData,x,y);
		} else {
			var offset = 4 * y * this.__imageData.width + x * 4;
			this.__imageData.data[offset] = (color & 16711680) >>> 16;
			this.__imageData.data[offset + 1] = (color & 65280) >>> 8;
			this.__imageData.data[offset + 2] = color & 255;
			if(this.__transparent) this.__imageData.data[offset + 3] = (color & -16777216) >>> 24; else this.__imageData.data[offset + 3] = 255;
			this.__imageDataChanged = true;
		}
	}
	,setPixel: function(x,y,color) {
		if(x < 0 || y < 0 || x >= (this.___textureBuffer != null?this.___textureBuffer.width:0) || y >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) return;
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.createImageData(1,1);
			imageData.data[0] = (color & 16711680) >>> 16;
			imageData.data[1] = (color & 65280) >>> 8;
			imageData.data[2] = color & 255;
			if(this.__transparent) imageData.data[3] = 255;
			ctx.putImageData(imageData,x,y);
		} else {
			var offset = 4 * y * this.__imageData.width + x * 4;
			this.__imageData.data[offset] = (color & 16711680) >>> 16;
			this.__imageData.data[offset + 1] = (color & 65280) >>> 8;
			this.__imageData.data[offset + 2] = color & 255;
			if(this.__transparent) this.__imageData.data[offset + 3] = 255;
			this.__imageDataChanged = true;
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
		var ctx = this.___textureBuffer.getContext("2d");
		var imageData = null;
		if(this.__locked) imageData = this.__imageData; else imageData = ctx.createImageData(this.___textureBuffer.width,this.___textureBuffer.height);
		var _g1 = 0, _g = this.___textureBuffer.width * this.___textureBuffer.height;
		while(_g1 < _g) {
			var i = _g1++;
			if(grayScale) imageData.data[i * 4] = imageData.data[i * 4 + 1] = imageData.data[i * 4 + 2] = low + generator.nextValue() % (high - low + 1); else {
				imageData.data[i * 4] = (channelOptions & 1) == 0?0:low + generator.nextValue() % (high - low + 1);
				imageData.data[i * 4 + 1] = (channelOptions & 2) == 0?0:low + generator.nextValue() % (high - low + 1);
				imageData.data[i * 4 + 2] = (channelOptions & 4) == 0?0:low + generator.nextValue() % (high - low + 1);
			}
			imageData.data[i * 4 + 3] = (channelOptions & 8) == 0?255:low + generator.nextValue() % (high - low + 1);
		}
		if(this.__locked) this.__imageDataChanged = true; else ctx.putImageData(imageData,0,0);
	}
	,lock: function() {
		this.__locked = true;
		var ctx = this.___textureBuffer.getContext("2d");
		this.__imageData = ctx.getImageData(0,0,this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0);
		this.__imageDataChanged = false;
		this.__copyPixelList = [];
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
				var boundingBox = new flash.geom.Rectangle(0,0,me.___textureBuffer != null?me.___textureBuffer.width:0,me.___textureBuffer != null?me.___textureBuffer.height:0);
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
				if(x < 0 || y < 0 || x >= (me.___textureBuffer != null?me.___textureBuffer.width:0) || y >= (me.___textureBuffer != null?me.___textureBuffer.height:0)) return false;
				if(imageData.data[Math.round(4 * (y * (me.___textureBuffer != null?me.___textureBuffer.width:0) + x)) + 3] - firstAlphaThreshold > 0) return true;
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
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0);
			return doHitTest(imageData);
		} else return doHitTest(this.__imageData);
	}
	,handle: function() {
		return this.___textureBuffer;
	}
	,getPixels: function(rect) {
		var len = Math.round(4 * rect.width * rect.height);
		var byteArray = new flash.utils.ByteArray();
		if(byteArray.allocated < len) byteArray.___resizeBuffer(byteArray.allocated = Math.max(len,byteArray.allocated * 2) | 0); else if(byteArray.allocated > len) byteArray.___resizeBuffer(byteArray.allocated = len);
		byteArray.length = len;
		len;
		rect = this.clipRect(rect);
		if(rect == null) return byteArray;
		if(!this.__locked) {
			var ctx = this.___textureBuffer.getContext("2d");
			var imagedata = ctx.getImageData(rect.x,rect.y,rect.width,rect.height);
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				byteArray.writeByte(imagedata.data[i]);
			}
		} else {
			var offset = Math.round(4 * this.__imageData.width * rect.y + rect.x * 4);
			var pos = offset;
			var boundR = Math.round(4 * (rect.x + rect.width));
			var _g = 0;
			while(_g < len) {
				var i = _g++;
				if(pos % (this.__imageData.width * 4) > boundR - 1) pos += this.__imageData.width * 4 - boundR;
				byteArray.writeByte(this.__imageData.data[pos]);
				pos++;
			}
		}
		byteArray.position = 0;
		return byteArray;
	}
	,getPixel32: function(x,y) {
		if(x < 0 || y < 0 || x >= (this.___textureBuffer != null?this.___textureBuffer.width:0) || y >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) return 0;
		if(!this.__locked) {
			var ctx = this.___textureBuffer.getContext("2d");
			return this.getInt32(0,ctx.getImageData(x,y,1,1).data);
		} else return this.getInt32(4 * y * this.___textureBuffer.width + x * 4,this.__imageData.data);
	}
	,getPixel: function(x,y) {
		if(x < 0 || y < 0 || x >= (this.___textureBuffer != null?this.___textureBuffer.width:0) || y >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) return 0;
		if(!this.__locked) {
			var ctx = this.___textureBuffer.getContext("2d");
			var imagedata = ctx.getImageData(x,y,1,1);
			return imagedata.data[0] << 16 | imagedata.data[1] << 8 | imagedata.data[2];
		} else {
			var offset = 4 * y * (this.___textureBuffer != null?this.___textureBuffer.width:0) + x * 4;
			return this.__imageData.data[offset] << 16 | this.__imageData.data[offset + 1] << 8 | this.__imageData.data[offset + 2];
		}
	}
	,getInt32: function(offset,data) {
		return (this.__transparent?data[offset + 3]:255) << 24 | data[offset] << 16 | data[offset + 1] << 8 | data[offset + 2];
	}
	,getColorBoundsRect: function(mask,color,findColor) {
		if(findColor == null) findColor = true;
		var me = this;
		var doGetColorBoundsRect = function(data) {
			var minX = me.___textureBuffer != null?me.___textureBuffer.width:0, maxX = 0, minY = me.___textureBuffer != null?me.___textureBuffer.height:0, maxY = 0, i = 0;
			while(i < data.length) {
				var value = me.getInt32(i,data);
				if(findColor) {
					if((value & mask) == color) {
						var x = Math.round(i % ((me.___textureBuffer != null?me.___textureBuffer.width:0) * 4) / 4);
						var y = Math.round(i / ((me.___textureBuffer != null?me.___textureBuffer.width:0) * 4));
						if(x < minX) minX = x;
						if(x > maxX) maxX = x;
						if(y < minY) minY = y;
						if(y > maxY) maxY = y;
					}
				} else if((value & mask) != color) {
					var x = Math.round(i % ((me.___textureBuffer != null?me.___textureBuffer.width:0) * 4) / 4);
					var y = Math.round(i / ((me.___textureBuffer != null?me.___textureBuffer.width:0) * 4));
					if(x < minX) minX = x;
					if(x > maxX) maxX = x;
					if(y < minY) minY = y;
					if(y > maxY) maxY = y;
				}
				i += 4;
			}
			if(minX < maxX && minY < maxY) return new flash.geom.Rectangle(minX,minY,maxX - minX + 1,maxY - minY); else return new flash.geom.Rectangle(0,0,me.___textureBuffer != null?me.___textureBuffer.width:0,me.___textureBuffer != null?me.___textureBuffer.height:0);
		};
		if(!this.__locked) {
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0);
			return doGetColorBoundsRect(imageData.data);
		} else return doGetColorBoundsRect(this.__imageData.data);
	}
	,floodFill: function(x,y,color) {
		var wasLocked = this.__locked;
		if(!this.__locked) this.lock();
		var queue = new Array();
		queue.push(new flash.geom.Point(x,y));
		var old = this.getPixel32(x,y);
		var iterations = 0;
		var search = new Array();
		var _g1 = 0, _g = (this.___textureBuffer != null?this.___textureBuffer.width:0) + 1;
		while(_g1 < _g) {
			var i = _g1++;
			var column = new Array();
			var _g3 = 0, _g2 = (this.___textureBuffer != null?this.___textureBuffer.height:0) + 1;
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
			if(x1 < 0 || x1 >= (this.___textureBuffer != null?this.___textureBuffer.width:0)) continue;
			if(y1 < 0 || y1 >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) continue;
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
		if(rect.x == 0 && rect.y == 0 && rect.width == this.___textureBuffer.width && rect.height == this.___textureBuffer.height) {
			if(this.__transparent) {
				if(color >>> 24 == 0 || color == this.__initColor) return this.__clearCanvas();
			} else if((color | -16777216) == (this.__initColor | -16777216)) return this.__clearCanvas();
		}
		return this.__fillRect(rect,color);
	}
	,drawToSurface: function(inSurface,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		this.__lease.set(this.__leaseNum++,new Date().getTime());
		var ctx = inSurface.getContext("2d");
		if(matrix != null) {
			ctx.save();
			if(matrix.a == 1 && matrix.b == 0 && matrix.c == 0 && matrix.d == 1) ctx.translate(matrix.tx,matrix.ty); else {
				flash.Lib.__setImageSmoothing(ctx,smoothing);
				ctx.setTransform(matrix.a,matrix.b,matrix.c,matrix.d,matrix.tx,matrix.ty);
			}
			ctx.drawImage(this.___textureBuffer,0,0);
			ctx.restore();
		} else ctx.drawImage(this.___textureBuffer,0,0);
		if(inColorTransform != null) this.colorTransform(new flash.geom.Rectangle(0,0,this.___textureBuffer.width,this.___textureBuffer.height),inColorTransform);
	}
	,draw: function(source,matrix,inColorTransform,blendMode,clipRect,smoothing) {
		if(smoothing == null) smoothing = false;
		this.__lease.set(this.__leaseNum++,new Date().getTime());
		source.drawToSurface(this.___textureBuffer,matrix,inColorTransform,blendMode,clipRect,smoothing);
		if(inColorTransform != null) {
			var rect = new flash.geom.Rectangle();
			var object = source;
			rect.x = matrix != null?matrix.tx:0;
			rect.y = matrix != null?matrix.ty:0;
			try {
				rect.width = Reflect.getProperty(source,"width");
				rect.height = Reflect.getProperty(source,"height");
			} catch( e ) {
				rect.width = this.___textureBuffer.width;
				rect.height = this.___textureBuffer.height;
			}
			this.colorTransform(rect,inColorTransform);
		}
	}
	,dispose: function() {
		this.__clearCanvas();
		this.___textureBuffer = null;
		this.__leaseNum = 0;
		this.__lease = null;
		this.__imageData = null;
	}
	,destroy: function() {
		this.___textureBuffer = null;
	}
	,copyPixels: function(sourceBitmapData,sourceRect,destPoint,alphaBitmapData,alphaPoint,mergeAlpha) {
		if(mergeAlpha == null) mergeAlpha = false;
		if(sourceBitmapData.___textureBuffer == null || this.___textureBuffer == null || sourceBitmapData.___textureBuffer.width == 0 || sourceBitmapData.___textureBuffer.height == 0 || sourceRect.width <= 0 || sourceRect.height <= 0) return;
		if(sourceRect.x + sourceRect.width > sourceBitmapData.___textureBuffer.width) sourceRect.width = sourceBitmapData.___textureBuffer.width - sourceRect.x;
		if(sourceRect.y + sourceRect.height > sourceBitmapData.___textureBuffer.height) sourceRect.height = sourceBitmapData.___textureBuffer.height - sourceRect.y;
		if(alphaBitmapData != null && alphaBitmapData.__transparent) {
			if(alphaPoint == null) alphaPoint = new flash.geom.Point();
			var bitmapData = new flash.display.BitmapData(sourceBitmapData.___textureBuffer != null?sourceBitmapData.___textureBuffer.width:0,sourceBitmapData.___textureBuffer != null?sourceBitmapData.___textureBuffer.height:0,true);
			bitmapData.copyPixels(sourceBitmapData,sourceRect,new flash.geom.Point(sourceRect.x,sourceRect.y));
			bitmapData.copyChannel(alphaBitmapData,new flash.geom.Rectangle(alphaPoint.x,alphaPoint.y,sourceRect.width,sourceRect.height),new flash.geom.Point(sourceRect.x,sourceRect.y),8,8);
			sourceBitmapData = bitmapData;
		}
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
			if(!mergeAlpha) {
				if(this.__transparent && sourceBitmapData.__transparent) {
					var trpCtx = sourceBitmapData.__transparentFiller.getContext("2d");
					var trpData = trpCtx.getImageData(sourceRect.x,sourceRect.y,sourceRect.width,sourceRect.height);
					ctx.putImageData(trpData,destPoint.x,destPoint.y);
				}
			}
			ctx.drawImage(sourceBitmapData.___textureBuffer,sourceRect.x,sourceRect.y,sourceRect.width,sourceRect.height,destPoint.x,destPoint.y,sourceRect.width,sourceRect.height);
		} else this.__copyPixelList[this.__copyPixelList.length] = { handle : sourceBitmapData.___textureBuffer, transparentFiller : mergeAlpha?null:sourceBitmapData.__transparentFiller, sourceX : sourceRect.x, sourceY : sourceRect.y, sourceWidth : sourceRect.width, sourceHeight : sourceRect.height, destX : destPoint.x, destY : destPoint.y};
	}
	,copyChannel: function(sourceBitmapData,sourceRect,destPoint,sourceChannel,destChannel) {
		this.rect = this.clipRect(this.rect);
		if(this.rect == null) return;
		if(destChannel == 8 && !this.__transparent) return;
		if(sourceBitmapData.___textureBuffer == null || this.___textureBuffer == null || sourceRect.width <= 0 || sourceRect.height <= 0) return;
		if(sourceRect.x + sourceRect.width > sourceBitmapData.___textureBuffer.width) sourceRect.width = sourceBitmapData.___textureBuffer.width - sourceRect.x;
		if(sourceRect.y + sourceRect.height > sourceBitmapData.___textureBuffer.height) sourceRect.height = sourceBitmapData.___textureBuffer.height - sourceRect.y;
		var doChannelCopy = function(imageData) {
			var srcCtx = sourceBitmapData.___textureBuffer.getContext("2d");
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
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
			var imageData = ctx.getImageData(0,0,this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0);
			doChannelCopy(imageData);
			ctx.putImageData(imageData,0,0);
		} else {
			doChannelCopy(this.__imageData);
			this.__imageDataChanged = true;
		}
	}
	,compare: function(inBitmapTexture) {
		throw "bitmapData.compare is currently not supported for HTML5";
		return 0;
	}
	,colorTransform: function(rect,colorTransform) {
		if(rect == null) return;
		rect = this.clipRect(rect);
		if(!this.__locked) {
			this.__lease.set(this.__leaseNum++,new Date().getTime());
			var ctx = this.___textureBuffer.getContext("2d");
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
			var s = 4 * (Math.round(rect.x) + Math.round(rect.y) * this.__imageData.width);
			var offsetY;
			var offsetX;
			var _g1 = 0, _g = Math.round(rect.height);
			while(_g1 < _g) {
				var i = _g1++;
				offsetY = i * this.__imageData.width;
				var _g3 = 0, _g2 = Math.round(rect.width);
				while(_g3 < _g2) {
					var j = _g3++;
					offsetX = 4 * (j + offsetY);
					this.__imageData.data[s + offsetX] = this.__imageData.data[s + offsetX] * colorTransform.redMultiplier + colorTransform.redOffset | 0;
					this.__imageData.data[s + offsetX + 1] = this.__imageData.data[s + offsetX + 1] * colorTransform.greenMultiplier + colorTransform.greenOffset | 0;
					this.__imageData.data[s + offsetX + 2] = this.__imageData.data[s + offsetX + 2] * colorTransform.blueMultiplier + colorTransform.blueOffset | 0;
					this.__imageData.data[s + offsetX + 3] = this.__imageData.data[s + offsetX + 3] * colorTransform.alphaMultiplier + colorTransform.alphaOffset | 0;
				}
			}
			this.__imageDataChanged = true;
		}
	}
	,clone: function() {
		var bitmapData = new flash.display.BitmapData(this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0,this.__transparent);
		var rect = new flash.geom.Rectangle(0,0,this.___textureBuffer != null?this.___textureBuffer.width:0,this.___textureBuffer != null?this.___textureBuffer.height:0);
		bitmapData.setPixels(rect,this.getPixels(rect));
		bitmapData.__lease.set(bitmapData.__leaseNum++,new Date().getTime());
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
		if(r.x + r.width >= (this.___textureBuffer != null?this.___textureBuffer.width:0)) {
			r.width -= r.x + r.width - (this.___textureBuffer != null?this.___textureBuffer.width:0);
			if(r.width <= 0) return null;
		}
		if(r.y + r.height >= (this.___textureBuffer != null?this.___textureBuffer.height:0)) {
			r.height -= r.y + r.height - (this.___textureBuffer != null?this.___textureBuffer.height:0);
			if(r.height <= 0) return null;
		}
		return r;
	}
	,clear: function(color) {
		this.fillRect(this.rect,color);
	}
	,applyFilter: function(sourceBitmapData,sourceRect,destPoint,filter) {
		if(sourceBitmapData == this && sourceRect.x == destPoint.x && sourceRect.y == destPoint.y) filter.__applyFilter(this.___textureBuffer,sourceRect); else {
			var bitmapData = new flash.display.BitmapData(sourceRect.width | 0,sourceRect.height | 0);
			bitmapData.copyPixels(sourceBitmapData,sourceRect,new flash.geom.Point());
			filter.__applyFilter(bitmapData.___textureBuffer);
			this.copyPixels(bitmapData,bitmapData.rect,destPoint);
		}
	}
	,___textureBuffer: null
	,___id: null
	,__transparentFiller: null
	,__transparent: null
	,__locked: null
	,__leaseNum: null
	,__lease: null
	,__initColor: null
	,__imageDataChanged: null
	,__copyPixelList: null
	,__assignedBitmaps: null
	,__referenceCount: null
	,__glTexture: null
	,__imageData: null
	,width: null
	,transparent: null
	,rect: null
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
	flash.Lib.__bootstrap();
	if(inSurface == null) {
		this.__surface = js.Browser.document.createElement("canvas");
		this.__surface.width = 0;
		this.__surface.height = 0;
	} else this.__surface = inSurface;
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
	this.__clearLine();
	this.mLineJobs = [];
	this.__changed = true;
	this.nextDrawIndex = 0;
	this.__extent = new flash.geom.Rectangle();
	this.__extentWithFilters = new flash.geom.Rectangle();
	this._padding = 0.0;
	this.__clearNextCycle = true;
};
$hxClasses["flash.display.Graphics"] = flash.display.Graphics;
flash.display.Graphics.__name__ = ["flash","display","Graphics"];
flash.display.Graphics.__detectIsPointInPathMode = function() {
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
	__render: function(maskHandle,filters,sx,sy,clip0,clip1,clip2,clip3) {
		if(sy == null) sy = 1.0;
		if(sx == null) sx = 1.0;
		if(!this.__changed) return false;
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
		this.__expandFilteredExtent(-(padding * sx) / 2,-(padding * sy) / 2);
		if(this.__clearNextCycle) {
			this.nextDrawIndex = 0;
			this.__clearCanvas();
			this.__clearNextCycle = false;
		}
		if(this.__extentWithFilters.width - this.__extentWithFilters.x > this.__surface.width || this.__extentWithFilters.height - this.__extentWithFilters.y > this.__surface.height) this.__adjustSurface(sx,sy);
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.__surface.getContext("2d");
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
				if(js.Boot.__instanceof(filter,flash.filters.DropShadowFilter)) filter.__applyFilter(this.__surface,null,true);
			}
		}
		var len = this.mDrawList.length;
		ctx.save();
		if(this.__extentWithFilters.x != 0 || this.__extentWithFilters.y != 0) ctx.translate(-this.__extentWithFilters.x * sx,-this.__extentWithFilters.y * sy);
		if(sx != 1 || sy != 0) ctx.scale(sx,sy);
		var doStroke = false;
		var _g = this.nextDrawIndex;
		while(_g < len) {
			var i = _g++;
			var d = this.mDrawList[len - 1 - i];
			if(d.tileJob != null) this.__drawTiles(d.tileJob.sheet,d.tileJob.drawList,d.tileJob.flags); else {
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
		this.__changed = false;
		this.nextDrawIndex = len > 0?len - 1:0;
		this.mDrawList = [];
		return true;
	}
	,__mediaSurface: function(surface) {
		this.__surface = surface;
	}
	,__invalidate: function() {
		this.__changed = true;
		this.__clearNextCycle = true;
	}
	,__hitTest: function(inX,inY) {
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.__surface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx == null) return false;
		if(ctx.isPointInPath(inX,inY)) return true; else if(this.mDrawList.length == 0 && this.__extent.width > 0 && this.__extent.height > 0) return true;
		return false;
	}
	,__expandStandardExtent: function(x,y,thickness) {
		if(thickness == null) thickness = 0;
		if(this._padding > 0) {
			this.__extent.width -= this._padding;
			this.__extent.height -= this._padding;
		}
		if(thickness != null && thickness > this._padding) this._padding = thickness;
		var maxX, minX, maxY, minY;
		minX = this.__extent.x;
		minY = this.__extent.y;
		maxX = this.__extent.width + minX;
		maxY = this.__extent.height + minY;
		maxX = x > maxX?x:maxX;
		minX = x < minX?x:minX;
		maxY = y > maxY?y:maxY;
		minY = y < minY?y:minY;
		this.__extent.x = minX;
		this.__extent.y = minY;
		this.__extent.width = maxX - minX + this._padding;
		this.__extent.height = maxY - minY + this._padding;
		this.boundsDirty = true;
	}
	,__expandFilteredExtent: function(x,y) {
		var maxX, minX, maxY, minY;
		minX = this.__extent.x;
		minY = this.__extent.y;
		maxX = this.__extent.width + minX;
		maxY = this.__extent.height + minY;
		maxX = x > maxX?x:maxX;
		minX = x < minX?x:minX;
		maxY = y > maxY?y:maxY;
		minY = y < minY?y:minY;
		this.__extentWithFilters.x = minX;
		this.__extentWithFilters.y = minY;
		this.__extentWithFilters.width = maxX - minX;
		this.__extentWithFilters.height = maxY - minY;
	}
	,__drawTiles: function(sheet,tileData,flags) {
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
		var surface = sheet.__bitmap.___textureBuffer;
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.__surface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx != null) while(index < totalCount) {
			var tileID = tileData[index + 2] | 0;
			if(tileID != previousTileID) {
				rect = sheet.__tileRects[tileID];
				center = sheet.__centerPoints[tileID];
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
	,__drawEllipse: function(x,y,rx,ry) {
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
	,__clearLine: function() {
		this.mCurrentLine = new flash.display.LineJob(null,-1,-1,0.0,0.0,0,1,0,256,3,3.0);
	}
	,__clearCanvas: function() {
		if(this.__surface != null) {
			var ctx = (function($this) {
				var $r;
				try {
					$r = $this.__surface.getContext("2d");
				} catch( e ) {
					$r = null;
				}
				return $r;
			}(this));
			if(ctx != null) ctx.clearRect(0,0,this.__surface.width,this.__surface.height);
		}
	}
	,__adjustSurface: function(sx,sy) {
		if(sy == null) sy = 1.0;
		if(sx == null) sx = 1.0;
		if(Reflect.field(this.__surface,"getContext") != null) {
			var width = Math.ceil((this.__extentWithFilters.width - this.__extentWithFilters.x) * sx);
			var height = Math.ceil((this.__extentWithFilters.height - this.__extentWithFilters.y) * sy);
			if(width <= 5000 && height <= 5000) {
				var dstCanvas = js.Browser.document.createElement("canvas");
				dstCanvas.width = width;
				dstCanvas.height = height;
				flash.Lib.__drawToSurface(this.__surface,dstCanvas);
				if(flash.Lib.__isOnStage(this.__surface)) {
					flash.Lib.__appendSurface(dstCanvas);
					flash.Lib.__copyStyle(this.__surface,dstCanvas);
					flash.Lib.__swapSurface(this.__surface,dstCanvas);
					flash.Lib.__removeSurface(this.__surface);
					if(this.__surface.id != null) flash.Lib.__setSurfaceId(dstCanvas,this.__surface.id);
				}
				this.__surface = dstCanvas;
			}
		}
	}
	,moveTo: function(inX,inY) {
		this.mPenX = inX;
		this.mPenY = inY;
		this.__expandStandardExtent(inX,inY);
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
		this.__expandStandardExtent(inX,inY,this.mCurrentLine.thickness);
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
			this.__clearLine();
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
			return this.__surface.getContext("2d");
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
		this.__expandStandardExtent(flash.Lib.get_current().get_stage().get_stageWidth(),flash.Lib.get_current().get_stage().get_stageHeight());
		this.addDrawable(new flash.display.Drawable(null,null,null,null,null,null,new flash.display.TileJob(sheet,tileData,flags)));
		this.__changed = true;
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
			if(data == null) this.mFilling = true; else switch(data.__graphicsDataType) {
			case flash.display.GraphicsDataType.STROKE:
				var stroke = data;
				if(stroke.fill == null) this.lineStyle(stroke.thickness,0,1.,stroke.pixelHinting,stroke.scaleMode,stroke.caps,stroke.joints,stroke.miterLimit); else switch(stroke.fill.__graphicsFillType) {
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
		this.__drawEllipse(x + rx,y + ry,rx,ry);
		this.closePolygon(false);
	}
	,drawCircle: function(x,y,rad) {
		this.closePolygon(false);
		this.__drawEllipse(x,y,rad,rad);
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
		this.__expandStandardExtent(inX,inY,this.mCurrentLine.thickness);
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
		this.__changed = true;
	}
	,clear: function() {
		this.__clearLine();
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
		this.__clearNextCycle = true;
		this.boundsDirty = true;
		this.__extent.x = 0.0;
		this.__extent.y = 0.0;
		this.__extent.width = 0.0;
		this.__extent.height = 0.0;
		this._padding = 0.0;
		this.mLineJobs = [];
	}
	,blit: function(inTexture) {
		this.closePolygon(true);
		var ctx = (function($this) {
			var $r;
			try {
				$r = $this.__surface.getContext("2d");
			} catch( e ) {
				$r = null;
			}
			return $r;
		}(this));
		if(ctx != null) ctx.drawImage(inTexture.___textureBuffer,this.mPenX,this.mPenY);
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
		this.__expandStandardExtent(bitmap.___textureBuffer != null?bitmap.___textureBuffer.width:0,bitmap.___textureBuffer != null?bitmap.___textureBuffer.height:0);
		this.mBitmap = { texture_buffer : bitmap.___textureBuffer, matrix : matrix == null?matrix:matrix.clone(), flags : (repeat?16:0) | (smooth?65536:0)};
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
	,__clearNextCycle: null
	,__changed: null
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
	,__surface: null
	,__extentWithFilters: null
	,__extent: null
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
	__graphicsFillType: null
	,__class__: flash.display.IGraphicsFill
}
flash.display.IGraphicsData = function() { }
$hxClasses["flash.display.IGraphicsData"] = flash.display.IGraphicsData;
flash.display.IGraphicsData.__name__ = ["flash","display","IGraphicsData"];
flash.display.IGraphicsData.prototype = {
	__graphicsDataType: null
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
	this.__graphicsDataType = flash.display.GraphicsDataType.GRADIENT;
	this.__graphicsFillType = flash.display.GraphicsFillType.GRADIENT_FILL;
};
$hxClasses["flash.display.GraphicsGradientFill"] = flash.display.GraphicsGradientFill;
flash.display.GraphicsGradientFill.__name__ = ["flash","display","GraphicsGradientFill"];
flash.display.GraphicsGradientFill.__interfaces__ = [flash.display.IGraphicsFill,flash.display.IGraphicsData];
flash.display.GraphicsGradientFill.prototype = {
	__graphicsFillType: null
	,__graphicsDataType: null
	,type: null
	,spreadMethod: null
	,ratios: null
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
	this.__graphicsDataType = flash.display.GraphicsDataType.PATH;
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
	,__graphicsDataType: null
	,winding: null
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
	this.__graphicsDataType = flash.display.GraphicsDataType.SOLID;
	this.__graphicsFillType = flash.display.GraphicsFillType.SOLID_FILL;
};
$hxClasses["flash.display.GraphicsSolidFill"] = flash.display.GraphicsSolidFill;
flash.display.GraphicsSolidFill.__name__ = ["flash","display","GraphicsSolidFill"];
flash.display.GraphicsSolidFill.__interfaces__ = [flash.display.IGraphicsFill,flash.display.IGraphicsData];
flash.display.GraphicsSolidFill.prototype = {
	__graphicsFillType: null
	,__graphicsDataType: null
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
	this.__graphicsDataType = flash.display.GraphicsDataType.STROKE;
};
$hxClasses["flash.display.GraphicsStroke"] = flash.display.GraphicsStroke;
flash.display.GraphicsStroke.__name__ = ["flash","display","GraphicsStroke"];
flash.display.GraphicsStroke.__interfaces__ = [flash.display.IGraphicsStroke,flash.display.IGraphicsData];
flash.display.GraphicsStroke.prototype = {
	__graphicsDataType: null
	,thickness: null
	,scaleMode: null
	,pixelHinting: null
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
		this.content.__invalidateBounds();
		this.content.__render(null,null);
		this.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE,$bind(this,this.handleLoad));
	}
	,validateBounds: function() {
		if(this.get__boundsInvalid()) {
			flash.display.Sprite.prototype.validateBounds.call(this);
			if(this.mImage != null) {
				var r = new flash.geom.Rectangle(0,0,this.mImage.get_width(),this.mImage.get_height());
				if(r.width != 0 || r.height != 0) {
					if(this.__boundsRect.width == 0 && this.__boundsRect.height == 0) this.__boundsRect = r.clone(); else this.__boundsRect.extendBounds(r);
				}
			}
			if(this.scale9Grid != null) {
				this.__boundsRect.width *= this.__scaleX;
				this.__boundsRect.height *= this.__scaleY;
				this.__width = this.__boundsRect.width;
				this.__height = this.__boundsRect.height;
			} else {
				this.__width = this.__boundsRect.width * this.__scaleX;
				this.__height = this.__boundsRect.height * this.__scaleY;
			}
		}
	}
	,toString: function() {
		return "[Loader name=" + this.name + " id=" + this.___id + "]";
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
			haxe.Log.trace("Error " + Std.string(e),{ fileName : "Loader.hx", lineNumber : 123, className : "flash.display.Loader", methodName : "loadBytes"});
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
		if(request.contentType == null && request.contentType != "") this.contentLoaderInfo.contentType = (function($this) {
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
				$r = "application/x-www-form-urlencoded";
			}
			return $r;
		}(this)); else this.contentLoaderInfo.contentType = request.contentType;
		this.mImage = new flash.display.BitmapData(0,0,transparent);
		try {
			this.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.handleLoad),false,2147483647);
			this.mImage.__loadFromFile(request.url,this.contentLoaderInfo);
			this.content = new flash.display.Bitmap(this.mImage);
			this.contentLoaderInfo.content = this.content;
			this.addChild(this.content);
		} catch( e ) {
			haxe.Log.trace("Error " + Std.string(e),{ fileName : "Loader.hx", lineNumber : 86, className : "flash.display.Loader", methodName : "load"});
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
		return "[MovieClip name=" + this.name + " id=" + this.___id + "]";
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
	this.__graphics = new flash.display.Graphics();
};
$hxClasses["flash.display.Shape"] = flash.display.Shape;
flash.display.Shape.__name__ = ["flash","display","Shape"];
flash.display.Shape.__super__ = flash.display.DisplayObject;
flash.display.Shape.prototype = $extend(flash.display.DisplayObject.prototype,{
	get_graphics: function() {
		return this.__graphics;
	}
	,__getObjectUnderPoint: function(point) {
		if(this.parent == null) return null;
		if(this.parent.mouseEnabled && flash.display.DisplayObject.prototype.__getObjectUnderPoint.call(this,point) == this) return this.parent; else return null;
	}
	,__getGraphics: function() {
		return this.__graphics;
	}
	,toString: function() {
		return "[Shape name=" + this.name + " id=" + this.___id + "]";
	}
	,__graphics: null
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
	this.__isCancelled = false;
	this.__isCancelledNow = false;
	this.target = null;
	this.currentTarget = null;
	this.eventPhase = flash.events.EventPhase.AT_TARGET;
};
$hxClasses["flash.events.Event"] = flash.events.Event;
flash.events.Event.__name__ = ["flash","events","Event"];
flash.events.Event.prototype = {
	__setPhase: function(phase) {
		this.eventPhase = phase;
	}
	,__getIsCancelledNow: function() {
		return this.__isCancelledNow;
	}
	,__getIsCancelled: function() {
		return this.__isCancelled;
	}
	,__createSimilar: function(type,related,targ) {
		var result = new flash.events.Event(type,this.bubbles,this.cancelable);
		if(targ != null) result.target = targ;
		return result;
	}
	,toString: function() {
		return "[Event type=" + this.type + " bubbles=" + Std.string(this.bubbles) + " cancelable=" + Std.string(this.cancelable) + "]";
	}
	,stopPropagation: function() {
		this.__isCancelled = true;
	}
	,stopImmediatePropagation: function() {
		this.__isCancelled = true;
		this.__isCancelledNow = true;
	}
	,clone: function() {
		return new flash.events.Event(this.type,this.bubbles,this.cancelable);
	}
	,__isCancelledNow: null
	,__isCancelled: null
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
flash.events.MouseEvent.__create = function(type,event,local,target) {
	var __mouseDown = false;
	var delta = 2;
	if(type == flash.events.MouseEvent.MOUSE_WHEEL) {
		var mouseEvent = event;
		if(mouseEvent.wheelDelta) delta = mouseEvent.wheelDelta / 120 | 0; else if(mouseEvent.detail) -mouseEvent.detail | 0;
	}
	if(type == flash.events.MouseEvent.MOUSE_DOWN) __mouseDown = event.which != null?event.which == 1:event.button != null?event.button == 0:false; else if(type == flash.events.MouseEvent.MOUSE_UP) {
		if(event.which != null) {
			if(event.which == 1) __mouseDown = false; else if(event.button != null) {
				if(event.button == 0) __mouseDown = false; else __mouseDown = false;
			}
		}
	}
	var pseudoEvent = new flash.events.MouseEvent(type,true,false,local.x,local.y,null,event.ctrlKey,event.altKey,event.shiftKey,__mouseDown,delta);
	pseudoEvent.stageX = flash.Lib.get_current().get_stage().get_mouseX();
	pseudoEvent.stageY = flash.Lib.get_current().get_stage().get_mouseY();
	pseudoEvent.target = target;
	return pseudoEvent;
}
flash.events.MouseEvent.__super__ = flash.events.Event;
flash.events.MouseEvent.prototype = $extend(flash.events.Event.prototype,{
	updateAfterEvent: function() {
	}
	,__createSimilar: function(type,related,targ) {
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
	this.__focusObject = null;
	this.__focusObjectActivated = false;
	this.__windowWidth = width;
	this.__windowHeight = height;
	this.stageFocusRect = false;
	this.scaleMode = flash.display.StageScaleMode.SHOW_ALL;
	this.__stageMatrix = new flash.geom.Matrix();
	this.tabEnabled = true;
	this.set_frameRate(0.0);
	this.set_backgroundColor(16777215);
	this.name = "Stage";
	this.loaderInfo = flash.display.LoaderInfo.create(null);
	this.loaderInfo.parameters.width = Std.string(this.__windowWidth);
	this.loaderInfo.parameters.height = Std.string(this.__windowHeight);
	this.__pointInPathMode = flash.display.Graphics.__detectIsPointInPathMode();
	this.__mouseOverObjects = [];
	this.set_showDefaultContextMenu(true);
	this.__touchInfo = [];
	this.__uIEventsQueue = new Array(1000);
	this.__uIEventsQueueIndex = 0;
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
		return this.__windowWidth;
	}
	,get_stageHeight: function() {
		return this.__windowHeight;
	}
	,get_stage: function() {
		return flash.Lib.__getStage();
	}
	,set_showDefaultContextMenu: function(showDefaultContextMenu) {
		if(showDefaultContextMenu != this.__showDefaultContextMenu && this.__showDefaultContextMenu != null) {
			if(!showDefaultContextMenu) flash.Lib.__disableRightClick(); else flash.Lib.__enableRightClick();
		}
		this.__showDefaultContextMenu = showDefaultContextMenu;
		return showDefaultContextMenu;
	}
	,get_showDefaultContextMenu: function() {
		return this.__showDefaultContextMenu;
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
			var __requestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame;
			if(__requestAnimationFrame == null) speed = 60;
		}
		if(speed != 0) this.__interval = 1000.0 / speed | 0;
		this.__frameRate = speed;
		this.__updateNextWake();
		return speed;
	}
	,get_frameRate: function() {
		return this.__frameRate;
	}
	,set_focus: function(inObj) {
		this.__onFocus(inObj);
		return this.__focusObject;
	}
	,get_focus: function() {
		return this.__focusObject;
	}
	,set_displayState: function(displayState) {
		if(displayState != this.displayState && this.displayState != null) {
			switch( (displayState)[1] ) {
			case 0:
				flash.Lib.__disableFullScreen();
				break;
			case 1:
			case 2:
				flash.Lib.__enableFullScreen();
				break;
			}
		}
		this.displayState = displayState;
		return displayState;
	}
	,get_displayState: function() {
		return this.displayState;
	}
	,set_color: function(col) {
		return this.__backgroundColour = col;
	}
	,get_color: function() {
		return this.__backgroundColour;
	}
	,set_backgroundColor: function(col) {
		return this.__backgroundColour = col;
	}
	,get_backgroundColor: function() {
		return this.__backgroundColour;
	}
	,__onTouch: function(event,touch,type,touchInfo,isPrimaryTouchPoint) {
		var rect = flash.Lib.mMe.__scr.getBoundingClientRect();
		var point = new flash.geom.Point(touch.pageX - rect.left,touch.pageY - rect.top);
		var obj = this.__getObjectUnderPoint(point);
		this._mouseX = point.x;
		this._mouseY = point.y;
		var stack = new Array();
		if(obj != null) obj.__getInteractiveObjectStack(stack);
		if(stack.length > 0) {
			stack.reverse();
			var local = obj.globalToLocal(point);
			var evt = flash.events.TouchEvent.__create(type,event,touch,local,obj);
			evt.touchPointID = touch.identifier;
			evt.isPrimaryTouchPoint = isPrimaryTouchPoint;
			this.__checkInOuts(evt,stack,touchInfo);
			obj.__fireEvent(evt);
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
						if($this.__dragObject != null) $this.__drag(point);
						$r = flash.events.MouseEvent.MOUSE_MOVE;
						return $r;
					}($this));
				}
				return $r;
			}(this));
			obj.__fireEvent(flash.events.MouseEvent.__create(mouseType,evt,local,obj));
		} else {
			var evt = flash.events.TouchEvent.__create(type,event,touch,point,null);
			evt.touchPointID = touch.identifier;
			evt.isPrimaryTouchPoint = isPrimaryTouchPoint;
			this.__checkInOuts(evt,stack,touchInfo);
		}
	}
	,__onResize: function(inW,inH) {
		this.__windowWidth = inW;
		this.__windowHeight = inH;
		var event = new flash.events.Event(flash.events.Event.RESIZE);
		event.target = this;
		this.__broadcast(event);
	}
	,__onMouse: function(event,type) {
		var rect = flash.Lib.mMe.__scr.getBoundingClientRect();
		var point = new flash.geom.Point(event.clientX - rect.left,event.clientY - rect.top);
		if(this.__dragObject != null) this.__drag(point);
		var obj = this.__getObjectUnderPoint(point);
		this._mouseX = point.x;
		this._mouseY = point.y;
		var stack = new Array();
		if(obj != null) obj.__getInteractiveObjectStack(stack);
		if(stack.length > 0) {
			stack.reverse();
			var local = obj.globalToLocal(point);
			var evt = flash.events.MouseEvent.__create(type,event,local,obj);
			this.__checkInOuts(evt,stack);
			if(type == flash.events.MouseEvent.MOUSE_DOWN) this.__onFocus(stack[stack.length - 1]);
			obj.__fireEvent(evt);
		} else {
			var evt = flash.events.MouseEvent.__create(type,event,point,null);
			this.__checkInOuts(evt,stack);
		}
	}
	,__onFocus: function(target) {
		if(target != this.__focusObject) {
			if(this.__focusObject != null) this.__focusObject.__fireEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_OUT,true,false,this.__focusObject,false,0));
			target.__fireEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_IN,true,false,target,false,0));
			this.__focusObject = target;
		}
	}
	,__onKey: function(code,pressed,inChar,ctrl,alt,shift,keyLocation) {
		var stack = new Array();
		if(this.__focusObject == null) this.__getInteractiveObjectStack(stack); else this.__focusObject.__getInteractiveObjectStack(stack);
		if(stack.length > 0) {
			var obj = stack[0];
			var evt = new flash.events.KeyboardEvent(pressed?flash.events.KeyboardEvent.KEY_DOWN:flash.events.KeyboardEvent.KEY_UP,true,false,inChar,code,keyLocation,ctrl,alt,shift);
			obj.__fireEvent(evt);
		}
	}
	,__handleOrientationChange: function() {
	}
	,__handleAccelerometer: function(evt) {
		flash.display.Stage.__acceleration.x = evt.accelerationIncludingGravity.x;
		flash.display.Stage.__acceleration.y = evt.accelerationIncludingGravity.y;
		flash.display.Stage.__acceleration.z = evt.accelerationIncludingGravity.z;
	}
	,__updateNextWake: function() {
		if(this.__frameRate == 0) {
			var __requestAnimationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame;
			__requestAnimationFrame($bind(this,this.__updateNextWake));
			this.__stageRender();
		} else {
			js.Browser.window.clearInterval(this.__timer);
			this.__timer = js.Browser.window.setInterval($bind(this,this.__stageRender),this.__interval);
		}
	}
	,__stopDrag: function(sprite) {
		this.__dragBounds = null;
		this.__dragObject = null;
	}
	,__startDrag: function(sprite,lockCenter,bounds) {
		if(lockCenter == null) lockCenter = false;
		this.__dragBounds = bounds == null?null:bounds.clone();
		this.__dragObject = sprite;
		if(this.__dragObject != null) {
			var mouse = new flash.geom.Point(this._mouseX,this._mouseY);
			var p = this.__dragObject.parent;
			if(p != null) mouse = p.globalToLocal(mouse);
			if(lockCenter) {
				var bounds1 = sprite.getBounds(this);
				this.__dragOffsetX = this.__dragObject.get_x() - (bounds1.width / 2 + bounds1.x);
				this.__dragOffsetY = this.__dragObject.get_y() - (bounds1.height / 2 + bounds1.y);
			} else {
				this.__dragOffsetX = this.__dragObject.get_x() - mouse.x;
				this.__dragOffsetY = this.__dragObject.get_y() - mouse.y;
			}
		}
	}
	,__stageRender: function(_) {
		if(!this.__stageActive) {
			this.__onResize(this.__windowWidth,this.__windowHeight);
			var event = new flash.events.Event(flash.events.Event.ACTIVATE);
			event.target = this;
			this.__broadcast(event);
			this.__stageActive = true;
		}
		var _g1 = 0, _g = this.__uIEventsQueueIndex;
		while(_g1 < _g) {
			var i = _g1++;
			if(this.__uIEventsQueue[i] != null) this.__processStageEvent(this.__uIEventsQueue[i]);
		}
		this.__uIEventsQueueIndex = 0;
		var event = new flash.events.Event(flash.events.Event.ENTER_FRAME);
		this.__broadcast(event);
		if(this.__invalid) {
			var event1 = new flash.events.Event(flash.events.Event.RENDER);
			this.__broadcast(event1);
		}
		this.__renderAll();
	}
	,__renderToCanvas: function(canvas) {
		canvas.width = canvas.width;
		this.__render(canvas);
	}
	,__renderAll: function() {
		this.__render(null,null);
	}
	,__queueStageEvent: function(evt) {
		this.__uIEventsQueue[this.__uIEventsQueueIndex++] = evt;
	}
	,__processStageEvent: function(evt) {
		evt.stopPropagation();
		switch(evt.type) {
		case "resize":
			this.__onResize(flash.Lib.__getWidth(),flash.Lib.__getHeight());
			break;
		case "focus":
			this.__onFocus(this);
			if(!this.__focusObjectActivated) {
				this.__focusObjectActivated = true;
				this.dispatchEvent(new flash.events.Event(flash.events.Event.ACTIVATE));
			}
			break;
		case "blur":
			if(this.__focusObjectActivated) {
				this.__focusObjectActivated = false;
				this.dispatchEvent(new flash.events.Event(flash.events.Event.DEACTIVATE));
			}
			break;
		case "mousemove":
			this.__onMouse(evt,flash.events.MouseEvent.MOUSE_MOVE);
			break;
		case "mousedown":
			this.__onMouse(evt,flash.events.MouseEvent.MOUSE_DOWN);
			break;
		case "mouseup":
			this.__onMouse(evt,flash.events.MouseEvent.MOUSE_UP);
			break;
		case "click":
			this.__onMouse(evt,flash.events.MouseEvent.CLICK);
			break;
		case "mousewheel":
			this.__onMouse(evt,flash.events.MouseEvent.MOUSE_WHEEL);
			break;
		case "dblclick":
			this.__onMouse(evt,flash.events.MouseEvent.DOUBLE_CLICK);
			break;
		case "keydown":
			var evt1 = evt;
			var keyCode = evt1.keyCode != null?evt1.keyCode:evt1.which;
			keyCode = flash.ui.Keyboard.__convertMozillaCode(keyCode);
			this.__onKey(keyCode,true,evt1.charCode,evt1.ctrlKey,evt1.altKey,evt1.shiftKey,evt1.keyLocation);
			break;
		case "keyup":
			var evt1 = evt;
			var keyCode = evt1.keyCode != null?evt1.keyCode:evt1.which;
			keyCode = flash.ui.Keyboard.__convertMozillaCode(keyCode);
			this.__onKey(keyCode,false,evt1.charCode,evt1.ctrlKey,evt1.altKey,evt1.shiftKey,evt1.keyLocation);
			break;
		case "touchstart":
			var evt1 = evt;
			evt1.preventDefault();
			var touchInfo = new flash.display._Stage.TouchInfo();
			this.__touchInfo[evt1.changedTouches[0].identifier] = touchInfo;
			this.__onTouch(evt1,evt1.changedTouches[0],"touchBegin",touchInfo,false);
			break;
		case "touchmove":
			var evt1 = evt;
			evt1.preventDefault();
			var touchInfo = this.__touchInfo[evt1.changedTouches[0].identifier];
			this.__onTouch(evt1,evt1.changedTouches[0],"touchMove",touchInfo,true);
			break;
		case "touchend":
			var evt1 = evt;
			evt1.preventDefault();
			var touchInfo = this.__touchInfo[evt1.changedTouches[0].identifier];
			this.__onTouch(evt1,evt1.changedTouches[0],"touchEnd",touchInfo,true);
			this.__touchInfo[evt1.changedTouches[0].identifier] = null;
			break;
		case "devicemotion":
			var evt1 = evt;
			this.__handleAccelerometer(evt1);
			break;
		case "orientationchange":
			this.__handleOrientationChange();
			break;
		default:
		}
	}
	,__isOnStage: function() {
		return true;
	}
	,__drag: function(point) {
		var p = this.__dragObject.parent;
		if(p != null) point = p.globalToLocal(point);
		var x = point.x + this.__dragOffsetX;
		var y = point.y + this.__dragOffsetY;
		if(this.__dragBounds != null) {
			if(x < this.__dragBounds.x) x = this.__dragBounds.x; else if(x > this.__dragBounds.get_right()) x = this.__dragBounds.get_right();
			if(y < this.__dragBounds.y) y = this.__dragBounds.y; else if(y > this.__dragBounds.get_bottom()) y = this.__dragBounds.get_bottom();
		}
		this.__dragObject.set_x(x);
		this.__dragObject.set_y(y);
	}
	,__checkInOuts: function(event,stack,touchInfo) {
		var prev = touchInfo == null?this.__mouseOverObjects:touchInfo.touchOverObjects;
		var changeEvents = touchInfo == null?flash.display.Stage.__mouseChanges:flash.display.Stage.__touchChanges;
		var new_n = stack.length;
		var new_obj = new_n > 0?stack[new_n - 1]:null;
		var old_n = prev.length;
		var old_obj = old_n > 0?prev[old_n - 1]:null;
		if(new_obj != old_obj) {
			if(old_obj != null) old_obj.__fireEvent(event.__createSimilar(changeEvents[0],new_obj,old_obj));
			if(new_obj != null) new_obj.__fireEvent(event.__createSimilar(changeEvents[1],old_obj,new_obj));
			var common = 0;
			while(common < new_n && common < old_n && stack[common] == prev[common]) common++;
			var rollOut = event.__createSimilar(changeEvents[2],new_obj,old_obj);
			var i = old_n - 1;
			while(i >= common) {
				prev[i].dispatchEvent(rollOut);
				i--;
			}
			var rollOver = event.__createSimilar(changeEvents[3],old_obj);
			var i1 = new_n - 1;
			while(i1 >= common) {
				stack[i1].dispatchEvent(rollOver);
				i1--;
			}
			if(touchInfo == null) this.__mouseOverObjects = stack; else touchInfo.touchOverObjects = stack;
		}
	}
	,toString: function() {
		return "[Stage id=" + this.___id + "]";
	}
	,invalidate: function() {
		this.__invalid = true;
	}
	,_mouseY: null
	,_mouseX: null
	,__windowHeight: null
	,__windowWidth: null
	,__uIEventsQueueIndex: null
	,__uIEventsQueue: null
	,__touchInfo: null
	,__timer: null
	,__stageMatrix: null
	,__stageActive: null
	,__showDefaultContextMenu: null
	,__mouseOverObjects: null
	,__invalid: null
	,__interval: null
	,__frameRate: null
	,__focusObjectActivated: null
	,__focusObject: null
	,__dragOffsetY: null
	,__dragOffsetX: null
	,__dragObject: null
	,__dragBounds: null
	,__backgroundColour: null
	,stageWidth: null
	,stageHeight: null
	,stageFocusRect: null
	,scaleMode: null
	,quality: null
	,__pointInPathMode: null
	,fullScreenWidth: null
	,fullScreenHeight: null
	,displayState: null
	,align: null
	,__class__: flash.display.Stage
	,__properties__: $extend(flash.display.DisplayObjectContainer.prototype.__properties__,{set_backgroundColor:"set_backgroundColor",get_backgroundColor:"get_backgroundColor",set_color:"set_color",get_color:"get_color",set_displayState:"set_displayState",get_displayState:"get_displayState",set_focus:"set_focus",get_focus:"get_focus",set_frameRate:"set_frameRate",get_frameRate:"get_frameRate",get_fullScreenHeight:"get_fullScreenHeight",get_fullScreenWidth:"get_fullScreenWidth",set_quality:"set_quality",get_quality:"get_quality",set_showDefaultContextMenu:"set_showDefaultContextMenu",get_showDefaultContextMenu:"get_showDefaultContextMenu",get_stageHeight:"get_stageHeight",get_stageWidth:"get_stageWidth"})
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
flash.events.ErrorEvent = function(type,bubbles,cancelable,text,id) {
	if(id == null) id = 0;
	flash.events.TextEvent.call(this,type,bubbles,cancelable);
	this.text = text;
	this.errorID = id;
};
$hxClasses["flash.events.ErrorEvent"] = flash.events.ErrorEvent;
flash.events.ErrorEvent.__name__ = ["flash","events","ErrorEvent"];
flash.events.ErrorEvent.__super__ = flash.events.TextEvent;
flash.events.ErrorEvent.prototype = $extend(flash.events.TextEvent.prototype,{
	errorID: null
	,__class__: flash.events.ErrorEvent
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
flash.events.TouchEvent.__create = function(type,event,touch,local,target) {
	var evt = new flash.events.TouchEvent(type,true,false,local.x,local.y,null,event.ctrlKey,event.altKey,event.shiftKey,false,0,null,0);
	evt.stageX = flash.Lib.get_current().get_stage().get_mouseX();
	evt.stageY = flash.Lib.get_current().get_stage().get_mouseY();
	evt.target = target;
	return evt;
}
flash.events.TouchEvent.__super__ = flash.events.Event;
flash.events.TouchEvent.prototype = $extend(flash.events.Event.prototype,{
	__createSimilar: function(type,related,targ) {
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
	__applyFilter: function(surface,rect,refreshCache) {
		if(refreshCache == null) refreshCache = false;
	}
	,__preFilter: function(surface) {
	}
	,clone: function() {
		return new flash.filters.BitmapFilter(this._mType);
	}
	,___cached: null
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
	this.___cached = false;
};
$hxClasses["flash.filters.DropShadowFilter"] = flash.filters.DropShadowFilter;
flash.filters.DropShadowFilter.__name__ = ["flash","filters","DropShadowFilter"];
flash.filters.DropShadowFilter.__super__ = flash.filters.BitmapFilter;
flash.filters.DropShadowFilter.prototype = $extend(flash.filters.BitmapFilter.prototype,{
	__applyFilter: function(surface,rect,refreshCache) {
		if(refreshCache == null) refreshCache = false;
		if(!this.___cached || refreshCache) {
			var distanceX = this.distance * Math.sin(2 * Math.PI * this.angle / 360.0);
			var distanceY = this.distance * Math.cos(2 * Math.PI * this.angle / 360.0);
			var blurRadius = Math.max(this.blurX,this.blurY);
			var context = surface.getContext("2d");
			context.shadowOffsetX = distanceX;
			context.shadowOffsetY = distanceY;
			context.shadowBlur = blurRadius;
			context.shadowColor = "rgba(" + (this.color >> 16 & 255) + "," + (this.color >> 8 & 255) + "," + (this.color & 255) + "," + this.alpha + ")";
			this.___cached = true;
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
	,__translateTransformed: function(inPos) {
		this.set_tx(inPos.x * this.a + inPos.y * this.c + this.tx);
		this.set_ty(inPos.x * this.b + inPos.y * this.d + this.ty);
		this.a = Math.round(this.a * 1000) / 1000;
		this.b = Math.round(this.b * 1000) / 1000;
		this.c = Math.round(this.c * 1000) / 1000;
		this.d = Math.round(this.d * 1000) / 1000;
		this.set_tx(Math.round(this.tx * 10) / 10);
		this.set_ty(Math.round(this.ty * 10) / 10);
	}
	,__transformY: function(inPos) {
		return inPos.x * this.b + inPos.y * this.d + this.ty;
	}
	,__transformX: function(inPos) {
		return inPos.x * this.a + inPos.y * this.c + this.tx;
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
	,setTo: function(xa,ya) {
		this.x = xa;
		this.y = ya;
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
		this._displayObject.__matrixOverridden();
		return this._matrix;
	}
	,get_matrix: function() {
		return this._matrix.clone();
	}
	,get_concatenatedMatrix: function() {
		return this.__getFullMatrix(this._matrix);
	}
	,set_colorTransform: function(inValue) {
		this.colorTransform = inValue;
		return inValue;
	}
	,__setMatrix: function(inValue) {
		this._matrix.copy(inValue);
	}
	,__setFullMatrix: function(inValue) {
		this._fullMatrix.copy(inValue);
		return this._fullMatrix;
	}
	,__getFullMatrix: function(localMatrix) {
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
	this.__soundChannels = new haxe.ds.IntMap();
	this.__soundIdx = 0;
	if(stream != null) this.load(stream,context);
};
$hxClasses["flash.media.Sound"] = flash.media.Sound;
flash.media.Sound.__name__ = ["flash","media","Sound"];
flash.media.Sound.__canPlayMime = function(mime) {
	var audio = js.Browser.document.createElement("audio");
	var playable = function(ok) {
		if(ok != "" && ok != "no") return true; else return false;
	};
	return playable(audio.canPlayType(mime,null));
}
flash.media.Sound.__canPlayType = function(extension) {
	var mime = flash.media.Sound.__mimeForExtension(extension);
	if(mime == null) return false;
	return flash.media.Sound.__canPlayMime(mime);
}
flash.media.Sound.__mimeForExtension = function(extension) {
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
	__onSoundLoaded: function(evt) {
		this.__removeEventListeners();
		var evt1 = new flash.events.Event(flash.events.Event.COMPLETE);
		this.dispatchEvent(evt1);
	}
	,__onSoundLoadError: function(evt) {
		this.__removeEventListeners();
		haxe.Log.trace("Error loading sound '" + this.__streamUrl + "'",{ fileName : "Sound.hx", lineNumber : 206, className : "flash.media.Sound", methodName : "__onSoundLoadError"});
		var evt1 = new flash.events.IOErrorEvent(flash.events.IOErrorEvent.IO_ERROR);
		this.dispatchEvent(evt1);
	}
	,__removeEventListeners: function() {
		this.__soundCache.removeEventListener(flash.events.Event.COMPLETE,$bind(this,this.__onSoundLoaded),false);
		this.__soundCache.removeEventListener(flash.events.IOErrorEvent.IO_ERROR,$bind(this,this.__onSoundLoadError),false);
	}
	,__load: function(stream,context,mime) {
		if(mime == null) mime = "";
		if(mime == null) {
			var url = stream.url.split("?");
			var extension = HxOverrides.substr(url[0],url[0].lastIndexOf(".") + 1,null);
			mime = flash.media.Sound.__mimeForExtension(extension);
		}
		if(mime == null || !flash.media.Sound.__canPlayMime(mime)) haxe.Log.trace("Warning: '" + stream.url + "' with type '" + mime + "' may not play on this browser.",{ fileName : "Sound.hx", lineNumber : 144, className : "flash.media.Sound", methodName : "__load"});
		this.__streamUrl = stream.url;
		try {
			this.__soundCache = new flash.net.URLLoader();
			this.__addEventListeners();
			this.__soundCache.load(stream);
		} catch( e ) {
			haxe.Log.trace("Warning: Could not preload '" + stream.url + "'",{ fileName : "Sound.hx", lineNumber : 159, className : "flash.media.Sound", methodName : "__load"});
		}
	}
	,__addEventListeners: function() {
		this.__soundCache.addEventListener(flash.events.Event.COMPLETE,$bind(this,this.__onSoundLoaded));
		this.__soundCache.addEventListener(flash.events.IOErrorEvent.IO_ERROR,$bind(this,this.__onSoundLoadError));
	}
	,play: function(startTime,loops,sndTransform) {
		if(loops == null) loops = 0;
		if(startTime == null) startTime = 0.0;
		if(this.__streamUrl == null) return null;
		var self = this;
		var curIdx = this.__soundIdx;
		var removeRef = function() {
			self.__soundChannels.remove(curIdx);
		};
		var channel = flash.media.SoundChannel.__create(this.__streamUrl,startTime,loops,sndTransform,removeRef);
		this.__soundChannels.set(curIdx,channel);
		this.__soundIdx++;
		var audio = channel.__audio;
		return channel;
	}
	,load: function(stream,context) {
		this.__load(stream,context);
	}
	,close: function() {
	}
	,__streamUrl: null
	,__soundIdx: null
	,__soundChannels: null
	,__soundCache: null
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
	this.__audioCurrentLoop = 1;
	this.__audioTotalLoops = 1;
};
$hxClasses["flash.media.SoundChannel"] = flash.media.SoundChannel;
flash.media.SoundChannel.__name__ = ["flash","media","SoundChannel"];
flash.media.SoundChannel.__create = function(src,startTime,loops,sndTransform,removeRef) {
	if(loops == null) loops = 0;
	if(startTime == null) startTime = 0.0;
	var channel = new flash.media.SoundChannel();
	channel.__audio = js.Browser.document.createElement("audio");
	channel.__removeRef = removeRef;
	channel.__audio.addEventListener("ended",$bind(channel,channel.__onSoundChannelFinished),false);
	channel.__audio.addEventListener("seeked",$bind(channel,channel.__onSoundSeeked),false);
	channel.__audio.addEventListener("stalled",$bind(channel,channel.__onStalled),false);
	channel.__audio.addEventListener("progress",$bind(channel,channel.__onProgress),false);
	if(loops > 0) {
		channel.__audioTotalLoops = loops;
		channel.__audio.loop = true;
	}
	channel.__startTime = startTime;
	if(startTime > 0.) {
		var onLoad = null;
		onLoad = function(_) {
			channel.__audio.currentTime = channel.__startTime;
			channel.__audio.play();
			channel.__audio.removeEventListener("canplaythrough",onLoad,false);
		};
		channel.__audio.addEventListener("canplaythrough",onLoad,false);
	} else channel.__audio.autoplay = true;
	channel.__audio.src = src;
	return channel;
}
flash.media.SoundChannel.__super__ = flash.events.EventDispatcher;
flash.media.SoundChannel.prototype = $extend(flash.events.EventDispatcher.prototype,{
	set_soundTransform: function(v) {
		this.__audio.volume = v.volume;
		return this.soundTransform = v;
	}
	,__onStalled: function(evt) {
		haxe.Log.trace("sound stalled",{ fileName : "SoundChannel.hx", lineNumber : 173, className : "flash.media.SoundChannel", methodName : "__onStalled"});
		if(this.__audio != null) this.__audio.load();
	}
	,__onSoundSeeked: function(evt) {
		if(this.__audioCurrentLoop >= this.__audioTotalLoops) {
			this.__audio.loop = false;
			this.stop();
		} else this.__audioCurrentLoop++;
	}
	,__onSoundChannelFinished: function(evt) {
		if(this.__audioCurrentLoop >= this.__audioTotalLoops) {
			this.__audio.removeEventListener("ended",$bind(this,this.__onSoundChannelFinished),false);
			this.__audio.removeEventListener("seeked",$bind(this,this.__onSoundSeeked),false);
			this.__audio.removeEventListener("stalled",$bind(this,this.__onStalled),false);
			this.__audio.removeEventListener("progress",$bind(this,this.__onProgress),false);
			this.__audio = null;
			var evt1 = new flash.events.Event(flash.events.Event.SOUND_COMPLETE);
			evt1.target = this;
			this.dispatchEvent(evt1);
			if(this.__removeRef != null) this.__removeRef();
		} else {
			this.__audio.currentTime = this.__startTime;
			this.__audio.play();
		}
	}
	,__onProgress: function(evt) {
		haxe.Log.trace("sound progress: " + Std.string(evt),{ fileName : "SoundChannel.hx", lineNumber : 117, className : "flash.media.SoundChannel", methodName : "__onProgress"});
	}
	,stop: function() {
		if(this.__audio != null) {
			this.__audio.pause();
			this.__audio = null;
			if(this.__removeRef != null) this.__removeRef();
		}
	}
	,__startTime: null
	,__removeRef: null
	,__audioTotalLoops: null
	,__audioCurrentLoop: null
	,soundTransform: null
	,rightPeak: null
	,position: null
	,__audio: null
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
	this.volume = vol;
	this.pan = panning;
	this.leftToLeft = 0;
	this.leftToRight = 0;
	this.rightToLeft = 0;
	this.rightToRight = 0;
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
	set_dataFormat: function(inputVal) {
		if(inputVal == flash.net.URLLoaderDataFormat.BINARY && !Reflect.hasField(js.Browser.window,"ArrayBuffer")) this.dataFormat = flash.net.URLLoaderDataFormat.TEXT; else this.dataFormat = inputVal;
		return this.dataFormat;
	}
	,onStatus: function(status) {
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
			this.data = flash.utils.ByteArray.__ofBuffer(content);
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
flash.ui = {}
flash.ui.Keyboard = function() { }
$hxClasses["flash.ui.Keyboard"] = flash.ui.Keyboard;
flash.ui.Keyboard.__name__ = ["flash","ui","Keyboard"];
flash.ui.Keyboard.isAccessible = function() {
	return false;
}
flash.ui.Keyboard.__convertMozillaCode = function(code) {
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
flash.ui.Keyboard.__convertWebkitCode = function(code) {
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
	this.___resizeBuffer(this.allocated);
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
flash.utils.ByteArray.__ofBuffer = function(buffer) {
	var bytes = new flash.utils.ByteArray();
	bytes.set_length(bytes.allocated = buffer.byteLength);
	bytes.data = new DataView(buffer);
	bytes.byteView = new Uint8Array(buffer);
	return bytes;
}
flash.utils.ByteArray.prototype = {
	set_length: function(value) {
		if(this.allocated < value) this.___resizeBuffer(this.allocated = Math.max(value,this.allocated * 2) | 0); else if(this.allocated > value) this.___resizeBuffer(this.allocated = value);
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
	,__set: function(pos,v) {
		this.data.setUint8(pos,v);
	}
	,__getBuffer: function() {
		return this.data.buffer;
	}
	,___resizeBuffer: function(len) {
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
	,__get: function(pos) {
		return this.data.getUint8(pos);
	}
	,__fromBytes: function(inBytes) {
		this.byteView = new Uint8Array(inBytes.b);
		this.set_length(this.byteView.length);
		this.allocated = this.length;
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
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setUint16(this.position,value,this.littleEndian);
		this.position += 2;
	}
	,writeUnsignedInt: function(value) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setUint32(this.position,value,this.littleEndian);
		this.position += 4;
	}
	,writeShort: function(value) {
		var lengthToEnsure = this.position + 2;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setInt16(this.position,value,this.littleEndian);
		this.position += 2;
	}
	,writeInt: function(value) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setInt32(this.position,value,this.littleEndian);
		this.position += 4;
	}
	,writeFloat: function(x) {
		var lengthToEnsure = this.position + 4;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.data.setFloat32(this.position,x,this.littleEndian);
		this.position += 4;
	}
	,writeDouble: function(x) {
		var lengthToEnsure = this.position + 8;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
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
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
			this.length = lengthToEnsure;
			lengthToEnsure;
		}
		this.byteView.set(bytes.byteView.subarray(offset,offset + length),this.position);
		this.position += length;
	}
	,writeByte: function(value) {
		var lengthToEnsure = this.position + 1;
		if(this.length < lengthToEnsure) {
			if(this.allocated < lengthToEnsure) this.___resizeBuffer(this.allocated = Math.max(lengthToEnsure,this.allocated * 2) | 0); else if(this.allocated > lengthToEnsure) this.___resizeBuffer(this.allocated = lengthToEnsure);
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
			if(this.allocated < len) this.___resizeBuffer(this.allocated = Math.max(len,this.allocated * 2) | 0); else if(this.allocated > len) this.___resizeBuffer(this.allocated = len);
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
			if(bytes.allocated < lengthToEnsure) bytes.___resizeBuffer(bytes.allocated = Math.max(lengthToEnsure,bytes.allocated * 2) | 0); else if(bytes.allocated > lengthToEnsure) bytes.___resizeBuffer(bytes.allocated = lengthToEnsure);
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
	,clear: function() {
		if(this.allocated < 0) this.___resizeBuffer(this.allocated = Math.max(0,this.allocated * 2) | 0); else if(this.allocated > 0) this.___resizeBuffer(this.allocated = 0);
		this.length = 0;
		0;
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
haxe.Log = function() { }
$hxClasses["haxe.Log"] = haxe.Log;
haxe.Log.__name__ = ["haxe","Log"];
haxe.Log.trace = function(v,infos) {
	js.Boot.__trace(v,infos);
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
	keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key | 0);
		}
		return HxOverrides.iter(a);
	}
	,remove: function(key) {
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
	set: function(key,value) {
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
haxe.io.Bytes = function() { }
$hxClasses["haxe.io.Bytes"] = haxe.io.Bytes;
haxe.io.Bytes.__name__ = ["haxe","io","Bytes"];
haxe.io.Bytes.prototype = {
	b: null
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
haxe.unit = {}
haxe.unit.TestCase = function() {
};
$hxClasses["haxe.unit.TestCase"] = haxe.unit.TestCase;
haxe.unit.TestCase.__name__ = ["haxe","unit","TestCase"];
haxe.unit.TestCase.prototype = {
	assertEquals: function(expected,actual,c) {
		this.currentTest.done = true;
		if(actual != expected) {
			this.currentTest.success = false;
			this.currentTest.error = "expected '" + Std.string(expected) + "' but was '" + Std.string(actual) + "'";
			this.currentTest.posInfos = c;
			throw this.currentTest;
		}
	}
	,assertFalse: function(b,c) {
		this.currentTest.done = true;
		if(b == true) {
			this.currentTest.success = false;
			this.currentTest.error = "expected false but was true";
			this.currentTest.posInfos = c;
			throw this.currentTest;
		}
	}
	,assertTrue: function(b,c) {
		this.currentTest.done = true;
		if(b == false) {
			this.currentTest.success = false;
			this.currentTest.error = "expected true but was false";
			this.currentTest.posInfos = c;
			throw this.currentTest;
		}
	}
	,print: function(v) {
		haxe.unit.TestRunner.print(v);
	}
	,tearDown: function() {
	}
	,setup: function() {
	}
	,currentTest: null
	,__class__: haxe.unit.TestCase
}
haxe.unit.TestResult = function() {
	this.m_tests = new List();
	this.success = true;
};
$hxClasses["haxe.unit.TestResult"] = haxe.unit.TestResult;
haxe.unit.TestResult.__name__ = ["haxe","unit","TestResult"];
haxe.unit.TestResult.prototype = {
	toString: function() {
		var buf = new StringBuf();
		var failures = 0;
		var $it0 = this.m_tests.iterator();
		while( $it0.hasNext() ) {
			var test = $it0.next();
			if(test.success == false) {
				buf.b += "* ";
				buf.b += Std.string(test.classname);
				buf.b += "::";
				buf.b += Std.string(test.method);
				buf.b += "()";
				buf.b += "\n";
				buf.b += "ERR: ";
				if(test.posInfos != null) {
					buf.b += Std.string(test.posInfos.fileName);
					buf.b += ":";
					buf.b += Std.string(test.posInfos.lineNumber);
					buf.b += "(";
					buf.b += Std.string(test.posInfos.className);
					buf.b += ".";
					buf.b += Std.string(test.posInfos.methodName);
					buf.b += ") - ";
				}
				buf.b += Std.string(test.error);
				buf.b += "\n";
				if(test.backtrace != null) {
					buf.b += Std.string(test.backtrace);
					buf.b += "\n";
				}
				buf.b += "\n";
				failures++;
			}
		}
		buf.b += "\n";
		if(failures == 0) buf.b += "OK "; else buf.b += "FAILED ";
		buf.b += Std.string(this.m_tests.length);
		buf.b += " tests, ";
		buf.b += Std.string(failures);
		buf.b += " failed, ";
		buf.b += Std.string(this.m_tests.length - failures);
		buf.b += " success";
		buf.b += "\n";
		return buf.b;
	}
	,add: function(t) {
		this.m_tests.add(t);
		if(!t.success) this.success = false;
	}
	,success: null
	,m_tests: null
	,__class__: haxe.unit.TestResult
}
haxe.unit.TestRunner = function() {
	this.result = new haxe.unit.TestResult();
	this.cases = new List();
};
$hxClasses["haxe.unit.TestRunner"] = haxe.unit.TestRunner;
haxe.unit.TestRunner.__name__ = ["haxe","unit","TestRunner"];
haxe.unit.TestRunner.print = function(v) {
	var msg = StringTools.htmlEscape(js.Boot.__string_rec(v,"")).split("\n").join("<br/>");
	var d = document.getElementById("haxe:trace");
	if(d == null) alert("haxe:trace element not found"); else d.innerHTML += msg;
}
haxe.unit.TestRunner.customTrace = function(v,p) {
	haxe.unit.TestRunner.print(p.fileName + ":" + p.lineNumber + ": " + Std.string(v) + "\n");
}
haxe.unit.TestRunner.prototype = {
	runCase: function(t) {
		var old = haxe.Log.trace;
		haxe.Log.trace = haxe.unit.TestRunner.customTrace;
		var cl = Type.getClass(t);
		var fields = Type.getInstanceFields(cl);
		haxe.unit.TestRunner.print("Class: " + Type.getClassName(cl) + " ");
		var _g = 0;
		while(_g < fields.length) {
			var f = fields[_g];
			++_g;
			var fname = f;
			var field = Reflect.field(t,f);
			if(StringTools.startsWith(fname,"test") && Reflect.isFunction(field)) {
				t.currentTest = new haxe.unit.TestStatus();
				t.currentTest.classname = Type.getClassName(cl);
				t.currentTest.method = fname;
				t.setup();
				try {
					field.apply(t,new Array());
					if(t.currentTest.done) {
						t.currentTest.success = true;
						haxe.unit.TestRunner.print(".");
					} else {
						t.currentTest.success = false;
						t.currentTest.error = "(warning) no assert";
						haxe.unit.TestRunner.print("W");
					}
				} catch( $e0 ) {
					if( js.Boot.__instanceof($e0,haxe.unit.TestStatus) ) {
						var e = $e0;
						haxe.unit.TestRunner.print("F");
						t.currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
					} else {
					var e = $e0;
					haxe.unit.TestRunner.print("E");
					if(e.message != null) t.currentTest.error = "exception thrown : " + Std.string(e) + " [" + Std.string(e.message) + "]"; else t.currentTest.error = "exception thrown : " + Std.string(e);
					t.currentTest.backtrace = haxe.CallStack.toString(haxe.CallStack.exceptionStack());
					}
				}
				this.result.add(t.currentTest);
				t.tearDown();
			}
		}
		haxe.unit.TestRunner.print("\n");
		haxe.Log.trace = old;
	}
	,run: function() {
		this.result = new haxe.unit.TestResult();
		var $it0 = this.cases.iterator();
		while( $it0.hasNext() ) {
			var c = $it0.next();
			this.runCase(c);
		}
		haxe.unit.TestRunner.print(this.result.toString());
		return this.result.success;
	}
	,add: function(c) {
		this.cases.add(c);
	}
	,cases: null
	,result: null
	,__class__: haxe.unit.TestRunner
}
haxe.unit.TestStatus = function() {
	this.done = false;
	this.success = false;
};
$hxClasses["haxe.unit.TestStatus"] = haxe.unit.TestStatus;
haxe.unit.TestStatus.__name__ = ["haxe","unit","TestStatus"];
haxe.unit.TestStatus.prototype = {
	backtrace: null
	,posInfos: null
	,classname: null
	,method: null
	,error: null
	,success: null
	,done: null
	,__class__: haxe.unit.TestStatus
}
haxe.xml = {}
haxe.xml.Parser = function() { }
$hxClasses["haxe.xml.Parser"] = haxe.xml.Parser;
haxe.xml.Parser.__name__ = ["haxe","xml","Parser"];
haxe.xml.Parser.parse = function(str) {
	var doc = Xml.createDocument();
	haxe.xml.Parser.doParse(str,0,doc);
	return doc;
}
haxe.xml.Parser.doParse = function(str,p,parent) {
	if(p == null) p = 0;
	var xml = null;
	var state = 1;
	var next = 1;
	var aname = null;
	var start = 0;
	var nsubs = 0;
	var nbrackets = 0;
	var c = str.charCodeAt(p);
	var buf = new StringBuf();
	while(!(c != c)) {
		switch(state) {
		case 0:
			switch(c) {
			case 10:case 13:case 9:case 32:
				break;
			default:
				state = next;
				continue;
			}
			break;
		case 1:
			switch(c) {
			case 60:
				state = 0;
				next = 2;
				break;
			default:
				start = p;
				state = 13;
				continue;
			}
			break;
		case 13:
			if(c == 60) {
				var child = Xml.createPCData(buf.b + HxOverrides.substr(str,start,p - start));
				buf = new StringBuf();
				parent.addChild(child);
				nsubs++;
				state = 0;
				next = 2;
			} else if(c == 38) {
				buf.addSub(str,start,p - start);
				state = 18;
				next = 13;
				start = p + 1;
			}
			break;
		case 17:
			if(c == 93 && str.charCodeAt(p + 1) == 93 && str.charCodeAt(p + 2) == 62) {
				var child = Xml.createCData(HxOverrides.substr(str,start,p - start));
				parent.addChild(child);
				nsubs++;
				p += 2;
				state = 1;
			}
			break;
		case 2:
			switch(c) {
			case 33:
				if(str.charCodeAt(p + 1) == 91) {
					p += 2;
					if(HxOverrides.substr(str,p,6).toUpperCase() != "CDATA[") throw "Expected <![CDATA[";
					p += 5;
					state = 17;
					start = p + 1;
				} else if(str.charCodeAt(p + 1) == 68 || str.charCodeAt(p + 1) == 100) {
					if(HxOverrides.substr(str,p + 2,6).toUpperCase() != "OCTYPE") throw "Expected <!DOCTYPE";
					p += 8;
					state = 16;
					start = p + 1;
				} else if(str.charCodeAt(p + 1) != 45 || str.charCodeAt(p + 2) != 45) throw "Expected <!--"; else {
					p += 2;
					state = 15;
					start = p + 1;
				}
				break;
			case 63:
				state = 14;
				start = p;
				break;
			case 47:
				if(parent == null) throw "Expected node name";
				start = p + 1;
				state = 0;
				next = 10;
				break;
			default:
				state = 3;
				start = p;
				continue;
			}
			break;
		case 3:
			if(!(c >= 97 && c <= 122 || c >= 65 && c <= 90 || c >= 48 && c <= 57 || c == 58 || c == 46 || c == 95 || c == 45)) {
				if(p == start) throw "Expected node name";
				xml = Xml.createElement(HxOverrides.substr(str,start,p - start));
				parent.addChild(xml);
				state = 0;
				next = 4;
				continue;
			}
			break;
		case 4:
			switch(c) {
			case 47:
				state = 11;
				nsubs++;
				break;
			case 62:
				state = 9;
				nsubs++;
				break;
			default:
				state = 5;
				start = p;
				continue;
			}
			break;
		case 5:
			if(!(c >= 97 && c <= 122 || c >= 65 && c <= 90 || c >= 48 && c <= 57 || c == 58 || c == 46 || c == 95 || c == 45)) {
				var tmp;
				if(start == p) throw "Expected attribute name";
				tmp = HxOverrides.substr(str,start,p - start);
				aname = tmp;
				if(xml.exists(aname)) throw "Duplicate attribute";
				state = 0;
				next = 6;
				continue;
			}
			break;
		case 6:
			switch(c) {
			case 61:
				state = 0;
				next = 7;
				break;
			default:
				throw "Expected =";
			}
			break;
		case 7:
			switch(c) {
			case 34:case 39:
				state = 8;
				start = p;
				break;
			default:
				throw "Expected \"";
			}
			break;
		case 8:
			if(c == str.charCodeAt(start)) {
				var val = HxOverrides.substr(str,start + 1,p - start - 1);
				xml.set(aname,val);
				state = 0;
				next = 4;
			}
			break;
		case 9:
			p = haxe.xml.Parser.doParse(str,p,xml);
			start = p;
			state = 1;
			break;
		case 11:
			switch(c) {
			case 62:
				state = 1;
				break;
			default:
				throw "Expected >";
			}
			break;
		case 12:
			switch(c) {
			case 62:
				if(nsubs == 0) parent.addChild(Xml.createPCData(""));
				return p;
			default:
				throw "Expected >";
			}
			break;
		case 10:
			if(!(c >= 97 && c <= 122 || c >= 65 && c <= 90 || c >= 48 && c <= 57 || c == 58 || c == 46 || c == 95 || c == 45)) {
				if(start == p) throw "Expected node name";
				var v = HxOverrides.substr(str,start,p - start);
				if(v != parent.get_nodeName()) throw "Expected </" + parent.get_nodeName() + ">";
				state = 0;
				next = 12;
				continue;
			}
			break;
		case 15:
			if(c == 45 && str.charCodeAt(p + 1) == 45 && str.charCodeAt(p + 2) == 62) {
				parent.addChild(Xml.createComment(HxOverrides.substr(str,start,p - start)));
				p += 2;
				state = 1;
			}
			break;
		case 16:
			if(c == 91) nbrackets++; else if(c == 93) nbrackets--; else if(c == 62 && nbrackets == 0) {
				parent.addChild(Xml.createDocType(HxOverrides.substr(str,start,p - start)));
				state = 1;
			}
			break;
		case 14:
			if(c == 63 && str.charCodeAt(p + 1) == 62) {
				p++;
				var str1 = HxOverrides.substr(str,start + 1,p - start - 2);
				parent.addChild(Xml.createProcessingInstruction(str1));
				state = 1;
			}
			break;
		case 18:
			if(c == 59) {
				var s = HxOverrides.substr(str,start,p - start);
				if(s.charCodeAt(0) == 35) {
					var i = s.charCodeAt(1) == 120?Std.parseInt("0" + HxOverrides.substr(s,1,s.length - 1)):Std.parseInt(HxOverrides.substr(s,1,s.length - 1));
					buf.b += Std.string(String.fromCharCode(i));
				} else if(!haxe.xml.Parser.escapes.exists(s)) buf.b += Std.string("&" + s + ";"); else buf.b += Std.string(haxe.xml.Parser.escapes.get(s));
				start = p + 1;
				state = next;
			}
			break;
		}
		c = str.charCodeAt(++p);
	}
	if(state == 1) {
		start = p;
		state = 13;
	}
	if(state == 13) {
		if(p != start || nsubs == 0) parent.addChild(Xml.createPCData(buf.b + HxOverrides.substr(str,start,p - start)));
		return p;
	}
	throw "Unexpected end";
}
var jasononeil = {}
jasononeil.CleverSort = function() { }
$hxClasses["jasononeil.CleverSort"] = jasononeil.CleverSort;
jasononeil.CleverSort.__name__ = ["jasononeil","CleverSort"];
var js = {}
js.Boot = function() { }
$hxClasses["js.Boot"] = js.Boot;
js.Boot.__name__ = ["js","Boot"];
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = i != null?i.fileName + ":" + i.lineNumber + ": ":"";
	msg += js.Boot.__string_rec(v,"");
	if(i != null && i.customParams != null) {
		var _g = 0, _g1 = i.customParams;
		while(_g < _g1.length) {
			var v1 = _g1[_g];
			++_g;
			msg += "," + js.Boot.__string_rec(v1,"");
		}
	}
	var d;
	if(typeof(document) != "undefined" && (d = document.getElementById("haxe:trace")) != null) d.innerHTML += js.Boot.__unhtml(msg) + "<br/>"; else if(typeof(console) != "undefined" && console.log != null) console.log(msg);
}
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
nx3.Constants = function() { }
$hxClasses["nx3.Constants"] = nx3.Constants;
nx3.Constants.__name__ = ["nx3","Constants"];
nx3.elements = {}
nx3.elements.interfaces = {}
nx3.elements.interfaces.IDistanceRects = function() { }
$hxClasses["nx3.elements.interfaces.IDistanceRects"] = nx3.elements.interfaces.IDistanceRects;
nx3.elements.interfaces.IDistanceRects.__name__ = ["nx3","elements","interfaces","IDistanceRects"];
nx3.elements.interfaces.IDistanceRects.prototype = {
	rectsBack: null
	,rectCenter: null
	,rectsFront: null
	,__class__: nx3.elements.interfaces.IDistanceRects
}
nx3.elements.DComplex = function(dnotes) {
	this.headsRect_ = null;
	this.dnotes = dnotes;
	this.signs = this.getSigns_(dnotes);
	this.avoidCollisions_();
	this.get_headsRect();
};
$hxClasses["nx3.elements.DComplex"] = nx3.elements.DComplex;
nx3.elements.DComplex.__name__ = ["nx3","elements","DComplex"];
nx3.elements.DComplex.__interfaces__ = [nx3.elements.interfaces.IDistanceRects];
nx3.elements.DComplex.prototype = {
	avoidCollisions_: function() {
		if(this.dnotes.length > 1) {
			var diff = this.dnotes[1].get_headTop().level - this.dnotes[0].get_headBottom().level;
			if(diff == 1) this.dnotes[1].set_xAdjust(3.0); else if(diff == 0) {
				if(this.dnotes[1].value != this.dnotes[0].value) this.dnotes[1].set_xAdjust(this.dnotes[0].get_headsRect().x + this.dnotes[0].get_headsRect().width - this.dnotes[1].get_headsRect().x + 0.6);
			} else if(diff < 1) {
				if(this.dnotes[1].value == this.dnotes[0].value) {
					if(nx3.elements.tools.HeadsTool.headsCollide(this.dnotes[0].get_heads(),this.dnotes[1].get_heads())) this.dnotes[1].set_xAdjust(this.dnotes[0].get_headsRect().x + this.dnotes[0].get_headsRect().width - this.dnotes[1].get_headsRect().x + 0.6); else this.dnotes[1].set_xAdjust(-0.6);
				} else this.dnotes[1].set_xAdjust(this.dnotes[0].get_headsRect().x + this.dnotes[0].get_headsRect().width - this.dnotes[1].get_headsRect().x + 0.6);
			} else {
			}
		}
	}
	,get_dnotesXAdjust: function() {
		return null;
	}
	,get_signRects: function() {
		if(this.signRects_ != null) return this.signRects_;
		if(this.signs.length == 0) return null;
		this.signRects_ = [];
		var currentRect = null;
		var _g = 0, _g1 = this.signs;
		while(_g < _g1.length) {
			var sign = _g1[_g];
			++_g;
			currentRect = nx3.elements.tools.SignsTools.getSignRect(sign.sign);
			currentRect.offset(0,sign.level);
			if(currentRect == null) continue;
			currentRect.offset(-currentRect.width,0);
			var xMove = 0;
			var _g2 = 0, _g3 = this.signRects_;
			while(_g2 < _g3.length) {
				var checkRect = _g3[_g2];
				++_g2;
				var isect = checkRect.intersection(currentRect);
				if(checkRect.intersects(currentRect)) currentRect.x = checkRect.x - currentRect.width;
			}
			this.signRects_.push(currentRect);
		}
		if(this.signRects_.length == 0) {
			this.signRects_ = null;
			return this.signRects_;
		}
		var combineRect = this.signRects_[0];
		var _g = 0, _g1 = this.signRects_;
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			if(combineRect == rect) {
			} else combineRect = combineRect.union(rect);
		}
		var _g = 0, _g1 = this.signRects_;
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			rect.offset(combineRect.width,0);
		}
		return this.signRects_;
	}
	,signRects_: null
	,signRects: null
	,get_signsFrame: function() {
		if(this.signsFrame_ != null) return this.signsFrame_;
		if(this.get_signRects() == null) return null;
		var _g = 0, _g1 = this.get_signRects();
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			if(this.signsFrame_ == null) this.signsFrame_ = rect.clone(); else this.signsFrame_ = this.signsFrame_.union(rect);
		}
		this.signsFrame_.x = this.get_headsRect().x - this.signsFrame_.width - 0.8;
		return this.signsFrame_;
	}
	,signsFrame_: null
	,signsFrame: null
	,getSigns_: function(dnotes) {
		var signs = new Array();
		var _g = 0;
		while(_g < dnotes.length) {
			var dnote = dnotes[_g];
			++_g;
			var _g1 = 0, _g2 = dnote.get_heads();
			while(_g1 < _g2.length) {
				var head = _g2[_g1];
				++_g1;
				signs.push({ sign : head.sign, level : head.level, position : 0});
			}
		}
		return nx3.elements.tools.SignsTools.adjustPositions(signs);
	}
	,get_headsRect: function() {
		if(this.headsRect_ != null) return this.headsRect_;
		this.headsRect_ = this.dnotes[0].get_headsRect();
		this.headsRect_.offset(this.dnotes[0].get_xAdjust(),0);
		if(this.dnotes.length == 1) return this.headsRect_;
		var _g1 = 1, _g = this.dnotes.length;
		while(_g1 < _g) {
			var i = _g1++;
			var dnoteRect = this.dnotes[i].get_headsRect();
			dnoteRect.offset(this.dnotes[i].get_xAdjust(),0);
			this.headsRect_ = this.headsRect_.union(dnoteRect);
		}
		return this.headsRect_;
	}
	,headsRect: null
	,headsRect_: null
	,rectsBack: null
	,get_rectsBack: function() {
		return this.rectsBack_;
	}
	,rectsBack_: null
	,rectCenter: null
	,get_rectCenter: function() {
		return this.rectCenter_;
	}
	,rectCenter_: null
	,rectsFront: null
	,get_rectsFront: function() {
		return this.rectsFront_;
	}
	,rectsFront_: null
	,dnotesXAdjust: null
	,position: null
	,signs: null
	,dnotes: null
	,__class__: nx3.elements.DComplex
	,__properties__: {get_dnotesXAdjust:"get_dnotesXAdjust",get_rectsFront:"get_rectsFront",get_rectCenter:"get_rectCenter",get_rectsBack:"get_rectsBack",get_headsRect:"get_headsRect",get_signsFrame:"get_signsFrame",get_signRects:"get_signRects"}
}
nx3.elements.DNote = function(note,variant,articulations,attributes,forceDirection) {
	this.xAdjust_ = 0;
	this.headRects_ = null;
	this.note = note;
	this.variant = variant == null?nx3.elements.ENotationVariant.Normal:variant;
	this.articulations = articulations == null?[]:articulations;
	this.attributes = attributes == null?[]:attributes;
	this.forceDirection = forceDirection;
	this.levelTop = this.note.get_nheads()[0].level;
	this.levelBottom = this.note.get_nheads()[this.note.get_nheads().length - 1].level;
	this.value = this.note.value;
	this.type = this.note.type;
};
$hxClasses["nx3.elements.DNote"] = nx3.elements.DNote;
nx3.elements.DNote.__name__ = ["nx3","elements","DNote"];
nx3.elements.DNote.prototype = {
	reset: function() {
		this.headRects_ = null;
		this.headsRect_ = null;
	}
	,set_xAdjust: function(val) {
		return this.xAdjust_ = val;
	}
	,get_xAdjust: function() {
		return this.xAdjust_;
	}
	,xAdjust_: null
	,get_headsRect: function() {
		if(this.headsRect_ != null) return this.headsRect_;
		this.headsRect_ = this.get_headRects()[0];
		if(this.get_heads().length > 1) {
			var _g1 = 1, _g = this.get_heads().length;
			while(_g1 < _g) {
				var i = _g1++;
				this.headsRect_ = this.headsRect_.union(this.get_headRects()[i]);
			}
		}
		return this.headsRect_;
	}
	,headsRect: null
	,headsRect_: null
	,get_headBottom: function() {
		if(this.headBottom_ != null) return this.headBottom_;
		this.headBottom_ = this.get_heads()[this.get_heads().length - 1];
		return this.headBottom_;
	}
	,headBottom: null
	,headBottom_: null
	,get_headTop: function() {
		if(this.heads_ != null) return this.heads_[0];
		return this.get_heads()[0];
	}
	,headTop: null
	,get_heads: function() {
		if(this.heads_ != null) return this.heads_;
		this.heads_ = this.note.get_nheads();
		return this.heads_;
	}
	,heads: null
	,heads_: null
	,get_midLevel: function() {
		if(this.midLevel_ != null) return this.midLevel_;
		this.midLevel_ = nx3.elements.tools.HeadsTool.midLevel(this.note.get_nheads());
		return this.midLevel_;
	}
	,midLevel_: null
	,midLevel: null
	,get_headRects: function() {
		if(this.headRects_ != null) return this.headRects_;
		this.headRects_ = [];
		var headPositions = nx3.elements.tools.HeadsTool.getHeadPositions(this.note.get_nheads(),this.get_direction());
		var i = 0;
		var _g = 0, _g1 = this.note.get_nheads();
		while(_g < _g1.length) {
			var head = _g1[_g];
			++_g;
			var rect = nx3.elements.tools.HeadTool.getHeadRect(head,this.note.value);
			rect.offset(rect.width * headPositions[i],0);
			this.headRects_.push(rect);
			i++;
		}
		return this.headRects_;
	}
	,headRects: null
	,headRects_: null
	,get_stemX: function() {
		if(this.stemX_ != null) return this.stemX_;
		this.stemX_ = 1.6;
		if(this.get_direction() == nx3.elements.EDirectionUD.Down) this.stemX_ = -this.stemX_;
		return this.stemX_;
	}
	,stemX_: null
	,stemX: null
	,set_direction: function(val) {
		this.direction_ = val;
		return this.direction_;
	}
	,get_direction: function() {
		if(this.direction_ != null) return this.direction_;
		if(this.forceDirection != null) this.direction_ = this.forceDirection; else this.direction_ = this.note.direction != null?nx3.elements.EDirectionUADTools.toUD(this.note.direction):nx3.elements.tools.HeadsTool.getDirection(this.note.get_nheads());
		return this.direction_;
	}
	,direction_: null
	,value: null
	,levelBottom: null
	,levelTop: null
	,forceDirection: null
	,attributes: null
	,articulations: null
	,variant: null
	,type: null
	,note: null
	,__class__: nx3.elements.DNote
	,__properties__: {set_direction:"set_direction",get_direction:"get_direction",get_stemX:"get_stemX",get_headRects:"get_headRects",get_midLevel:"get_midLevel",get_heads:"get_heads",get_headTop:"get_headTop",get_headBottom:"get_headBottom",get_headsRect:"get_headsRect",set_xAdjust:"set_xAdjust",get_xAdjust:"get_xAdjust"}
}
nx3.elements.EBarType = $hxClasses["nx3.elements.EBarType"] = { __ename__ : true, __constructs__ : ["Normal","Repeat","Ignore","Folded"] }
nx3.elements.EBarType.Normal = ["Normal",0];
nx3.elements.EBarType.Normal.toString = $estr;
nx3.elements.EBarType.Normal.__enum__ = nx3.elements.EBarType;
nx3.elements.EBarType.Repeat = ["Repeat",1];
nx3.elements.EBarType.Repeat.toString = $estr;
nx3.elements.EBarType.Repeat.__enum__ = nx3.elements.EBarType;
nx3.elements.EBarType.Ignore = ["Ignore",2];
nx3.elements.EBarType.Ignore.toString = $estr;
nx3.elements.EBarType.Ignore.__enum__ = nx3.elements.EBarType;
nx3.elements.EBarType.Folded = ["Folded",3];
nx3.elements.EBarType.Folded.toString = $estr;
nx3.elements.EBarType.Folded.__enum__ = nx3.elements.EBarType;
nx3.elements.EClef = $hxClasses["nx3.elements.EClef"] = { __ename__ : true, __constructs__ : ["ClefG","ClefF","ClefC"] }
nx3.elements.EClef.ClefG = ["ClefG",0];
nx3.elements.EClef.ClefG.toString = $estr;
nx3.elements.EClef.ClefG.__enum__ = nx3.elements.EClef;
nx3.elements.EClef.ClefF = ["ClefF",1];
nx3.elements.EClef.ClefF.toString = $estr;
nx3.elements.EClef.ClefF.__enum__ = nx3.elements.EClef;
nx3.elements.EClef.ClefC = ["ClefC",2];
nx3.elements.EClef.ClefC.toString = $estr;
nx3.elements.EClef.ClefC.__enum__ = nx3.elements.EClef;
nx3.elements.EDirectionUAD = $hxClasses["nx3.elements.EDirectionUAD"] = { __ename__ : true, __constructs__ : ["Up","Auto","Down"] }
nx3.elements.EDirectionUAD.Up = ["Up",0];
nx3.elements.EDirectionUAD.Up.toString = $estr;
nx3.elements.EDirectionUAD.Up.__enum__ = nx3.elements.EDirectionUAD;
nx3.elements.EDirectionUAD.Auto = ["Auto",1];
nx3.elements.EDirectionUAD.Auto.toString = $estr;
nx3.elements.EDirectionUAD.Auto.__enum__ = nx3.elements.EDirectionUAD;
nx3.elements.EDirectionUAD.Down = ["Down",2];
nx3.elements.EDirectionUAD.Down.toString = $estr;
nx3.elements.EDirectionUAD.Down.__enum__ = nx3.elements.EDirectionUAD;
nx3.elements.EDirectionUADTools = function() { }
$hxClasses["nx3.elements.EDirectionUADTools"] = nx3.elements.EDirectionUADTools;
nx3.elements.EDirectionUADTools.__name__ = ["nx3","elements","EDirectionUADTools"];
nx3.elements.EDirectionUADTools.toUD = function(direction) {
	switch( (direction)[1] ) {
	case 0:
		return nx3.elements.EDirectionUD.Up;
	case 2:
		return nx3.elements.EDirectionUD.Down;
	default:
		return nx3.elements.EDirectionUD.Down;
	}
}
nx3.elements.EDirectionUD = $hxClasses["nx3.elements.EDirectionUD"] = { __ename__ : true, __constructs__ : ["Up","Down"] }
nx3.elements.EDirectionUD.Up = ["Up",0];
nx3.elements.EDirectionUD.Up.toString = $estr;
nx3.elements.EDirectionUD.Up.__enum__ = nx3.elements.EDirectionUD;
nx3.elements.EDirectionUD.Down = ["Down",1];
nx3.elements.EDirectionUD.Down.toString = $estr;
nx3.elements.EDirectionUD.Down.__enum__ = nx3.elements.EDirectionUD;
nx3.elements.EDirectionUDTools = function() { }
$hxClasses["nx3.elements.EDirectionUDTools"] = nx3.elements.EDirectionUDTools;
nx3.elements.EDirectionUDTools.__name__ = ["nx3","elements","EDirectionUDTools"];
nx3.elements.EDirectionUDTools.toUAD = function(direction) {
	return direction == nx3.elements.EDirectionUD.Up?nx3.elements.EDirectionUAD.Up:nx3.elements.EDirectionUAD.Down;
}
nx3.elements.EDisplayALN = $hxClasses["nx3.elements.EDisplayALN"] = { __ename__ : true, __constructs__ : ["Always","Layout","Never"] }
nx3.elements.EDisplayALN.Always = ["Always",0];
nx3.elements.EDisplayALN.Always.toString = $estr;
nx3.elements.EDisplayALN.Always.__enum__ = nx3.elements.EDisplayALN;
nx3.elements.EDisplayALN.Layout = ["Layout",1];
nx3.elements.EDisplayALN.Layout.toString = $estr;
nx3.elements.EDisplayALN.Layout.__enum__ = nx3.elements.EDisplayALN;
nx3.elements.EDisplayALN.Never = ["Never",2];
nx3.elements.EDisplayALN.Never.toString = $estr;
nx3.elements.EDisplayALN.Never.__enum__ = nx3.elements.EDisplayALN;
nx3.elements.EHeadType = $hxClasses["nx3.elements.EHeadType"] = { __ename__ : true, __constructs__ : ["Normal","Rythmic","Crossed"] }
nx3.elements.EHeadType.Normal = ["Normal",0];
nx3.elements.EHeadType.Normal.toString = $estr;
nx3.elements.EHeadType.Normal.__enum__ = nx3.elements.EHeadType;
nx3.elements.EHeadType.Rythmic = ["Rythmic",1];
nx3.elements.EHeadType.Rythmic.toString = $estr;
nx3.elements.EHeadType.Rythmic.__enum__ = nx3.elements.EHeadType;
nx3.elements.EHeadType.Crossed = ["Crossed",2];
nx3.elements.EHeadType.Crossed.toString = $estr;
nx3.elements.EHeadType.Crossed.__enum__ = nx3.elements.EHeadType;
nx3.elements.EHeadValuetype = $hxClasses["nx3.elements.EHeadValuetype"] = { __ename__ : true, __constructs__ : ["HVT4","HVT2","HVT1"] }
nx3.elements.EHeadValuetype.HVT4 = ["HVT4",0];
nx3.elements.EHeadValuetype.HVT4.toString = $estr;
nx3.elements.EHeadValuetype.HVT4.__enum__ = nx3.elements.EHeadValuetype;
nx3.elements.EHeadValuetype.HVT2 = ["HVT2",1];
nx3.elements.EHeadValuetype.HVT2.toString = $estr;
nx3.elements.EHeadValuetype.HVT2.__enum__ = nx3.elements.EHeadValuetype;
nx3.elements.EHeadValuetype.HVT1 = ["HVT1",2];
nx3.elements.EHeadValuetype.HVT1.toString = $estr;
nx3.elements.EHeadValuetype.HVT1.__enum__ = nx3.elements.EHeadValuetype;
nx3.elements.EKey = function(levelShift) {
	this.levelShift = levelShift;
};
$hxClasses["nx3.elements.EKey"] = nx3.elements.EKey;
nx3.elements.EKey.__name__ = ["nx3","elements","EKey"];
nx3.elements.EKey.getSignLevel = function(levelShift,signIndex,clef) {
	var shift = [0];
	if(levelShift < 0) shift = [0,-3,1,-2,2,-1,3]; else shift = [-4,-1,-5,-2,-6,-3];
	var level = shift[signIndex];
	if(clef != null) {
		switch( (clef)[1] ) {
		case 2:
			level += 1;
			break;
		case 1:
			level += 2;
			break;
		default:
		}
	}
	if(level < -5) level += 7;
	return level;
}
nx3.elements.EKey.prototype = {
	levelShift: null
	,__class__: nx3.elements.EKey
}
nx3.elements.ELyricContinuation = $hxClasses["nx3.elements.ELyricContinuation"] = { __ename__ : true, __constructs__ : ["Hyphen","Melisma"] }
nx3.elements.ELyricContinuation.Hyphen = ["Hyphen",0];
nx3.elements.ELyricContinuation.Hyphen.toString = $estr;
nx3.elements.ELyricContinuation.Hyphen.__enum__ = nx3.elements.ELyricContinuation;
nx3.elements.ELyricContinuation.Melisma = ["Melisma",1];
nx3.elements.ELyricContinuation.Melisma.toString = $estr;
nx3.elements.ELyricContinuation.Melisma.__enum__ = nx3.elements.ELyricContinuation;
nx3.elements.ELyricFormat = $hxClasses["nx3.elements.ELyricFormat"] = { __ename__ : true, __constructs__ : ["Bold","Italic","Format"] }
nx3.elements.ELyricFormat.Bold = ["Bold",0];
nx3.elements.ELyricFormat.Bold.toString = $estr;
nx3.elements.ELyricFormat.Bold.__enum__ = nx3.elements.ELyricFormat;
nx3.elements.ELyricFormat.Italic = ["Italic",1];
nx3.elements.ELyricFormat.Italic.toString = $estr;
nx3.elements.ELyricFormat.Italic.__enum__ = nx3.elements.ELyricFormat;
nx3.elements.ELyricFormat.Format = function(fontName,size,bold,Italic) { var $x = ["Format",2,fontName,size,bold,Italic]; $x.__enum__ = nx3.elements.ELyricFormat; $x.toString = $estr; return $x; }
nx3.elements.ENotationVariant = $hxClasses["nx3.elements.ENotationVariant"] = { __ename__ : true, __constructs__ : ["Normal","Rythmic","RythmicSingleLevel","HeadsOnly","StavesOnly"] }
nx3.elements.ENotationVariant.Normal = ["Normal",0];
nx3.elements.ENotationVariant.Normal.toString = $estr;
nx3.elements.ENotationVariant.Normal.__enum__ = nx3.elements.ENotationVariant;
nx3.elements.ENotationVariant.Rythmic = ["Rythmic",1];
nx3.elements.ENotationVariant.Rythmic.toString = $estr;
nx3.elements.ENotationVariant.Rythmic.__enum__ = nx3.elements.ENotationVariant;
nx3.elements.ENotationVariant.RythmicSingleLevel = function(level) { var $x = ["RythmicSingleLevel",2,level]; $x.__enum__ = nx3.elements.ENotationVariant; $x.toString = $estr; return $x; }
nx3.elements.ENotationVariant.HeadsOnly = ["HeadsOnly",3];
nx3.elements.ENotationVariant.HeadsOnly.toString = $estr;
nx3.elements.ENotationVariant.HeadsOnly.__enum__ = nx3.elements.ENotationVariant;
nx3.elements.ENotationVariant.StavesOnly = ["StavesOnly",4];
nx3.elements.ENotationVariant.StavesOnly.toString = $estr;
nx3.elements.ENotationVariant.StavesOnly.__enum__ = nx3.elements.ENotationVariant;
nx3.elements.ENoteArticulation = $hxClasses["nx3.elements.ENoteArticulation"] = { __ename__ : true, __constructs__ : ["Staccato","Tenuto","Marcato"] }
nx3.elements.ENoteArticulation.Staccato = ["Staccato",0];
nx3.elements.ENoteArticulation.Staccato.toString = $estr;
nx3.elements.ENoteArticulation.Staccato.__enum__ = nx3.elements.ENoteArticulation;
nx3.elements.ENoteArticulation.Tenuto = ["Tenuto",1];
nx3.elements.ENoteArticulation.Tenuto.toString = $estr;
nx3.elements.ENoteArticulation.Tenuto.__enum__ = nx3.elements.ENoteArticulation;
nx3.elements.ENoteArticulation.Marcato = ["Marcato",2];
nx3.elements.ENoteArticulation.Marcato.toString = $estr;
nx3.elements.ENoteArticulation.Marcato.__enum__ = nx3.elements.ENoteArticulation;
nx3.elements.ENoteAttributes = $hxClasses["nx3.elements.ENoteAttributes"] = { __ename__ : true, __constructs__ : ["Arpeggio","Clef"] }
nx3.elements.ENoteAttributes.Arpeggio = function(top,bottomY) { var $x = ["Arpeggio",0,top,bottomY]; $x.__enum__ = nx3.elements.ENoteAttributes; $x.toString = $estr; return $x; }
nx3.elements.ENoteAttributes.Clef = function(variant) { var $x = ["Clef",1,variant]; $x.__enum__ = nx3.elements.ENoteAttributes; $x.toString = $estr; return $x; }
nx3.elements.ENoteType = $hxClasses["nx3.elements.ENoteType"] = { __ename__ : true, __constructs__ : ["Note","Pause","BarPause","Tpl","Lyric","Chord","Dynam"] }
nx3.elements.ENoteType.Note = function(heads,variant,articulations,attributes) { var $x = ["Note",0,heads,variant,articulations,attributes]; $x.__enum__ = nx3.elements.ENoteType; $x.toString = $estr; return $x; }
nx3.elements.ENoteType.Pause = function(level) { var $x = ["Pause",1,level]; $x.__enum__ = nx3.elements.ENoteType; $x.toString = $estr; return $x; }
nx3.elements.ENoteType.BarPause = ["BarPause",2];
nx3.elements.ENoteType.BarPause.toString = $estr;
nx3.elements.ENoteType.BarPause.__enum__ = nx3.elements.ENoteType;
nx3.elements.ENoteType.Tpl = ["Tpl",3];
nx3.elements.ENoteType.Tpl.toString = $estr;
nx3.elements.ENoteType.Tpl.__enum__ = nx3.elements.ENoteType;
nx3.elements.ENoteType.Lyric = function(text,offset,continuation,format) { var $x = ["Lyric",4,text,offset,continuation,format]; $x.__enum__ = nx3.elements.ENoteType; $x.toString = $estr; return $x; }
nx3.elements.ENoteType.Chord = ["Chord",5];
nx3.elements.ENoteType.Chord.toString = $estr;
nx3.elements.ENoteType.Chord.__enum__ = nx3.elements.ENoteType;
nx3.elements.ENoteType.Dynam = ["Dynam",6];
nx3.elements.ENoteType.Dynam.toString = $estr;
nx3.elements.ENoteType.Dynam.__enum__ = nx3.elements.ENoteType;
nx3.elements.ENoteValue = function(value,head,stavingLevel,beamingLevel,dotlevel) {
	if(dotlevel == null) dotlevel = 0;
	if(beamingLevel == null) beamingLevel = 0;
	if(stavingLevel == null) stavingLevel = 0;
	this.value = value | 0;
	this.head = head;
	this.stavingLevel = stavingLevel;
	this.beamingLevel = beamingLevel;
	this.dotLevel = dotlevel;
};
$hxClasses["nx3.elements.ENoteValue"] = nx3.elements.ENoteValue;
nx3.elements.ENoteValue.__name__ = ["nx3","elements","ENoteValue"];
nx3.elements.ENoteValue.getFromValue = function(value) {
	if(value == nx3.elements.ENoteValue.N1 * 3024) return nx3.elements.ENoteValue.Nv1;
	if(value == nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv1dot;
	if(value == nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv1ddot;
	if(value == nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv1tri;
	if(value == nx3.elements.ENoteValue.N2 * 3024) return nx3.elements.ENoteValue.Nv2;
	if(value == nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv2dot;
	if(value == nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv2ddot;
	if(value == nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv2tri;
	if(value == 3024) return nx3.elements.ENoteValue.Nv4;
	if(value == 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv4dot;
	if(value == 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv4ddot;
	if(value == 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv4tri;
	if(value == nx3.elements.ENoteValue.N8 * 3024) return nx3.elements.ENoteValue.Nv8;
	if(value == nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv8dot;
	if(value == nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv8ddot;
	if(value == nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv8tri;
	if(value == nx3.elements.ENoteValue.N16 * 3024) return nx3.elements.ENoteValue.Nv16;
	if(value == nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv16dot;
	if(value == nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv16ddot;
	if(value == nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv16tri;
	if(value == nx3.elements.ENoteValue.N32 * 3024) return nx3.elements.ENoteValue.Nv32;
	if(value == nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.DOT) return nx3.elements.ENoteValue.Nv32dot;
	if(value == nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.DOTDOT) return nx3.elements.ENoteValue.Nv32ddot;
	if(value == nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.TRI) return nx3.elements.ENoteValue.Nv32tri;
	throw "Could not find note value for value " + value;
	return nx3.elements.ENoteValue.Nv4;
}
nx3.elements.ENoteValue.prototype = {
	dotLevel: null
	,beamingLevel: null
	,stavingLevel: null
	,head: null
	,value: null
	,__class__: nx3.elements.ENoteValue
}
nx3.elements.EPartType = $hxClasses["nx3.elements.EPartType"] = { __ename__ : true, __constructs__ : ["Normal","Lyrics","Tpl","Tplchain","Dynamics","Chords","Ignore","Hidden"] }
nx3.elements.EPartType.Normal = ["Normal",0];
nx3.elements.EPartType.Normal.toString = $estr;
nx3.elements.EPartType.Normal.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Lyrics = ["Lyrics",1];
nx3.elements.EPartType.Lyrics.toString = $estr;
nx3.elements.EPartType.Lyrics.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Tpl = ["Tpl",2];
nx3.elements.EPartType.Tpl.toString = $estr;
nx3.elements.EPartType.Tpl.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Tplchain = ["Tplchain",3];
nx3.elements.EPartType.Tplchain.toString = $estr;
nx3.elements.EPartType.Tplchain.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Dynamics = ["Dynamics",4];
nx3.elements.EPartType.Dynamics.toString = $estr;
nx3.elements.EPartType.Dynamics.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Chords = ["Chords",5];
nx3.elements.EPartType.Chords.toString = $estr;
nx3.elements.EPartType.Chords.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Ignore = ["Ignore",6];
nx3.elements.EPartType.Ignore.toString = $estr;
nx3.elements.EPartType.Ignore.__enum__ = nx3.elements.EPartType;
nx3.elements.EPartType.Hidden = ["Hidden",7];
nx3.elements.EPartType.Hidden.toString = $estr;
nx3.elements.EPartType.Hidden.__enum__ = nx3.elements.EPartType;
nx3.elements.EPosition = $hxClasses["nx3.elements.EPosition"] = { __ename__ : true, __constructs__ : ["X","Y","XY","XYW"] }
nx3.elements.EPosition.X = function(x) { var $x = ["X",0,x]; $x.__enum__ = nx3.elements.EPosition; $x.toString = $estr; return $x; }
nx3.elements.EPosition.Y = function(y) { var $x = ["Y",1,y]; $x.__enum__ = nx3.elements.EPosition; $x.toString = $estr; return $x; }
nx3.elements.EPosition.XY = function(x,y) { var $x = ["XY",2,x,y]; $x.__enum__ = nx3.elements.EPosition; $x.toString = $estr; return $x; }
nx3.elements.EPosition.XYW = function(x,y,w) { var $x = ["XYW",3,x,y,w]; $x.__enum__ = nx3.elements.EPosition; $x.toString = $estr; return $x; }
nx3.elements.ESign = $hxClasses["nx3.elements.ESign"] = { __ename__ : true, __constructs__ : ["None","Natural","Flat","Sharp","DoubleFlat","DoubleSharp","ParNatural","ParFlat","ParSharp"] }
nx3.elements.ESign.None = ["None",0];
nx3.elements.ESign.None.toString = $estr;
nx3.elements.ESign.None.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.Natural = ["Natural",1];
nx3.elements.ESign.Natural.toString = $estr;
nx3.elements.ESign.Natural.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.Flat = ["Flat",2];
nx3.elements.ESign.Flat.toString = $estr;
nx3.elements.ESign.Flat.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.Sharp = ["Sharp",3];
nx3.elements.ESign.Sharp.toString = $estr;
nx3.elements.ESign.Sharp.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.DoubleFlat = ["DoubleFlat",4];
nx3.elements.ESign.DoubleFlat.toString = $estr;
nx3.elements.ESign.DoubleFlat.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.DoubleSharp = ["DoubleSharp",5];
nx3.elements.ESign.DoubleSharp.toString = $estr;
nx3.elements.ESign.DoubleSharp.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.ParNatural = ["ParNatural",6];
nx3.elements.ESign.ParNatural.toString = $estr;
nx3.elements.ESign.ParNatural.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.ParFlat = ["ParFlat",7];
nx3.elements.ESign.ParFlat.toString = $estr;
nx3.elements.ESign.ParFlat.__enum__ = nx3.elements.ESign;
nx3.elements.ESign.ParSharp = ["ParSharp",8];
nx3.elements.ESign.ParSharp.toString = $estr;
nx3.elements.ESign.ParSharp.__enum__ = nx3.elements.ESign;
nx3.elements.ETie = $hxClasses["nx3.elements.ETie"] = { __ename__ : true, __constructs__ : ["Tie","Gliss"] }
nx3.elements.ETie.Tie = function(direction) { var $x = ["Tie",0,direction]; $x.__enum__ = nx3.elements.ETie; $x.toString = $estr; return $x; }
nx3.elements.ETie.Gliss = function(direction) { var $x = ["Gliss",1,direction]; $x.__enum__ = nx3.elements.ETie; $x.toString = $estr; return $x; }
nx3.elements.ETime = $hxClasses["nx3.elements.ETime"] = { __ename__ : true, __constructs__ : ["Time2_2","Time3_2","Time4_2","Time2_4","Time3_4","Time4_4","Time5_4","Time6_4","Time7_4","Time2_8","Time3_8","Time4_8","Time5_8","Time6_8","Time7_8","Time9_8","Time12_8","TimeCommon","TimeAllabreve"] }
nx3.elements.ETime.Time2_2 = ["Time2_2",0];
nx3.elements.ETime.Time2_2.toString = $estr;
nx3.elements.ETime.Time2_2.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time3_2 = ["Time3_2",1];
nx3.elements.ETime.Time3_2.toString = $estr;
nx3.elements.ETime.Time3_2.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time4_2 = ["Time4_2",2];
nx3.elements.ETime.Time4_2.toString = $estr;
nx3.elements.ETime.Time4_2.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time2_4 = ["Time2_4",3];
nx3.elements.ETime.Time2_4.toString = $estr;
nx3.elements.ETime.Time2_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time3_4 = ["Time3_4",4];
nx3.elements.ETime.Time3_4.toString = $estr;
nx3.elements.ETime.Time3_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time4_4 = ["Time4_4",5];
nx3.elements.ETime.Time4_4.toString = $estr;
nx3.elements.ETime.Time4_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time5_4 = ["Time5_4",6];
nx3.elements.ETime.Time5_4.toString = $estr;
nx3.elements.ETime.Time5_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time6_4 = ["Time6_4",7];
nx3.elements.ETime.Time6_4.toString = $estr;
nx3.elements.ETime.Time6_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time7_4 = ["Time7_4",8];
nx3.elements.ETime.Time7_4.toString = $estr;
nx3.elements.ETime.Time7_4.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time2_8 = ["Time2_8",9];
nx3.elements.ETime.Time2_8.toString = $estr;
nx3.elements.ETime.Time2_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time3_8 = ["Time3_8",10];
nx3.elements.ETime.Time3_8.toString = $estr;
nx3.elements.ETime.Time3_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time4_8 = ["Time4_8",11];
nx3.elements.ETime.Time4_8.toString = $estr;
nx3.elements.ETime.Time4_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time5_8 = ["Time5_8",12];
nx3.elements.ETime.Time5_8.toString = $estr;
nx3.elements.ETime.Time5_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time6_8 = ["Time6_8",13];
nx3.elements.ETime.Time6_8.toString = $estr;
nx3.elements.ETime.Time6_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time7_8 = ["Time7_8",14];
nx3.elements.ETime.Time7_8.toString = $estr;
nx3.elements.ETime.Time7_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time9_8 = ["Time9_8",15];
nx3.elements.ETime.Time9_8.toString = $estr;
nx3.elements.ETime.Time9_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.Time12_8 = ["Time12_8",16];
nx3.elements.ETime.Time12_8.toString = $estr;
nx3.elements.ETime.Time12_8.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.TimeCommon = ["TimeCommon",17];
nx3.elements.ETime.TimeCommon.toString = $estr;
nx3.elements.ETime.TimeCommon.__enum__ = nx3.elements.ETime;
nx3.elements.ETime.TimeAllabreve = ["TimeAllabreve",18];
nx3.elements.ETime.TimeAllabreve.toString = $estr;
nx3.elements.ETime.TimeAllabreve.__enum__ = nx3.elements.ETime;
nx3.elements.ETimeUtils = function() { }
$hxClasses["nx3.elements.ETimeUtils"] = nx3.elements.ETimeUtils;
nx3.elements.ETimeUtils.__name__ = ["nx3","elements","ETimeUtils"];
nx3.elements.ETimeUtils.toString = function(time) {
	switch( (time)[1] ) {
	case 0:
		return "2/2";
	case 1:
		return "3/2";
	case 2:
		return "4/2";
	case 8:
		return "7/4";
	case 7:
		return "6/4";
	case 6:
		return "5/4";
	case 5:
		return "4/4";
	case 4:
		return "3/4";
	case 3:
		return "2/4";
	case 9:
		return "2/8";
	case 10:
		return "3/8";
	case 11:
		return "4/8";
	case 12:
		return "5/8";
	case 13:
		return "6/8";
	case 14:
		return "7/8";
	case 15:
		return "9/8";
	case 16:
		return "12/8";
	case 17:
		return "Common";
	case 18:
		return "Allabreve";
	}
	return "time-unknown";
}
nx3.elements.ETimeUtils.fromString = function(str) {
	if(str == null) return null;
	switch(str) {
	case "4/2":
		return nx3.elements.ETime.Time4_2;
	case "3/2":
		return nx3.elements.ETime.Time3_2;
	case "224":
		return nx3.elements.ETime.Time2_2;
	case "7/4":
		return nx3.elements.ETime.Time7_4;
	case "6/4":
		return nx3.elements.ETime.Time6_4;
	case "5/4":
		return nx3.elements.ETime.Time5_4;
	case "4/4":
		return nx3.elements.ETime.Time4_4;
	case "3/4":
		return nx3.elements.ETime.Time3_4;
	case "2/4":
		return nx3.elements.ETime.Time2_4;
	case "2/8":
		return nx3.elements.ETime.Time2_8;
	case "3/8":
		return nx3.elements.ETime.Time3_8;
	case "4/8":
		return nx3.elements.ETime.Time4_8;
	case "5/8":
		return nx3.elements.ETime.Time5_8;
	case "6/8":
		return nx3.elements.ETime.Time6_8;
	case "7/8":
		return nx3.elements.ETime.Time7_8;
	case "9/8":
		return nx3.elements.ETime.Time9_8;
	case "12/8":
		return nx3.elements.ETime.Time12_8;
	case "Common":
		return nx3.elements.ETime.TimeCommon;
	case "Allabreve":
		return nx3.elements.ETime.TimeAllabreve;
	default:
		return null;
	}
	return null;
}
nx3.elements.EVoiceType = $hxClasses["nx3.elements.EVoiceType"] = { __ename__ : true, __constructs__ : ["Normal","Barpause"] }
nx3.elements.EVoiceType.Normal = ["Normal",0];
nx3.elements.EVoiceType.Normal.toString = $estr;
nx3.elements.EVoiceType.Normal.__enum__ = nx3.elements.EVoiceType;
nx3.elements.EVoiceType.Barpause = ["Barpause",1];
nx3.elements.EVoiceType.Barpause.toString = $estr;
nx3.elements.EVoiceType.Barpause.__enum__ = nx3.elements.EVoiceType;
nx3.elements.NBar = function(parts,type,time,timeDisplay) {
	this.nparts = parts;
	this.type = type == null?nx3.elements.EBarType.Normal:type;
	this.time = time == null?nx3.elements.ETime.Time4_4:time;
	this.timeDisplay = timeDisplay == null?nx3.elements.EDisplayALN.Layout:timeDisplay;
};
$hxClasses["nx3.elements.NBar"] = nx3.elements.NBar;
nx3.elements.NBar.__name__ = ["nx3","elements","NBar"];
nx3.elements.NBar.prototype = {
	timeDisplay: null
	,time: null
	,type: null
	,nparts: null
	,__class__: nx3.elements.NBar
}
nx3.elements.NHead = function(type,level,sign,tie,tieTo) {
	if(level == null) level = 0;
	this.type = type != null?type:nx3.elements.EHeadType.Normal;
	this.sign = sign != null?sign:nx3.elements.ESign.None;
	this.tie = tie != null?tie:null;
	this.tieTo = tieTo != null?tieTo:null;
	this.level = level;
};
$hxClasses["nx3.elements.NHead"] = nx3.elements.NHead;
nx3.elements.NHead.__name__ = ["nx3","elements","NHead"];
nx3.elements.NHead.prototype = {
	tieTo: null
	,tie: null
	,sign: null
	,type: null
	,level: null
	,__class__: nx3.elements.NHead
}
nx3.elements.NNote = function(type,heads,value,direction) {
	if(type == null) type = heads != null?nx3.elements.ENoteType.Note(heads):nx3.elements.ENoteType.Note([new nx3.elements.NHead()]);
	this.type = type == null?nx3.elements.ENoteType.Note(heads):type;
	this.value = value == null?nx3.elements.ENoteValue.Nv4:value;
	this.direction = direction == null?nx3.elements.EDirectionUAD.Auto:direction;
};
$hxClasses["nx3.elements.NNote"] = nx3.elements.NNote;
nx3.elements.NNote.__name__ = ["nx3","elements","NNote"];
nx3.elements.NNote.prototype = {
	getBottomLevel: function() {
		return this.get_nheads()[this.get_nheads().length - 1].level;
	}
	,getTopLevel: function() {
		return this.get_nheads()[0].level;
	}
	,getHeadLevels: function() {
		if(this.headLevels != null) return this.headLevels;
		this.headLevels = [];
		var _g = 0, _g1 = this.get_nheads();
		while(_g < _g1.length) {
			var head = _g1[_g];
			++_g;
			this.headLevels.push(head.level);
		}
		return this.headLevels;
	}
	,headLevels: null
	,get_nheads: function() {
		if(this.nheads_ != null) return this.nheads_;
		var _g = this;
		var $e = (_g.type);
		switch( $e[1] ) {
		case 0:
			var attributes = $e[5], articulations = $e[4], variant = $e[3], nheads = $e[2];
			nheads.sort(function(i1,i2) {
				var cmp;
				cmp = Reflect.compare(i1.level,i2.level);
				if(cmp != 0) return cmp;
				return 0;
			});
			this.nheads_ = nheads;
			return this.nheads_;
		default:
		}
		return null;
	}
	,nheads_: null
	,nheads: null
	,direction: null
	,value: null
	,type: null
	,__class__: nx3.elements.NNote
	,__properties__: {get_nheads:"get_nheads"}
}
nx3.elements.NPart = function(voices,type,clef,clefDisplay,key,keyDisplay) {
	this.nvoices = voices;
	if(this.nvoices.length > 2) throw "For now, NPart can't have more than two voices";
	this.type = type == null?nx3.elements.EPartType.Normal:type;
	this.clef = clef == null?nx3.elements.EClef.ClefG:clef;
	this.clefDisplay = clefDisplay == null?nx3.elements.EDisplayALN.Layout:clefDisplay;
	this.key = key == null?nx3.elements.EKey.Natural:key;
	this.keyDisplay = keyDisplay == null?nx3.elements.EDisplayALN.Layout:keyDisplay;
};
$hxClasses["nx3.elements.NPart"] = nx3.elements.NPart;
nx3.elements.NPart.__name__ = ["nx3","elements","NPart"];
nx3.elements.NPart.prototype = {
	keyDisplay: null
	,key: null
	,clefDisplay: null
	,clef: null
	,nvoices: null
	,type: null
	,__class__: nx3.elements.NPart
}
nx3.elements.NVoice = function(notes,type,direction) {
	if(notes == null || notes == []) {
		this.nnotes = null;
		this.type = nx3.elements.EVoiceType.Barpause;
	} else {
		this.nnotes = notes;
		this.type = type != null?type:nx3.elements.EVoiceType.Normal;
	}
	this.direction = direction;
};
$hxClasses["nx3.elements.NVoice"] = nx3.elements.NVoice;
nx3.elements.NVoice.__name__ = ["nx3","elements","NVoice"];
nx3.elements.NVoice.prototype = {
	type: null
	,nnotes: null
	,direction: null
	,__class__: nx3.elements.NVoice
}
nx3.elements._ULevel = {}
nx3.elements._ULevel.ULevel_Impl_ = function() { }
$hxClasses["nx3.elements._ULevel.ULevel_Impl_"] = nx3.elements._ULevel.ULevel_Impl_;
nx3.elements._ULevel.ULevel_Impl_.__name__ = ["nx3","elements","_ULevel","ULevel_Impl_"];
nx3.elements._ULevel.ULevel_Impl_._new = function(value) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(value);
}
nx3.elements._ULevel.ULevel_Impl_.fromInt = function(value) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(value);
}
nx3.elements._ULevel.ULevel_Impl_.toInt = function(this1) {
	return this1;
}
nx3.elements._ULevel.ULevel_Impl_.add = function(l,h) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(l + h);
}
nx3.elements._ULevel.ULevel_Impl_.addPlusPlus = function(l) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(l);
}
nx3.elements._ULevel.ULevel_Impl_.addPlusPlusAfter = function(l) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(l);
}
nx3.elements._ULevel.ULevel_Impl_.addInteger = function(l,r) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(l + r);
}
nx3.elements._ULevel.ULevel_Impl_.addFloat = function(l,r) {
	return nx3.elements._ULevel.ULevel_Impl_.inRange(l + r);
}
nx3.elements._ULevel.ULevel_Impl_.gtFloat = function(l,r) {
	return l > r;
}
nx3.elements._ULevel.ULevel_Impl_.gtInt = function(l,r) {
	return l > r;
}
nx3.elements._ULevel.ULevel_Impl_.ltFloat = function(l,r) {
	return l < r;
}
nx3.elements._ULevel.ULevel_Impl_.ltInt = function(l,r) {
	return l < r;
}
nx3.elements._ULevel.ULevel_Impl_.inRange = function(value) {
	return Math.min(Math.max(value,nx3.elements._ULevel.ULevel_Impl_.MIN_LEVEL),nx3.elements._ULevel.ULevel_Impl_.MAX_LEVEL) | 0;
}
nx3.elements.VTree = function() { }
$hxClasses["nx3.elements.VTree"] = nx3.elements.VTree;
nx3.elements.VTree.__name__ = ["nx3","elements","VTree"];
nx3.elements.VBar = function(nbar) {
	this.nbar = nbar;
};
$hxClasses["nx3.elements.VBar"] = nx3.elements.VBar;
nx3.elements.VBar.__name__ = ["nx3","elements","VBar"];
nx3.elements.VBar.prototype = {
	getValue: function() {
		if(this.value != null) return this.value;
		var value = .0;
		var _g = 0, _g1 = this.getVParts();
		while(_g < _g1.length) {
			var vpart = _g1[_g];
			++_g;
			value = Math.max(value,vpart.getValue());
		}
		this.value = value | 0;
		return this.value;
	}
	,value: null
	,getPositionsColumns: function() {
		if(this.positionsVColumns == null) this.getVColumns();
		return this.positionsVColumns;
	}
	,positionsVColumns: null
	,getVColumns: function() {
		if(this.vcolumns != null) return this.vcolumns;
		if(this.vparts == null) this.getVParts();
		var generator = new nx3.elements.VBarColumnsGenerator(this.vparts);
		this.vcolumns = generator.getColumns();
		this.positionsVColumns = generator.getPositionsColumns();
		return this.vcolumns;
	}
	,vcolumns: null
	,getVParts: function() {
		if(this.vparts != null) return this.vparts;
		this.vparts = [];
		var _g = 0, _g1 = this.nbar.nparts;
		while(_g < _g1.length) {
			var npart = _g1[_g];
			++_g;
			this.vparts.push(new nx3.elements.VPart(npart));
		}
		return this.vparts;
	}
	,vparts: null
	,nbar: null
	,__class__: nx3.elements.VBar
}
nx3.elements.VBarColumnsGenerator = function(vparts) {
	this.vparts = vparts;
};
$hxClasses["nx3.elements.VBarColumnsGenerator"] = nx3.elements.VBarColumnsGenerator;
nx3.elements.VBarColumnsGenerator.__name__ = ["nx3","elements","VBarColumnsGenerator"];
nx3.elements.VBarColumnsGenerator.prototype = {
	calcPositions: function(vparts) {
		var positionsMap = new haxe.ds.IntMap();
		var _g = 0;
		while(_g < vparts.length) {
			var vpart = vparts[_g];
			++_g;
			var poss = nx3.elements.VMapTools.keysToArray(vpart.getPositionsVComplexes().keys());
			var _g1 = 0;
			while(_g1 < poss.length) {
				var pos = poss[_g1];
				++_g1;
				positionsMap.set(pos,true);
			}
		}
		var positions = nx3.elements.VMapTools.keysToArray(positionsMap.keys());
		positions.sort(function(a,b) {
			return Reflect.compare(a,b);
		});
		return positions;
	}
	,calcColumns: function(positions,vparts) {
		var partsCount = vparts.length;
		this.columns = [];
		this.positionsColumns = new haxe.ds.IntMap();
		var _g = 0;
		while(_g < positions.length) {
			var pos = positions[_g];
			++_g;
			var vcolumn = null;
			var vcomplexes = [];
			var i = 0;
			var _g1 = 0;
			while(_g1 < vparts.length) {
				var vpart = vparts[_g1];
				++_g1;
				var complex = vpart.getPositionsVComplexes().get(pos);
				vcomplexes.push(complex);
				i++;
			}
			var vcolumn1 = new nx3.elements.VColumn(vcomplexes);
			this.columns.push(vcolumn1);
			this.positionsColumns.set(pos,vcolumn1);
		}
	}
	,getPositionsColumns: function() {
		if(this.columns == null) this.getColumns();
		return this.positionsColumns;
	}
	,getColumns: function() {
		if(this.columns != null) return this.columns;
		this.positions = this.calcPositions(this.vparts);
		this.calcColumns(this.positions,this.vparts);
		return this.columns;
	}
	,positionsColumns: null
	,columns: null
	,positions: null
	,vparts: null
	,__class__: nx3.elements.VBarColumnsGenerator
}
nx3.elements.VColumn = function(vcomplexes) {
	this.vcomplexes = vcomplexes;
};
$hxClasses["nx3.elements.VColumn"] = nx3.elements.VColumn;
nx3.elements.VColumn.__name__ = ["nx3","elements","VColumn"];
nx3.elements.VColumn.prototype = {
	vcomplexes: null
	,__class__: nx3.elements.VColumn
}
nx3.elements.VPart = function(npart) {
	this.npart = npart;
};
$hxClasses["nx3.elements.VPart"] = nx3.elements.VPart;
nx3.elements.VPart.__name__ = ["nx3","elements","VPart"];
nx3.elements.VPart.prototype = {
	getValue: function() {
		if(this.value != null) return this.value;
		if(this.getVVoices().length == 1) this.value = this.vvoices[0].getValue();
		var value = .0;
		var _g = 0, _g1 = this.vvoices;
		while(_g < _g1.length) {
			var vvoice = _g1[_g];
			++_g;
			value = Math.max(value,vvoice.getValue());
		}
		this.value = value | 0;
		return this.value;
	}
	,value: null
	,getPositionsVComplexes: function() {
		if(this.vcomplexes == null) this.getComplexes();
		return this.positionsVComplexes;
	}
	,getComplexes: function() {
		if(this.vcomplexes != null) return this.vcomplexes;
		this.generator = new nx3.elements.VPartComplexesGenerator(this.getVVoices());
		this.vcomplexes = this.generator.getComplexes();
		this.vcomplexesPositions = this.generator.getComplexesPositions();
		this.positionsVComplexes = this.generator.getPositionsComplexes();
		return this.vcomplexes;
	}
	,generator: null
	,positionsVComplexes: null
	,vcomplexesPositions: null
	,vcomplexes: null
	,getVVoices: function() {
		if(this.vvoices != null) return this.vvoices;
		this.vvoices = [];
		var _g = 0, _g1 = this.npart.nvoices;
		while(_g < _g1.length) {
			var nvoice = _g1[_g];
			++_g;
			this.vvoices.push(new nx3.elements.VVoice(nvoice));
		}
		return this.vvoices;
	}
	,vvoices: null
	,npart: null
	,__class__: nx3.elements.VPart
}
nx3.elements.VVoice = function(nvoice) {
	this.nvoice = nvoice;
};
$hxClasses["nx3.elements.VVoice"] = nx3.elements.VVoice;
nx3.elements.VVoice.__name__ = ["nx3","elements","VVoice"];
nx3.elements.VVoice.prototype = {
	getBeamgroups: function(pattern) {
		if(pattern != this.beampattern) this.beamgroups = null;
		if(this.beamgroups != null) return this.beamgroups;
		this.beamgroups = new nx3.elements.VCreateBeamgroups(this.getVNotes(),pattern).getBeamgroups();
		return this.beamgroups;
	}
	,beampattern: null
	,beamgroups: null
	,getValue: function() {
		if(this.value != null) return this.value;
		if(this.vnotes == null) this.getVNotes();
		this.value = 0;
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			this.value += vnote.nnote.value.value;
		}
		return this.value;
	}
	,value: null
	,getVNotePosition: function(vnote) {
		if(this.vnotePositions != null) return this.vnotePositions.h[vnote.__id__];
		if(this.vnotes == null) this.getVNotes();
		this.vnotePositions = new haxe.ds.ObjectMap();
		var pos = 0;
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote1 = _g1[_g];
			++_g;
			this.vnotePositions.set(vnote1,pos);
			pos += vnote1.nnote.value.value;
		}
		return this.vnotePositions.h[vnote.__id__];
	}
	,vnotePositions: null
	,getVNotes: function() {
		if(this.vnotes != null) return this.vnotes;
		this.vnotes = [];
		var _g = 0, _g1 = this.nvoice.nnotes;
		while(_g < _g1.length) {
			var nnote = _g1[_g];
			++_g;
			this.vnotes.push(new nx3.elements.VNote(nnote));
		}
		return this.vnotes;
	}
	,vnotes: null
	,nvoice: null
	,__class__: nx3.elements.VVoice
}
nx3.elements.VNote = function(nnote) {
	this.nnote = nnote;
};
$hxClasses["nx3.elements.VNote"] = nx3.elements.VNote;
nx3.elements.VNote.__name__ = ["nx3","elements","VNote"];
nx3.elements.VNote.prototype = {
	getDirection: function() {
		if(this.direction != null) return this.direction;
		var calculator = new nx3.elements.VNoteDirectionCalculator(this);
		var configDirection = this.config != null?this.config.direction:null;
		this.direction = calculator.getDirection(configDirection);
		return this.direction;
	}
	,direction: null
	,setConfig: function(newConfig) {
		if(Std.string(this.config) == Std.string(newConfig)) return; else {
			this.direction = null;
			this.vheadsPlacements = null;
		}
		this.config = newConfig;
	}
	,config: null
	,getVHeadsPlacements: function() {
		if(this.vheadsPlacements != null) return this.vheadsPlacements;
		if(this.vheads == null) this.getVHeads();
		var calculator = new nx3.elements.VHeadPlacementCalculator(this.vheads,this.getDirection());
		this.vheadsPlacements = calculator.getHeadsPlacements();
		return this.vheadsPlacements;
	}
	,vheadsPlacements: null
	,getVHeads: function() {
		if(this.vheads != null) return this.vheads;
		this.vheads = [];
		var _g = 0, _g1 = this.nnote.get_nheads();
		while(_g < _g1.length) {
			var nhead = _g1[_g];
			++_g;
			this.vheads.push(new nx3.elements.VHead(nhead));
		}
		return this.vheads;
	}
	,vheads: null
	,nnote: null
	,__class__: nx3.elements.VNote
}
nx3.elements.VNoteDirectionCalculator = function(vnote) {
	this.vnote = vnote;
};
$hxClasses["nx3.elements.VNoteDirectionCalculator"] = nx3.elements.VNoteDirectionCalculator;
nx3.elements.VNoteDirectionCalculator.__name__ = ["nx3","elements","VNoteDirectionCalculator"];
nx3.elements.VNoteDirectionCalculator.prototype = {
	getDirection: function(directionConfig) {
		var direction;
		if(this.vnote.nnote.direction != null) {
			var _g = this;
			switch( (_g.vnote.nnote.direction)[1] ) {
			case 0:
				direction = nx3.elements.EDirectionUD.Up;
				return direction;
			case 2:
				direction = nx3.elements.EDirectionUD.Down;
				return direction;
			default:
			}
		}
		if(directionConfig != null) return directionConfig;
		var calculator = new nx3.elements.VNoteInternalDirectionCalculator(this.vnote.getVHeads());
		return calculator.getDirection();
	}
	,vnote: null
	,__class__: nx3.elements.VNoteDirectionCalculator
}
nx3.elements.VNoteInternalDirectionCalculator = function(vheads) {
	this.vheads = vheads;
};
$hxClasses["nx3.elements.VNoteInternalDirectionCalculator"] = nx3.elements.VNoteInternalDirectionCalculator;
nx3.elements.VNoteInternalDirectionCalculator.__name__ = ["nx3","elements","VNoteInternalDirectionCalculator"];
nx3.elements.VNoteInternalDirectionCalculator.prototype = {
	weightToDirection: function(weight) {
		return weight <= 0?nx3.elements.EDirectionUD.Down:nx3.elements.EDirectionUD.Up;
	}
	,getDirection: function() {
		var headsCount = this.vheads.length;
		if(headsCount == 1) return this.weightToDirection(this.vheads[0].nhead.level);
		var weight = nx3.elements._ULevel.ULevel_Impl_.add(this.vheads[0].nhead.level,this.vheads[headsCount - 1].nhead.level);
		return this.weightToDirection(weight);
	}
	,vheads: null
	,__class__: nx3.elements.VNoteInternalDirectionCalculator
}
nx3.elements.VHeadPlacementCalculator = function(vheads,direction) {
	this.vheads = vheads;
	this.direction = direction;
};
$hxClasses["nx3.elements.VHeadPlacementCalculator"] = nx3.elements.VHeadPlacementCalculator;
nx3.elements.VHeadPlacementCalculator.__name__ = ["nx3","elements","VHeadPlacementCalculator"];
nx3.elements.VHeadPlacementCalculator.prototype = {
	getHeadsPlacements: function() {
		if(this.vheads.length == 1) return [{ level : this.vheads[0].nhead.level, pos : nx3.elements.EHeadPosition.Center}];
		var len = this.vheads.length;
		var placements = [];
		var tempArray = [];
		var _g = 0, _g1 = this.vheads;
		while(_g < _g1.length) {
			var vhead = _g1[_g];
			++_g;
			var placement = { level : vhead.nhead.level, pos : nx3.elements.EHeadPosition.Center};
			placements.push(placement);
			tempArray.push(0);
		}
		if(this.direction == nx3.elements.EDirectionUD.Up) {
			var _g1 = 0, _g = len - 1;
			while(_g1 < _g) {
				var j = _g1++;
				var i = len - j - 1;
				var vhead = this.vheads[i];
				var vheadNext = this.vheads[i - 1];
				var lDiff = vhead.nhead.level - vheadNext.nhead.level;
				if(lDiff < 2) {
					if(tempArray[i] == tempArray[i - 1]) {
						tempArray[i - 1] = 1;
						placements[i - 1].pos = nx3.elements.EHeadPosition.Right;
					}
				}
			}
		} else {
			var _g1 = 0, _g = len - 1;
			while(_g1 < _g) {
				var i = _g1++;
				var vhead = this.vheads[i];
				var vheadNext = this.vheads[i + 1];
				var lDiff = vheadNext.nhead.level - vhead.nhead.level;
				if(lDiff < 2) {
					if(tempArray[i] == tempArray[i + 1]) {
						tempArray[i + 1] = -1;
						placements[i + 1].pos = nx3.elements.EHeadPosition.Left;
					}
				}
			}
		}
		return placements;
	}
	,direction: null
	,vheads: null
	,__class__: nx3.elements.VHeadPlacementCalculator
}
nx3.elements.EHeadPosition = $hxClasses["nx3.elements.EHeadPosition"] = { __ename__ : true, __constructs__ : ["Left","Center","Right"] }
nx3.elements.EHeadPosition.Left = ["Left",0];
nx3.elements.EHeadPosition.Left.toString = $estr;
nx3.elements.EHeadPosition.Left.__enum__ = nx3.elements.EHeadPosition;
nx3.elements.EHeadPosition.Center = ["Center",1];
nx3.elements.EHeadPosition.Center.toString = $estr;
nx3.elements.EHeadPosition.Center.__enum__ = nx3.elements.EHeadPosition;
nx3.elements.EHeadPosition.Right = ["Right",2];
nx3.elements.EHeadPosition.Right.toString = $estr;
nx3.elements.EHeadPosition.Right.__enum__ = nx3.elements.EHeadPosition;
nx3.elements.VHead = function(nhead) {
	this.nhead = nhead;
};
$hxClasses["nx3.elements.VHead"] = nx3.elements.VHead;
nx3.elements.VHead.__name__ = ["nx3","elements","VHead"];
nx3.elements.VHead.prototype = {
	nhead: null
	,__class__: nx3.elements.VHead
}
nx3.elements.VComplexSignsCalculator = function(vnotes) {
	this.vnotes = vnotes;
};
$hxClasses["nx3.elements.VComplexSignsCalculator"] = nx3.elements.VComplexSignsCalculator;
nx3.elements.VComplexSignsCalculator.__name__ = ["nx3","elements","VComplexSignsCalculator"];
nx3.elements.VComplexSignsCalculator.prototype = {
	calcSortSigns: function(vsigns) {
		vsigns.sort(function(a,b) {
			return Reflect.compare(a.level,b.level);
		});
		return vsigns;
	}
	,calcUnsortedSigns: function(vnotes) {
		var vsigns = [];
		var _g = 0;
		while(_g < vnotes.length) {
			var vnote = vnotes[_g];
			++_g;
			var _g1 = 0, _g2 = vnote.nnote.get_nheads();
			while(_g1 < _g2.length) {
				var nhead = _g2[_g1];
				++_g1;
				var tsign = { sign : nhead.sign, level : nhead.level, position : 0};
				vsigns.push(tsign);
			}
		}
		return vsigns;
	}
	,calcVisibleSigns: function(signs) {
		var visibleSigns = [];
		var _g = 0;
		while(_g < signs.length) {
			var sign = signs[_g];
			++_g;
			if(sign.sign == nx3.elements.ESign.None) continue;
			visibleSigns.push(sign);
		}
		return visibleSigns;
	}
	,getVisibleSigns: function() {
		return this.calcVisibleSigns(this.getSigns());
	}
	,visibleSigns: null
	,getSigns: function() {
		var signs;
		signs = this.calcUnsortedSigns(this.vnotes);
		signs = this.calcSortSigns(signs);
		return signs;
	}
	,vnotes: null
	,__class__: nx3.elements.VComplexSignsCalculator
}
nx3.elements.VComplex = function(vnotes) {
	if(vnotes.length > 2) throw "VComplex nr of VNote(s) limited to max 2 - for now";
	this.vnotes = vnotes;
};
$hxClasses["nx3.elements.VComplex"] = nx3.elements.VComplex;
nx3.elements.VComplex.__name__ = ["nx3","elements","VComplex"];
nx3.elements.VComplex.prototype = {
	getVisibleSigns: function() {
		if(this.visibleSigns != null) return this.visibleSigns;
		this.getSigns();
		return this.visibleSigns;
	}
	,getSigns: function() {
		if(this.signs != null) return this.signs;
		this.calculator = new nx3.elements.VComplexSignsCalculator(this.vnotes);
		this.signs = this.calculator.getSigns();
		this.visibleSigns = this.calculator.getVisibleSigns();
		return this.signs;
	}
	,calculator: null
	,visibleSigns: null
	,signs: null
	,vnotes: null
	,__class__: nx3.elements.VComplex
}
nx3.elements.VBeamgroup = function(vnotes) {
	this.vnotes = vnotes;
};
$hxClasses["nx3.elements.VBeamgroup"] = nx3.elements.VBeamgroup;
nx3.elements.VBeamgroup.__name__ = ["nx3","elements","VBeamgroup"];
nx3.elements.VBeamgroup.prototype = {
	getFrame: function() {
		if(this.frame != null) return this.frame;
		if(this.direction == null) this.getDirection();
		this.calculator = new nx3.elements.VBeamgroupFrameCalculator(this);
		this.frame = this.calculator.getFrame();
		return this.frame;
	}
	,frame: null
	,calculator: null
	,setDirection: function(val) {
		return this.direction = val;
	}
	,getDirection: function() {
		if(this.direction != null) return this.direction;
		this.direction = new nx3.elements.VBeamgroupDirectionCalculator(this).getDirection();
		return this.direction;
	}
	,direction: null
	,vnotes: null
	,__class__: nx3.elements.VBeamgroup
}
nx3.elements.VBeamgroupFrameCalculator = function(beamgroup) {
	this.beamgroup = beamgroup;
};
$hxClasses["nx3.elements.VBeamgroupFrameCalculator"] = nx3.elements.VBeamgroupFrameCalculator;
nx3.elements.VBeamgroupFrameCalculator.__name__ = ["nx3","elements","VBeamgroupFrameCalculator"];
nx3.elements.VBeamgroupFrameCalculator.prototype = {
	calcLevelArrays: function() {
		if(this.beamgroup.getDirection() == nx3.elements.EDirectionUD.Up) {
			this.outerLevels = this.getTopLevels();
			this.innerLevels = this.getBottomLevels();
		} else {
			this.outerLevels = this.getBottomLevels();
			this.innerLevels = this.getTopLevels();
		}
	}
	,getBottomLevels: function() {
		var levels = [];
		var _g = 0, _g1 = this.beamgroup.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			levels.push(vnote.nnote.getBottomLevel());
		}
		return levels;
	}
	,getTopLevels: function() {
		var levels = [];
		var _g = 0, _g1 = this.beamgroup.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			levels.push(vnote.nnote.getTopLevel());
		}
		return levels;
	}
	,calcFramePrototype: function() {
		var count = this.innerLevels.length;
		return { leftInnerY : this.innerLevels[0], leftOuterY : this.outerLevels[0], rightInnerY : this.innerLevels[count - 1], rightOuterY : this.outerLevels[count - 1]};
	}
	,getFrame: function() {
		this.calcLevelArrays();
		var frame = this.calcFramePrototype();
		return frame;
	}
	,innerLevels: null
	,outerLevels: null
	,beamgroup: null
	,__class__: nx3.elements.VBeamgroupFrameCalculator
}
nx3.elements.VBeamgroupDirectionCalculator = function(beamgroup) {
	this.beamgroup = beamgroup;
};
$hxClasses["nx3.elements.VBeamgroupDirectionCalculator"] = nx3.elements.VBeamgroupDirectionCalculator;
nx3.elements.VBeamgroupDirectionCalculator.__name__ = ["nx3","elements","VBeamgroupDirectionCalculator"];
nx3.elements.VBeamgroupDirectionCalculator.prototype = {
	findBottomLevel: function() {
		var bottomLevel = this.beamgroup.vnotes[0].nnote.getBottomLevel();
		if(this.beamgroup.vnotes.length == 1) return bottomLevel;
		var _g1 = 1, _g = this.beamgroup.vnotes.length;
		while(_g1 < _g) {
			var i = _g1++;
			var level = this.beamgroup.vnotes[i].nnote.getBottomLevel();
			bottomLevel = Math.max(bottomLevel,level) | 0;
		}
		return bottomLevel;
	}
	,bottomLevel: null
	,findTopLevel: function() {
		var topLevel = this.beamgroup.vnotes[0].nnote.getTopLevel();
		if(this.beamgroup.vnotes.length == 1) return topLevel;
		var _g1 = 1, _g = this.beamgroup.vnotes.length;
		while(_g1 < _g) {
			var i = _g1++;
			var level = this.beamgroup.vnotes[i].nnote.getTopLevel();
			topLevel = Math.min(topLevel,level) | 0;
		}
		return topLevel;
	}
	,topLevel: null
	,getDirection: function() {
		this.topLevel = this.findTopLevel();
		this.bottomLevel = this.findBottomLevel();
		if(this.topLevel + this.bottomLevel <= 0) return nx3.elements.EDirectionUD.Down;
		return nx3.elements.EDirectionUD.Up;
	}
	,beamgroup: null
	,__class__: nx3.elements.VBeamgroupDirectionCalculator
}
nx3.elements.VCreateBeamgroups = function(vnotes,pattern) {
	if(pattern == null) pattern = [nx3.elements.ENoteValue.Nv4];
	this.vnotes = vnotes;
	this.pattern = pattern;
	this.adjustPatternLenght();
};
$hxClasses["nx3.elements.VCreateBeamgroups"] = nx3.elements.VCreateBeamgroups;
nx3.elements.VCreateBeamgroups.__name__ = ["nx3","elements","VCreateBeamgroups"];
nx3.elements.VCreateBeamgroups.prototype = {
	findBeamGroupIndex: function(pos,endPos,countFrom) {
		if(countFrom == null) countFrom = 0;
		var _g1 = countFrom, _g = this.patternValuePos.length;
		while(_g1 < _g) {
			var idx = _g1++;
			if(pos >= this.patternValuePos[idx] && endPos <= this.patternValueEnd[idx]) return idx;
		}
		return -1;
	}
	,createBeamGroups: function() {
		this.beamgropus = [];
		var vnoteGroupIdx = new haxe.ds.ObjectMap();
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			var vnotePos = this.vnotePosition.h[vnote.__id__];
			var vnoteEnd = this.vnotePositionEnd.h[vnote.__id__];
			var groupIdx = -111;
			var $e = (vnote.nnote.type);
			switch( $e[1] ) {
			case 0:
				var attributes = $e[5], articulations = $e[4], variant = $e[3], heads = $e[2];
				if(vnote.nnote.value.beamingLevel < 1) groupIdx = -1; else groupIdx = this.findBeamGroupIndex(vnotePos,vnoteEnd);
				break;
			default:
				groupIdx = -2;
			}
			vnoteGroupIdx.set(vnote,groupIdx);
		}
		var count = 0;
		var prevVNote = null;
		var arrVNote = [];
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			if(prevVNote == null) {
				arrVNote.push(vnote);
				prevVNote = vnote;
				continue;
			}
			var prevIdx = vnoteGroupIdx.h[prevVNote.__id__];
			var groupIdx = vnoteGroupIdx.h[vnote.__id__];
			if(prevIdx != groupIdx || prevIdx == -1) {
				var newBeamGroup = new nx3.elements.VBeamgroup(arrVNote);
				this.beamgropus.push(newBeamGroup);
				count = 0;
				arrVNote = [vnote];
			} else {
				count++;
				arrVNote.push(vnote);
			}
			prevVNote = vnote;
		}
		var newBeamGroup = new nx3.elements.VBeamgroup(arrVNote);
		this.beamgropus.push(newBeamGroup);
	}
	,preparePositionMaps: function() {
		this.vnotePosition = new haxe.ds.ObjectMap();
		this.vnotePositionEnd = new haxe.ds.ObjectMap();
		var pos = 0;
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			this.vnotePosition.set(vnote,pos);
			var endpos = pos + vnote.nnote.value.value;
			this.vnotePositionEnd.set(vnote,pos + vnote.nnote.value.value);
			pos = endpos;
		}
	}
	,vnotePositionEnd: null
	,vnotePosition: null
	,preparePatternCalculation: function() {
		this.patternValuePos = [];
		this.patternValueEnd = [];
		var vPos = 0;
		var i = 0;
		var _g = 0, _g1 = this.pattern;
		while(_g < _g1.length) {
			var v = _g1[_g];
			++_g;
			var vValue = v.value;
			var vEnd = vPos + vValue;
			this.patternValuePos.push(vPos);
			this.patternValueEnd.push(vEnd);
			vPos = vEnd;
			i++;
		}
		return this;
	}
	,patternValueEnd: null
	,patternValuePos: null
	,adjustPatternLenght: function() {
		var notesValue = 0;
		var _g = 0, _g1 = this.vnotes;
		while(_g < _g1.length) {
			var vnote = _g1[_g];
			++_g;
			notesValue += vnote.nnote.value.value;
		}
		var patternValue = 0;
		var _g = 0, _g1 = this.pattern;
		while(_g < _g1.length) {
			var value = _g1[_g];
			++_g;
			patternValue += value.value;
		}
		while(patternValue < notesValue) {
			this.pattern = this.pattern.concat(this.pattern);
			patternValue *= 2;
		}
	}
	,getBeamgroups: function() {
		this.preparePatternCalculation();
		this.preparePositionMaps();
		this.createBeamGroups();
		return this.beamgropus;
	}
	,beamgropus: null
	,pattern: null
	,vnotes: null
	,__class__: nx3.elements.VCreateBeamgroups
}
nx3.elements.VPartComplexesGenerator = function(vvoices) {
	this.vvoices = vvoices;
};
$hxClasses["nx3.elements.VPartComplexesGenerator"] = nx3.elements.VPartComplexesGenerator;
nx3.elements.VPartComplexesGenerator.__name__ = ["nx3","elements","VPartComplexesGenerator"];
nx3.elements.VPartComplexesGenerator.prototype = {
	calcPositionsMap: function() {
		var positionsMap = new haxe.ds.IntMap();
		var _g = 0, _g1 = this.vvoices;
		while(_g < _g1.length) {
			var vvoice = _g1[_g];
			++_g;
			var _g2 = 0, _g3 = vvoice.getVNotes();
			while(_g2 < _g3.length) {
				var vnote = _g3[_g2];
				++_g2;
				var npos = vvoice.getVNotePosition(vnote);
				if(!positionsMap.exists(npos)) positionsMap.set(npos,[]);
				positionsMap.get(npos).push(vnote);
			}
		}
		return positionsMap;
	}
	,positionsMap: null
	,calcComplexes: function(positions) {
		this.complexes = [];
		this.positionsComplexes = new haxe.ds.IntMap();
		this.complexesPositions = new haxe.ds.ObjectMap();
		var poskeys = nx3.elements.VMapTools.keysToArray(positions.keys());
		poskeys = nx3.elements.VMapTools.sortarray(poskeys);
		var _g = 0;
		while(_g < poskeys.length) {
			var pos = poskeys[_g];
			++_g;
			var vnotes = positions.get(pos);
			var vcomplex = new nx3.elements.VComplex(vnotes);
			this.complexes.push(vcomplex);
			this.positionsComplexes.set(pos,vcomplex);
			this.complexesPositions.set(vcomplex,pos);
		}
	}
	,getComplexesPositions: function() {
		if(this.complexes == null) this.getComplexes();
		return this.complexesPositions;
	}
	,complexesPositions: null
	,getPositionsComplexes: function() {
		if(this.complexes == null) this.getComplexes();
		return this.positionsComplexes;
	}
	,positionsComplexes: null
	,getComplexes: function() {
		if(this.complexes != null) return this.complexes;
		this.positionsMap = this.calcPositionsMap();
		this.calcComplexes(this.positionsMap);
		return this.complexes;
	}
	,complexes: null
	,vvoices: null
	,__class__: nx3.elements.VPartComplexesGenerator
}
nx3.elements.VMapTools = function() { }
$hxClasses["nx3.elements.VMapTools"] = nx3.elements.VMapTools;
nx3.elements.VMapTools.__name__ = ["nx3","elements","VMapTools"];
nx3.elements.VMapTools.keysToArray = function(it) {
	var result = [];
	while( it.hasNext() ) {
		var v = it.next();
		result.push(v);
	}
	return result;
}
nx3.elements.VMapTools.sortarray = function(a) {
	a.sort(function(a1,b) {
		return Reflect.compare(a1,b);
	});
	return a;
}
nx3.elements.tools = {}
nx3.elements.tools.ENoteTypeTools = function() { }
$hxClasses["nx3.elements.tools.ENoteTypeTools"] = nx3.elements.tools.ENoteTypeTools;
nx3.elements.tools.ENoteTypeTools.__name__ = ["nx3","elements","tools","ENoteTypeTools"];
nx3.elements.tools.ENoteTypeTools.noteSortHeads = function(type) {
	var $e = (type);
	switch( $e[1] ) {
	case 0:
		var attributes = $e[5], articulations = $e[4], variant = $e[3], heads = $e[2];
		heads.sort(function(i1,i2) {
			var cmp;
			cmp = Reflect.compare(i1.level,i2.level);
			if(cmp != 0) return cmp;
			return 0;
		});
		break;
	default:
		throw "Can not sort heads on other type than ENoteType.Note - this one is a " + Std.string(type);
	}
}
nx3.elements.tools.HeadTool = function() { }
$hxClasses["nx3.elements.tools.HeadTool"] = nx3.elements.tools.HeadTool;
nx3.elements.tools.HeadTool.__name__ = ["nx3","elements","tools","HeadTool"];
nx3.elements.tools.HeadTool.getHeadRect = function(head,value) {
	var rect = null;
	switch( (value.head)[1] ) {
	case 2:
		rect = new flash.geom.Rectangle(-2,-1,4,2);
		break;
	case 1:
	case 0:
		rect = new flash.geom.Rectangle(-1.6,-1,3.2,2);
		break;
	}
	rect.offset(0,head.level);
	return rect;
}
nx3.elements.tools.HeadTool.getDirection = function(heads) {
	return null;
}
nx3.elements.tools.HeadsTool = function() { }
$hxClasses["nx3.elements.tools.HeadsTool"] = nx3.elements.tools.HeadsTool;
nx3.elements.tools.HeadsTool.__name__ = ["nx3","elements","tools","HeadsTool"];
nx3.elements.tools.HeadsTool.topLevel = function(heads) {
	return heads[0].level;
}
nx3.elements.tools.HeadsTool.bottomLevel = function(heads) {
	return heads[heads.length - 1].level;
}
nx3.elements.tools.HeadsTool.midLevel = function(heads) {
	var bottom = nx3.elements.tools.HeadsTool.bottomLevel(heads);
	var top = nx3.elements.tools.HeadsTool.topLevel(heads);
	return top + (bottom - top) / 2;
}
nx3.elements.tools.HeadsTool.getDirection = function(heads) {
	return nx3.elements.tools.HeadsTool.midLevel(heads) > 0?nx3.elements.EDirectionUD.Up:nx3.elements.EDirectionUD.Down;
}
nx3.elements.tools.HeadsTool.getHeadPositions = function(heads,direction) {
	if(heads.length < 2) return [0];
	var len = heads.length;
	var result = [];
	var _g = 0;
	while(_g < len) {
		var i = _g++;
		result.push(0);
	}
	if(direction == nx3.elements.EDirectionUD.Down) {
		var _g1 = 0, _g = len - 1;
		while(_g1 < _g) {
			var i = _g1++;
			var head = heads[i];
			var headNext = heads[i + 1];
			var lDiff = headNext.level - head.level;
			if(lDiff < 2) {
				if(result[i] == result[i + 1]) result[i + 1] = -1;
			}
		}
	} else {
		var _g1 = 0, _g = len - 1;
		while(_g1 < _g) {
			var j = _g1++;
			var i = len - j - 1;
			var head = heads[i];
			var headNext = heads[i - 1];
			var lDiff = head.level - headNext.level;
			if(lDiff < 2) {
				if(result[i] == result[i - 1]) result[i - 1] = 1;
			}
		}
	}
	return result;
}
nx3.elements.tools.HeadsTool.headsCollide = function(heads1,heads2) {
	var _g = 0;
	while(_g < heads1.length) {
		var head1 = heads1[_g];
		++_g;
		var _g1 = 0;
		while(_g1 < heads2.length) {
			var head2 = heads2[_g1];
			++_g1;
			if(head1.level == head2.level - 1) return true;
			if(head1.level == head2.level) return true;
			if(head1.level == nx3.elements._ULevel.ULevel_Impl_.addInteger(head2.level,1)) return true;
		}
	}
	return false;
}
nx3.elements.tools.SignsTools = function() { }
$hxClasses["nx3.elements.tools.SignsTools"] = nx3.elements.tools.SignsTools;
nx3.elements.tools.SignsTools.__name__ = ["nx3","elements","tools","SignsTools"];
nx3.elements.tools.SignsTools.adjustPositions = function(signs) {
	signs = nx3.elements.tools.SignsTools.removeNones(signs);
	if(signs.length < 2) return signs;
	signs = nx3.elements.tools.SignsTools.sortSigns(signs);
	signs = nx3.elements.tools.SignsTools.calcPositions(signs);
	return signs;
}
nx3.elements.tools.SignsTools.calcPositions = function(signs) {
	var levels = [-999,-999,-999,-999];
	var _g = 0;
	while(_g < signs.length) {
		var sign = signs[_g];
		++_g;
		var cpos = 0;
		var diff = sign.level - levels[cpos];
		while(diff < nx3.elements.tools.SignsTools.BREAKPOINT) {
			cpos++;
			diff = sign.level - levels[cpos];
		}
		levels[cpos] = sign.level;
		sign.position = cpos;
	}
	return signs;
}
nx3.elements.tools.SignsTools.removeNones = function(signs) {
	var r = [];
	var _g = 0;
	while(_g < signs.length) {
		var sign = signs[_g];
		++_g;
		if(sign.sign != nx3.elements.ESign.None) r.push(sign);
	}
	return r;
}
nx3.elements.tools.SignsTools.sortSigns = function(signs) {
	signs.sort(function(signA,signB) {
		if(signA.level <= signB.level) return -1; else return 1;
	});
	return signs;
}
nx3.elements.tools.SignsTools.getPositions = function(signs) {
	return Lambda.array(Lambda.map(signs,function(sign) {
		return sign.position;
	}));
}
nx3.elements.tools.SignsTools.getSignRect = function(sign) {
	switch( (sign)[1] ) {
	case 0:
		return null;
	case 5:
		return new flash.geom.Rectangle(0,-1.5,2.6,3);
	case 7:
	case 8:
	case 6:
		return new flash.geom.Rectangle(0,-2,4.4,4);
	case 2:
		return new flash.geom.Rectangle(0,-3,2.6,5);
	default:
		return new flash.geom.Rectangle(0,-3,2.6,6);
	}
	throw "This shouldn't happen!";
	return null;
}
nx3.elements.tools.SignsTools.adjustSignFontX = function(sign) {
	switch( (sign)[1] ) {
	case 2:
		return 0.3;
	case 1:
		return 0.3;
	default:
	}
	return 0;
}
nx3.io = {}
nx3.io.HeadXML = function() { }
$hxClasses["nx3.io.HeadXML"] = nx3.io.HeadXML;
nx3.io.HeadXML.__name__ = ["nx3","io","HeadXML"];
nx3.io.HeadXML.toXml = function(head) {
	var xml = Xml.createElement(nx3.io.HeadXML.XHEAD);
	switch( (head.type)[1] ) {
	case 2:
	case 1:
		xml.set(nx3.io.HeadXML.XHEAD_TYPE,Std.string(head.type));
		break;
	default:
	}
	xml.set(nx3.io.HeadXML.XHEAD_LEVEL,Std.string(head.level));
	if(head.sign != nx3.elements.ESign.None) xml.set(nx3.io.HeadXML.XHEAD_SIGN,Std.string(head.sign));
	if(head.tie != null) {
		var $e = (head.tie);
		switch( $e[1] ) {
		case 0:
			var direction = $e[2];
			xml.set(nx3.io.HeadXML.XHEAD_TIE,Std.string(head.tie));
			break;
		case 1:
			var direction = $e[2];
			xml.set(nx3.io.HeadXML.XHEAD_TIE,Std.string(head.tie));
			break;
		}
	}
	if(head.tieTo != null) {
		var $e = (head.tieTo);
		switch( $e[1] ) {
		case 0:
			var direction = $e[2];
			xml.set(nx3.io.HeadXML.XHEAD_TIETO,Std.string(head.tieTo));
			break;
		case 1:
			var direction = $e[2];
			xml.set(nx3.io.HeadXML.XHEAD_TIETO,Std.string(head.tieTo));
			break;
		}
	}
	return xml;
}
nx3.io.HeadXML.fromXmlStr = function(xmlStr) {
	var xml = Xml.parse(xmlStr).firstElement();
	var typeStr = xml.get(nx3.io.HeadXML.XHEAD_TYPE);
	var type = cx.EnumTools.createFromString(nx3.elements.EHeadType,typeStr);
	var level = Std.parseInt(xml.get(nx3.io.HeadXML.XHEAD_LEVEL));
	var sign = cx.EnumTools.createFromString(nx3.elements.ESign,xml.get(nx3.io.HeadXML.XHEAD_SIGN));
	var tie = cx.EnumTools.createFromString(nx3.elements.ETie,xml.get(nx3.io.HeadXML.XHEAD_TIE));
	var tieTo = cx.EnumTools.createFromString(nx3.elements.ETie,xml.get(nx3.io.HeadXML.XHEAD_TIETO));
	return new nx3.elements.NHead(type,nx3.elements._ULevel.ULevel_Impl_.inRange(level),sign,tie,tieTo);
}
nx3.io.HeadXML.test = function(item) {
	var str = nx3.io.HeadXML.toXml(item).toString();
	var item2 = nx3.io.HeadXML.fromXmlStr(str);
	var str2 = nx3.io.HeadXML.toXml(item2).toString();
	haxe.Log.trace(str,{ fileName : "HeadXML.hx", lineNumber : 129, className : "nx3.io.HeadXML", methodName : "test"});
	haxe.Log.trace(str2,{ fileName : "HeadXML.hx", lineNumber : 130, className : "nx3.io.HeadXML", methodName : "test"});
	return str == str2;
}
nx3.io.NoteXML = function() { }
$hxClasses["nx3.io.NoteXML"] = nx3.io.NoteXML;
nx3.io.NoteXML.__name__ = ["nx3","io","NoteXML"];
nx3.io.NoteXML.toXml = function(note) {
	var xml = null;
	var $e = (note.type);
	switch( $e[1] ) {
	case 0:
		var attributes = $e[5], articulations = $e[4], variant = $e[3], heads = $e[2];
		xml = Xml.createElement("note");
		var _g = 0;
		while(_g < heads.length) {
			var head = heads[_g];
			++_g;
			var headXml = nx3.io.HeadXML.toXml(head);
			xml.addChild(headXml);
		}
		if(variant != null) xml.set("variant",Std.string(variant));
		if(articulations != null) {
			var articulationStrings = [];
			var _g = 0;
			while(_g < articulations.length) {
				var articulation = articulations[_g];
				++_g;
				articulationStrings.push(Std.string(articulation));
			}
			xml.set("articulations",articulationStrings.join(";"));
		}
		if(attributes != null) {
			var attributesStrings = [];
			var _g = 0;
			while(_g < attributes.length) {
				var attribute = attributes[_g];
				++_g;
				attributesStrings.push(Std.string(attribute));
			}
			xml.set("attributes",attributesStrings.join(";"));
		}
		break;
	case 1:
		var level = $e[2];
		xml = Xml.createElement("pause");
		if(level != 0) xml.set("level",Std.string(level));
		break;
	case 4:
		var format = $e[5], continuation = $e[4], offset = $e[3], text = $e[2];
		xml = Xml.createElement("lyric");
		xml.set("text",text);
		if(continuation != null) xml.set("continuation",Std.string(continuation));
		if(offset != null) xml.set("offset",Std.string(offset));
		if(format != null) xml.set("format",Std.string(format));
		break;
	default:
		xml = Xml.createElement("undefined");
	}
	if(note.value.value != nx3.elements.ENoteValue.Nv4.value) xml.set("value",Std.string(note.value.value));
	if(note.direction != null) xml.set("direction",Std.string(note.direction));
	return xml;
}
nx3.io.NoteXML.fromXmlStr = function(xmlStr) {
	var xml = Xml.parse(xmlStr).firstElement();
	var xmlType = xml.get_nodeName();
	var type = null;
	switch(xmlType) {
	case "note":
		var heads = [];
		var $it0 = xml.elementsNamed(nx3.io.HeadXML.XHEAD);
		while( $it0.hasNext() ) {
			var h = $it0.next();
			var head = nx3.io.HeadXML.fromXmlStr(h.toString());
			heads.push(head);
		}
		var variant = cx.EnumTools.createFromString(nx3.elements.ENotationVariant,xml.get("variant"));
		var articulations = [];
		var articulationsStr = xml.get("articulations");
		if(articulationsStr != null) {
			var articulationStrings = articulationsStr.split(";");
			var _g = 0;
			while(_g < articulationStrings.length) {
				var articulationStr = articulationStrings[_g];
				++_g;
				articulations.push(cx.EnumTools.createFromString(nx3.elements.ENoteArticulation,articulationStr));
			}
		}
		if(articulations.length == 0) articulations = null;
		var attributes = [];
		var attributesStr = xml.get("attributes");
		if(attributesStr != null) {
			var attributesStrings = attributesStr.split(";");
			var _g = 0;
			while(_g < attributesStrings.length) {
				var attributeStr = attributesStrings[_g];
				++_g;
				attributes.push(cx.EnumTools.createFromString(nx3.elements.ENoteAttributes,attributeStr));
			}
		}
		if(attributes.length == 0) attributes = null;
		type = nx3.elements.ENoteType.Note(heads,variant,articulations,attributes);
		break;
	case "pause":
		var pauseLevelStr = xml.get("level");
		var levelInt = pauseLevelStr == null?0:Std.parseInt(pauseLevelStr);
		type = nx3.elements.ENoteType.Pause(nx3.elements._ULevel.ULevel_Impl_.inRange(0));
		break;
	case "lyric":
		var text = xml.get("text");
		var offsetStr = xml.get("offset");
		var offset = cx.EnumTools.createFromString(nx3.elements.EPosition,offsetStr);
		var continuationStr = xml.get("continuation");
		var continuation = cx.EnumTools.createFromString(nx3.elements.ELyricContinuation,continuationStr);
		var formatStr = xml.get("format");
		var format = cx.EnumTools.createFromString(nx3.elements.ELyricFormat,formatStr);
		type = nx3.elements.ENoteType.Lyric(text,offset,continuation,format);
		break;
	}
	var valStr = xml.get("value");
	var val = valStr == null?nx3.elements.ENoteValue.Nv4.value:Std.parseInt(xml.get("value"));
	var value = nx3.elements.ENoteValue.getFromValue(val);
	var direction = cx.EnumTools.createFromString(nx3.elements.EDirectionUAD,xml.get("direction"));
	return new nx3.elements.NNote(type,null,value,direction);
}
nx3.io.NoteXML.test = function(item) {
	var str = nx3.io.NoteXML.toXml(item).toString();
	var item2 = nx3.io.NoteXML.fromXmlStr(str);
	var str2 = nx3.io.NoteXML.toXml(item2).toString();
	haxe.Log.trace(str,{ fileName : "NoteXML.hx", lineNumber : 195, className : "nx3.io.NoteXML", methodName : "test"});
	haxe.Log.trace(str2,{ fileName : "NoteXML.hx", lineNumber : 196, className : "nx3.io.NoteXML", methodName : "test"});
	return str == str2;
}
nx3.render = {}
nx3.render.ISpriteRenderer = function() { }
$hxClasses["nx3.render.ISpriteRenderer"] = nx3.render.ISpriteRenderer;
nx3.render.ISpriteRenderer.__name__ = ["nx3","render","ISpriteRenderer"];
nx3.render.ISpriteRenderer.prototype = {
	initTargetSprite: null
	,__class__: nx3.render.ISpriteRenderer
}
nx3.render.IRenderer = function() { }
$hxClasses["nx3.render.IRenderer"] = nx3.render.IRenderer;
nx3.render.IRenderer.__name__ = ["nx3","render","IRenderer"];
nx3.render.IRenderer.prototype = {
	complex: null
	,note: null
	,signs: null
	,heads: null
	,stave: null
	,notelines: null
	,__class__: nx3.render.IRenderer
}
nx3.render.FrameRenderer = function(target,scaling) {
	this.initTargetSprite(target,scaling);
};
$hxClasses["nx3.render.FrameRenderer"] = nx3.render.FrameRenderer;
nx3.render.FrameRenderer.__name__ = ["nx3","render","FrameRenderer"];
nx3.render.FrameRenderer.__interfaces__ = [nx3.render.ISpriteRenderer,nx3.render.IRenderer];
nx3.render.FrameRenderer.prototype = {
	drawRect: function(rect,x,y,lineColor,inflate) {
		if(inflate == null) inflate = 0;
		if(lineColor == null) lineColor = 0;
		this.target.get_graphics().lineStyle(1,lineColor);
		var r = nx3.render.scaling.Scaling.scaleRect(this.scaling,rect);
		r.offset(x,y);
		if(inflate != 0) r.inflate(inflate,inflate);
		this.target.get_graphics().drawRect(r.x,r.y,r.width,r.height);
	}
	,rects: function(x,y,rects) {
		var _g = 0;
		while(_g < rects.length) {
			var item = rects[_g];
			++_g;
		}
	}
	,signs: function(x,y,dcomplex) {
		if(dcomplex.get_signsFrame() != null) this.drawRect(dcomplex.get_signsFrame(),x,y,16711680,2);
		var signsX = x + dcomplex.get_signsFrame().x * this.scaling.halfNoteWidth;
		if(dcomplex.get_signRects() != null) {
			var _g = 0, _g1 = dcomplex.get_signRects();
			while(_g < _g1.length) {
				var signRect = _g1[_g];
				++_g;
				this.drawRect(signRect,signsX,y,0);
			}
		}
	}
	,heads: function(x,y,dnote) {
		var _g = 0, _g1 = dnote.get_headRects();
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			this.drawRect(rect,x,y,255);
		}
	}
	,stave: function(x,y,dnote) {
	}
	,notelines: function(x,y,width) {
		this.target.get_graphics().lineStyle(this.scaling.linesWidth,11184810);
		var _g = -2;
		while(_g < 3) {
			var i = _g++;
			var cy = y + i * this.scaling.space;
			this.target.get_graphics().moveTo(x,cy);
			this.target.get_graphics().lineTo(x + width,cy);
		}
	}
	,complex: function(x,y,dcomplex) {
		var _g = 0, _g1 = dcomplex.dnotes;
		while(_g < _g1.length) {
			var dnote = _g1[_g];
			++_g;
			this.note(x,y,dnote);
		}
		this.signs(x,y,dcomplex);
		this.drawRect(dcomplex.get_headsRect(),x,y,16711680,2);
	}
	,note: function(x,y,dnote) {
		this.heads(x,y,dnote);
		this.stave(x,y,dnote);
		this.drawRect(dnote.get_headsRect(),x,y,16755370,2);
		this.target.get_graphics().lineStyle(1,11184810);
		this.target.get_graphics().moveTo(x,y + this.scaling.space * 6);
		this.target.get_graphics().lineTo(x,y - this.scaling.space * 6);
	}
	,initTargetSprite: function(target,scaling) {
		this.target = target;
		this.scaling = scaling;
	}
	,target: null
	,scaling: null
	,__class__: nx3.render.FrameRenderer
}
nx3.render.scaling = {}
nx3.render.scaling.Scaling = function() { }
$hxClasses["nx3.render.scaling.Scaling"] = nx3.render.scaling.Scaling;
nx3.render.scaling.Scaling.__name__ = ["nx3","render","scaling","Scaling"];
nx3.render.scaling.Scaling.scaleRect = function(scaling,rect) {
	return new flash.geom.Rectangle(rect.x * scaling.halfNoteWidth,rect.y * scaling.halfSpace,rect.width * scaling.halfNoteWidth,rect.height * scaling.halfSpace);
}
nx3.render.tools = {}
nx3.render.tools.RenderTools = function() { }
$hxClasses["nx3.render.tools.RenderTools"] = nx3.render.tools.RenderTools;
nx3.render.tools.RenderTools.__name__ = ["nx3","render","tools","RenderTools"];
nx3.render.tools.RenderTools.spriteToPng = function(sprite,filename,extraWidth,extraHeight) {
	if(extraHeight == null) extraHeight = 100;
	if(extraWidth == null) extraWidth = 100;
}
nx3.test.QHead = function(level,sign) {
	if(level == null) level = 0;
	nx3.elements.NHead.call(this,null,level,sign);
};
$hxClasses["nx3.test.QHead"] = nx3.test.QHead;
nx3.test.QHead.__name__ = ["nx3","test","QHead"];
nx3.test.QHead.__super__ = nx3.elements.NHead;
nx3.test.QHead.prototype = $extend(nx3.elements.NHead.prototype,{
	__class__: nx3.test.QHead
});
nx3.test.QHeadSharp = function(level) {
	if(level == null) level = 0;
	nx3.test.QHead.call(this,level,nx3.elements.ESign.Sharp);
};
$hxClasses["nx3.test.QHeadSharp"] = nx3.test.QHeadSharp;
nx3.test.QHeadSharp.__name__ = ["nx3","test","QHeadSharp"];
nx3.test.QHeadSharp.__super__ = nx3.test.QHead;
nx3.test.QHeadSharp.prototype = $extend(nx3.test.QHead.prototype,{
	__class__: nx3.test.QHeadSharp
});
nx3.test.QHeadFlat = function(level) {
	if(level == null) level = 0;
	nx3.test.QHead.call(this,level,nx3.elements.ESign.Flat);
};
$hxClasses["nx3.test.QHeadFlat"] = nx3.test.QHeadFlat;
nx3.test.QHeadFlat.__name__ = ["nx3","test","QHeadFlat"];
nx3.test.QHeadFlat.__super__ = nx3.test.QHead;
nx3.test.QHeadFlat.prototype = $extend(nx3.test.QHead.prototype,{
	__class__: nx3.test.QHeadFlat
});
nx3.test.QHeadNatural = function(level) {
	if(level == null) level = 0;
	nx3.test.QHead.call(this,level,nx3.elements.ESign.Natural);
};
$hxClasses["nx3.test.QHeadNatural"] = nx3.test.QHeadNatural;
nx3.test.QHeadNatural.__name__ = ["nx3","test","QHeadNatural"];
nx3.test.QHeadNatural.__super__ = nx3.test.QHead;
nx3.test.QHeadNatural.prototype = $extend(nx3.test.QHead.prototype,{
	__class__: nx3.test.QHeadNatural
});
nx3.test.QNote = function(headLevel,headLevels,head,heads,value,signs,direction) {
	if(signs == null) signs = "";
	signs += "...........";
	var aSigns = signs.split("");
	if(headLevel != null) headLevels = [headLevel];
	if(headLevels != null) {
		heads = [];
		var i = 0;
		var _g = 0;
		while(_g < headLevels.length) {
			var level = headLevels[_g];
			++_g;
			heads.push(new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(level),this.getSign(aSigns[i++])));
		}
	}
	if(head != null) heads = [head];
	if(heads == null) heads = [new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(0))];
	if(value == null) value = nx3.elements.ENoteValue.Nv4;
	nx3.elements.NNote.call(this,null,heads,value,direction);
};
$hxClasses["nx3.test.QNote"] = nx3.test.QNote;
nx3.test.QNote.__name__ = ["nx3","test","QNote"];
nx3.test.QNote.__super__ = nx3.elements.NNote;
nx3.test.QNote.prototype = $extend(nx3.elements.NNote.prototype,{
	getSign: function(val) {
		switch(val) {
		case "#":
			return nx3.elements.ESign.Sharp;
		case "b":
			return nx3.elements.ESign.Flat;
		case "N":case "n":
			return nx3.elements.ESign.Natural;
		default:
			return null;
		}
	}
	,__class__: nx3.test.QNote
});
nx3.test.QNote4 = function(headLevel,headLevels,signs) {
	if(signs == null) signs = "";
	nx3.test.QNote.call(this,headLevel,headLevels,null,null,nx3.elements.ENoteValue.Nv4,signs);
};
$hxClasses["nx3.test.QNote4"] = nx3.test.QNote4;
nx3.test.QNote4.__name__ = ["nx3","test","QNote4"];
nx3.test.QNote4.__super__ = nx3.test.QNote;
nx3.test.QNote4.prototype = $extend(nx3.test.QNote.prototype,{
	__class__: nx3.test.QNote4
});
nx3.test.QNote8 = function(headLevel,headLevels,signs) {
	if(signs == null) signs = "";
	nx3.test.QNote.call(this,headLevel,headLevels,null,null,nx3.elements.ENoteValue.Nv8);
};
$hxClasses["nx3.test.QNote8"] = nx3.test.QNote8;
nx3.test.QNote8.__name__ = ["nx3","test","QNote8"];
nx3.test.QNote8.__super__ = nx3.test.QNote;
nx3.test.QNote8.prototype = $extend(nx3.test.QNote.prototype,{
	__class__: nx3.test.QNote8
});
nx3.test.QNote2 = function(headLevel,headLevels,signs) {
	if(signs == null) signs = "";
	nx3.test.QNote.call(this,headLevel,headLevels,null,null,nx3.elements.ENoteValue.Nv2);
};
$hxClasses["nx3.test.QNote2"] = nx3.test.QNote2;
nx3.test.QNote2.__name__ = ["nx3","test","QNote2"];
nx3.test.QNote2.__super__ = nx3.test.QNote;
nx3.test.QNote2.prototype = $extend(nx3.test.QNote.prototype,{
	__class__: nx3.test.QNote2
});
nx3.test.QVoice = function(notevalues,notevalue,headlevels,levelrepeats,signs,direction) {
	if(levelrepeats == null) levelrepeats = 1;
	var _notevalues = notevalues;
	if(_notevalues == null) _notevalues = [notevalue];
	if(_notevalues == null) _notevalues = [4];
	var _headlevels = headlevels != null?headlevels:[0];
	while(_notevalues.length > _headlevels.length) _headlevels.push(0);
	var r = 1;
	var copy = _headlevels.slice();
	while(r < levelrepeats) {
		_headlevels = _headlevels.concat(copy);
		r++;
	}
	while(_headlevels.length > _notevalues.length) _notevalues = _notevalues.concat(_notevalues);
	var notes = [];
	if(signs == null) signs = "-";
	var asigns = signs.split("");
	while(_headlevels.length > asigns.length) asigns = asigns.concat(asigns);
	var i = 0;
	var _g = 0;
	while(_g < _headlevels.length) {
		var level = _headlevels[_g];
		++_g;
		var sign = this.getSign(asigns[i]);
		var head = new nx3.test.QHead(level,sign);
		var note = new nx3.test.QNote(null,null,head,null,this.getNotevalue(_notevalues[i]));
		notes.push(note);
		i++;
	}
	nx3.elements.NVoice.call(this,notes,null,direction);
};
$hxClasses["nx3.test.QVoice"] = nx3.test.QVoice;
nx3.test.QVoice.__name__ = ["nx3","test","QVoice"];
nx3.test.QVoice.__super__ = nx3.elements.NVoice;
nx3.test.QVoice.prototype = $extend(nx3.elements.NVoice.prototype,{
	getNotevalue: function(val) {
		switch(val) {
		case 16.0:
			return nx3.elements.ENoteValue.Nv16;
		case .16:
			return nx3.elements.ENoteValue.Nv16dot;
		case 8.0:
			return nx3.elements.ENoteValue.Nv8;
		case .8:
			return nx3.elements.ENoteValue.Nv8dot;
		case 4.0:
			return nx3.elements.ENoteValue.Nv4;
		case .4:
			return nx3.elements.ENoteValue.Nv4dot;
		case 2.0:
			return nx3.elements.ENoteValue.Nv2;
		case .2:
			return nx3.elements.ENoteValue.Nv2dot;
		case 1.0:
			return nx3.elements.ENoteValue.Nv1;
		case .1:
			return nx3.elements.ENoteValue.Nv1dot;
		default:
			throw "Unknown notevalue: " + val;
		}
		return nx3.elements.ENoteValue.Nv4;
	}
	,getSign: function(val) {
		switch(val) {
		case "#":
			return nx3.elements.ESign.Sharp;
		case "b":
			return nx3.elements.ESign.Flat;
		case "N":case "n":
			return nx3.elements.ESign.Natural;
		default:
			return null;
		}
	}
	,__class__: nx3.test.QVoice
});
nx3.test.QVoiceDown = function(notevalues,notevalue,headlevels,levelrepeats,signs) {
	nx3.test.QVoice.call(this,notevalues,notevalue,headlevels,levelrepeats,signs,nx3.elements.EDirectionUAD.Down);
};
$hxClasses["nx3.test.QVoiceDown"] = nx3.test.QVoiceDown;
nx3.test.QVoiceDown.__name__ = ["nx3","test","QVoiceDown"];
nx3.test.QVoiceDown.__super__ = nx3.test.QVoice;
nx3.test.QVoiceDown.prototype = $extend(nx3.test.QVoice.prototype,{
	__class__: nx3.test.QVoiceDown
});
nx3.test.QVoiceUp = function(notevalues,notevalue,headlevels,levelrepeats,signs) {
	nx3.test.QVoice.call(this,notevalues,notevalue,headlevels,levelrepeats,signs,nx3.elements.EDirectionUAD.Up);
};
$hxClasses["nx3.test.QVoiceUp"] = nx3.test.QVoiceUp;
nx3.test.QVoiceUp.__name__ = ["nx3","test","QVoiceUp"];
nx3.test.QVoiceUp.__super__ = nx3.test.QVoice;
nx3.test.QVoiceUp.prototype = $extend(nx3.test.QVoice.prototype,{
	__class__: nx3.test.QVoiceUp
});
nx3.test.TestN = function() {
	haxe.unit.TestCase.call(this);
};
$hxClasses["nx3.test.TestN"] = nx3.test.TestN;
nx3.test.TestN.__name__ = ["nx3","test","TestN"];
nx3.test.TestN.__super__ = haxe.unit.TestCase;
nx3.test.TestN.prototype = $extend(haxe.unit.TestCase.prototype,{
	test2: function() {
		var item1 = new nx3.elements.NNote(null,[new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(-3)),new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(-2),nx3.elements.ESign.Flat),new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(4),nx3.elements.ESign.Natural),new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(1))],nx3.elements.ENoteValue.Nv2dot,nx3.elements.EDirectionUAD.Down);
		var xmlstr1 = nx3.io.NoteXML.toXml(item1).toString();
		var item2 = nx3.io.NoteXML.fromXmlStr(xmlstr1);
		var xmlstr2 = nx3.io.NoteXML.toXml(item2).toString();
		this.assertEquals(Std.string(item1),Std.string(item2),{ fileName : "TestN.hx", lineNumber : 34, className : "nx3.test.TestN", methodName : "test2"});
		this.assertEquals(xmlstr1,xmlstr2,{ fileName : "TestN.hx", lineNumber : 35, className : "nx3.test.TestN", methodName : "test2"});
		this.assertEquals([-3,-2,1,4].toString(),item1.getHeadLevels().toString(),{ fileName : "TestN.hx", lineNumber : 38, className : "nx3.test.TestN", methodName : "test2"});
	}
	,test1: function() {
		var item1 = new nx3.elements.NHead(null,nx3.elements._ULevel.ULevel_Impl_.inRange(2),nx3.elements.ESign.Flat);
		var xmlstr1 = nx3.io.HeadXML.toXml(item1).toString();
		var item2 = nx3.io.HeadXML.fromXmlStr(xmlstr1);
		var xmlstr2 = nx3.io.HeadXML.toXml(item2).toString();
		this.assertEquals(Std.string(item1),Std.string(item2),{ fileName : "TestN.hx", lineNumber : 23, className : "nx3.test.TestN", methodName : "test1"});
		this.assertEquals(xmlstr1,xmlstr2,{ fileName : "TestN.hx", lineNumber : 24, className : "nx3.test.TestN", methodName : "test1"});
	}
	,__class__: nx3.test.TestN
});
nx3.test.TestQ = function() {
	haxe.unit.TestCase.call(this);
};
$hxClasses["nx3.test.TestQ"] = nx3.test.TestQ;
nx3.test.TestQ.__name__ = ["nx3","test","TestQ"];
nx3.test.TestQ.__super__ = haxe.unit.TestCase;
nx3.test.TestQ.prototype = $extend(haxe.unit.TestCase.prototype,{
	test0: function() {
		this.assertTrue(true,{ fileName : "TestQ.hx", lineNumber : 16, className : "nx3.test.TestQ", methodName : "test0"});
	}
	,__class__: nx3.test.TestQ
});
nx3.test.TestV = function() {
	haxe.unit.TestCase.call(this);
};
$hxClasses["nx3.test.TestV"] = nx3.test.TestV;
nx3.test.TestV.__name__ = ["nx3","test","TestV"];
nx3.test.TestV.__super__ = haxe.unit.TestCase;
nx3.test.TestV.prototype = $extend(haxe.unit.TestCase.prototype,{
	testVBar: function() {
		var npart0 = new nx3.elements.NPart([new nx3.test.QVoice([2]),new nx3.test.QVoice([.4,8])]);
		var npart1 = new nx3.elements.NPart([new nx3.test.QVoice([8,.4]),new nx3.test.QVoice([4,4])]);
		var vbar = new nx3.elements.VBar(new nx3.elements.NBar([npart0,npart1]));
		var positionsColumns = vbar.getPositionsColumns();
		this.assertEquals(nx3.elements.VMapTools.keysToArray(positionsColumns.keys()).toString(),[0,1512,3024,4536].toString(),{ fileName : "TestV.hx", lineNumber : 546, className : "nx3.test.TestV", methodName : "testVBar"});
	}
	,testVBarValue: function() {
		var npart0 = new nx3.elements.NPart([new nx3.test.QVoice([4]),new nx3.test.QVoice([4,4])]);
		var npart1 = new nx3.elements.NPart([new nx3.test.QVoice([4,4,4,4]),new nx3.test.QVoice([4,4,4])]);
		var vbar = new nx3.elements.VBar(new nx3.elements.NBar([npart0,npart1]));
		var value = vbar.getValue();
		this.assertEquals(value,nx3.elements.ENoteValue.Nv4.value * 4,{ fileName : "TestV.hx", lineNumber : 531, className : "nx3.test.TestV", methodName : "testVBarValue"});
	}
	,testBarColumnsGenerator: function() {
		var vpart = new nx3.elements.VPart(new nx3.elements.NPart([new nx3.test.QVoice([4,8,8,2]),new nx3.test.QVoice([4,4,2])]));
		var generator = new nx3.elements.VBarColumnsGenerator([vpart]);
		var columns = generator.getColumns();
		this.assertFalse(false,{ fileName : "TestV.hx", lineNumber : 496, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(generator.positions.toString(),[0,3024,4536,6048].toString(),{ fileName : "TestV.hx", lineNumber : 497, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(columns.length,4,{ fileName : "TestV.hx", lineNumber : 498, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		var vpart0 = new nx3.elements.VPart(new nx3.elements.NPart([new nx3.test.QVoice([.4,.4,4])]));
		var vpart1 = new nx3.elements.VPart(new nx3.elements.NPart([new nx3.test.QVoice([4,8,8,4,4])]));
		var generator1 = new nx3.elements.VBarColumnsGenerator([vpart0,vpart1]);
		var columns1 = generator1.getColumns();
		this.assertFalse(false,{ fileName : "TestV.hx", lineNumber : 508, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(generator1.positions.toString(),[0,3024,4536,6048,9072].toString(),{ fileName : "TestV.hx", lineNumber : 509, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		var column0 = columns1[0];
		this.assertEquals(column0.vcomplexes.length,2,{ fileName : "TestV.hx", lineNumber : 512, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(vpart0.getVVoices()[0].getVNotes()[0],column0.vcomplexes[0].vnotes[0],{ fileName : "TestV.hx", lineNumber : 513, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(vpart1.getVVoices()[0].getVNotes()[0],column0.vcomplexes[1].vnotes[0],{ fileName : "TestV.hx", lineNumber : 514, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertTrue(columns1[1].vcomplexes[0] == null,{ fileName : "TestV.hx", lineNumber : 515, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
		this.assertEquals(vpart1.getVVoices()[0].getVNotes()[1],columns1[1].vcomplexes[1].vnotes[0],{ fileName : "TestV.hx", lineNumber : 516, className : "nx3.test.TestV", methodName : "testBarColumnsGenerator"});
	}
	,testVPartComplexes: function() {
		var vpart = new nx3.elements.VPart(new nx3.elements.NPart([new nx3.test.QVoice([4,8,8,2]),new nx3.test.QVoice([4,4,2])]));
		var vcomplexes = vpart.getComplexes();
		this.assertEquals(vcomplexes.length,4,{ fileName : "TestV.hx", lineNumber : 483, className : "nx3.test.TestV", methodName : "testVPartComplexes"});
		var positions = nx3.elements.VMapTools.keysToArray(vpart.getPositionsVComplexes().keys());
		this.assertEquals([0,3024,4536,6048].toString(),positions.toString(),{ fileName : "TestV.hx", lineNumber : 485, className : "nx3.test.TestV", methodName : "testVPartComplexes"});
	}
	,testVPartComplexesGenerator: function() {
		var vvoice = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		var generator = new nx3.elements.VPartComplexesGenerator([vvoice]);
		var complexes = generator.getComplexes();
		this.assertEquals(nx3.elements.VMapTools.keysToArray(generator.positionsMap.keys()).toString(),[0,3024,4536,6048].toString(),{ fileName : "TestV.hx", lineNumber : 435, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes.length,4,{ fileName : "TestV.hx", lineNumber : 436, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		var vvoice0 = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		var vvoice1 = new nx3.elements.VVoice(new nx3.test.QVoice([4,4,2]));
		var generator1 = new nx3.elements.VPartComplexesGenerator([vvoice0,vvoice1]);
		var complexes1 = generator1.getComplexes();
		this.assertEquals(nx3.elements.VMapTools.keysToArray(generator1.positionsMap.keys()).toString(),[0,3024,4536,6048].toString(),{ fileName : "TestV.hx", lineNumber : 442, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes1.length,4,{ fileName : "TestV.hx", lineNumber : 443, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes1[0].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 444, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes1[1].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 445, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes1[2].vnotes.length,1,{ fileName : "TestV.hx", lineNumber : 446, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes1[3].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 447, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		var vvoice01 = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,4,4]));
		var vvoice11 = new nx3.elements.VVoice(new nx3.test.QVoice([.4,.4,4]));
		var generator2 = new nx3.elements.VPartComplexesGenerator([vvoice01,vvoice11]);
		var complexes2 = generator2.getComplexes();
		this.assertEquals(cx.ArrayTools.sorta(nx3.elements.VMapTools.keysToArray(generator2.positionsMap.keys())).toString(),[0,3024,4536,6048,9072].toString(),{ fileName : "TestV.hx", lineNumber : 454, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2.length,5,{ fileName : "TestV.hx", lineNumber : 455, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2[0].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 456, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2[1].vnotes.length,1,{ fileName : "TestV.hx", lineNumber : 457, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2[2].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 458, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2[3].vnotes.length,1,{ fileName : "TestV.hx", lineNumber : 459, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		this.assertEquals(complexes2[4].vnotes.length,2,{ fileName : "TestV.hx", lineNumber : 460, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		var vvoice02 = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		var vvoice12 = new nx3.elements.VVoice(new nx3.test.QVoice([4,4,2]));
		var generator3 = new nx3.elements.VPartComplexesGenerator([vvoice02,vvoice12]);
		var positionsComplexes = generator3.getPositionsComplexes();
		this.assertEquals([0,3024,4536,6048].toString(),nx3.elements.VMapTools.keysToArray(positionsComplexes.keys()).toString(),{ fileName : "TestV.hx", lineNumber : 466, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		var vcomplex1 = generator3.getComplexes()[1];
		var vcomplex2 = positionsComplexes.get(3024);
		this.assertEquals(vcomplex1,vcomplex2,{ fileName : "TestV.hx", lineNumber : 469, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
		var vcomplex1pos = generator3.getComplexesPositions().h[vcomplex1.__id__];
		this.assertEquals(vcomplex1pos,3024,{ fileName : "TestV.hx", lineNumber : 471, className : "nx3.test.TestV", methodName : "testVPartComplexesGenerator"});
	}
	,testVComplexSigns: function() {
		var vcomplex = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(0))]);
		this.assertEquals(1,vcomplex.vnotes.length,{ fileName : "TestV.hx", lineNumber : 363, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var signs = vcomplex.getSigns();
		this.assertEquals(signs[0].sign,nx3.elements.ESign.None,{ fileName : "TestV.hx", lineNumber : 365, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs[0].level,0,{ fileName : "TestV.hx", lineNumber : 366, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex1 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(2,null,"#")),new nx3.elements.VNote(new nx3.test.QNote4(-3,null,"n"))]);
		this.assertEquals(2,vcomplex1.vnotes.length,{ fileName : "TestV.hx", lineNumber : 369, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var signs1 = vcomplex1.getSigns();
		this.assertEquals(signs1.length,2,{ fileName : "TestV.hx", lineNumber : 371, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs1[0].level,-3,{ fileName : "TestV.hx", lineNumber : 372, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs1[0].sign,nx3.elements.ESign.Natural,{ fileName : "TestV.hx", lineNumber : 373, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs1[1].level,2,{ fileName : "TestV.hx", lineNumber : 374, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs1[1].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 375, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex2 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(null,[-4,1,3],"b.#"))]);
		var signs2 = vcomplex2.getSigns();
		this.assertEquals(signs2.length,3,{ fileName : "TestV.hx", lineNumber : 379, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[0].level,-4,{ fileName : "TestV.hx", lineNumber : 380, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[0].sign,nx3.elements.ESign.Flat,{ fileName : "TestV.hx", lineNumber : 381, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[1].level,1,{ fileName : "TestV.hx", lineNumber : 382, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[1].sign,nx3.elements.ESign.None,{ fileName : "TestV.hx", lineNumber : 383, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[2].level,3,{ fileName : "TestV.hx", lineNumber : 384, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs2[2].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 385, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex3 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(null,[-2,0,2],"n#.")),new nx3.elements.VNote(new nx3.test.QNote4(null,[-4,1,3],"b.#"))]);
		var signs3 = vcomplex3.getSigns();
		this.assertEquals(signs3.length,6,{ fileName : "TestV.hx", lineNumber : 389, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[0].level,-4,{ fileName : "TestV.hx", lineNumber : 390, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[0].sign,nx3.elements.ESign.Flat,{ fileName : "TestV.hx", lineNumber : 391, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[1].level,-2,{ fileName : "TestV.hx", lineNumber : 392, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[1].sign,nx3.elements.ESign.Natural,{ fileName : "TestV.hx", lineNumber : 393, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[2].level,0,{ fileName : "TestV.hx", lineNumber : 394, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[2].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 395, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[3].level,1,{ fileName : "TestV.hx", lineNumber : 396, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[3].sign,nx3.elements.ESign.None,{ fileName : "TestV.hx", lineNumber : 397, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[4].level,2,{ fileName : "TestV.hx", lineNumber : 398, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[4].sign,nx3.elements.ESign.None,{ fileName : "TestV.hx", lineNumber : 399, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[5].level,3,{ fileName : "TestV.hx", lineNumber : 400, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs3[5].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 401, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex4 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(0))]);
		var signs4 = vcomplex4.getVisibleSigns();
		this.assertEquals(0,signs4.length,{ fileName : "TestV.hx", lineNumber : 407, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex5 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(2,null,"#")),new nx3.elements.VNote(new nx3.test.QNote4(-3,null,"."))]);
		this.assertEquals(2,vcomplex5.vnotes.length,{ fileName : "TestV.hx", lineNumber : 410, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var signs5 = vcomplex5.getVisibleSigns();
		this.assertEquals(signs5.length,1,{ fileName : "TestV.hx", lineNumber : 412, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs5[0].level,2,{ fileName : "TestV.hx", lineNumber : 413, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs5[0].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 414, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		var vcomplex6 = new nx3.elements.VComplex([new nx3.elements.VNote(new nx3.test.QNote4(null,[-2,0,2],"n#.")),new nx3.elements.VNote(new nx3.test.QNote4(null,[-4,1,3],"b.#"))]);
		var signs6 = vcomplex6.getVisibleSigns();
		this.assertEquals(signs6.length,4,{ fileName : "TestV.hx", lineNumber : 418, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[0].level,-4,{ fileName : "TestV.hx", lineNumber : 419, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[0].sign,nx3.elements.ESign.Flat,{ fileName : "TestV.hx", lineNumber : 420, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[1].level,-2,{ fileName : "TestV.hx", lineNumber : 421, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[1].sign,nx3.elements.ESign.Natural,{ fileName : "TestV.hx", lineNumber : 422, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[2].level,0,{ fileName : "TestV.hx", lineNumber : 423, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[2].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 424, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[3].level,3,{ fileName : "TestV.hx", lineNumber : 425, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
		this.assertEquals(signs6[3].sign,nx3.elements.ESign.Sharp,{ fileName : "TestV.hx", lineNumber : 426, className : "nx3.test.TestV", methodName : "testVComplexSigns"});
	}
	,testBeamgroupFrame: function() {
		var vnotes = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,1])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-4,3]))];
		var beamgroup = new nx3.elements.VBeamgroup(vnotes);
		var frame = beamgroup.getFrame();
		this.assertEquals(nx3.elements.EDirectionUD.Down,beamgroup.getDirection(),{ fileName : "TestV.hx", lineNumber : 334, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		beamgroup.getFrame();
		this.assertEquals([1,3].toString(),beamgroup.calculator.outerLevels.toString(),{ fileName : "TestV.hx", lineNumber : 336, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals([-2,-4].toString(),beamgroup.calculator.innerLevels.toString(),{ fileName : "TestV.hx", lineNumber : 337, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(-2,frame.leftInnerY,{ fileName : "TestV.hx", lineNumber : 340, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(1,frame.leftOuterY,{ fileName : "TestV.hx", lineNumber : 341, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(-4,frame.rightInnerY,{ fileName : "TestV.hx", lineNumber : 342, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(3,frame.rightOuterY,{ fileName : "TestV.hx", lineNumber : 343, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		var vnotes1 = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,1])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-4,3]))];
		var beamgroup1 = new nx3.elements.VBeamgroup(vnotes1);
		beamgroup1.setDirection(nx3.elements.EDirectionUD.Up);
		var frame1 = beamgroup1.getFrame();
		this.assertEquals(nx3.elements.EDirectionUD.Up,beamgroup1.getDirection(),{ fileName : "TestV.hx", lineNumber : 349, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals([1,3].toString(),beamgroup1.calculator.innerLevels.toString(),{ fileName : "TestV.hx", lineNumber : 350, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals([-2,-4].toString(),beamgroup1.calculator.outerLevels.toString(),{ fileName : "TestV.hx", lineNumber : 351, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(1,frame1.leftInnerY,{ fileName : "TestV.hx", lineNumber : 354, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(-2,frame1.leftOuterY,{ fileName : "TestV.hx", lineNumber : 355, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(3,frame1.rightInnerY,{ fileName : "TestV.hx", lineNumber : 356, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
		this.assertEquals(-4,frame1.rightOuterY,{ fileName : "TestV.hx", lineNumber : 357, className : "nx3.test.TestV", methodName : "testBeamgroupFrame"});
	}
	,testBeamgroupCalculator: function() {
		var vnotes = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,2]))];
		var calc = new nx3.elements.VBeamgroupFrameCalculator(new nx3.elements.VBeamgroup(vnotes));
		var frame = calc.getFrame();
		this.assertEquals([-2].toString(),calc.getTopLevels().toString(),{ fileName : "TestV.hx", lineNumber : 312, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
		this.assertEquals([2].toString(),calc.getBottomLevels().toString(),{ fileName : "TestV.hx", lineNumber : 313, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
		var vnotes1 = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,4])),new nx3.elements.VNote(new nx3.test.QNote8(null,[5,-3]))];
		var calc1 = new nx3.elements.VBeamgroupFrameCalculator(new nx3.elements.VBeamgroup(vnotes1));
		var frame1 = calc1.getFrame();
		this.assertEquals([-2,-3].toString(),calc1.getTopLevels().toString(),{ fileName : "TestV.hx", lineNumber : 318, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
		this.assertEquals([4,5].toString(),calc1.getBottomLevels().toString(),{ fileName : "TestV.hx", lineNumber : 319, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
		var vnotes2 = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,4])),new nx3.elements.VNote(new nx3.test.QNote8(null,[6])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-4])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-3,5])),new nx3.elements.VNote(new nx3.test.QNote8(null,[0]))];
		var calc2 = new nx3.elements.VBeamgroupFrameCalculator(new nx3.elements.VBeamgroup(vnotes2));
		var frame2 = calc2.getFrame();
		this.assertEquals([-2,6,-4,-3,0].toString(),calc2.getTopLevels().toString(),{ fileName : "TestV.hx", lineNumber : 324, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
		this.assertEquals([4,6,-4,5,0].toString(),calc2.getBottomLevels().toString(),{ fileName : "TestV.hx", lineNumber : 325, className : "nx3.test.TestV", methodName : "testBeamgroupCalculator"});
	}
	,testBeamgroupDirectionSetter: function() {
		var beamgroup = new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(0))]);
		this.assertEquals(nx3.elements.EDirectionUD.Down,beamgroup.getDirection(),{ fileName : "TestV.hx", lineNumber : 299, className : "nx3.test.TestV", methodName : "testBeamgroupDirectionSetter"});
		var beamgroup1 = new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(0))]);
		beamgroup1.setDirection(nx3.elements.EDirectionUD.Up);
		this.assertEquals(nx3.elements.EDirectionUD.Up,beamgroup1.getDirection(),{ fileName : "TestV.hx", lineNumber : 303, className : "nx3.test.TestV", methodName : "testBeamgroupDirectionSetter"});
	}
	,testBeamgroupDirection: function() {
		var calculator = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(0))]));
		var direction = calculator.getDirection();
		this.assertEquals(calculator.getDirection(),nx3.elements.EDirectionUD.Down,{ fileName : "TestV.hx", lineNumber : 255, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(0,calculator.topLevel,{ fileName : "TestV.hx", lineNumber : 256, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(0,calculator.bottomLevel,{ fileName : "TestV.hx", lineNumber : 257, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var calculator1 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(5))]));
		var direction1 = calculator1.getDirection();
		this.assertEquals(calculator1.getDirection(),nx3.elements.EDirectionUD.Up,{ fileName : "TestV.hx", lineNumber : 261, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(5,calculator1.topLevel,{ fileName : "TestV.hx", lineNumber : 262, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(5,calculator1.bottomLevel,{ fileName : "TestV.hx", lineNumber : 263, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var calculator2 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(-2))]));
		var direction2 = calculator2.getDirection();
		this.assertEquals(calculator2.getDirection(),nx3.elements.EDirectionUD.Down,{ fileName : "TestV.hx", lineNumber : 267, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(-2,calculator2.topLevel,{ fileName : "TestV.hx", lineNumber : 268, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(-2,calculator2.bottomLevel,{ fileName : "TestV.hx", lineNumber : 269, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var vnotes = [new nx3.elements.VNote(new nx3.test.QNote8(null,[-2,3]))];
		var calculator3 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup(vnotes));
		var direction3 = calculator3.getDirection();
		this.assertEquals(calculator3.getDirection(),nx3.elements.EDirectionUD.Up,{ fileName : "TestV.hx", lineNumber : 274, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(-2,calculator3.topLevel,{ fileName : "TestV.hx", lineNumber : 275, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(3,calculator3.bottomLevel,{ fileName : "TestV.hx", lineNumber : 276, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var vnotes1 = [new nx3.elements.VNote(new nx3.test.QNote8(null,[3])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-2]))];
		var calculator4 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup(vnotes1));
		var direction4 = calculator4.getDirection();
		this.assertEquals(calculator4.getDirection(),nx3.elements.EDirectionUD.Up,{ fileName : "TestV.hx", lineNumber : 281, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(-2,calculator4.topLevel,{ fileName : "TestV.hx", lineNumber : 282, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(3,calculator4.bottomLevel,{ fileName : "TestV.hx", lineNumber : 283, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var vnotes2 = [new nx3.elements.VNote(new nx3.test.QNote8(null,[3])),new nx3.elements.VNote(new nx3.test.QNote8(null,[-5])),new nx3.elements.VNote(new nx3.test.QNote8(null,[4]))];
		var calculator5 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup(vnotes2));
		var direction5 = calculator5.getDirection();
		this.assertEquals(calculator5.getDirection(),nx3.elements.EDirectionUD.Down,{ fileName : "TestV.hx", lineNumber : 288, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(-5,calculator5.topLevel,{ fileName : "TestV.hx", lineNumber : 289, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		this.assertEquals(4,calculator5.bottomLevel,{ fileName : "TestV.hx", lineNumber : 290, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
		var calculator6 = new nx3.elements.VBeamgroupDirectionCalculator(new nx3.elements.VBeamgroup([new nx3.elements.VNote(new nx3.test.QNote4(0))]));
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator6.getDirection(),{ fileName : "TestV.hx", lineNumber : 293, className : "nx3.test.TestV", methodName : "testBeamgroupDirection"});
	}
	,testBeamgroups: function() {
		var vvoice = new nx3.elements.VVoice(new nx3.test.QVoice([8,8,8,8,8,8]));
		this.assertTrue(vvoice.beamgroups == null,{ fileName : "TestV.hx", lineNumber : 205, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var beamgroups = vvoice.getBeamgroups([nx3.elements.ENoteValue.Nv4]);
		this.assertEquals(3,beamgroups.length,{ fileName : "TestV.hx", lineNumber : 207, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 208, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 209, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups[2].vnotes.length,{ fileName : "TestV.hx", lineNumber : 210, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertTrue(vvoice.beamgroups != null,{ fileName : "TestV.hx", lineNumber : 211, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var beamgroups1 = vvoice.getBeamgroups([nx3.elements.ENoteValue.Nv4dot]);
		this.assertEquals(2,beamgroups1.length,{ fileName : "TestV.hx", lineNumber : 213, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(3,beamgroups1[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 214, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(3,beamgroups1[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 215, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var vvoice1 = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,8,8]));
		var beamgroups2 = vvoice1.getBeamgroups([nx3.elements.ENoteValue.Nv4]);
		this.assertEquals(3,beamgroups2.length,{ fileName : "TestV.hx", lineNumber : 219, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups2[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 220, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups2[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 221, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups2[2].vnotes.length,{ fileName : "TestV.hx", lineNumber : 222, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var beamgroups3 = vvoice1.getBeamgroups([nx3.elements.ENoteValue.Nv4dot]);
		this.assertEquals(3,beamgroups3.length,{ fileName : "TestV.hx", lineNumber : 224, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups3[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 225, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups3[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 226, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(3,beamgroups3[2].vnotes.length,{ fileName : "TestV.hx", lineNumber : 227, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var vvoice2 = new nx3.elements.VVoice(new nx3.test.QVoice([8,4,8,8,8]));
		var beamgroups4 = vvoice2.getBeamgroups([nx3.elements.ENoteValue.Nv4]);
		this.assertEquals(4,beamgroups4.length,{ fileName : "TestV.hx", lineNumber : 231, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups4[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 232, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups4[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 233, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups4[2].vnotes.length,{ fileName : "TestV.hx", lineNumber : 234, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(2,beamgroups4[3].vnotes.length,{ fileName : "TestV.hx", lineNumber : 235, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var beamgroups5 = vvoice2.getBeamgroups([nx3.elements.ENoteValue.Nv4dot]);
		this.assertEquals(3,beamgroups5.length,{ fileName : "TestV.hx", lineNumber : 237, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups5[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 238, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups5[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 239, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(3,beamgroups5[2].vnotes.length,{ fileName : "TestV.hx", lineNumber : 240, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		var vvoice3 = new nx3.elements.VVoice(new nx3.test.QVoice([.2,16,16,16,16]));
		var beamgroups6 = vvoice3.getBeamgroups([nx3.elements.ENoteValue.Nv4]);
		this.assertEquals(2,beamgroups6.length,{ fileName : "TestV.hx", lineNumber : 246, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(1,beamgroups6[0].vnotes.length,{ fileName : "TestV.hx", lineNumber : 247, className : "nx3.test.TestV", methodName : "testBeamgroups"});
		this.assertEquals(4,beamgroups6[1].vnotes.length,{ fileName : "TestV.hx", lineNumber : 248, className : "nx3.test.TestV", methodName : "testBeamgroups"});
	}
	,testVVoice2: function() {
		var vvoice = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		this.assertTrue(vvoice.vnotes == null,{ fileName : "TestV.hx", lineNumber : 185, className : "nx3.test.TestV", methodName : "testVVoice2"});
		vvoice.getVNotes();
		this.assertTrue(vvoice.vnotes != null,{ fileName : "TestV.hx", lineNumber : 187, className : "nx3.test.TestV", methodName : "testVVoice2"});
		this.assertTrue(vvoice.vnotePositions == null,{ fileName : "TestV.hx", lineNumber : 189, className : "nx3.test.TestV", methodName : "testVVoice2"});
		vvoice.getVNotePosition(vvoice.getVNotes()[0]);
		this.assertTrue(vvoice.vnotePositions != null,{ fileName : "TestV.hx", lineNumber : 191, className : "nx3.test.TestV", methodName : "testVVoice2"});
		var vvoice1 = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		this.assertTrue(vvoice1.vnotes == null,{ fileName : "TestV.hx", lineNumber : 194, className : "nx3.test.TestV", methodName : "testVVoice2"});
		this.assertTrue(vvoice1.value == null,{ fileName : "TestV.hx", lineNumber : 195, className : "nx3.test.TestV", methodName : "testVVoice2"});
		var value = vvoice1.getValue();
		this.assertTrue(vvoice1.vnotes != null,{ fileName : "TestV.hx", lineNumber : 197, className : "nx3.test.TestV", methodName : "testVVoice2"});
		this.assertTrue(vvoice1.value != null,{ fileName : "TestV.hx", lineNumber : 198, className : "nx3.test.TestV", methodName : "testVVoice2"});
		this.assertEquals(nx3.elements.ENoteValue.Nv4.value * 4,vvoice1.value,{ fileName : "TestV.hx", lineNumber : 199, className : "nx3.test.TestV", methodName : "testVVoice2"});
	}
	,testVVoice1: function() {
		var vvoice = new nx3.elements.VVoice(new nx3.test.QVoice([4,8,8,2]));
		this.assertEquals(4,vvoice.nvoice.nnotes.length,{ fileName : "TestV.hx", lineNumber : 170, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(4,vvoice.getVNotes().length,{ fileName : "TestV.hx", lineNumber : 171, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv8,vvoice.getVNotes()[1].nnote.value,{ fileName : "TestV.hx", lineNumber : 172, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv2,vvoice.getVNotes()[3].nnote.value,{ fileName : "TestV.hx", lineNumber : 173, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(0,vvoice.getVNotePosition(vvoice.getVNotes()[0]),{ fileName : "TestV.hx", lineNumber : 175, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv4.value,vvoice.getVNotePosition(vvoice.getVNotes()[1]),{ fileName : "TestV.hx", lineNumber : 176, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv4.value + nx3.elements.ENoteValue.Nv8.value,vvoice.getVNotePosition(vvoice.getVNotes()[2]),{ fileName : "TestV.hx", lineNumber : 177, className : "nx3.test.TestV", methodName : "testVVoice1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv4.value + nx3.elements.ENoteValue.Nv8.value + nx3.elements.ENoteValue.Nv8.value,vvoice.getVNotePosition(vvoice.getVNotes()[3]),{ fileName : "TestV.hx", lineNumber : 178, className : "nx3.test.TestV", methodName : "testVVoice1"});
	}
	,testVNoteDirectionCalculator: function() {
		var vnote = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,1],null,null,null,null,nx3.elements.EDirectionUAD.Auto));
		var calculator = new nx3.elements.VNoteDirectionCalculator(vnote);
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator.getDirection(null),{ fileName : "TestV.hx", lineNumber : 126, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote1 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2],null,null,null,null,nx3.elements.EDirectionUAD.Auto));
		var calculator1 = new nx3.elements.VNoteDirectionCalculator(vnote1);
		this.assertEquals(nx3.elements.EDirectionUD.Up,calculator1.getDirection(null),{ fileName : "TestV.hx", lineNumber : 130, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote2 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2],null,null,null,null,nx3.elements.EDirectionUAD.Down));
		var calculator2 = new nx3.elements.VNoteDirectionCalculator(vnote2);
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator2.getDirection(null),{ fileName : "TestV.hx", lineNumber : 134, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote3 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2]));
		var calculator3 = new nx3.elements.VNoteDirectionCalculator(vnote3);
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator3.getDirection(nx3.elements.EDirectionUD.Down),{ fileName : "TestV.hx", lineNumber : 138, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote4 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2],null,null,null,null,nx3.elements.EDirectionUAD.Up));
		var calculator4 = new nx3.elements.VNoteDirectionCalculator(vnote4);
		this.assertEquals(nx3.elements.EDirectionUD.Up,calculator4.getDirection(nx3.elements.EDirectionUD.Down),{ fileName : "TestV.hx", lineNumber : 142, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote5 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2]));
		this.assertEquals(vnote5.direction,null,{ fileName : "TestV.hx", lineNumber : 147, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		this.assertEquals(nx3.elements.EDirectionUD.Up,vnote5.getDirection(),{ fileName : "TestV.hx", lineNumber : 148, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		vnote5.setConfig({ direction : nx3.elements.EDirectionUD.Down});
		this.assertEquals(vnote5.direction,null,{ fileName : "TestV.hx", lineNumber : 150, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		this.assertEquals(nx3.elements.EDirectionUD.Down,vnote5.getDirection(),{ fileName : "TestV.hx", lineNumber : 151, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote6 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2],null,null,null,null,nx3.elements.EDirectionUAD.Down));
		this.assertEquals(nx3.elements.EDirectionUD.Down,vnote6.getDirection(),{ fileName : "TestV.hx", lineNumber : 154, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		var vnote7 = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,2]));
		vnote7.setConfig({ direction : nx3.elements.EDirectionUD.Down});
		this.assertEquals(nx3.elements.EDirectionUD.Down,vnote7.getDirection(),{ fileName : "TestV.hx", lineNumber : 158, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		this.assertTrue(vnote7.direction != null,{ fileName : "TestV.hx", lineNumber : 159, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		vnote7.setConfig({ direction : null});
		this.assertTrue(vnote7.direction == null,{ fileName : "TestV.hx", lineNumber : 161, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
		this.assertEquals(nx3.elements.EDirectionUD.Up,vnote7.getDirection(),{ fileName : "TestV.hx", lineNumber : 162, className : "nx3.test.TestV", methodName : "testVNoteDirectionCalculator"});
	}
	,testVNoteHeadPlacement: function() {
		var vnote = new nx3.elements.VNote(new nx3.test.QNote(null,[-1,0,1]));
		var placements = vnote.getVHeadsPlacements();
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements[0].pos,{ fileName : "TestV.hx", lineNumber : 85, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements[1].pos,{ fileName : "TestV.hx", lineNumber : 86, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements[2].pos,{ fileName : "TestV.hx", lineNumber : 87, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		var vnote1 = new nx3.elements.VNote(new nx3.test.QNote(null,[0,1,2]));
		var placements1 = vnote1.getVHeadsPlacements();
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements1[0].pos,{ fileName : "TestV.hx", lineNumber : 91, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Right,placements1[1].pos,{ fileName : "TestV.hx", lineNumber : 92, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements1[2].pos,{ fileName : "TestV.hx", lineNumber : 93, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		var vnote2 = new nx3.elements.VNote(new nx3.test.QNote(null,[-2,-1,0,1]));
		var placements2 = vnote2.getVHeadsPlacements();
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements2[0].pos,{ fileName : "TestV.hx", lineNumber : 97, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements2[1].pos,{ fileName : "TestV.hx", lineNumber : 98, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements2[2].pos,{ fileName : "TestV.hx", lineNumber : 99, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements2[3].pos,{ fileName : "TestV.hx", lineNumber : 100, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		var vnote3 = new nx3.elements.VNote(new nx3.test.QNote(null,[0,1,2,3]));
		var placements3 = vnote3.getVHeadsPlacements();
		this.assertEquals(nx3.elements.EHeadPosition.Right,placements3[0].pos,{ fileName : "TestV.hx", lineNumber : 104, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements3[1].pos,{ fileName : "TestV.hx", lineNumber : 105, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Right,placements3[2].pos,{ fileName : "TestV.hx", lineNumber : 106, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements3[3].pos,{ fileName : "TestV.hx", lineNumber : 107, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		var vnote4 = new nx3.elements.VNote(new nx3.test.QNote(null,[0,1,2,3]));
		this.assertTrue(vnote4.vheadsPlacements == null,{ fileName : "TestV.hx", lineNumber : 110, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		vnote4.getVHeadsPlacements();
		this.assertTrue(vnote4.vheadsPlacements != null,{ fileName : "TestV.hx", lineNumber : 112, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		vnote4.setConfig({ direction : nx3.elements.EDirectionUD.Down});
		this.assertTrue(vnote4.vheadsPlacements == null,{ fileName : "TestV.hx", lineNumber : 114, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		var placements4 = vnote4.getVHeadsPlacements();
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements4[0].pos,{ fileName : "TestV.hx", lineNumber : 116, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements4[1].pos,{ fileName : "TestV.hx", lineNumber : 117, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements4[2].pos,{ fileName : "TestV.hx", lineNumber : 118, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements4[3].pos,{ fileName : "TestV.hx", lineNumber : 119, className : "nx3.test.TestV", methodName : "testVNoteHeadPlacement"});
	}
	,testVHeadsPlacementsCalculator: function() {
		var vnote = new nx3.elements.VNote(new nx3.test.QNote(null,[1,2]));
		var calculator = new nx3.elements.VHeadPlacementCalculator(vnote.getVHeads(),nx3.elements.EDirectionUD.Down);
		var placements = calculator.getHeadsPlacements();
		this.assertEquals(1,placements[0].level,{ fileName : "TestV.hx", lineNumber : 67, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements[0].pos,{ fileName : "TestV.hx", lineNumber : 68, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(2,placements[1].level,{ fileName : "TestV.hx", lineNumber : 69, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(nx3.elements.EHeadPosition.Left,placements[1].pos,{ fileName : "TestV.hx", lineNumber : 70, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		var calculator1 = new nx3.elements.VHeadPlacementCalculator(vnote.getVHeads(),nx3.elements.EDirectionUD.Up);
		var placements1 = calculator1.getHeadsPlacements();
		this.assertEquals(1,placements1[0].level,{ fileName : "TestV.hx", lineNumber : 74, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(nx3.elements.EHeadPosition.Right,placements1[0].pos,{ fileName : "TestV.hx", lineNumber : 75, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(2,placements1[1].level,{ fileName : "TestV.hx", lineNumber : 76, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
		this.assertEquals(nx3.elements.EHeadPosition.Center,placements1[1].pos,{ fileName : "TestV.hx", lineNumber : 77, className : "nx3.test.TestV", methodName : "testVHeadsPlacementsCalculator"});
	}
	,testVNoteInternalDirection: function() {
		var calculator = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[0])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator.getDirection(),{ fileName : "TestV.hx", lineNumber : 47, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
		var calculator1 = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[1])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Up,calculator1.getDirection(),{ fileName : "TestV.hx", lineNumber : 49, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
		var calculator2 = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[-5,5])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator2.getDirection(),{ fileName : "TestV.hx", lineNumber : 52, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
		var calculator3 = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[-4,5])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Up,calculator3.getDirection(),{ fileName : "TestV.hx", lineNumber : 54, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
		var calculator4 = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[-5,1,2,3,4,5])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Down,calculator4.getDirection(),{ fileName : "TestV.hx", lineNumber : 57, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
		var calculator5 = new nx3.elements.VNoteInternalDirectionCalculator(new nx3.elements.VNote(new nx3.test.QNote(null,[-4,1,2,5])).getVHeads());
		this.assertEquals(nx3.elements.EDirectionUD.Up,calculator5.getDirection(),{ fileName : "TestV.hx", lineNumber : 59, className : "nx3.test.TestV", methodName : "testVNoteInternalDirection"});
	}
	,testVNote1: function() {
		var vnote = new nx3.elements.VNote(new nx3.test.QNote(null,[1,-2]));
		this.assertEquals(2,vnote.nnote.get_nheads().length,{ fileName : "TestV.hx", lineNumber : 39, className : "nx3.test.TestV", methodName : "testVNote1"});
		this.assertEquals([-2,1].toString(),vnote.nnote.getHeadLevels().toString(),{ fileName : "TestV.hx", lineNumber : 40, className : "nx3.test.TestV", methodName : "testVNote1"});
		this.assertEquals(nx3.elements.ENoteValue.Nv4,vnote.nnote.value,{ fileName : "TestV.hx", lineNumber : 41, className : "nx3.test.TestV", methodName : "testVNote1"});
	}
	,__class__: nx3.test.TestV
});
nx3.test.TestVRender = function() {
	haxe.unit.TestCase.call(this);
	this.target = flash.Lib.get_current();
	this.renderer = new nx3.test.DevRenderer(this.target,nx3.render.scaling.Scaling.NORMAL);
};
$hxClasses["nx3.test.TestVRender"] = nx3.test.TestVRender;
nx3.test.TestVRender.__name__ = ["nx3","test","TestVRender"];
nx3.test.TestVRender.__super__ = haxe.unit.TestCase;
nx3.test.TestVRender.prototype = $extend(haxe.unit.TestCase.prototype,{
	test0: function() {
		this.assertEquals(1,1,{ fileName : "TestVRender.hx", lineNumber : 34, className : "nx3.test.TestVRender", methodName : "test0"});
		this.renderer.notelines(10,50,300);
	}
	,renderer: null
	,target: null
	,__class__: nx3.test.TestVRender
});
nx3.test.DevRenderer = function(target,scaling) {
	nx3.render.FrameRenderer.call(this,target,scaling);
};
$hxClasses["nx3.test.DevRenderer"] = nx3.test.DevRenderer;
nx3.test.DevRenderer.__name__ = ["nx3","test","DevRenderer"];
nx3.test.DevRenderer.__super__ = nx3.render.FrameRenderer;
nx3.test.DevRenderer.prototype = $extend(nx3.render.FrameRenderer.prototype,{
	__class__: nx3.test.DevRenderer
});
var openfl = {}
openfl.display = {}
openfl.display.Tilesheet = function(image) {
	this.__bitmap = image;
	this.__centerPoints = new Array();
	this.__tileRects = new Array();
	this.__tileUVs = new Array();
};
$hxClasses["openfl.display.Tilesheet"] = openfl.display.Tilesheet;
openfl.display.Tilesheet.__name__ = ["openfl","display","Tilesheet"];
openfl.display.Tilesheet.prototype = {
	getTileUVs: function(index) {
		return this.__tileUVs[index];
	}
	,getTileRect: function(index) {
		return this.__tileRects[index];
	}
	,getTileCenter: function(index) {
		return this.__centerPoints[index];
	}
	,drawTiles: function(graphics,tileData,smooth,flags) {
		if(flags == null) flags = 0;
		if(smooth == null) smooth = false;
		graphics.drawTiles(this,tileData,smooth,flags);
	}
	,addTileRect: function(rectangle,centerPoint) {
		this.__tileRects.push(rectangle);
		if(centerPoint == null) centerPoint = new flash.geom.Point();
		this.__centerPoints.push(centerPoint);
		this.__tileUVs.push(new flash.geom.Rectangle(rectangle.get_left() / this.__bitmap.get_width(),rectangle.get_top() / this.__bitmap.get_height(),rectangle.get_right() / this.__bitmap.get_width(),rectangle.get_bottom() / this.__bitmap.get_height()));
		return this.__tileRects.length - 1;
	}
	,__tileUVs: null
	,__tileRects: null
	,__centerPoints: null
	,__bitmap: null
	,__class__: openfl.display.Tilesheet
}
var tink = {}
tink.macro = {}
tink.macro.tools = {}
tink.macro.tools.MacroTools = function() { }
$hxClasses["tink.macro.tools.MacroTools"] = tink.macro.tools.MacroTools;
tink.macro.tools.MacroTools.__name__ = ["tink","macro","tools","MacroTools"];
tink.macro.tools.MacroTools.tempName = function(c,prefix) {
	if(prefix == null) prefix = "__tinkTmp";
	return prefix + Std.string(tink.macro.tools.MacroTools.idCounter++);
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
haxe.Resource.content = [];
flash.display.DisplayObject.GRAPHICS_INVALID = 2;
flash.display.DisplayObject.MATRIX_INVALID = 4;
flash.display.DisplayObject.MATRIX_CHAIN_INVALID = 8;
flash.display.DisplayObject.MATRIX_OVERRIDDEN = 16;
flash.display.DisplayObject.TRANSFORM_INVALID = 32;
flash.display.DisplayObject.BOUNDS_INVALID = 64;
flash.display.DisplayObject.RENDER_VALIDATE_IN_PROGRESS = 1024;
flash.display.DisplayObject.ALL_RENDER_FLAGS = 98;
flash.Lib.HTML_ACCELEROMETER_EVENT_TYPE = "devicemotion";
flash.Lib.HTML_ORIENTATION_EVENT_TYPE = "orientationchange";
flash.Lib.DEFAULT_HEIGHT = 500;
flash.Lib.DEFAULT_WIDTH = 500;
flash.Lib.HTML_DIV_EVENT_TYPES = ["resize","mouseover","mouseout","mousewheel","dblclick","click"];
flash.Lib.HTML_TOUCH_EVENT_TYPES = ["touchstart","touchmove","touchend"];
flash.Lib.HTML_TOUCH_ALT_EVENT_TYPES = ["mousedown","mousemove","mouseup"];
flash.Lib.HTML_WINDOW_EVENT_TYPES = ["keyup","keypress","keydown","resize","blur","focus"];
flash.Lib.NME_IDENTIFIER = "haxe:openfl";
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
flash.display.Graphics.__MAX_DIM = 5000;
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
flash.display.Stage.OrientationPortrait = 1;
flash.display.Stage.OrientationPortraitUpsideDown = 2;
flash.display.Stage.OrientationLandscapeRight = 3;
flash.display.Stage.OrientationLandscapeLeft = 4;
flash.display.Stage.__acceleration = { x : 0.0, y : 1.0, z : 0.0};
flash.display.Stage.DEFAULT_FRAMERATE = 0.0;
flash.display.Stage.UI_EVENTS_QUEUE_MAX = 1000;
flash.display.Stage.__mouseChanges = [flash.events.MouseEvent.MOUSE_OUT,flash.events.MouseEvent.MOUSE_OVER,flash.events.MouseEvent.ROLL_OUT,flash.events.MouseEvent.ROLL_OVER];
flash.display.Stage.__touchChanges = ["touchOut","touchOver","touchRollOut","touchRollOver"];
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
haxe.ds.ObjectMap.count = 0;
haxe.xml.Parser.escapes = (function($this) {
	var $r;
	var h = new haxe.ds.StringMap();
	h.set("lt","<");
	h.set("gt",">");
	h.set("amp","&");
	h.set("quot","\"");
	h.set("apos","'");
	h.set("nbsp",String.fromCharCode(160));
	$r = h;
	return $r;
}(this));
js.Browser.window = typeof window != "undefined" ? window : null;
js.Browser.document = typeof window != "undefined" ? window.document : null;
nx3.Constants.BASE_NOTE_VALUE = 3024;
nx3.Constants.STAVE_LENGTH = 6.8;
nx3.Constants.SIGN_TO_NOTE_DISTANCE = 0.8;
nx3.Constants.COMPLEX_COLLISION_OVERLAP_XTRA = 0.6;
nx3.Constants.SIGN_NORMAL_WIDTH = 2.6;
nx3.Constants.SIGN_PARENTHESIS_WIDTH = 4.4;
nx3.Constants.HEAD_ADJUST_X = 0;
nx3.Constants.COMPLEX_COLLISION_ADJUST_X = 3.0;
nx3.Constants.NOTE_STEM_X_NORMAL = 1.6;
nx3.elements.EKey.Sharp6 = new nx3.elements.EKey(6);
nx3.elements.EKey.Sharp5 = new nx3.elements.EKey(5);
nx3.elements.EKey.Sharp4 = new nx3.elements.EKey(4);
nx3.elements.EKey.Sharp3 = new nx3.elements.EKey(3);
nx3.elements.EKey.Sharp2 = new nx3.elements.EKey(2);
nx3.elements.EKey.Sharp1 = new nx3.elements.EKey(1);
nx3.elements.EKey.Natural = new nx3.elements.EKey(0);
nx3.elements.EKey.Flat1 = new nx3.elements.EKey(-1);
nx3.elements.EKey.Flat2 = new nx3.elements.EKey(-2);
nx3.elements.EKey.Flat3 = new nx3.elements.EKey(-3);
nx3.elements.EKey.Flat4 = new nx3.elements.EKey(-4);
nx3.elements.EKey.Flat5 = new nx3.elements.EKey(-5);
nx3.elements.EKey.Flat6 = new nx3.elements.EKey(-6);
nx3.elements.ENoteValue.DOT = 1.5;
nx3.elements.ENoteValue.DOTDOT = 1.75;
nx3.elements.ENoteValue.TRI = 2 / 3;
nx3.elements.ENoteValue.N1 = 4;
nx3.elements.ENoteValue.N2 = 2;
nx3.elements.ENoteValue.N8 = .5;
nx3.elements.ENoteValue.N16 = .25;
nx3.elements.ENoteValue.N32 = .125;
nx3.elements.ENoteValue.Nv1 = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N1 * 3024,nx3.elements.EHeadValuetype.HVT1);
nx3.elements.ENoteValue.Nv1dot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT1,0,0,1);
nx3.elements.ENoteValue.Nv1ddot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT1,0,0,2);
nx3.elements.ENoteValue.Nv1tri = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N1 * 3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT1);
nx3.elements.ENoteValue.Nv2 = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N2 * 3024,nx3.elements.EHeadValuetype.HVT2,1);
nx3.elements.ENoteValue.Nv2dot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT2,1,0,1);
nx3.elements.ENoteValue.Nv2ddot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT2,1,0,2);
nx3.elements.ENoteValue.Nv2tri = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N2 * 3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT2,1);
nx3.elements.ENoteValue.Nv4 = new nx3.elements.ENoteValue(3024,nx3.elements.EHeadValuetype.HVT4,1,0,0);
nx3.elements.ENoteValue.Nv4dot = new nx3.elements.ENoteValue(3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT4,1,0,1);
nx3.elements.ENoteValue.Nv4ddot = new nx3.elements.ENoteValue(3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT4,1,0,2);
nx3.elements.ENoteValue.Nv4tri = new nx3.elements.ENoteValue(3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT4,1,0,0);
nx3.elements.ENoteValue.Nv8 = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N8 * 3024,nx3.elements.EHeadValuetype.HVT4,1,1,0);
nx3.elements.ENoteValue.Nv8dot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT4,1,1,1);
nx3.elements.ENoteValue.Nv8ddot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT4,1,1,2);
nx3.elements.ENoteValue.Nv8tri = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N8 * 3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT4,1,1,0);
nx3.elements.ENoteValue.Nv16 = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N16 * 3024,nx3.elements.EHeadValuetype.HVT4,1,2,0);
nx3.elements.ENoteValue.Nv16dot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT4,1,2,1);
nx3.elements.ENoteValue.Nv16ddot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT4,1,2,2);
nx3.elements.ENoteValue.Nv16tri = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N16 * 3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT4,1,2,0);
nx3.elements.ENoteValue.Nv32 = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N32 * 3024,nx3.elements.EHeadValuetype.HVT4,1,3,0);
nx3.elements.ENoteValue.Nv32dot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.DOT,nx3.elements.EHeadValuetype.HVT4,1,3,1);
nx3.elements.ENoteValue.Nv32ddot = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.DOTDOT,nx3.elements.EHeadValuetype.HVT4,1,3,2);
nx3.elements.ENoteValue.Nv32tri = new nx3.elements.ENoteValue(nx3.elements.ENoteValue.N32 * 3024 * nx3.elements.ENoteValue.TRI,nx3.elements.EHeadValuetype.HVT4,1,3,0);
nx3.elements._ULevel.ULevel_Impl_.MAX_LEVEL = 15;
nx3.elements._ULevel.ULevel_Impl_.MIN_LEVEL = -15;
nx3.elements.tools.SignsTools.BREAKPOINT = 5;
nx3.io.HeadXML.XHEAD = "head";
nx3.io.HeadXML.XHEAD_TYPE = "type";
nx3.io.HeadXML.XHEAD_LEVEL = "level";
nx3.io.HeadXML.XHEAD_SIGN = "sign";
nx3.io.HeadXML.XHEAD_TIE = "tie";
nx3.io.HeadXML.XHEAD_TIETO = "tieto";
nx3.io.NoteXML.XNOTE = "note";
nx3.io.NoteXML.XPAUSE = "pause";
nx3.io.NoteXML.XPAUSE_LEVEL = "level";
nx3.io.NoteXML.XLYRIC = "lyric";
nx3.io.NoteXML.XLYRIC_TEXT = "text";
nx3.io.NoteXML.XUNDEFINED = "undefined";
nx3.io.NoteXML.XNOTE_TYPE = "type";
nx3.io.NoteXML.XNOTE_TYPE_NOTE = "note";
nx3.io.NoteXML.XNOTE_TYPE_NOTATION_VARIANT = "variant";
nx3.io.NoteXML.XNOTE_VALUE = "value";
nx3.io.NoteXML.XNOTE_DIRECTION = "direction";
nx3.io.NoteXML.XNOTE_TYPE_PAUSE = "pause";
nx3.io.NoteXML.XNOTE_TYPE_NOTE_ARTICULATIONS = "articulations";
nx3.io.NoteXML.LIST_DELIMITER = ";";
nx3.io.NoteXML.XNOTE_TYPE_NOTE_ATTRIBUTES = "attributes";
nx3.io.NoteXML.XOFFSET = "offset";
nx3.io.NoteXML.XLYRIC_CONTINUATION = "continuation";
nx3.io.NoteXML.XLYRIC_FORMAT = "format";
nx3.render.scaling.Scaling.MID = { linesWidth : 0.8, space : 12.0, halfSpace : 6.0, noteWidth : 10, halfNoteWidth : 5, quarterNoteWidth : 2.5, signPosWidth : 14.0, svgScale : .27, svgX : 0, svgY : -55.0, fontScaling : 6.0};
nx3.render.scaling.Scaling.NORMAL = { linesWidth : .5, space : 8.0, halfSpace : 4.0, noteWidth : 7.0, halfNoteWidth : 3.5, quarterNoteWidth : 1.75, signPosWidth : 9.5, svgScale : .175, svgX : 0, svgY : -36.0, fontScaling : 4.0};
nx3.render.scaling.Scaling.SMALL = { linesWidth : .5, space : 6.0, halfSpace : 3.0, noteWidth : 5.0, halfNoteWidth : 2.5, quarterNoteWidth : 1.25, signPosWidth : 7.0, svgScale : .14, svgX : 0, svgY : -28.5, fontScaling : 3.0};
nx3.render.scaling.Scaling.BIG = { linesWidth : 1.5, space : 16.0, halfSpace : 8.0, noteWidth : 14.0, halfNoteWidth : 7.0, quarterNoteWidth : 5.5, signPosWidth : 19.0, svgScale : .36, svgX : -0.0, svgY : -74.0, fontScaling : 8.0};
nx3.render.scaling.Scaling.PRINT1 = { linesWidth : 3, space : 32.0, halfSpace : 16.0, noteWidth : 28.0, halfNoteWidth : 14.0, quarterNoteWidth : 11.0, signPosWidth : 38.0, svgScale : .72, svgX : -0.0, svgY : -148.0, fontScaling : 16.0};
openfl.display.Tilesheet.TILE_SCALE = 1;
openfl.display.Tilesheet.TILE_ROTATION = 2;
openfl.display.Tilesheet.TILE_RGB = 4;
openfl.display.Tilesheet.TILE_ALPHA = 8;
openfl.display.Tilesheet.TILE_TRANS_2x2 = 16;
openfl.display.Tilesheet.TILE_BLEND_NORMAL = 0;
openfl.display.Tilesheet.TILE_BLEND_ADD = 65536;
openfl.display.Tilesheet.TILE_BLEND_MULTIPLY = 131072;
openfl.display.Tilesheet.TILE_BLEND_SCREEN = 262144;
tink.macro.tools.MacroTools.idCounter = 0;
ApplicationMain.main();
})();

//@ sourceMappingURL=Nx3OpenFLTest.js.map
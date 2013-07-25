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
	ApplicationMain.preloader = new NMEPreloader();
	flash.Lib.get_current().addChild(ApplicationMain.preloader);
	ApplicationMain.preloader.onInit();
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
	if(Reflect.field(nx3.xamples.main.openfl.Main,"main") == null) {
		var mainDisplayObj = Type.createInstance(DocumentClass,[]);
		if(js.Boot.__instanceof(mainDisplayObj,flash.display.DisplayObject)) flash.Lib.get_current().addChild(mainDisplayObj);
	} else Reflect.field(nx3.xamples.main.openfl.Main,"main").apply(nx3.xamples.main.openfl.Main,[]);
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
		if(child == null) return false;
		if(this == child) return true;
		var _g = 0, _g1 = this.nmeChildren;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c == child) return true;
		}
		return false;
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
var nx3 = {}
nx3.xamples = {}
nx3.xamples.main = {}
nx3.xamples.main.openfl = {}
nx3.xamples.main.openfl.Main = function() {
	flash.display.Sprite.call(this);
	this.addEventListener(flash.events.Event.ADDED_TO_STAGE,$bind(this,this.added));
};
$hxClasses["nx3.xamples.main.openfl.Main"] = nx3.xamples.main.openfl.Main;
nx3.xamples.main.openfl.Main.__name__ = ["nx3","xamples","main","openfl","Main"];
nx3.xamples.main.openfl.Main.main = function() {
	flash.Lib.get_current().get_stage().align = flash.display.StageAlign.TOP_LEFT;
	flash.Lib.get_current().get_stage().scaleMode = flash.display.StageScaleMode.NO_SCALE;
	flash.Lib.get_current().addChild(new nx3.xamples.main.openfl.Main());
}
nx3.xamples.main.openfl.Main.__super__ = flash.display.Sprite;
nx3.xamples.main.openfl.Main.prototype = $extend(flash.display.Sprite.prototype,{
	added: function(e) {
		this.removeEventListener(flash.events.Event.ADDED_TO_STAGE,$bind(this,this.added));
		this.get_stage().addEventListener(flash.events.Event.RESIZE,$bind(this,this.resize));
		this.init();
	}
	,init: function() {
		if(this.inited) return;
		this.inited = true;
		var target = new flash.display.Sprite();
		var note1 = new nx3.elements.Note(null,[new nx3.elements.Head(null,nx3.units._Level.Level_Impl_.inRange(-4),nx3.enums.ESign.Flat),new nx3.elements.Head(null,nx3.units._Level.Level_Impl_.inRange(0),nx3.enums.ESign.Flat),new nx3.elements.Head(null,nx3.units._Level.Level_Impl_.inRange(2),nx3.enums.ESign.Flat)],nx3.enums.ENoteValue.Nv4,nx3.enums.EDirectionUD.Up);
		var note2 = new nx3.elements.Note(null,[new nx3.elements.Head(null,nx3.units._Level.Level_Impl_.inRange(5),nx3.enums.ESign.Flat)],nx3.enums.ENoteValue.Nv2,nx3.enums.EDirectionUD.Down);
		var render = new nx3.render.MultiRenderer(target,nx3.render.scaling.Scaling.MID,[nx3.render.FontRenderer]);
		var dnote1 = new nx3.display.DNote(note1);
		var dnote2 = new nx3.display.DNote(note2);
		var dcomplex = new nx3.display.DComplex([dnote1,dnote2]);
		render.notelines(0,100,700);
		this.addChild(target);
		render.complex(200,100,dcomplex);
	}
	,resize: function(e) {
		if(!this.inited) this.init();
	}
	,inited: null
	,__class__: nx3.xamples.main.openfl.Main
});
var DocumentClass = function() {
	nx3.xamples.main.openfl.Main.call(this);
};
$hxClasses["DocumentClass"] = DocumentClass;
DocumentClass.__name__ = ["DocumentClass"];
DocumentClass.__super__ = nx3.xamples.main.openfl.Main;
DocumentClass.prototype = $extend(nx3.xamples.main.openfl.Main.prototype,{
	get_stage: function() {
		return flash.Lib.get_current().get_stage();
	}
	,__class__: DocumentClass
});
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
	,split: function(s) {
		var d = "#__delim__#";
		return s.replace(this.r,d).split(d);
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
Type.createEnumIndex = function(e,index,params) {
	var c = e.__constructs__[index];
	if(c == null) throw index + " is not a valid enum constructor index";
	return Type.createEnum(e,c,params);
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
	,elements: function() {
		if(this._children == null) throw "bad nodetype";
		return { cur : 0, x : this._children, hasNext : function() {
			var k = this.cur;
			var l = this.x.length;
			while(k < l) {
				if(this.x[k].nodeType == Xml.Element) break;
				k += 1;
			}
			this.cur = k;
			return k < l;
		}, next : function() {
			var k = this.cur;
			var l = this.x.length;
			while(k < l) {
				var n = this.x[k];
				k += 1;
				if(n.nodeType == Xml.Element) {
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
	this.nmeFocusOverObjects = [];
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
		return this.nmeFocusObject = inObj;
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
			if(type == flash.events.MouseEvent.MOUSE_DOWN) this.nmeCheckFocusInOuts(evt,stack);
			obj.nmeFireEvent(evt);
		} else {
			var evt = flash.events.MouseEvent.nmeCreate(type,event,point,null);
			this.nmeCheckInOuts(evt,stack);
			if(type == flash.events.MouseEvent.MOUSE_DOWN) this.nmeCheckFocusInOuts(evt,stack);
		}
	}
	,nmeOnFocus: function(event,hasFocus) {
		if(hasFocus) {
			this.dispatchEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_IN));
			this.nmeBroadcast(new flash.events.Event(flash.events.Event.ACTIVATE));
		} else {
			this.dispatchEvent(new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_OUT));
			this.nmeBroadcast(new flash.events.Event(flash.events.Event.DEACTIVATE));
		}
	}
	,nmeOnKey: function(code,pressed,inChar,ctrl,alt,shift,keyLocation) {
		var event = new flash.events.KeyboardEvent(pressed?flash.events.KeyboardEvent.KEY_DOWN:flash.events.KeyboardEvent.KEY_UP,true,false,inChar,code,keyLocation,ctrl,alt,shift);
		this.dispatchEvent(event);
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
			this.nmeOnFocus(evt,true);
			break;
		case "blur":
			this.nmeOnFocus(evt,false);
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
	,nmeCheckFocusInOuts: function(event,inStack) {
		var new_n = inStack.length;
		var new_obj = new_n > 0?inStack[new_n - 1]:null;
		var old_n = this.nmeFocusOverObjects.length;
		var old_obj = old_n > 0?this.nmeFocusOverObjects[old_n - 1]:null;
		if(new_obj != old_obj) {
			var common = 0;
			while(common < new_n && common < old_n && inStack[common] == this.nmeFocusOverObjects[common]) common++;
			var focusOut = new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_OUT,false,false,new_obj,false,0);
			var i = old_n - 1;
			while(i >= common) {
				this.nmeFocusOverObjects[i].dispatchEvent(focusOut);
				i--;
			}
			var focusIn = new flash.events.FocusEvent(flash.events.FocusEvent.FOCUS_IN,false,false,old_obj,false,0);
			var i1 = new_n - 1;
			while(i1 >= common) {
				inStack[i1].dispatchEvent(focusIn);
				i1--;
			}
			this.nmeFocusOverObjects = inStack;
			this.set_focus(new_obj);
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
	,nmeFocusOverObjects: null
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
flash.events.KeyboardEvent = function(type,bubbles,cancelable,inCharCode,inKeyCode,inKeyLocation,inCtrlKey,inAltKey,inShiftKey) {
	if(inShiftKey == null) inShiftKey = false;
	if(inAltKey == null) inAltKey = false;
	if(inCtrlKey == null) inCtrlKey = false;
	if(inKeyLocation == null) inKeyLocation = 0;
	if(inKeyCode == null) inKeyCode = 0;
	if(inCharCode == null) inCharCode = 0;
	if(cancelable == null) cancelable = false;
	if(bubbles == null) bubbles = false;
	flash.events.Event.call(this,type,bubbles,cancelable);
	this.keyCode = inKeyCode;
	this.keyLocation = inKeyLocation == null?0:inKeyLocation;
	this.charCode = inCharCode == null?0:inCharCode;
	this.shiftKey = inShiftKey == null?false:inShiftKey;
	this.altKey = inAltKey == null?false:inAltKey;
	this.ctrlKey = inCtrlKey == null?false:inCtrlKey;
};
$hxClasses["flash.events.KeyboardEvent"] = flash.events.KeyboardEvent;
flash.events.KeyboardEvent.__name__ = ["flash","events","KeyboardEvent"];
flash.events.KeyboardEvent.__super__ = flash.events.Event;
flash.events.KeyboardEvent.prototype = $extend(flash.events.Event.prototype,{
	keyLocation: null
	,shiftKey: null
	,ctrlKey: null
	,charCode: null
	,keyCode: null
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
var format = {}
format.SVG = function(content) {
	this.data = new format.svg.SVGData(Xml.parse(content));
};
$hxClasses["format.SVG"] = format.SVG;
format.SVG.__name__ = ["format","SVG"];
format.SVG.prototype = {
	render: function(graphics,x,y,width,height) {
		if(height == null) height = -1;
		if(width == null) width = -1;
		if(y == null) y = 0;
		if(x == null) x = 0;
		var matrix = new flash.geom.Matrix();
		matrix.identity();
		matrix.translate(x,y);
		if(width > -1 && height > -1) matrix.scale(width / this.data.width,height / this.data.height);
		var renderer = new format.svg.SVGRenderer(this.data);
		renderer.render(graphics,matrix);
	}
	,data: null
	,__class__: format.SVG
}
format.gfx = {}
format.gfx.Gfx = function() {
};
$hxClasses["format.gfx.Gfx"] = format.gfx.Gfx;
format.gfx.Gfx.__name__ = ["format","gfx","Gfx"];
format.gfx.Gfx.prototype = {
	eof: function() {
	}
	,renderText: function(text) {
	}
	,curveTo: function(inCX,inCY,inX,inY) {
	}
	,lineTo: function(inX,inY) {
	}
	,moveTo: function(inX,inY) {
	}
	,endLineStyle: function() {
	}
	,lineStyle: function(style) {
	}
	,endFill: function() {
	}
	,beginFill: function(color,alpha) {
	}
	,beginGradientFill: function(grad) {
	}
	,size: function(inWidth,inHeight) {
	}
	,geometryOnly: function() {
		return false;
	}
	,__class__: format.gfx.Gfx
}
format.gfx.Gfx2Haxe = function() {
	format.gfx.Gfx.call(this);
	this.commands = [];
};
$hxClasses["format.gfx.Gfx2Haxe"] = format.gfx.Gfx2Haxe;
format.gfx.Gfx2Haxe.__name__ = ["format","gfx","Gfx2Haxe"];
format.gfx.Gfx2Haxe.__super__ = format.gfx.Gfx;
format.gfx.Gfx2Haxe.prototype = $extend(format.gfx.Gfx.prototype,{
	curveTo: function(inCX,inCY,inX,inY) {
		this.commands.push("g.curveTo(" + inCX + "," + inCY + "," + inX + "," + inY + ");");
	}
	,lineTo: function(inX,inY) {
		this.commands.push("g.lineTo(" + inX + "," + inY + ");");
	}
	,moveTo: function(inX,inY) {
		this.commands.push("g.moveTo(" + inX + "," + inY + ");");
	}
	,endLineStyle: function() {
		this.commands.push("g.lineStyle();");
	}
	,lineStyle: function(style) {
		this.commands.push("g.lineStyle(" + this.f2a(style.thickness) + "," + style.color + "," + this.f2a(style.alpha) + "," + Std.string(style.pixelHinting) + "," + Std.string(style.scaleMode) + "," + Std.string(style.capsStyle) + "," + Std.string(style.jointStyle) + "," + this.f2a(style.miterLimit));
	}
	,endFill: function() {
		this.commands.push("g.endFill();");
	}
	,beginFill: function(color,alpha) {
		this.commands.push("g.beginFill(" + color + "," + this.f2a(alpha) + ");");
	}
	,beginGradientFill: function(grad) {
		this.commands.push("g.beginGradientFill(" + Std.string(grad.type) + "," + Std.string(grad.colors) + "," + Std.string(grad.alphas) + "," + Std.string(grad.ratios) + "," + this.newMatrix(grad.matrix) + "," + Std.string(grad.spread) + "," + Std.string(grad.interp) + "," + grad.focus + ");");
	}
	,newMatrix: function(m) {
		return "new Matrix(" + this.f2a(m.a) + "," + this.f2a(m.b) + "," + this.f2a(m.c) + "," + this.f2a(m.d) + "," + this.f2a(m.tx) + "," + this.f2a(m.ty) + ")";
	}
	,f2a: function(f) {
		if(Math.abs(f) < 0.000001) return "0";
		if(Math.abs(1 - f) < 0.000001) return "1";
		return f + "";
	}
	,commands: null
	,__class__: format.gfx.Gfx2Haxe
});
format.gfx.GfxBytes = function(inBuffer,inFlags) {
	if(inFlags == null) inFlags = 0;
	format.gfx.Gfx.call(this);
	this.buffer = inBuffer == null?new flash.utils.ByteArray():inBuffer;
};
$hxClasses["format.gfx.GfxBytes"] = format.gfx.GfxBytes;
format.gfx.GfxBytes.__name__ = ["format","gfx","GfxBytes"];
format.gfx.GfxBytes.fromString = function(inString) {
	if(format.gfx.GfxBytes.baseCoder == null) format.gfx.GfxBytes.baseCoder = new haxe.crypto.BaseCode(haxe.io.Bytes.ofString(format.gfx.GfxBytes.base64));
	var bytes = new flash.utils.ByteArray();
	bytes.writeUTF(inString);
	return new format.gfx.GfxBytes(bytes);
}
format.gfx.GfxBytes.__super__ = format.gfx.Gfx;
format.gfx.GfxBytes.prototype = $extend(format.gfx.Gfx.prototype,{
	curveTo: function(inCX,inCY,inX,inY) {
		this.buffer.writeByte(32);
		this.buffer.writeFloat(inCX);
		this.buffer.writeFloat(inCY);
		this.buffer.writeFloat(inX);
		this.buffer.writeFloat(inY);
	}
	,lineTo: function(inX,inY) {
		this.buffer.writeByte(31);
		this.buffer.writeFloat(inX);
		this.buffer.writeFloat(inY);
	}
	,moveTo: function(inX,inY) {
		this.buffer.writeByte(30);
		this.buffer.writeFloat(inX);
		this.buffer.writeFloat(inY);
	}
	,endLineStyle: function() {
		this.buffer.writeByte(21);
	}
	,lineStyle: function(style) {
		this.buffer.writeByte(20);
		this.buffer.writeFloat(style.thickness);
		this.writeRGB(style.color);
		this.buffer.writeFloat(style.alpha);
		this.buffer.writeByte(style.pixelHinting?1:0);
		this.buffer.writeByte(style.scaleMode[1]);
		this.buffer.writeByte(style.capsStyle[1]);
		this.buffer.writeByte(style.jointStyle[1]);
		this.buffer.writeFloat(style.miterLimit);
	}
	,endFill: function() {
		this.buffer.writeByte(12);
	}
	,beginFill: function(color,alpha) {
		this.buffer.writeByte(10);
		this.writeRGB(color);
		this.buffer.writeFloat(alpha);
	}
	,beginGradientFill: function(grad) {
		this.buffer.writeByte(11);
		this.buffer.writeByte(grad.type[1]);
		this.buffer.writeByte(grad.colors.length);
		var _g1 = 0, _g = grad.colors.length;
		while(_g1 < _g) {
			var i = _g1++;
			this.writeRGB(grad.colors[i] | 0);
			this.pushClipped(grad.alphas[i] * 255.0);
			this.pushClipped(grad.ratios[i]);
		}
		this.buffer.writeFloat(grad.matrix.a);
		this.buffer.writeFloat(grad.matrix.b);
		this.buffer.writeFloat(grad.matrix.c);
		this.buffer.writeFloat(grad.matrix.d);
		this.buffer.writeFloat(grad.matrix.tx);
		this.buffer.writeFloat(grad.matrix.ty);
		this.buffer.writeByte(grad.spread[1]);
		this.buffer.writeByte(grad.interp[1]);
		this.buffer.writeFloat(grad.focus);
	}
	,readRGB: function() {
		var r = this.buffer.readByte();
		var g = this.buffer.readByte();
		var b = this.buffer.readByte();
		return r << 16 | g << 8 | b;
	}
	,writeRGB: function(inVal) {
		this.buffer.writeByte(inVal >> 16 & 255);
		this.buffer.writeByte(inVal >> 8 & 255);
		this.buffer.writeByte(inVal & 255);
	}
	,pushClipped: function(inVal) {
		this.buffer.writeByte(inVal < 0?0:inVal > 255.0?255:inVal | 0);
	}
	,size: function(inWidth,inHeight) {
		this.buffer.writeByte(1);
		this.buffer.writeFloat(inWidth);
		this.buffer.writeFloat(inHeight);
	}
	,iterate: function(inGfx) {
		this.buffer.position = 0;
		while(true) {
			var _g = this.buffer.readByte();
			switch(_g) {
			case 0:
				return;
			case 1:
				var w = this.buffer.readFloat();
				var h = this.buffer.readFloat();
				inGfx.size(w,h);
				break;
			case 10:
				var col = this.readRGB();
				var alpha = this.buffer.readFloat();
				inGfx.beginFill(col,alpha);
				break;
			case 11:
				var grad = new format.gfx.Gradient();
				grad.type = Type.createEnumIndex(flash.display.GradientType,this.buffer.readByte());
				var len = this.buffer.readByte();
				var _g1 = 0;
				while(_g1 < len) {
					var i = _g1++;
					grad.colors.push(this.readRGB());
					grad.alphas.push(this.buffer.readByte() / 255.0);
					grad.ratios.push(this.buffer.readByte());
				}
				grad.matrix.a = this.buffer.readFloat();
				grad.matrix.b = this.buffer.readFloat();
				grad.matrix.c = this.buffer.readFloat();
				grad.matrix.d = this.buffer.readFloat();
				grad.matrix.set_tx(this.buffer.readFloat());
				grad.matrix.set_ty(this.buffer.readFloat());
				grad.spread = format.gfx.GfxBytes.spreadMethods[this.buffer.readByte()];
				grad.interp = format.gfx.GfxBytes.interpolationMethods[this.buffer.readByte()];
				grad.focus = this.buffer.readFloat();
				inGfx.beginGradientFill(grad);
				break;
			case 12:
				inGfx.endFill();
				break;
			case 20:
				var style = new format.gfx.LineStyle();
				style.thickness = this.buffer.readFloat();
				style.color = this.readRGB();
				style.alpha = this.buffer.readFloat();
				style.pixelHinting = this.buffer.readByte() > 0;
				style.scaleMode = format.gfx.GfxBytes.scaleModes[this.buffer.readByte()];
				style.capsStyle = format.gfx.GfxBytes.capsStyles[this.buffer.readByte()];
				style.jointStyle = format.gfx.GfxBytes.jointStyles[this.buffer.readByte()];
				style.miterLimit = this.buffer.readFloat();
				inGfx.lineStyle(style);
				break;
			case 21:
				inGfx.endLineStyle();
				break;
			case 30:
				var x = this.buffer.readFloat();
				var y = this.buffer.readFloat();
				inGfx.moveTo(x,y);
				break;
			case 31:
				var x = this.buffer.readFloat();
				var y = this.buffer.readFloat();
				inGfx.lineTo(x,y);
				break;
			case 32:
				var cx = this.buffer.readFloat();
				var cy = this.buffer.readFloat();
				var x = this.buffer.readFloat();
				var y = this.buffer.readFloat();
				inGfx.curveTo(cx,cy,x,y);
				break;
			default:
				throw "Unknown gfx buffer format.";
			}
		}
	}
	,eof: function() {
		this.buffer.writeByte(0);
	}
	,toString: function() {
		return "";
	}
	,buffer: null
	,__class__: format.gfx.GfxBytes
});
format.gfx.GfxExtent = function() {
	format.gfx.Gfx.call(this);
	this.extent = null;
};
$hxClasses["format.gfx.GfxExtent"] = format.gfx.GfxExtent;
format.gfx.GfxExtent.__name__ = ["format","gfx","GfxExtent"];
format.gfx.GfxExtent.__super__ = format.gfx.Gfx;
format.gfx.GfxExtent.prototype = $extend(format.gfx.Gfx.prototype,{
	curveTo: function(inCX,inCY,inX,inY) {
		this.addExtent(inCX,inCY);
		this.addExtent(inX,inY);
	}
	,lineTo: function(inX,inY) {
		this.addExtent(inX,inY);
	}
	,moveTo: function(inX,inY) {
		this.addExtent(inX,inY);
	}
	,geometryOnly: function() {
		return true;
	}
	,addExtent: function(inX,inY) {
		if(this.extent == null) {
			this.extent = new flash.geom.Rectangle(inX,inY,0,0);
			return;
		}
		if(inX < this.extent.get_left()) this.extent.set_left(inX);
		if(inX > this.extent.get_right()) this.extent.set_right(inX);
		if(inY < this.extent.get_top()) this.extent.set_top(inY);
		if(inY > this.extent.get_bottom()) this.extent.set_bottom(inY);
	}
	,extent: null
	,__class__: format.gfx.GfxExtent
});
format.gfx.GfxGraphics = function(inGraphics) {
	format.gfx.Gfx.call(this);
	this.graphics = inGraphics;
};
$hxClasses["format.gfx.GfxGraphics"] = format.gfx.GfxGraphics;
format.gfx.GfxGraphics.__name__ = ["format","gfx","GfxGraphics"];
format.gfx.GfxGraphics.__super__ = format.gfx.Gfx;
format.gfx.GfxGraphics.prototype = $extend(format.gfx.Gfx.prototype,{
	curveTo: function(inCX,inCY,inX,inY) {
		this.graphics.curveTo(inCX,inCY,inX,inY);
	}
	,lineTo: function(inX,inY) {
		this.graphics.lineTo(inX,inY);
	}
	,moveTo: function(inX,inY) {
		this.graphics.moveTo(inX,inY);
	}
	,endLineStyle: function() {
		this.graphics.lineStyle();
	}
	,lineStyle: function(style) {
		this.graphics.lineStyle(style.thickness,style.color,style.alpha,style.pixelHinting,style.scaleMode,style.capsStyle,style.jointStyle,style.miterLimit);
	}
	,endFill: function() {
		this.graphics.endFill();
	}
	,beginFill: function(color,alpha) {
		this.graphics.beginFill(color,alpha);
	}
	,beginGradientFill: function(grad) {
	}
	,graphics: null
	,__class__: format.gfx.GfxGraphics
});
format.gfx.GfxTextFinder = function() {
	format.gfx.Gfx.call(this);
};
$hxClasses["format.gfx.GfxTextFinder"] = format.gfx.GfxTextFinder;
format.gfx.GfxTextFinder.__name__ = ["format","gfx","GfxTextFinder"];
format.gfx.GfxTextFinder.__super__ = format.gfx.Gfx;
format.gfx.GfxTextFinder.prototype = $extend(format.gfx.Gfx.prototype,{
	renderText: function(inText) {
		if(this.text == null) this.text = inText;
	}
	,geometryOnly: function() {
		return true;
	}
	,text: null
	,__class__: format.gfx.GfxTextFinder
});
format.gfx.Gradient = function() {
	this.type = flash.display.GradientType.LINEAR;
	this.colors = [];
	this.alphas = [];
	this.ratios = [];
	this.matrix = new flash.geom.Matrix();
	this.spread = flash.display.SpreadMethod.PAD;
	this.interp = flash.display.InterpolationMethod.RGB;
	this.focus = 0.0;
};
$hxClasses["format.gfx.Gradient"] = format.gfx.Gradient;
format.gfx.Gradient.__name__ = ["format","gfx","Gradient"];
format.gfx.Gradient.prototype = {
	focus: null
	,interp: null
	,spread: null
	,matrix: null
	,ratios: null
	,alphas: null
	,colors: null
	,type: null
	,__class__: format.gfx.Gradient
}
format.gfx.LineStyle = function() {
	this.thickness = 1.0;
	this.color = 0;
	this.alpha = 1.0;
	this.pixelHinting = false;
	this.scaleMode = flash.display.LineScaleMode.NORMAL;
	this.capsStyle = flash.display.CapsStyle.ROUND;
	this.jointStyle = flash.display.JointStyle.ROUND;
	this.miterLimit = 3.0;
};
$hxClasses["format.gfx.LineStyle"] = format.gfx.LineStyle;
format.gfx.LineStyle.__name__ = ["format","gfx","LineStyle"];
format.gfx.LineStyle.prototype = {
	miterLimit: null
	,jointStyle: null
	,capsStyle: null
	,scaleMode: null
	,pixelHinting: null
	,alpha: null
	,color: null
	,thickness: null
	,__class__: format.gfx.LineStyle
}
format.svg = {}
format.svg.FillType = $hxClasses["format.svg.FillType"] = { __ename__ : true, __constructs__ : ["FillGrad","FillSolid","FillNone"] }
format.svg.FillType.FillGrad = function(grad) { var $x = ["FillGrad",0,grad]; $x.__enum__ = format.svg.FillType; $x.toString = $estr; return $x; }
format.svg.FillType.FillSolid = function(colour) { var $x = ["FillSolid",1,colour]; $x.__enum__ = format.svg.FillType; $x.toString = $estr; return $x; }
format.svg.FillType.FillNone = ["FillNone",2];
format.svg.FillType.FillNone.toString = $estr;
format.svg.FillType.FillNone.__enum__ = format.svg.FillType;
format.svg.Grad = function(inType) {
	format.gfx.Gradient.call(this);
	this.type = inType;
	this.radius = 0.0;
	this.gradMatrix = new flash.geom.Matrix();
	this.x1 = 0.0;
	this.y1 = 0.0;
	this.x2 = 0.0;
	this.y2 = 0.0;
};
$hxClasses["format.svg.Grad"] = format.svg.Grad;
format.svg.Grad.__name__ = ["format","svg","Grad"];
format.svg.Grad.__super__ = format.gfx.Gradient;
format.svg.Grad.prototype = $extend(format.gfx.Gradient.prototype,{
	updateMatrix: function(inMatrix) {
		var dx = this.x2 - this.x1;
		var dy = this.y2 - this.y1;
		var theta = Math.atan2(dy,dx);
		var len = Math.sqrt(dx * dx + dy * dy);
		var mtx = new flash.geom.Matrix();
		if(this.type == flash.display.GradientType.LINEAR) {
			mtx.createGradientBox(1.0,1.0);
			mtx.scale(len,len);
		} else {
			if(this.radius != 0.0) this.focus = len / this.radius;
			mtx.createGradientBox(1.0,1.0);
			mtx.translate(-0.5,-0.5);
			mtx.scale(this.radius * 2,this.radius * 2);
		}
		mtx.rotate(theta);
		mtx.translate(this.x1,this.y1);
		mtx.concat(this.gradMatrix);
		mtx.concat(inMatrix);
		this.matrix = mtx;
	}
	,y2: null
	,x2: null
	,y1: null
	,x1: null
	,radius: null
	,gradMatrix: null
	,__class__: format.svg.Grad
});
format.svg.Group = function() {
	this.name = "";
	this.children = [];
};
$hxClasses["format.svg.Group"] = format.svg.Group;
format.svg.Group.__name__ = ["format","svg","Group"];
format.svg.Group.prototype = {
	children: null
	,name: null
	,findGroup: function(inName) {
		var _g = 0, _g1 = this.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			var $e = (child);
			switch( $e[1] ) {
			case 1:
				var group = $e[2];
				if(group.name == inName) return group;
				break;
			default:
			}
		}
		return null;
	}
	,hasGroup: function(inName) {
		return this.findGroup(inName) != null;
	}
	,__class__: format.svg.Group
}
format.svg.DisplayElement = $hxClasses["format.svg.DisplayElement"] = { __ename__ : true, __constructs__ : ["DisplayPath","DisplayGroup","DisplayText"] }
format.svg.DisplayElement.DisplayPath = function(path) { var $x = ["DisplayPath",0,path]; $x.__enum__ = format.svg.DisplayElement; $x.toString = $estr; return $x; }
format.svg.DisplayElement.DisplayGroup = function(group) { var $x = ["DisplayGroup",1,group]; $x.__enum__ = format.svg.DisplayElement; $x.toString = $estr; return $x; }
format.svg.DisplayElement.DisplayText = function(text) { var $x = ["DisplayText",2,text]; $x.__enum__ = format.svg.DisplayElement; $x.toString = $estr; return $x; }
format.svg.Path = function() {
};
$hxClasses["format.svg.Path"] = format.svg.Path;
format.svg.Path.__name__ = ["format","svg","Path"];
format.svg.Path.prototype = {
	segments: null
	,miter_limit: null
	,joint_style: null
	,stroke_caps: null
	,stroke_width: null
	,stroke_colour: null
	,stroke_alpha: null
	,fill_alpha: null
	,alpha: null
	,fill: null
	,font_size: null
	,name: null
	,matrix: null
	,__class__: format.svg.Path
}
format.svg.PathParser = function() {
	if(format.svg.PathParser.sCommandArgs == null) {
		format.svg.PathParser.sCommandArgs = [];
		var _g = 0;
		while(_g < 128) {
			var i = _g++;
			format.svg.PathParser.sCommandArgs[i] = this.commandArgs(i);
		}
	}
};
$hxClasses["format.svg.PathParser"] = format.svg.PathParser;
format.svg.PathParser.__name__ = ["format","svg","PathParser"];
format.svg.PathParser.prototype = {
	createCommand: function(code,a) {
		switch(code) {
		case 77:
			this.lastMoveX = a[0];
			this.lastMoveY = a[1];
			return new format.svg.MoveSegment(this.lastMoveX,this.lastMoveY);
		case 109:
			this.lastMoveX = a[0] + this.prevX();
			this.lastMoveY = a[1] + this.prevY();
			return new format.svg.MoveSegment(this.lastMoveX,this.lastMoveY);
		case 76:
			return new format.svg.DrawSegment(a[0],a[1]);
		case 108:
			return new format.svg.DrawSegment(a[0] + this.prevX(),a[1] + this.prevY());
		case 72:
			return new format.svg.DrawSegment(a[0],this.prevY());
		case 104:
			return new format.svg.DrawSegment(a[0] + this.prevX(),this.prevY());
		case 86:
			return new format.svg.DrawSegment(this.prevX(),a[0]);
		case 118:
			return new format.svg.DrawSegment(this.prevX(),a[0] + this.prevY());
		case 67:
			return new format.svg.CubicSegment(a[0],a[1],a[2],a[3],a[4],a[5]);
		case 99:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.CubicSegment(a[0] + rx,a[1] + ry,a[2] + rx,a[3] + ry,a[4] + rx,a[5] + ry);
		case 83:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.CubicSegment(rx * 2 - this.prevCX(),ry * 2 - this.prevCY(),a[0],a[1],a[2],a[3]);
		case 115:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.CubicSegment(rx * 2 - this.prevCX(),ry * 2 - this.prevCY(),a[0] + rx,a[1] + ry,a[2] + rx,a[3] + ry);
		case 81:
			return new format.svg.QuadraticSegment(a[0],a[1],a[2],a[3]);
		case 113:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.QuadraticSegment(a[0] + rx,a[1] + ry,a[2] + rx,a[3] + ry);
		case 84:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.QuadraticSegment(rx * 2 - this.prevCX(),rx * 2 - this.prevCY(),a[2],a[3]);
		case 116:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.QuadraticSegment(rx * 2 - this.prevCX(),ry * 2 - this.prevCY(),a[0] + rx,a[1] + ry);
		case 65:
			return new format.svg.ArcSegment(this.prevX(),this.prevY(),a[0],a[1],a[2],a[3] != 0.,a[4] != 0.,a[5],a[6]);
		case 97:
			var rx = this.prevX();
			var ry = this.prevY();
			return new format.svg.ArcSegment(rx,ry,a[0],a[1],a[2],a[3] != 0.,a[4] != 0.,a[5] + rx,a[6] + ry);
		case 90:
			return new format.svg.DrawSegment(this.lastMoveX,this.lastMoveY);
		case 122:
			return new format.svg.DrawSegment(this.lastMoveX,this.lastMoveY);
		}
		return null;
	}
	,prevCY: function() {
		return this.prev != null?this.prev.prevCY():0;
	}
	,prevCX: function() {
		return this.prev != null?this.prev.prevCX():0;
	}
	,prevY: function() {
		return this.prev != null?this.prev.prevY():0;
	}
	,prevX: function() {
		return this.prev != null?this.prev.prevX():0;
	}
	,commandArgs: function(inCode) {
		if(inCode == 10) return format.svg.PathParser.SEPARATOR;
		var str = String.fromCharCode(inCode).toUpperCase();
		if(str >= "0" && str <= "9") return format.svg.PathParser.FLOAT;
		switch(str) {
		case "Z":
			return 0;
		case "H":case "V":
			return 1;
		case "M":case "L":case "T":
			return 2;
		case "S":case "Q":
			return 4;
		case "C":
			return 6;
		case "A":
			return 7;
		case "\t":case "\n":case " ":case "\r":case ",":
			return format.svg.PathParser.SEPARATOR;
		case "-":
			return format.svg.PathParser.FLOAT_SIGN;
		case "+":
			return format.svg.PathParser.FLOAT_SIGN;
		case "E":case "e":
			return format.svg.PathParser.FLOAT_EXP;
		case ".":
			return format.svg.PathParser.FLOAT_DOT;
		}
		return format.svg.PathParser.UNKNOWN;
	}
	,parse: function(pathToParse,inConvertCubics) {
		this.lastMoveX = this.lastMoveY = 0;
		var pos = 0;
		var args = new Array();
		var segments = new Array();
		var current_command_pos = 0;
		var current_command = -1;
		var current_args = -1;
		this.prev = null;
		var len = pathToParse.length;
		var finished = false;
		while(pos <= len) {
			var code = pos == len?32:HxOverrides.cca(pathToParse,pos);
			var command = code > 0 && code < 128?format.svg.PathParser.sCommandArgs[code]:format.svg.PathParser.UNKNOWN;
			if(command == format.svg.PathParser.UNKNOWN) throw "failed parsing path near '" + HxOverrides.substr(pathToParse,pos,null) + "'";
			if(command == format.svg.PathParser.SEPARATOR) pos++; else if(command <= format.svg.PathParser.FLOAT) {
				var end = pos + 1;
				var e_pos = -1;
				var seen_dot = command == format.svg.PathParser.FLOAT_DOT;
				if(command == format.svg.PathParser.FLOAT_EXP) {
					e_pos = 0;
					seen_dot = true;
				}
				while(end < pathToParse.length) {
					var ch = HxOverrides.cca(pathToParse,end);
					var code1 = ch < 0 || ch > 127?format.svg.PathParser.UNKNOWN:format.svg.PathParser.sCommandArgs[ch];
					if(code1 > format.svg.PathParser.FLOAT) break;
					if(code1 == format.svg.PathParser.FLOAT_DOT && seen_dot) break;
					if(e_pos >= 0) {
						if(code1 == format.svg.PathParser.FLOAT_SIGN) {
							if(e_pos != 0) break;
						} else if(code1 != format.svg.PathParser.FLOAT) break;
						e_pos++;
					} else if(code1 == format.svg.PathParser.FLOAT_EXP) {
						if(e_pos >= 0) break;
						e_pos = 0;
						seen_dot = true;
					} else if(code1 == format.svg.PathParser.FLOAT_SIGN) break;
					end++;
				}
				if(current_command < 0) {
				} else {
					var f = Std.parseFloat(HxOverrides.substr(pathToParse,pos,end - pos));
					args.push(f);
				}
				pos = end;
			} else {
				current_command = code;
				current_args = command;
				finished = false;
				current_command_pos = pos;
				args = [];
				pos++;
			}
			var px = 0.0;
			var py = 0.0;
			if(current_command >= 0) {
				if(current_args == args.length) {
					if(inConvertCubics && this.prev != null) {
						px = this.prev.prevX();
						py = this.prev.prevY();
					}
					this.prev = this.createCommand(current_command,args);
					if(this.prev == null) throw "Unknown command " + String.fromCharCode(current_command) + " near '" + HxOverrides.substr(pathToParse,current_command_pos,null) + "'";
					if(inConvertCubics && this.prev.getType() == 4) {
						var cubic = this.prev;
						var quads = cubic.toQuadratics(px,py);
						var _g = 0;
						while(_g < quads.length) {
							var q = quads[_g];
							++_g;
							segments.push(q);
						}
					} else segments.push(this.prev);
					finished = true;
					if(current_args == 0) {
						current_args = -1;
						current_command = -1;
					} else if(current_command == 77) current_command = 76; else if(current_command == 109) current_command = 108;
					current_command_pos = pos;
					args = [];
				}
			}
		}
		if(current_command >= 0 && !finished) throw "Unfinished command (" + args.length + "/" + current_args + ") near '" + HxOverrides.substr(pathToParse,current_command_pos,null) + "'";
		return segments;
	}
	,prev: null
	,lastMoveY: null
	,lastMoveX: null
	,__class__: format.svg.PathParser
}
format.svg.PathSegment = function(inX,inY) {
	this.x = inX;
	this.y = inY;
};
$hxClasses["format.svg.PathSegment"] = format.svg.PathSegment;
format.svg.PathSegment.__name__ = ["format","svg","PathSegment"];
format.svg.PathSegment.prototype = {
	toGfx: function(inGfx,ioContext) {
		ioContext.setLast(this.x,this.y);
		ioContext.firstX = ioContext.lastX;
		ioContext.firstY = ioContext.lastY;
		inGfx.moveTo(ioContext.lastX,ioContext.lastY);
	}
	,prevCY: function() {
		return this.y;
	}
	,prevCX: function() {
		return this.x;
	}
	,prevY: function() {
		return this.y;
	}
	,prevX: function() {
		return this.x;
	}
	,getType: function() {
		return 0;
	}
	,y: null
	,x: null
	,__class__: format.svg.PathSegment
}
format.svg.MoveSegment = function(inX,inY) {
	format.svg.PathSegment.call(this,inX,inY);
};
$hxClasses["format.svg.MoveSegment"] = format.svg.MoveSegment;
format.svg.MoveSegment.__name__ = ["format","svg","MoveSegment"];
format.svg.MoveSegment.__super__ = format.svg.PathSegment;
format.svg.MoveSegment.prototype = $extend(format.svg.PathSegment.prototype,{
	getType: function() {
		return 1;
	}
	,__class__: format.svg.MoveSegment
});
format.svg.DrawSegment = function(inX,inY) {
	format.svg.PathSegment.call(this,inX,inY);
};
$hxClasses["format.svg.DrawSegment"] = format.svg.DrawSegment;
format.svg.DrawSegment.__name__ = ["format","svg","DrawSegment"];
format.svg.DrawSegment.__super__ = format.svg.PathSegment;
format.svg.DrawSegment.prototype = $extend(format.svg.PathSegment.prototype,{
	getType: function() {
		return 2;
	}
	,toGfx: function(inGfx,ioContext) {
		ioContext.setLast(this.x,this.y);
		inGfx.lineTo(ioContext.lastX,ioContext.lastY);
	}
	,__class__: format.svg.DrawSegment
});
format.svg.QuadraticSegment = function(inCX,inCY,inX,inY) {
	format.svg.PathSegment.call(this,inX,inY);
	this.cx = inCX;
	this.cy = inCY;
};
$hxClasses["format.svg.QuadraticSegment"] = format.svg.QuadraticSegment;
format.svg.QuadraticSegment.__name__ = ["format","svg","QuadraticSegment"];
format.svg.QuadraticSegment.__super__ = format.svg.PathSegment;
format.svg.QuadraticSegment.prototype = $extend(format.svg.PathSegment.prototype,{
	getType: function() {
		return 3;
	}
	,toGfx: function(inGfx,ioContext) {
		ioContext.setLast(this.x,this.y);
		inGfx.curveTo(ioContext.transX(this.cx,this.cy),ioContext.transY(this.cx,this.cy),ioContext.lastX,ioContext.lastY);
	}
	,prevCY: function() {
		return this.cy;
	}
	,prevCX: function() {
		return this.cx;
	}
	,cy: null
	,cx: null
	,__class__: format.svg.QuadraticSegment
});
format.svg.CubicSegment = function(inCX1,inCY1,inCX2,inCY2,inX,inY) {
	format.svg.PathSegment.call(this,inX,inY);
	this.cx1 = inCX1;
	this.cy1 = inCY1;
	this.cx2 = inCX2;
	this.cy2 = inCY2;
};
$hxClasses["format.svg.CubicSegment"] = format.svg.CubicSegment;
format.svg.CubicSegment.__name__ = ["format","svg","CubicSegment"];
format.svg.CubicSegment.__super__ = format.svg.PathSegment;
format.svg.CubicSegment.prototype = $extend(format.svg.PathSegment.prototype,{
	getType: function() {
		return 4;
	}
	,toQuadratics: function(tx0,ty0) {
		var result = new Array();
		var pa_x = this.Interp(tx0,this.cx1,0.75);
		var pa_y = this.Interp(ty0,this.cy1,0.75);
		var pb_x = this.Interp(this.x,this.cx2,0.75);
		var pb_y = this.Interp(this.y,this.cy2,0.75);
		var dx = (this.x - tx0) / 16;
		var dy = (this.y - ty0) / 16;
		var pcx_1 = this.Interp(tx0,this.cx1,0.375);
		var pcy_1 = this.Interp(ty0,this.cy1,0.375);
		var pcx_2 = this.Interp(pa_x,pb_x,0.375) - dx;
		var pcy_2 = this.Interp(pa_y,pb_y,0.375) - dy;
		var pcx_3 = this.Interp(pb_x,pa_x,0.375) + dx;
		var pcy_3 = this.Interp(pb_y,pa_y,0.375) + dy;
		var pcx_4 = this.Interp(this.x,this.cx2,0.375);
		var pcy_4 = this.Interp(this.y,this.cy2,0.375);
		var pax_1 = (pcx_1 + pcx_2) * 0.5;
		var pay_1 = (pcy_1 + pcy_2) * 0.5;
		var pax_2 = (pa_x + pb_x) * 0.5;
		var pay_2 = (pa_y + pb_y) * 0.5;
		var pax_3 = (pcx_3 + pcx_4) * 0.5;
		var pay_3 = (pcy_3 + pcy_4) * 0.5;
		result.push(new format.svg.QuadraticSegment(pcx_1,pcy_1,pax_1,pay_1));
		result.push(new format.svg.QuadraticSegment(pcx_2,pcy_2,pax_2,pay_2));
		result.push(new format.svg.QuadraticSegment(pcx_3,pcy_3,pax_3,pay_3));
		result.push(new format.svg.QuadraticSegment(pcx_4,pcy_4,this.x,this.y));
		return result;
	}
	,toGfx: function(inGfx,ioContext) {
		var tx0 = ioContext.lastX;
		var ty0 = ioContext.lastY;
		var tx1 = ioContext.transX(this.cx1,this.cy1);
		var ty1 = ioContext.transY(this.cx1,this.cy1);
		var tx2 = ioContext.transX(this.cx2,this.cy2);
		var ty2 = ioContext.transY(this.cx2,this.cy2);
		ioContext.setLast(this.x,this.y);
		var tx3 = ioContext.lastX;
		var ty3 = ioContext.lastY;
		var pa_x = this.Interp(tx0,tx1,0.75);
		var pa_y = this.Interp(ty0,ty1,0.75);
		var pb_x = this.Interp(tx3,tx2,0.75);
		var pb_y = this.Interp(ty3,ty2,0.75);
		var dx = (tx3 - tx0) / 16;
		var dy = (ty3 - ty0) / 16;
		var pcx_1 = this.Interp(tx0,tx1,0.375);
		var pcy_1 = this.Interp(ty0,ty1,0.375);
		var pcx_2 = this.Interp(pa_x,pb_x,0.375) - dx;
		var pcy_2 = this.Interp(pa_y,pb_y,0.375) - dy;
		var pcx_3 = this.Interp(pb_x,pa_x,0.375) + dx;
		var pcy_3 = this.Interp(pb_y,pa_y,0.375) + dy;
		var pcx_4 = this.Interp(tx3,tx2,0.375);
		var pcy_4 = this.Interp(ty3,ty2,0.375);
		var pax_1 = (pcx_1 + pcx_2) * 0.5;
		var pay_1 = (pcy_1 + pcy_2) * 0.5;
		var pax_2 = (pa_x + pb_x) * 0.5;
		var pay_2 = (pa_y + pb_y) * 0.5;
		var pax_3 = (pcx_3 + pcx_4) * 0.5;
		var pay_3 = (pcy_3 + pcy_4) * 0.5;
		inGfx.curveTo(pcx_1,pcy_1,pax_1,pay_1);
		inGfx.curveTo(pcx_2,pcy_2,pax_2,pay_2);
		inGfx.curveTo(pcx_3,pcy_3,pax_3,pay_3);
		inGfx.curveTo(pcx_4,pcy_4,tx3,ty3);
	}
	,Interp: function(a,b,frac) {
		return a + (b - a) * frac;
	}
	,prevCY: function() {
		return this.cy2;
	}
	,prevCX: function() {
		return this.cx2;
	}
	,cy2: null
	,cx2: null
	,cy1: null
	,cx1: null
	,__class__: format.svg.CubicSegment
});
format.svg.ArcSegment = function(inX1,inY1,inRX,inRY,inRotation,inLargeArc,inSweep,x,y) {
	this.x1 = inX1;
	this.y1 = inY1;
	format.svg.PathSegment.call(this,x,y);
	this.rx = inRX;
	this.ry = inRY;
	this.phi = inRotation;
	this.fA = inLargeArc;
	this.fS = inSweep;
};
$hxClasses["format.svg.ArcSegment"] = format.svg.ArcSegment;
format.svg.ArcSegment.__name__ = ["format","svg","ArcSegment"];
format.svg.ArcSegment.__super__ = format.svg.PathSegment;
format.svg.ArcSegment.prototype = $extend(format.svg.PathSegment.prototype,{
	getType: function() {
		return 5;
	}
	,toGfx: function(inGfx,ioContext) {
		if(this.x1 == this.x && this.y1 == this.y) return;
		ioContext.setLast(this.x,this.y);
		if(this.rx == 0 || this.ry == 0) {
			inGfx.lineTo(ioContext.lastX,ioContext.lastY);
			return;
		}
		if(this.rx < 0) this.rx = -this.rx;
		if(this.ry < 0) this.ry = -this.ry;
		var p = this.phi * Math.PI / 180.0;
		var cos = Math.cos(p);
		var sin = Math.sin(p);
		var dx = (this.x1 - this.x) * 0.5;
		var dy = (this.y1 - this.y) * 0.5;
		var x1_ = cos * dx + sin * dy;
		var y1_ = -sin * dx + cos * dy;
		var rx2 = this.rx * this.rx;
		var ry2 = this.ry * this.ry;
		var x1_2 = x1_ * x1_;
		var y1_2 = y1_ * y1_;
		var s = (rx2 * ry2 - rx2 * y1_2 - ry2 * x1_2) / (rx2 * y1_2 + ry2 * x1_2);
		if(s < 0) s = 0; else if(this.fA == this.fS) s = -Math.sqrt(s); else s = Math.sqrt(s);
		var cx_ = s * this.rx * y1_ / this.ry;
		var cy_ = -s * this.ry * x1_ / this.rx;
		var xm = (this.x1 + this.x) * 0.5;
		var ym = (this.y1 + this.y) * 0.5;
		var cx = cos * cx_ - sin * cy_ + xm;
		var cy = sin * cx_ + cos * cy_ + ym;
		var theta = Math.atan2((y1_ - cy_) / this.ry,(x1_ - cx_) / this.rx);
		var dtheta = Math.atan2((-y1_ - cy_) / this.ry,(-x1_ - cx_) / this.rx) - theta;
		if(this.fS && dtheta < 0) dtheta += 2.0 * Math.PI; else if(!this.fS && dtheta > 0) dtheta -= 2.0 * Math.PI;
		var m = ioContext.matrix;
		var Txc;
		var Txs;
		var Tx0;
		var Tyc;
		var Tys;
		var Ty0;
		if(m != null) {
			Txc = m.a * this.rx;
			Txs = m.c * this.ry;
			Tx0 = m.a * cx + m.c * cy + m.tx;
			Tyc = m.b * this.rx;
			Tys = m.d * this.ry;
			Ty0 = m.b * cx + m.d * cy + m.ty;
		} else {
			Txc = this.rx;
			Txs = 0;
			Tx0 = cx + m.tx;
			Tyc = 0;
			Tys = this.ry;
			Ty0 = cy + m.ty;
		}
		var len = Math.abs(dtheta) * Math.sqrt(Txc * Txc + Txs * Txs + Tyc * Tyc + Tys * Tys);
		len *= 5;
		var steps = Math.round(len);
		if(steps > 1) {
			dtheta /= steps;
			var _g1 = 1, _g = steps - 1;
			while(_g1 < _g) {
				var i = _g1++;
				var c = Math.cos(theta);
				var s1 = Math.sin(theta);
				theta += dtheta;
				inGfx.lineTo(Txc * c + Txs * s1 + Tx0,Tyc * c + Tys * s1 + Ty0);
			}
		}
		inGfx.lineTo(ioContext.lastX,ioContext.lastY);
	}
	,fS: null
	,fA: null
	,phi: null
	,ry: null
	,rx: null
	,y1: null
	,x1: null
	,__class__: format.svg.ArcSegment
});
format.svg.RenderContext = function(inMatrix,inRect,inW,inH) {
	this.matrix = inMatrix;
	this.rect = inRect;
	this.rectW = inW != null?inW:inRect != null?inRect.width:1;
	this.rectH = inH != null?inH:inRect != null?inRect.height:1;
	this.firstX = 0;
	this.firstY = 0;
	this.lastX = 0;
	this.lastY = 0;
};
$hxClasses["format.svg.RenderContext"] = format.svg.RenderContext;
format.svg.RenderContext.__name__ = ["format","svg","RenderContext"];
format.svg.RenderContext.prototype = {
	lastY: null
	,lastX: null
	,firstY: null
	,firstX: null
	,rectH: null
	,rectW: null
	,rect: null
	,matrix: null
	,setLast: function(inX,inY) {
		this.lastX = this.transX(inX,inY);
		this.lastY = this.transY(inX,inY);
	}
	,transY: function(inX,inY) {
		if(this.rect != null && inY > this.rect.y) {
			if(inY > this.rect.get_right()) inY += this.rectH - this.rect.height; else inY = this.rect.y + this.rectH * (inY - this.rect.y) / this.rect.height;
		}
		return inX * this.matrix.b + inY * this.matrix.d + this.matrix.ty;
	}
	,transX: function(inX,inY) {
		if(this.rect != null && inX > this.rect.x) {
			if(inX > this.rect.get_right()) inX += this.rectW - this.rect.width; else inX = this.rect.x + this.rectW * (inX - this.rect.x) / this.rect.width;
		}
		return inX * this.matrix.a + inY * this.matrix.c + this.matrix.tx;
	}
	,__class__: format.svg.RenderContext
}
format.svg.SVG2Gfx = function(inXml) {
	this.renderer = new format.svg.SVGRenderer(new format.svg.SVGData(inXml));
};
$hxClasses["format.svg.SVG2Gfx"] = format.svg.SVG2Gfx;
format.svg.SVG2Gfx.__name__ = ["format","svg","SVG2Gfx"];
format.svg.SVG2Gfx.prototype = {
	createShape: function() {
		return this.renderer.createShape();
	}
	,renderer: null
	,__class__: format.svg.SVG2Gfx
}
format.svg.SVGData = function(inXML,inConvertCubics) {
	if(inConvertCubics == null) inConvertCubics = false;
	format.svg.Group.call(this);
	var svg = inXML.firstElement();
	if(svg == null || svg.get_nodeName() != "svg" && svg.get_nodeName() != "svg:svg") throw "Not an SVG file (" + (svg == null?"null":svg.get_nodeName()) + ")";
	this.mGrads = new haxe.ds.StringMap();
	this.mPathParser = new format.svg.PathParser();
	this.mConvertCubics = inConvertCubics;
	this.width = this.getFloatStyle("width",svg,null,0.0);
	this.height = this.getFloatStyle("height",svg,null,0.0);
	if(this.width == 0 && this.height == 0) this.width = this.height = 400; else if(this.width == 0) this.width = this.height; else if(this.height == 0) this.height = this.width;
	this.loadGroup(this,svg,new flash.geom.Matrix(),null);
};
$hxClasses["format.svg.SVGData"] = format.svg.SVGData;
format.svg.SVGData.__name__ = ["format","svg","SVGData"];
format.svg.SVGData.__super__ = format.svg.Group;
format.svg.SVGData.prototype = $extend(format.svg.Group.prototype,{
	loadText: function(inText,matrix,inStyles) {
		if(inText.exists("transform")) {
			matrix = matrix.clone();
			this.applyTransform(matrix,inText.get("transform"));
		}
		var styles = this.getStyles(inText,inStyles);
		var text = new format.svg.Text();
		text.matrix = matrix;
		text.name = inText.exists("id")?inText.get("id"):"";
		text.x = this.getFloat(inText,"x",0.0);
		text.y = this.getFloat(inText,"y",0.0);
		text.fill = this.getFillStyle("fill",inText,styles);
		text.fill_alpha = this.getFloatStyle("fill-opacity",inText,styles,1.0);
		text.stroke_alpha = this.getFloatStyle("stroke-opacity",inText,styles,1.0);
		text.stroke_colour = this.getStrokeStyle("stroke",inText,styles,null);
		text.stroke_width = this.getFloatStyle("stroke-width",inText,styles,1.0);
		text.font_family = this.getStyle("font-family",inText,styles,"");
		text.font_size = this.getFloatStyle("font-size",inText,styles,12);
		text.letter_spacing = this.getFloatStyle("letter-spacing",inText,styles,0);
		text.kerning = this.getFloatStyle("kerning",inText,styles,0);
		var string = "";
		var $it0 = inText.elements();
		while( $it0.hasNext() ) {
			var el = $it0.next();
			string += el.toString();
		}
		text.text = string;
		return text;
	}
	,loadPath: function(inPath,matrix,inStyles,inIsRect,inIsEllipse,inIsCircle) {
		if(inIsCircle == null) inIsCircle = false;
		if(inPath.exists("transform")) {
			matrix = matrix.clone();
			this.applyTransform(matrix,inPath.get("transform"));
		}
		var styles = this.getStyles(inPath,inStyles);
		var name = inPath.exists("id")?inPath.get("id"):"";
		var path = new format.svg.Path();
		path.fill = this.getFillStyle("fill",inPath,styles);
		path.alpha = this.getFloatStyle("opacity",inPath,styles,1.0);
		path.fill_alpha = this.getFloatStyle("fill-opacity",inPath,styles,1.0);
		path.stroke_alpha = this.getFloatStyle("stroke-opacity",inPath,styles,1.0);
		path.stroke_colour = this.getStrokeStyle("stroke",inPath,styles,null);
		path.stroke_width = this.getFloatStyle("stroke-width",inPath,styles,1.0);
		path.stroke_caps = flash.display.CapsStyle.ROUND;
		path.joint_style = flash.display.JointStyle.ROUND;
		path.miter_limit = this.getFloatStyle("stroke-miterlimit",inPath,styles,3.0);
		path.segments = [];
		path.matrix = matrix;
		path.name = name;
		if(inIsRect) {
			var x = inPath.exists("x")?Std.parseFloat(inPath.get("x")):0;
			var y = inPath.exists("y")?Std.parseFloat(inPath.get("y")):0;
			var w = Std.parseFloat(inPath.get("width"));
			var h = Std.parseFloat(inPath.get("height"));
			var rx = inPath.exists("rx")?Std.parseFloat(inPath.get("rx")):0.0;
			var ry = inPath.exists("ry")?Std.parseFloat(inPath.get("ry")):0.0;
			if(rx == 0 || ry == 0) {
				path.segments.push(new format.svg.MoveSegment(x,y));
				path.segments.push(new format.svg.DrawSegment(x + w,y));
				path.segments.push(new format.svg.DrawSegment(x + w,y + h));
				path.segments.push(new format.svg.DrawSegment(x,y + h));
				path.segments.push(new format.svg.DrawSegment(x,y));
			} else {
				path.segments.push(new format.svg.MoveSegment(x,y + ry));
				path.segments.push(new format.svg.QuadraticSegment(x,y,x + rx,y));
				path.segments.push(new format.svg.DrawSegment(x + w - rx,y));
				path.segments.push(new format.svg.QuadraticSegment(x + w,y,x + w,y + rx));
				path.segments.push(new format.svg.DrawSegment(x + w,y + h - ry));
				path.segments.push(new format.svg.QuadraticSegment(x + w,y + h,x + w - rx,y + h));
				path.segments.push(new format.svg.DrawSegment(x + rx,y + h));
				path.segments.push(new format.svg.QuadraticSegment(x,y + h,x,y + h - ry));
				path.segments.push(new format.svg.DrawSegment(x,y + ry));
			}
		} else if(inIsEllipse) {
			var x = inPath.exists("cx")?Std.parseFloat(inPath.get("cx")):0;
			var y = inPath.exists("cy")?Std.parseFloat(inPath.get("cy")):0;
			var r = inIsCircle && inPath.exists("r")?Std.parseFloat(inPath.get("r")):0.0;
			var w = inIsCircle?r:inPath.exists("rx")?Std.parseFloat(inPath.get("rx")):0.0;
			var w_ = w * format.svg.SVGData.SIN45;
			var cw_ = w * format.svg.SVGData.TAN22;
			var h = inIsCircle?r:inPath.exists("ry")?Std.parseFloat(inPath.get("ry")):0.0;
			var h_ = h * format.svg.SVGData.SIN45;
			var ch_ = h * format.svg.SVGData.TAN22;
			path.segments.push(new format.svg.MoveSegment(x + w,y));
			path.segments.push(new format.svg.QuadraticSegment(x + w,y + ch_,x + w_,y + h_));
			path.segments.push(new format.svg.QuadraticSegment(x + cw_,y + h,x,y + h));
			path.segments.push(new format.svg.QuadraticSegment(x - cw_,y + h,x - w_,y + h_));
			path.segments.push(new format.svg.QuadraticSegment(x - w,y + ch_,x - w,y));
			path.segments.push(new format.svg.QuadraticSegment(x - w,y - ch_,x - w_,y - h_));
			path.segments.push(new format.svg.QuadraticSegment(x - cw_,y - h,x,y - h));
			path.segments.push(new format.svg.QuadraticSegment(x + cw_,y - h,x + w_,y - h_));
			path.segments.push(new format.svg.QuadraticSegment(x + w,y - ch_,x + w,y));
		} else {
			var d = inPath.exists("points")?"M" + inPath.get("points") + "z":inPath.exists("x1")?"M" + inPath.get("x1") + "," + inPath.get("y1") + " " + inPath.get("x2") + "," + inPath.get("y2") + "z":inPath.get("d");
			var _g = 0, _g1 = this.mPathParser.parse(d,this.mConvertCubics);
			while(_g < _g1.length) {
				var segment = _g1[_g];
				++_g;
				path.segments.push(segment);
			}
		}
		return path;
	}
	,loadGroup: function(g,inG,matrix,inStyles) {
		if(inG.exists("transform")) {
			matrix = matrix.clone();
			this.applyTransform(matrix,inG.get("transform"));
		}
		if(inG.exists("inkscape:label")) g.name = inG.get("inkscape:label"); else if(inG.exists("id")) g.name = inG.get("id");
		var styles = this.getStyles(inG,inStyles);
		var $it0 = inG.elements();
		while( $it0.hasNext() ) {
			var el = $it0.next();
			var name = el.get_nodeName();
			if(HxOverrides.substr(name,0,4) == "svg:") name = HxOverrides.substr(name,4,null);
			if(name == "defs") this.loadDefs(el); else if(name == "g") {
				if(!(el.exists("display") && el.get("display") == "none")) g.children.push(format.svg.DisplayElement.DisplayGroup(this.loadGroup(new format.svg.Group(),el,matrix,styles)));
			} else if(name == "path" || name == "line" || name == "polyline") g.children.push(format.svg.DisplayElement.DisplayPath(this.loadPath(el,matrix,styles,false,false))); else if(name == "rect") g.children.push(format.svg.DisplayElement.DisplayPath(this.loadPath(el,matrix,styles,true,false))); else if(name == "polygon") g.children.push(format.svg.DisplayElement.DisplayPath(this.loadPath(el,matrix,styles,false,false))); else if(name == "ellipse") g.children.push(format.svg.DisplayElement.DisplayPath(this.loadPath(el,matrix,styles,false,true))); else if(name == "circle") g.children.push(format.svg.DisplayElement.DisplayPath(this.loadPath(el,matrix,styles,false,true,true))); else if(name == "text") g.children.push(format.svg.DisplayElement.DisplayText(this.loadText(el,matrix,styles))); else if(name == "linearGradient") this.loadGradient(el,flash.display.GradientType.LINEAR,true); else if(name == "radialGradient") this.loadGradient(el,flash.display.GradientType.RADIAL,true); else {
			}
		}
		return g;
	}
	,loadGradient: function(inGrad,inType,inCrossLink) {
		var name = inGrad.get("id");
		var grad = new format.svg.Grad(inType);
		if(inCrossLink && inGrad.exists("xlink:href")) {
			var xlink = inGrad.get("xlink:href");
			if(xlink.charAt(0) != "#") throw "xlink - unkown syntax : " + xlink;
			var base = this.mGrads.get(HxOverrides.substr(xlink,1,null));
			if(base != null) {
				grad.colors = base.colors;
				grad.alphas = base.alphas;
				grad.ratios = base.ratios;
				grad.gradMatrix = base.gradMatrix.clone();
				grad.spread = base.spread;
				grad.interp = base.interp;
				grad.radius = base.radius;
			} else throw "Unknown xlink : " + xlink;
		}
		if(inGrad.exists("x1")) {
			grad.x1 = this.getFloat(inGrad,"x1");
			grad.y1 = this.getFloat(inGrad,"y1");
			grad.x2 = this.getFloat(inGrad,"x2");
			grad.y2 = this.getFloat(inGrad,"y2");
		} else {
			grad.x1 = this.getFloat(inGrad,"cx");
			grad.y1 = this.getFloat(inGrad,"cy");
			grad.x2 = this.getFloat(inGrad,"fx",grad.x1);
			grad.y2 = this.getFloat(inGrad,"fy",grad.y1);
		}
		grad.radius = this.getFloat(inGrad,"r");
		if(inGrad.exists("gradientTransform")) this.applyTransform(grad.gradMatrix,inGrad.get("gradientTransform"));
		var $it0 = inGrad.elements();
		while( $it0.hasNext() ) {
			var stop = $it0.next();
			var styles = this.getStyles(stop,null);
			grad.colors.push(this.getColorStyle("stop-color",stop,styles,0));
			grad.alphas.push(this.getFloatStyle("stop-opacity",stop,styles,1.0));
			grad.ratios.push(Std.parseFloat(stop.get("offset")) * 255.0 | 0);
		}
		this.mGrads.set(name,grad);
	}
	,loadDefs: function(inXML) {
		var _g = 0;
		while(_g < 2) {
			var pass = _g++;
			var $it0 = inXML.elements();
			while( $it0.hasNext() ) {
				var def = $it0.next();
				var name = def.get_nodeName();
				if(HxOverrides.substr(name,0,4) == "svg:") name = HxOverrides.substr(name,4,null);
				if(name == "linearGradient") this.loadGradient(def,flash.display.GradientType.LINEAR,pass == 1); else if(name == "radialGradient") this.loadGradient(def,flash.display.GradientType.RADIAL,pass == 1);
			}
		}
	}
	,getStyles: function(inNode,inPrevStyles) {
		if(!inNode.exists("style")) return inPrevStyles;
		var styles = new haxe.ds.StringMap();
		if(inPrevStyles != null) {
			var $it0 = inPrevStyles.keys();
			while( $it0.hasNext() ) {
				var s = $it0.next();
				styles.set(s,inPrevStyles.get(s));
			}
		}
		var style = inNode.get("style");
		var strings = format.svg.SVGData.mStyleSplit.split(style);
		var _g = 0;
		while(_g < strings.length) {
			var s = strings[_g];
			++_g;
			if(format.svg.SVGData.mStyleValue.match(s)) styles.set(format.svg.SVGData.mStyleValue.matched(1),format.svg.SVGData.mStyleValue.matched(2));
		}
		return styles;
	}
	,getStyle: function(inKey,inNode,inStyles,inDefault) {
		if(inNode != null && inNode.exists(inKey)) return inNode.get(inKey);
		if(inStyles != null && inStyles.exists(inKey)) return inStyles.get(inKey);
		return inDefault;
	}
	,getStrokeStyle: function(inKey,inNode,inStyles,inDefault) {
		var s = this.getStyle(inKey,inNode,inStyles,"");
		if(s == "") return inDefault;
		if(s == "none") return null;
		if(s.charAt(0) == "#") return Std.parseInt("0x" + HxOverrides.substr(s,1,null));
		return Std.parseInt(s);
	}
	,getFloatStyle: function(inKey,inNode,inStyles,inDefault) {
		var s = this.getStyle(inKey,inNode,inStyles,"");
		if(s == "") return inDefault;
		return Std.parseFloat(s);
	}
	,getFloat: function(inXML,inName,inDef) {
		if(inDef == null) inDef = 0.0;
		if(inXML.exists(inName)) return Std.parseFloat(inXML.get(inName));
		return inDef;
	}
	,getFillStyle: function(inKey,inNode,inStyles) {
		var s = this.getStyle(inKey,inNode,inStyles,"");
		if(s == "") return format.svg.SVGData.defaultFill;
		if(s.charAt(0) == "#") return format.svg.FillType.FillSolid(Std.parseInt("0x" + HxOverrides.substr(s,1,null)));
		if(s == "none") return format.svg.FillType.FillNone;
		if(format.svg.SVGData.mURLMatch.match(s)) {
			var url = format.svg.SVGData.mURLMatch.matched(1);
			if(this.mGrads.exists(url)) return format.svg.FillType.FillGrad(this.mGrads.get(url));
			throw "Unknown url:" + url;
		}
		throw "Unknown fill string:" + s;
		return format.svg.FillType.FillNone;
	}
	,getColorStyle: function(inKey,inNode,inStyles,inDefault) {
		var s = this.getStyle(inKey,inNode,inStyles,"");
		if(s == "") return inDefault;
		if(s.charAt(0) == "#") return Std.parseInt("0x" + HxOverrides.substr(s,1,null));
		return Std.parseInt(s);
	}
	,dumpGroup: function(g,indent) {
		console.log(indent + "Group:" + g.name);
		indent += "  ";
		var _g = 0, _g1 = g.children;
		while(_g < _g1.length) {
			var e = _g1[_g];
			++_g;
			var $e = (e);
			switch( $e[1] ) {
			case 0:
				var path = $e[2];
				console.log(indent + "Path" + "  " + Std.string(path.matrix));
				break;
			case 1:
				var group = $e[2];
				this.dumpGroup(group,indent + "   ");
				break;
			case 2:
				var text = $e[2];
				console.log(indent + "Text " + text.text);
				break;
			}
		}
	}
	,applyTransform: function(ioMatrix,inTrans) {
		var scale = 1.0;
		if(format.svg.SVGData.mTranslateMatch.match(inTrans)) ioMatrix.translate(Std.parseFloat(format.svg.SVGData.mTranslateMatch.matched(1)),Std.parseFloat(format.svg.SVGData.mTranslateMatch.matched(2))); else if(format.svg.SVGData.mScaleMatch.match(inTrans)) {
			var s = Std.parseFloat(format.svg.SVGData.mScaleMatch.matched(1));
			ioMatrix.scale(s,s);
			scale = s;
		} else if(format.svg.SVGData.mMatrixMatch.match(inTrans)) {
			var m = new flash.geom.Matrix(Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(1)),Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(2)),Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(3)),Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(4)),Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(5)),Std.parseFloat(format.svg.SVGData.mMatrixMatch.matched(6)));
			m.concat(ioMatrix);
			ioMatrix.a = m.a;
			ioMatrix.b = m.b;
			ioMatrix.c = m.c;
			ioMatrix.d = m.d;
			ioMatrix.set_tx(m.tx);
			ioMatrix.set_ty(m.ty);
			scale = Math.sqrt(ioMatrix.a * ioMatrix.a + ioMatrix.c * ioMatrix.c);
		} else console.log("Warning, unknown transform:" + inTrans);
		return scale;
	}
	,mPathParser: null
	,mGrads: null
	,mConvertCubics: null
	,width: null
	,height: null
	,__class__: format.svg.SVGData
});
format.svg.SVGRenderer = function(inSvg,inLayer) {
	this.mSvg = inSvg;
	this.width = this.mSvg.width;
	this.height = this.mSvg.height;
	this.mRoot = this.mSvg;
	if(inLayer != null) {
		this.mRoot = this.mSvg.findGroup(inLayer);
		if(this.mRoot == null) throw "Could not find SVG group: " + inLayer;
	}
};
$hxClasses["format.svg.SVGRenderer"] = format.svg.SVGRenderer;
format.svg.SVGRenderer.__name__ = ["format","svg","SVGRenderer"];
format.svg.SVGRenderer.toHaxe = function(inXML,inFilter) {
	return new format.svg.SVGRenderer(new format.svg.SVGData(inXML,true)).iterate(new format.gfx.Gfx2Haxe(),inFilter).commands;
}
format.svg.SVGRenderer.toBytes = function(inXML,inFilter) {
	return new format.svg.SVGRenderer(new format.svg.SVGData(inXML,true)).iterate(new format.gfx.GfxBytes(),inFilter);
}
format.svg.SVGRenderer.prototype = {
	renderBitmap: function(inRect,inScale) {
		if(inScale == null) inScale = 1.0;
		this.mMatrix = new flash.geom.Matrix(inScale,0,0,inScale,-inRect.x * inScale,-inRect.y * inScale);
		var w = Math.ceil(inRect == null?this.width:inRect.width * inScale) | 0;
		var h = Math.ceil(inRect == null?this.width:inRect.height * inScale) | 0;
		var bmp = new flash.display.BitmapData(w,h,true,0);
		var shape = new flash.display.Shape();
		this.mGfx = new format.gfx.GfxGraphics(shape.get_graphics());
		this.mGroupPath = [];
		this.iterateGroup(this.mRoot,true);
		bmp.draw(shape);
		this.mGfx = null;
		return bmp;
	}
	,namedShape: function(inName) {
		return this.createShape(null,function(name,_) {
			return name == inName;
		});
	}
	,createShape: function(inMatrix,inFilter,inScale9) {
		var shape = new flash.display.Shape();
		this.renderObject(shape,shape.get_graphics(),inMatrix,inFilter,inScale9);
		return shape;
	}
	,renderSprite: function(inObj,inMatrix,inFilter,inScale9) {
		this.renderObject(inObj,inObj.get_graphics(),inMatrix,inFilter,inScale9);
	}
	,renderObject: function(inObj,inGfx,inMatrix,inFilter,inScale9) {
		this.render(inGfx,inMatrix,inFilter,inScale9);
		var rect = this.getExtent(inMatrix,function(_,groups) {
			return groups[1] == ".scale9";
		});
	}
	,getMatchingRect: function(inMatch) {
		return this.getExtent(null,function(_,groups) {
			return groups[1] != null && inMatch.match(groups[1]);
		},false);
	}
	,findText: function(inFilter) {
		this.mFilter = inFilter;
		this.mGroupPath = [];
		var finder = new format.gfx.GfxTextFinder();
		this.mGfx = finder;
		this.iterateGroup(this.mRoot,false);
		return finder.text;
	}
	,getExtent: function(inMatrix,inFilter,inIgnoreDot) {
		if(inIgnoreDot == null) inIgnoreDot = inFilter == null;
		var gfx = new format.gfx.GfxExtent();
		this.mGfx = gfx;
		if(inMatrix == null) this.mMatrix = new flash.geom.Matrix(); else this.mMatrix = inMatrix.clone();
		this.mFilter = inFilter;
		this.mGroupPath = [];
		this.iterateGroup(this.mRoot,inIgnoreDot);
		return gfx.extent;
	}
	,renderRect0: function(inGfx,inFilter,scaleRect,inBounds,inRect) {
		var matrix = new flash.geom.Matrix();
		matrix.set_tx(-inBounds.x);
		matrix.set_ty(-inBounds.y);
		if(scaleRect != null) {
			var extraX = inRect.width - (inBounds.width - scaleRect.width);
			var extraY = inRect.height - (inBounds.height - scaleRect.height);
			this.render(inGfx,matrix,inFilter,scaleRect,extraX,extraY);
		} else this.render(inGfx,matrix,inFilter);
	}
	,renderRect: function(inGfx,inFilter,scaleRect,inBounds,inRect) {
		var matrix = new flash.geom.Matrix();
		matrix.set_tx(inRect.x - inBounds.x);
		matrix.set_ty(inRect.y - inBounds.y);
		if(scaleRect != null) {
			var extraX = inRect.width - (inBounds.width - scaleRect.width);
			var extraY = inRect.height - (inBounds.height - scaleRect.height);
			this.render(inGfx,matrix,inFilter,scaleRect,extraX,extraY);
		} else this.render(inGfx,matrix,inFilter);
	}
	,render: function(inGfx,inMatrix,inFilter,inScaleRect,inScaleW,inScaleH) {
		this.mGfx = new format.gfx.GfxGraphics(inGfx);
		if(inMatrix == null) this.mMatrix = new flash.geom.Matrix(); else this.mMatrix = inMatrix.clone();
		this.mScaleRect = inScaleRect;
		this.mScaleW = inScaleW;
		this.mScaleH = inScaleH;
		this.mFilter = inFilter;
		this.mGroupPath = [];
		this.iterateGroup(this.mRoot,inFilter == null);
	}
	,iterateGroup: function(inGroup,inIgnoreDot) {
		if(inIgnoreDot && inGroup.name != null && HxOverrides.substr(inGroup.name,0,1) == ".") return;
		this.mGroupPath.push(inGroup.name);
		var _g = 0, _g1 = inGroup.children;
		while(_g < _g1.length) {
			var child = _g1[_g];
			++_g;
			var $e = (child);
			switch( $e[1] ) {
			case 1:
				var group = $e[2];
				this.iterateGroup(group,inIgnoreDot);
				break;
			case 0:
				var path = $e[2];
				this.iteratePath(path);
				break;
			case 2:
				var text = $e[2];
				this.iterateText(text);
				break;
			}
		}
		this.mGroupPath.pop();
	}
	,iteratePath: function(inPath) {
		if(this.mFilter != null && !this.mFilter(inPath.name,this.mGroupPath)) return;
		if(inPath.segments.length == 0 || this.mGfx == null) return;
		var px = 0.0;
		var py = 0.0;
		var m = inPath.matrix.clone();
		m.concat(this.mMatrix);
		var context = new format.svg.RenderContext(m,this.mScaleRect,this.mScaleW,this.mScaleH);
		var geomOnly = this.mGfx.geometryOnly();
		if(!geomOnly) {
			inPath.segments[0].toGfx(this.mGfx,context);
			var $e = (inPath.fill);
			switch( $e[1] ) {
			case 0:
				var grad = $e[2];
				grad.updateMatrix(m);
				this.mGfx.beginGradientFill(grad);
				break;
			case 1:
				var colour = $e[2];
				this.mGfx.beginFill(colour,inPath.fill_alpha * inPath.alpha);
				break;
			case 2:
				break;
			}
			if(inPath.stroke_colour == null) {
			} else {
				var style = new format.gfx.LineStyle();
				var scale = Math.sqrt(m.a * m.a + m.c * m.c);
				style.thickness = inPath.stroke_width * scale;
				style.alpha = inPath.stroke_alpha * inPath.alpha;
				style.color = inPath.stroke_colour;
				style.capsStyle = inPath.stroke_caps;
				style.jointStyle = inPath.joint_style;
				style.miterLimit = inPath.miter_limit;
				this.mGfx.lineStyle(style);
			}
		}
		var _g = 0, _g1 = inPath.segments;
		while(_g < _g1.length) {
			var segment = _g1[_g];
			++_g;
			segment.toGfx(this.mGfx,context);
		}
		this.mGfx.endFill();
		this.mGfx.endLineStyle();
	}
	,iterateText: function(inText) {
		if(this.mFilter != null && !this.mFilter(inText.name,this.mGroupPath)) return;
		this.mGfx.renderText(inText);
	}
	,hasGroup: function(inName) {
		return this.mRoot.hasGroup(inName);
	}
	,iterate: function(inGfx,inFilter) {
		this.mGfx = inGfx;
		this.mMatrix = new flash.geom.Matrix();
		this.mFilter = inFilter;
		this.mGroupPath = [];
		this.mGfx.size(this.width,this.height);
		this.iterateGroup(this.mRoot,true);
		this.mGfx.eof();
		return inGfx;
	}
	,mGroupPath: null
	,mFilter: null
	,mScaleH: null
	,mScaleW: null
	,mScaleRect: null
	,mMatrix: null
	,mGfx: null
	,mRoot: null
	,mSvg: null
	,height: null
	,width: null
	,__class__: format.svg.SVGRenderer
}
format.svg.Text = function() {
};
$hxClasses["format.svg.Text"] = format.svg.Text;
format.svg.Text.__name__ = ["format","svg","Text"];
format.svg.Text.prototype = {
	letter_spacing: null
	,kerning: null
	,font_size: null
	,font_family: null
	,stroke_width: null
	,stroke_colour: null
	,stroke_alpha: null
	,fill_alpha: null
	,fill: null
	,text: null
	,matrix: null
	,y: null
	,x: null
	,name: null
	,__class__: format.svg.Text
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
haxe.crypto = {}
haxe.crypto.BaseCode = function(base) {
	var len = base.length;
	var nbits = 1;
	while(len > 1 << nbits) nbits++;
	if(nbits > 8 || len != 1 << nbits) throw "BaseCode : base length must be a power of two.";
	this.base = base;
	this.nbits = nbits;
};
$hxClasses["haxe.crypto.BaseCode"] = haxe.crypto.BaseCode;
haxe.crypto.BaseCode.__name__ = ["haxe","crypto","BaseCode"];
haxe.crypto.BaseCode.prototype = {
	nbits: null
	,base: null
	,__class__: haxe.crypto.BaseCode
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
	,set: function(key,value) {
		this.h[key] = value;
	}
	,h: null
	,__class__: haxe.ds.IntMap
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
haxe.io.Bytes = function(length,b) {
	this.length = length;
	this.b = b;
};
$hxClasses["haxe.io.Bytes"] = haxe.io.Bytes;
haxe.io.Bytes.__name__ = ["haxe","io","Bytes"];
haxe.io.Bytes.ofString = function(s) {
	var a = new Array();
	var _g1 = 0, _g = s.length;
	while(_g1 < _g) {
		var i = _g1++;
		var c = s.charCodeAt(i);
		if(c <= 127) a.push(c); else if(c <= 2047) {
			a.push(192 | c >> 6);
			a.push(128 | c & 63);
		} else if(c <= 65535) {
			a.push(224 | c >> 12);
			a.push(128 | c >> 6 & 63);
			a.push(128 | c & 63);
		} else {
			a.push(240 | c >> 18);
			a.push(128 | c >> 12 & 63);
			a.push(128 | c >> 6 & 63);
			a.push(128 | c & 63);
		}
	}
	return new haxe.io.Bytes(a.length,a);
}
haxe.io.Bytes.prototype = {
	b: null
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
nx3.display = {}
nx3.display.DComplex = function(dnotes) {
	this.headsRect_ = null;
	this.dnotes = dnotes;
	this.signs = this.getSigns_(dnotes);
	this.avoidCollisions_();
	this.get_headsRect();
};
$hxClasses["nx3.display.DComplex"] = nx3.display.DComplex;
nx3.display.DComplex.__name__ = ["nx3","display","DComplex"];
nx3.display.DComplex.prototype = {
	avoidCollisions_: function() {
		if(this.dnotes.length > 1) {
			var diff = this.dnotes[1].get_headTop().level - this.dnotes[0].get_headBottom().level;
			if(diff == 1) this.dnotes[1].set_xAdjust(nx3.display.DComplex.SECOND_CLASH_ADJUST_X); else if(diff == 0) {
				if(this.dnotes[1].get_value() != this.dnotes[0].get_value()) this.dnotes[1].set_xAdjust(nx3.units._NX.NX_Impl_.add(nx3.units._NX.NX_Impl_.sub(nx3.units._NX.NX_Impl_.add(this.dnotes[0].get_headsRect().x,this.dnotes[0].get_headsRect().width),this.dnotes[1].get_headsRect().x),0.6));
			} else if(diff < 1) {
				if(this.dnotes[1].get_value() == this.dnotes[0].get_value()) {
					if(nx3.display.tools.HeadsTool.headsCollide(this.dnotes[0].get_heads(),this.dnotes[1].get_heads())) this.dnotes[1].set_xAdjust(nx3.units._NX.NX_Impl_.add(nx3.units._NX.NX_Impl_.sub(nx3.units._NX.NX_Impl_.add(this.dnotes[0].get_headsRect().x,this.dnotes[0].get_headsRect().width),this.dnotes[1].get_headsRect().x),0.6)); else this.dnotes[1].set_xAdjust(nx3.units._NX.NX_Impl_.sw(0.6));
				} else this.dnotes[1].set_xAdjust(nx3.units._NX.NX_Impl_.add(nx3.units._NX.NX_Impl_.sub(nx3.units._NX.NX_Impl_.add(this.dnotes[0].get_headsRect().x,this.dnotes[0].get_headsRect().width),this.dnotes[1].get_headsRect().x),0.6));
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
			currentRect = nx3.display.tools.SignsTools.getSignRect(sign.sign);
			currentRect.offset(0,sign.level);
			if(currentRect == null) continue;
			currentRect.offset(nx3.units._NX.NX_Impl_.sw(currentRect.width),0);
			var xMove = 0;
			var _g2 = 0, _g3 = this.signRects_;
			while(_g2 < _g3.length) {
				var checkRect = _g3[_g2];
				++_g2;
				var isect = checkRect.intersection(currentRect);
				if(checkRect.intersects(currentRect)) currentRect.x = nx3.units._NX.NX_Impl_.sub(checkRect.x,currentRect.width);
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
		this.signsFrame_.x = nx3.units._NX.NX_Impl_.sub(nx3.units._NX.NX_Impl_.sub(this.get_headsRect().x,this.signsFrame_.width),0.8);
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
		return nx3.display.tools.SignsTools.adjustPositions(signs);
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
	,dnotesXAdjust: null
	,signs: null
	,dnotes: null
	,__class__: nx3.display.DComplex
	,__properties__: {get_dnotesXAdjust:"get_dnotesXAdjust",get_headsRect:"get_headsRect",get_signsFrame:"get_signsFrame",get_signRects:"get_signRects"}
}
nx3.display.IDNoteRects = function() { }
$hxClasses["nx3.display.IDNoteRects"] = nx3.display.IDNoteRects;
nx3.display.IDNoteRects.__name__ = ["nx3","display","IDNoteRects"];
nx3.display.IDNoteRects.prototype = {
	rectsBack: null
	,rectsFront: null
	,__class__: nx3.display.IDNoteRects
}
nx3.display.calc = {}
nx3.display.calc.DNoteCalc = function(note,variant,articulations,attributes,forceDirection) {
	this.xAdjust_ = 0;
	this.headRects_ = null;
	this.note = note;
	this.variant = variant;
	this.articulations = articulations;
	this.attributes = attributes;
	this.forceDirection = forceDirection;
	this.get_rectsBack();
};
$hxClasses["nx3.display.calc.DNoteCalc"] = nx3.display.calc.DNoteCalc;
nx3.display.calc.DNoteCalc.__name__ = ["nx3","display","calc","DNoteCalc"];
nx3.display.calc.DNoteCalc.__interfaces__ = [nx3.display.IDNoteRects];
nx3.display.calc.DNoteCalc.prototype = {
	get_value: function() {
		return this.note.value;
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
		this.heads_ = this.note.get_heads();
		return this.heads_;
	}
	,heads: null
	,heads_: null
	,get_midLevel: function() {
		if(this.midLevel_ != null) return this.midLevel_;
		this.midLevel_ = nx3.display.tools.HeadsTool.midLevel(this.note.get_heads());
		return this.midLevel_;
	}
	,midLevel_: null
	,midLevel: null
	,get_headRects: function() {
		if(this.headRects_ != null) return this.headRects_;
		this.headRects_ = [];
		var headPositions = nx3.display.tools.HeadsTool.getHeadPositions(this.note.get_heads(),this.get_direction());
		var i = 0;
		var _g = 0, _g1 = this.note.get_heads();
		while(_g < _g1.length) {
			var head = _g1[_g];
			++_g;
			var rect = nx3.display.tools.HeadTool.getHeadRect(head,this.note.value);
			rect.offset(nx3.units._NX.NX_Impl_.mulInt(rect.width,headPositions[i]),0);
			this.headRects_.push(rect);
			i++;
		}
		return this.headRects_;
	}
	,headRects: null
	,headRects_: null
	,get_rectsBack: function() {
		this.get_headRects();
		return null;
	}
	,rectsBack_: null
	,get_rectsFront: function() {
		return null;
	}
	,rectsBack: null
	,rectsFront: null
	,get_direction: function() {
		if(this.direction_ != null) return this.direction_;
		if(this.forceDirection != null) this.direction_ = this.forceDirection; else this.direction_ = this.note.direction != null?this.note.direction:nx3.display.tools.HeadsTool.getDirection(this.note.get_heads());
		return this.direction_;
	}
	,direction_: null
	,value: null
	,direction: null
	,forceDirection: null
	,attributes: null
	,articulations: null
	,variant: null
	,note: null
	,__class__: nx3.display.calc.DNoteCalc
	,__properties__: {get_direction:"get_direction",get_value:"get_value",get_rectsFront:"get_rectsFront",get_rectsBack:"get_rectsBack",get_headRects:"get_headRects",get_midLevel:"get_midLevel",get_heads:"get_heads",get_headTop:"get_headTop",get_headBottom:"get_headBottom",get_headsRect:"get_headsRect",set_xAdjust:"set_xAdjust",get_xAdjust:"get_xAdjust"}
}
nx3.display.DNote = function(note,forceDirection) {
	var $e = (note.type);
	switch( $e[1] ) {
	case 0:
		var attributes = $e[5], articulations = $e[4], variant = $e[3], heads = $e[2];
		nx3.display.calc.DNoteCalc.call(this,note,variant,articulations,attributes,forceDirection);
		break;
	default:
		throw "DNote should have type ENoteType.Note, but has " + Std.string(note.type);
	}
};
$hxClasses["nx3.display.DNote"] = nx3.display.DNote;
nx3.display.DNote.__name__ = ["nx3","display","DNote"];
nx3.display.DNote.__super__ = nx3.display.calc.DNoteCalc;
nx3.display.DNote.prototype = $extend(nx3.display.calc.DNoteCalc.prototype,{
	reset: function() {
		this.headRects_ = null;
		this.headsRect_ = null;
	}
	,__class__: nx3.display.DNote
});
nx3.display.tools = {}
nx3.display.tools.HeadTool = function() { }
$hxClasses["nx3.display.tools.HeadTool"] = nx3.display.tools.HeadTool;
nx3.display.tools.HeadTool.__name__ = ["nx3","display","tools","HeadTool"];
nx3.display.tools.HeadTool.getHeadRect = function(head,value) {
	var rect = null;
	switch( (value.type)[1] ) {
	case 2:
		rect = new nx3.units.NRect(-2,-1,4,2);
		break;
	case 1:
	case 0:
		rect = new nx3.units.NRect(-1.6,-1,3.2,2);
		break;
	}
	rect.offset(0,head.level);
	return rect;
}
nx3.display.tools.HeadTool.getDirection = function(heads) {
	return null;
}
nx3.display.tools.HeadsTool = function() { }
$hxClasses["nx3.display.tools.HeadsTool"] = nx3.display.tools.HeadsTool;
nx3.display.tools.HeadsTool.__name__ = ["nx3","display","tools","HeadsTool"];
nx3.display.tools.HeadsTool.topLevel = function(heads) {
	return heads[0].level;
}
nx3.display.tools.HeadsTool.bottomLevel = function(heads) {
	return heads[heads.length - 1].level;
}
nx3.display.tools.HeadsTool.midLevel = function(heads) {
	var bottom = nx3.display.tools.HeadsTool.bottomLevel(heads);
	var top = nx3.display.tools.HeadsTool.topLevel(heads);
	return top + (bottom - top) / 2;
}
nx3.display.tools.HeadsTool.getDirection = function(heads) {
	return nx3.display.tools.HeadsTool.midLevel(heads) > 0?nx3.enums.EDirectionUD.Up:nx3.enums.EDirectionUD.Down;
}
nx3.display.tools.HeadsTool.getHeadPositions = function(heads,direction) {
	if(heads.length < 2) return [0];
	var len = heads.length;
	var result = [];
	var _g = 0;
	while(_g < len) {
		var i = _g++;
		result.push(0);
	}
	if(direction == nx3.enums.EDirectionUD.Down) {
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
nx3.display.tools.HeadsTool.headsCollide = function(heads1,heads2) {
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
			if(head1.level == nx3.units._Level.Level_Impl_.addInteger(head2.level,1)) return true;
		}
	}
	return false;
}
nx3.display.tools.SignsTools = function() { }
$hxClasses["nx3.display.tools.SignsTools"] = nx3.display.tools.SignsTools;
nx3.display.tools.SignsTools.__name__ = ["nx3","display","tools","SignsTools"];
nx3.display.tools.SignsTools.adjustPositions = function(signs) {
	signs = nx3.display.tools.SignsTools.removeNones(signs);
	if(signs.length < 2) return signs;
	signs = nx3.display.tools.SignsTools.sortSigns(signs);
	signs = nx3.display.tools.SignsTools.calcPositions(signs);
	return signs;
}
nx3.display.tools.SignsTools.calcPositions = function(signs) {
	var levels = [-999,-999,-999,-999];
	var _g = 0;
	while(_g < signs.length) {
		var sign = signs[_g];
		++_g;
		var cpos = 0;
		var diff = sign.level - levels[cpos];
		while(diff < nx3.display.tools.SignsTools.BREAKPOINT) {
			cpos++;
			diff = sign.level - levels[cpos];
		}
		levels[cpos] = sign.level;
		sign.position = cpos;
	}
	return signs;
}
nx3.display.tools.SignsTools.removeNones = function(signs) {
	var r = [];
	var _g = 0;
	while(_g < signs.length) {
		var sign = signs[_g];
		++_g;
		if(sign.sign != nx3.enums.ESign.None) r.push(sign);
	}
	return r;
}
nx3.display.tools.SignsTools.sortSigns = function(signs) {
	signs.sort(function(signA,signB) {
		if(signA.level <= signB.level) return -1; else return 1;
	});
	return signs;
}
nx3.display.tools.SignsTools.getPositions = function(signs) {
	return Lambda.array(Lambda.map(signs,function(sign) {
		return sign.position;
	}));
}
nx3.display.tools.SignsTools.getSignRect = function(sign) {
	switch( (sign)[1] ) {
	case 0:
		return null;
	case 5:
		return new nx3.units.NRect(0,-1.5,2.6,3);
	case 7:
	case 8:
	case 6:
		return new nx3.units.NRect(0,-2,4.4,4);
	case 2:
		return new nx3.units.NRect(0,-3,2.6,5);
	default:
		return new nx3.units.NRect(0,-3,2.6,6);
	}
	throw "This shouldn't happen!";
	return null;
}
nx3.display.tools.SignsTools.adjustSignFontX = function(sign) {
	switch( (sign)[1] ) {
	case 2:
		return 0.3;
	default:
	}
	return 0;
}
nx3.elements = {}
nx3.elements.Head = function(type,level,sign,tie,tieTo) {
	if(level == null) level = 0;
	this.type = type != null?type:nx3.enums.EHeadType.Normal;
	this.sign = sign != null?sign:nx3.enums.ESign.None;
	this.tie = tie != null?tie:null;
	this.tieTo = tieTo != null?tieTo:null;
	this.level = level;
};
$hxClasses["nx3.elements.Head"] = nx3.elements.Head;
nx3.elements.Head.__name__ = ["nx3","elements","Head"];
nx3.elements.Head.prototype = {
	tieTo: null
	,tie: null
	,sign: null
	,type: null
	,level: null
	,__class__: nx3.elements.Head
}
nx3.elements.Note = function(type,heads,value,direction) {
	if(type == null) type = heads != null?nx3.enums.ENoteType.Note(heads):nx3.enums.ENoteType.Note([new nx3.elements.Head()]);
	if(value == null) value = nx3.enums.ENoteValue.Nv4;
	this.type = type;
	this.value = value;
	this.direction = direction;
	nx3.enums.tools.ENoteTypeTools.noteSortHeads(this.type);
};
$hxClasses["nx3.elements.Note"] = nx3.elements.Note;
nx3.elements.Note.__name__ = ["nx3","elements","Note"];
nx3.elements.Note.prototype = {
	get_heads: function() {
		if(this.heads_ != null) return this.heads_;
		var _g = this;
		var $e = (_g.type);
		switch( $e[1] ) {
		case 0:
			var attributes = $e[5], articulations = $e[4], variant = $e[3], heads = $e[2];
			this.heads_ = heads;
			return this.heads_;
		default:
		}
		return null;
	}
	,heads_: null
	,heads: null
	,direction: null
	,value: null
	,type: null
	,__class__: nx3.elements.Note
	,__properties__: {get_heads:"get_heads"}
}
nx3.enums = {}
nx3.enums.EClef = $hxClasses["nx3.enums.EClef"] = { __ename__ : true, __constructs__ : ["ClefG","ClefF","ClefC"] }
nx3.enums.EClef.ClefG = ["ClefG",0];
nx3.enums.EClef.ClefG.toString = $estr;
nx3.enums.EClef.ClefG.__enum__ = nx3.enums.EClef;
nx3.enums.EClef.ClefF = ["ClefF",1];
nx3.enums.EClef.ClefF.toString = $estr;
nx3.enums.EClef.ClefF.__enum__ = nx3.enums.EClef;
nx3.enums.EClef.ClefC = ["ClefC",2];
nx3.enums.EClef.ClefC.toString = $estr;
nx3.enums.EClef.ClefC.__enum__ = nx3.enums.EClef;
nx3.enums.EDirectionUAD = $hxClasses["nx3.enums.EDirectionUAD"] = { __ename__ : true, __constructs__ : ["Up","Auto","Down"] }
nx3.enums.EDirectionUAD.Up = ["Up",0];
nx3.enums.EDirectionUAD.Up.toString = $estr;
nx3.enums.EDirectionUAD.Up.__enum__ = nx3.enums.EDirectionUAD;
nx3.enums.EDirectionUAD.Auto = ["Auto",1];
nx3.enums.EDirectionUAD.Auto.toString = $estr;
nx3.enums.EDirectionUAD.Auto.__enum__ = nx3.enums.EDirectionUAD;
nx3.enums.EDirectionUAD.Down = ["Down",2];
nx3.enums.EDirectionUAD.Down.toString = $estr;
nx3.enums.EDirectionUAD.Down.__enum__ = nx3.enums.EDirectionUAD;
nx3.enums.EDirectionUD = $hxClasses["nx3.enums.EDirectionUD"] = { __ename__ : true, __constructs__ : ["Up","Down"] }
nx3.enums.EDirectionUD.Up = ["Up",0];
nx3.enums.EDirectionUD.Up.toString = $estr;
nx3.enums.EDirectionUD.Up.__enum__ = nx3.enums.EDirectionUD;
nx3.enums.EDirectionUD.Down = ["Down",1];
nx3.enums.EDirectionUD.Down.toString = $estr;
nx3.enums.EDirectionUD.Down.__enum__ = nx3.enums.EDirectionUD;
nx3.enums.EHeadType = $hxClasses["nx3.enums.EHeadType"] = { __ename__ : true, __constructs__ : ["Normal","Rythmic","Crossed"] }
nx3.enums.EHeadType.Normal = ["Normal",0];
nx3.enums.EHeadType.Normal.toString = $estr;
nx3.enums.EHeadType.Normal.__enum__ = nx3.enums.EHeadType;
nx3.enums.EHeadType.Rythmic = ["Rythmic",1];
nx3.enums.EHeadType.Rythmic.toString = $estr;
nx3.enums.EHeadType.Rythmic.__enum__ = nx3.enums.EHeadType;
nx3.enums.EHeadType.Crossed = ["Crossed",2];
nx3.enums.EHeadType.Crossed.toString = $estr;
nx3.enums.EHeadType.Crossed.__enum__ = nx3.enums.EHeadType;
nx3.enums.EHeadValuetype = $hxClasses["nx3.enums.EHeadValuetype"] = { __ename__ : true, __constructs__ : ["HVT4","HVT2","HVT1"] }
nx3.enums.EHeadValuetype.HVT4 = ["HVT4",0];
nx3.enums.EHeadValuetype.HVT4.toString = $estr;
nx3.enums.EHeadValuetype.HVT4.__enum__ = nx3.enums.EHeadValuetype;
nx3.enums.EHeadValuetype.HVT2 = ["HVT2",1];
nx3.enums.EHeadValuetype.HVT2.toString = $estr;
nx3.enums.EHeadValuetype.HVT2.__enum__ = nx3.enums.EHeadValuetype;
nx3.enums.EHeadValuetype.HVT1 = ["HVT1",2];
nx3.enums.EHeadValuetype.HVT1.toString = $estr;
nx3.enums.EHeadValuetype.HVT1.__enum__ = nx3.enums.EHeadValuetype;
nx3.enums.ELyricContinuation = $hxClasses["nx3.enums.ELyricContinuation"] = { __ename__ : true, __constructs__ : ["Hyphen","Melisma"] }
nx3.enums.ELyricContinuation.Hyphen = ["Hyphen",0];
nx3.enums.ELyricContinuation.Hyphen.toString = $estr;
nx3.enums.ELyricContinuation.Hyphen.__enum__ = nx3.enums.ELyricContinuation;
nx3.enums.ELyricContinuation.Melisma = ["Melisma",1];
nx3.enums.ELyricContinuation.Melisma.toString = $estr;
nx3.enums.ELyricContinuation.Melisma.__enum__ = nx3.enums.ELyricContinuation;
nx3.enums.ELyricFormat = $hxClasses["nx3.enums.ELyricFormat"] = { __ename__ : true, __constructs__ : ["Bold","Italic","Format"] }
nx3.enums.ELyricFormat.Bold = ["Bold",0];
nx3.enums.ELyricFormat.Bold.toString = $estr;
nx3.enums.ELyricFormat.Bold.__enum__ = nx3.enums.ELyricFormat;
nx3.enums.ELyricFormat.Italic = ["Italic",1];
nx3.enums.ELyricFormat.Italic.toString = $estr;
nx3.enums.ELyricFormat.Italic.__enum__ = nx3.enums.ELyricFormat;
nx3.enums.ELyricFormat.Format = function(fontName,size,bold,Italic) { var $x = ["Format",2,fontName,size,bold,Italic]; $x.__enum__ = nx3.enums.ELyricFormat; $x.toString = $estr; return $x; }
nx3.enums.ENoteArticulation = $hxClasses["nx3.enums.ENoteArticulation"] = { __ename__ : true, __constructs__ : ["Staccato","Tenuto","Marcato"] }
nx3.enums.ENoteArticulation.Staccato = ["Staccato",0];
nx3.enums.ENoteArticulation.Staccato.toString = $estr;
nx3.enums.ENoteArticulation.Staccato.__enum__ = nx3.enums.ENoteArticulation;
nx3.enums.ENoteArticulation.Tenuto = ["Tenuto",1];
nx3.enums.ENoteArticulation.Tenuto.toString = $estr;
nx3.enums.ENoteArticulation.Tenuto.__enum__ = nx3.enums.ENoteArticulation;
nx3.enums.ENoteArticulation.Marcato = ["Marcato",2];
nx3.enums.ENoteArticulation.Marcato.toString = $estr;
nx3.enums.ENoteArticulation.Marcato.__enum__ = nx3.enums.ENoteArticulation;
nx3.enums.ENoteAttributes = $hxClasses["nx3.enums.ENoteAttributes"] = { __ename__ : true, __constructs__ : ["Arpeggio","Clef"] }
nx3.enums.ENoteAttributes.Arpeggio = function(top,bottomY) { var $x = ["Arpeggio",0,top,bottomY]; $x.__enum__ = nx3.enums.ENoteAttributes; $x.toString = $estr; return $x; }
nx3.enums.ENoteAttributes.Clef = function(variant) { var $x = ["Clef",1,variant]; $x.__enum__ = nx3.enums.ENoteAttributes; $x.toString = $estr; return $x; }
nx3.enums.ENoteType = $hxClasses["nx3.enums.ENoteType"] = { __ename__ : true, __constructs__ : ["Note","Pause","BarPause","Tpl","Lyric","Chord","Dynam"] }
nx3.enums.ENoteType.Note = function(heads,variant,articulations,attributes) { var $x = ["Note",0,heads,variant,articulations,attributes]; $x.__enum__ = nx3.enums.ENoteType; $x.toString = $estr; return $x; }
nx3.enums.ENoteType.Pause = function(level) { var $x = ["Pause",1,level]; $x.__enum__ = nx3.enums.ENoteType; $x.toString = $estr; return $x; }
nx3.enums.ENoteType.BarPause = ["BarPause",2];
nx3.enums.ENoteType.BarPause.toString = $estr;
nx3.enums.ENoteType.BarPause.__enum__ = nx3.enums.ENoteType;
nx3.enums.ENoteType.Tpl = ["Tpl",3];
nx3.enums.ENoteType.Tpl.toString = $estr;
nx3.enums.ENoteType.Tpl.__enum__ = nx3.enums.ENoteType;
nx3.enums.ENoteType.Lyric = function(text,offset,continuation,format) { var $x = ["Lyric",4,text,offset,continuation,format]; $x.__enum__ = nx3.enums.ENoteType; $x.toString = $estr; return $x; }
nx3.enums.ENoteType.Chord = ["Chord",5];
nx3.enums.ENoteType.Chord.toString = $estr;
nx3.enums.ENoteType.Chord.__enum__ = nx3.enums.ENoteType;
nx3.enums.ENoteType.Dynam = ["Dynam",6];
nx3.enums.ENoteType.Dynam.toString = $estr;
nx3.enums.ENoteType.Dynam.__enum__ = nx3.enums.ENoteType;
nx3.enums.ENoteValue = function(value,type) {
	this.value = value | 0;
	this.type = type;
};
$hxClasses["nx3.enums.ENoteValue"] = nx3.enums.ENoteValue;
nx3.enums.ENoteValue.__name__ = ["nx3","enums","ENoteValue"];
nx3.enums.ENoteValue.getFromValue = function(value) {
	if(value == nx3.enums.ENoteValue.N1 * 3024) return nx3.enums.ENoteValue.Nv1;
	if(value == nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv1dot;
	if(value == nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv1ddot;
	if(value == nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv1tri;
	if(value == nx3.enums.ENoteValue.N2 * 3024) return nx3.enums.ENoteValue.Nv2;
	if(value == nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv2dot;
	if(value == nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv2ddot;
	if(value == nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv2tri;
	if(value == 3024) return nx3.enums.ENoteValue.Nv4;
	if(value == 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv4dot;
	if(value == 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv4ddot;
	if(value == 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv4tri;
	if(value == nx3.enums.ENoteValue.N8 * 3024) return nx3.enums.ENoteValue.Nv8;
	if(value == nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv8dot;
	if(value == nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv8ddot;
	if(value == nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv8tri;
	if(value == nx3.enums.ENoteValue.N16 * 3024) return nx3.enums.ENoteValue.Nv16;
	if(value == nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv16dot;
	if(value == nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv16ddot;
	if(value == nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv16tri;
	if(value == nx3.enums.ENoteValue.N32 * 3024) return nx3.enums.ENoteValue.Nv32;
	if(value == nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.DOT) return nx3.enums.ENoteValue.Nv32dot;
	if(value == nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.DOTDOT) return nx3.enums.ENoteValue.Nv32ddot;
	if(value == nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.TRI) return nx3.enums.ENoteValue.Nv32tri;
	throw "Could not find note value for value " + value;
	return nx3.enums.ENoteValue.Nv4;
}
nx3.enums.ENoteValue.prototype = {
	type: null
	,value: null
	,__class__: nx3.enums.ENoteValue
}
nx3.enums.ENoteVariant = $hxClasses["nx3.enums.ENoteVariant"] = { __ename__ : true, __constructs__ : ["Normal","Rythmic","RythmicSingleLevel","HeadsOnly","StavesOnly"] }
nx3.enums.ENoteVariant.Normal = ["Normal",0];
nx3.enums.ENoteVariant.Normal.toString = $estr;
nx3.enums.ENoteVariant.Normal.__enum__ = nx3.enums.ENoteVariant;
nx3.enums.ENoteVariant.Rythmic = ["Rythmic",1];
nx3.enums.ENoteVariant.Rythmic.toString = $estr;
nx3.enums.ENoteVariant.Rythmic.__enum__ = nx3.enums.ENoteVariant;
nx3.enums.ENoteVariant.RythmicSingleLevel = function(level) { var $x = ["RythmicSingleLevel",2,level]; $x.__enum__ = nx3.enums.ENoteVariant; $x.toString = $estr; return $x; }
nx3.enums.ENoteVariant.HeadsOnly = ["HeadsOnly",3];
nx3.enums.ENoteVariant.HeadsOnly.toString = $estr;
nx3.enums.ENoteVariant.HeadsOnly.__enum__ = nx3.enums.ENoteVariant;
nx3.enums.ENoteVariant.StavesOnly = ["StavesOnly",4];
nx3.enums.ENoteVariant.StavesOnly.toString = $estr;
nx3.enums.ENoteVariant.StavesOnly.__enum__ = nx3.enums.ENoteVariant;
nx3.enums.EPosition = $hxClasses["nx3.enums.EPosition"] = { __ename__ : true, __constructs__ : ["X","Y","XY","XYW"] }
nx3.enums.EPosition.X = function(x) { var $x = ["X",0,x]; $x.__enum__ = nx3.enums.EPosition; $x.toString = $estr; return $x; }
nx3.enums.EPosition.Y = function(y) { var $x = ["Y",1,y]; $x.__enum__ = nx3.enums.EPosition; $x.toString = $estr; return $x; }
nx3.enums.EPosition.XY = function(x,y) { var $x = ["XY",2,x,y]; $x.__enum__ = nx3.enums.EPosition; $x.toString = $estr; return $x; }
nx3.enums.EPosition.XYW = function(x,y,w) { var $x = ["XYW",3,x,y,w]; $x.__enum__ = nx3.enums.EPosition; $x.toString = $estr; return $x; }
nx3.enums.ESign = $hxClasses["nx3.enums.ESign"] = { __ename__ : true, __constructs__ : ["None","Natural","Flat","Sharp","DoubleFlat","DoubleSharp","ParNatural","ParFlat","ParSharp"] }
nx3.enums.ESign.None = ["None",0];
nx3.enums.ESign.None.toString = $estr;
nx3.enums.ESign.None.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.Natural = ["Natural",1];
nx3.enums.ESign.Natural.toString = $estr;
nx3.enums.ESign.Natural.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.Flat = ["Flat",2];
nx3.enums.ESign.Flat.toString = $estr;
nx3.enums.ESign.Flat.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.Sharp = ["Sharp",3];
nx3.enums.ESign.Sharp.toString = $estr;
nx3.enums.ESign.Sharp.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.DoubleFlat = ["DoubleFlat",4];
nx3.enums.ESign.DoubleFlat.toString = $estr;
nx3.enums.ESign.DoubleFlat.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.DoubleSharp = ["DoubleSharp",5];
nx3.enums.ESign.DoubleSharp.toString = $estr;
nx3.enums.ESign.DoubleSharp.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.ParNatural = ["ParNatural",6];
nx3.enums.ESign.ParNatural.toString = $estr;
nx3.enums.ESign.ParNatural.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.ParFlat = ["ParFlat",7];
nx3.enums.ESign.ParFlat.toString = $estr;
nx3.enums.ESign.ParFlat.__enum__ = nx3.enums.ESign;
nx3.enums.ESign.ParSharp = ["ParSharp",8];
nx3.enums.ESign.ParSharp.toString = $estr;
nx3.enums.ESign.ParSharp.__enum__ = nx3.enums.ESign;
nx3.enums.ETie = $hxClasses["nx3.enums.ETie"] = { __ename__ : true, __constructs__ : ["Tie","Gliss"] }
nx3.enums.ETie.Tie = function(direction) { var $x = ["Tie",0,direction]; $x.__enum__ = nx3.enums.ETie; $x.toString = $estr; return $x; }
nx3.enums.ETie.Gliss = function(direction) { var $x = ["Gliss",1,direction]; $x.__enum__ = nx3.enums.ETie; $x.toString = $estr; return $x; }
nx3.enums.EVoiceType = $hxClasses["nx3.enums.EVoiceType"] = { __ename__ : true, __constructs__ : ["Normal","Barpause"] }
nx3.enums.EVoiceType.Normal = ["Normal",0];
nx3.enums.EVoiceType.Normal.toString = $estr;
nx3.enums.EVoiceType.Normal.__enum__ = nx3.enums.EVoiceType;
nx3.enums.EVoiceType.Barpause = ["Barpause",1];
nx3.enums.EVoiceType.Barpause.toString = $estr;
nx3.enums.EVoiceType.Barpause.__enum__ = nx3.enums.EVoiceType;
nx3.enums.tools = {}
nx3.enums.tools.EDirectionTools = function() { }
$hxClasses["nx3.enums.tools.EDirectionTools"] = nx3.enums.tools.EDirectionTools;
nx3.enums.tools.EDirectionTools.__name__ = ["nx3","enums","tools","EDirectionTools"];
nx3.enums.tools.ENoteTypeTools = function() { }
$hxClasses["nx3.enums.tools.ENoteTypeTools"] = nx3.enums.tools.ENoteTypeTools;
nx3.enums.tools.ENoteTypeTools.__name__ = ["nx3","enums","tools","ENoteTypeTools"];
nx3.enums.tools.ENoteTypeTools.noteSortHeads = function(type) {
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
	if(head.sign != nx3.enums.ESign.None) xml.set(nx3.io.HeadXML.XHEAD_SIGN,Std.string(head.sign));
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
	var type = cx.EnumTools.createFromString(nx3.enums.EHeadType,typeStr);
	var level = Std.parseInt(xml.get(nx3.io.HeadXML.XHEAD_LEVEL));
	var sign = cx.EnumTools.createFromString(nx3.enums.ESign,xml.get(nx3.io.HeadXML.XHEAD_SIGN));
	var tie = cx.EnumTools.createFromString(nx3.enums.ETie,xml.get(nx3.io.HeadXML.XHEAD_TIE));
	var tieTo = cx.EnumTools.createFromString(nx3.enums.ETie,xml.get(nx3.io.HeadXML.XHEAD_TIETO));
	return new nx3.elements.Head(type,nx3.units._Level.Level_Impl_.inRange(level),sign,tie,tieTo);
}
nx3.io.HeadXML.test = function(item) {
	var str = nx3.io.HeadXML.toXml(item).toString();
	var item2 = nx3.io.HeadXML.fromXmlStr(str);
	var str2 = nx3.io.HeadXML.toXml(item2).toString();
	console.log(str);
	console.log(str2);
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
	xml.set("value",Std.string(note.value.value));
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
		var variant = cx.EnumTools.createFromString(nx3.enums.ENoteVariant,xml.get("variant"));
		var articulations = [];
		var articulationsStr = xml.get("articulations");
		if(articulationsStr != null) {
			var articulationStrings = articulationsStr.split(";");
			var _g = 0;
			while(_g < articulationStrings.length) {
				var articulationStr = articulationStrings[_g];
				++_g;
				articulations.push(cx.EnumTools.createFromString(nx3.enums.ENoteArticulation,articulationStr));
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
				attributes.push(cx.EnumTools.createFromString(nx3.enums.ENoteAttributes,attributeStr));
			}
		}
		if(attributes.length == 0) attributes = null;
		type = nx3.enums.ENoteType.Note(heads,variant,articulations,attributes);
		break;
	case "pause":
		var level = nx3.units._Level.Level_Impl_.inRange(Std.parseInt(xml.get("level")));
		type = nx3.enums.ENoteType.Pause(level);
		break;
	case "lyric":
		var text = xml.get("text");
		var offsetStr = xml.get("offset");
		var offset = cx.EnumTools.createFromString(nx3.enums.EPosition,offsetStr);
		var continuationStr = xml.get("continuation");
		var continuation = cx.EnumTools.createFromString(nx3.enums.ELyricContinuation,continuationStr);
		var formatStr = xml.get("format");
		var format = cx.EnumTools.createFromString(nx3.enums.ELyricFormat,formatStr);
		type = nx3.enums.ENoteType.Lyric(text,offset,continuation,format);
		break;
	}
	var val = Std.parseInt(xml.get("value"));
	var value = nx3.enums.ENoteValue.getFromValue(val);
	var direction = cx.EnumTools.createFromString(nx3.enums.EDirectionUD,xml.get("direction"));
	return new nx3.elements.Note(type,null,value,direction);
}
nx3.io.NoteXML.test = function(item) {
	var str = nx3.io.NoteXML.toXml(item).toString();
	var item2 = nx3.io.NoteXML.fromXmlStr(str);
	var str2 = nx3.io.NoteXML.toXml(item2).toString();
	console.log(str);
	console.log(str2);
	return str == str2;
}
nx3.render = {}
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
nx3.render.FontRenderer = function(target,scaling) {
	this.initTargetSprite(target,scaling);
};
$hxClasses["nx3.render.FontRenderer"] = nx3.render.FontRenderer;
nx3.render.FontRenderer.__name__ = ["nx3","render","FontRenderer"];
nx3.render.FontRenderer.__interfaces__ = [nx3.render.IRenderer];
nx3.render.FontRenderer.prototype = {
	signs: function(x,y,dcomplex) {
		if(dcomplex.get_signRects() == null) return;
		var signsX = x + dcomplex.get_signsFrame().x * this.scaling.halfNoteWidth;
		var _g1 = 0, _g = dcomplex.get_signRects().length;
		while(_g1 < _g) {
			var i = _g1++;
			var signRect = dcomplex.get_signRects()[i];
			var sign = dcomplex.signs[i].sign;
			var signStr = "sign" + Std.string(sign);
			var xmlStr = nx3.render.svg.ShapeTools.getElementStr(signStr);
			if(xmlStr == null) continue;
			var shape = nx3.render.svg.ShapeTools.getShape(xmlStr,this.scaling);
			if(shape == null) return;
			var r = signRect.toRectangle();
			var shapeX = signsX + (r.x + nx3.display.tools.SignsTools.adjustSignFontX(sign)) * this.scaling.halfNoteWidth + this.scaling.svgX;
			var shapeY = y + (r.y + 2) * this.scaling.halfSpace + this.scaling.svgY;
			shape.set_x(shapeX);
			shape.set_y(shapeY);
			this.target.addChild(shape);
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
	}
	,note: function(x,y,dnote) {
		this.stave(x,y,dnote);
		this.heads(x,y,dnote);
	}
	,heads: function(x,y,dnote) {
		var _g = 0, _g1 = dnote.get_headRects();
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			var xmlStr = null;
			var _g2 = dnote.get_value();
			switch( (_g2.type)[1] ) {
			case 2:
				xmlStr = nx3.render.svg.Elements.noteWhole;
				break;
			case 1:
				xmlStr = nx3.render.svg.Elements.noteWhite;
				break;
			default:
				xmlStr = nx3.render.svg.Elements.noteBlack;
			}
			var shape = nx3.render.svg.ShapeTools.getShape(xmlStr,this.scaling);
			if(shape == null) return;
			var r = rect.toRectangle();
			var shapeX = x + r.x * this.scaling.halfNoteWidth + this.scaling.svgX;
			var shapeY = y + r.y * this.scaling.halfSpace + this.scaling.svgY;
			shape.set_x(shapeX);
			shape.set_y(shapeY);
			this.target.addChild(shape);
		}
	}
	,stave: function(x,y,dnote) {
		this.target.get_graphics().lineStyle(this.scaling.linesWidth,0);
		var topY = y + dnote.get_headTop().level * this.scaling.halfSpace;
		var bottomY = y + dnote.get_headBottom().level * this.scaling.halfSpace;
		var staveLength = 6.8 * this.scaling.halfSpace;
		var staveX = x;
		var _g = dnote.get_direction();
		switch( (_g)[1] ) {
		case 0:
			staveX += (dnote.get_headsRect().x + dnote.get_headsRect().width) * this.scaling.halfNoteWidth;
			this.target.get_graphics().moveTo(staveX,bottomY);
			this.target.get_graphics().lineTo(staveX,topY - staveLength);
			break;
		case 1:
			staveX += dnote.get_headsRect().x * this.scaling.halfNoteWidth;
			this.target.get_graphics().moveTo(staveX,topY);
			this.target.get_graphics().lineTo(staveX,bottomY + staveLength);
			break;
		}
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
	,initTargetSprite: function(target,scaling) {
		this.target = target;
		this.scaling = scaling;
	}
	,target: null
	,scaling: null
	,__class__: nx3.render.FontRenderer
}
nx3.render.ISpriteRenderer = function() { }
$hxClasses["nx3.render.ISpriteRenderer"] = nx3.render.ISpriteRenderer;
nx3.render.ISpriteRenderer.__name__ = ["nx3","render","ISpriteRenderer"];
nx3.render.ISpriteRenderer.prototype = {
	initTargetSprite: null
	,__class__: nx3.render.ISpriteRenderer
}
nx3.render.FrameRenderer = function(target,scaling) {
	this.initTargetSprite(target,scaling);
};
$hxClasses["nx3.render.FrameRenderer"] = nx3.render.FrameRenderer;
nx3.render.FrameRenderer.__name__ = ["nx3","render","FrameRenderer"];
nx3.render.FrameRenderer.__interfaces__ = [nx3.render.ISpriteRenderer,nx3.render.IRenderer];
nx3.render.FrameRenderer.prototype = {
	signs: function(x,y,dcomplex) {
		if(dcomplex.get_signsFrame() != null) {
			this.target.get_graphics().lineStyle(1,16711680);
			var r = dcomplex.get_signsFrame().toRectangle();
			var signsX = x + r.x * this.scaling.halfNoteWidth;
			var r2 = new flash.geom.Rectangle(signsX,y + r.y * this.scaling.halfSpace,r.width * this.scaling.halfNoteWidth,r.height * this.scaling.halfSpace);
			r2.inflate(2,2);
			this.target.get_graphics().drawRect(r2.x,r2.y,r2.width,r2.height);
		}
		if(dcomplex.get_signRects() != null) {
			this.target.get_graphics().lineStyle(1,0);
			var signsX = x + dcomplex.get_signsFrame().x * this.scaling.halfNoteWidth;
			var _g = 0, _g1 = dcomplex.get_signRects();
			while(_g < _g1.length) {
				var signRect = _g1[_g];
				++_g;
				var r = signRect.toRectangle();
				var r2 = new flash.geom.Rectangle(signsX + r.x * this.scaling.halfNoteWidth,y + r.y * this.scaling.halfSpace,r.width * this.scaling.halfNoteWidth,r.height * this.scaling.halfSpace);
				this.target.get_graphics().drawRect(r2.x,r2.y,r2.width,r2.height);
			}
		}
	}
	,heads: function(x,y,dnote) {
		var headsX = x;
		this.target.get_graphics().lineStyle(1,11184895);
		var _g = 0, _g1 = dnote.get_headRects();
		while(_g < _g1.length) {
			var rect = _g1[_g];
			++_g;
			var r = rect.toRectangle();
			var rx = headsX + r.x * this.scaling.halfNoteWidth;
			this.target.get_graphics().drawRect(rx,y + r.y * this.scaling.halfSpace,r.width * this.scaling.halfNoteWidth,r.height * this.scaling.halfSpace);
		}
	}
	,stave: function(x,y,dnote) {
		this.target.get_graphics().lineStyle(this.scaling.linesWidth,0);
		var topY = y + dnote.get_headTop().level * this.scaling.halfSpace;
		var bottomY = y + dnote.get_headBottom().level * this.scaling.halfSpace;
		var staveLength = 6.8 * this.scaling.halfSpace;
		var staveX = x;
		var _g = dnote.get_direction();
		switch( (_g)[1] ) {
		case 0:
			staveX += (dnote.get_headsRect().x + dnote.get_headsRect().width) * this.scaling.halfNoteWidth;
			this.target.get_graphics().moveTo(staveX,bottomY);
			this.target.get_graphics().lineTo(staveX,topY - staveLength);
			break;
		case 1:
			staveX += dnote.get_headsRect().x * this.scaling.halfNoteWidth;
			this.target.get_graphics().moveTo(staveX,topY);
			this.target.get_graphics().lineTo(staveX,bottomY + staveLength);
			break;
		}
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
		this.target.get_graphics().lineStyle(1,255);
		var r = dcomplex.get_headsRect().toRectangle();
		var r2 = new flash.geom.Rectangle(x + r.x * this.scaling.halfNoteWidth,y + r.y * this.scaling.halfSpace,r.width * this.scaling.halfNoteWidth,r.height * this.scaling.halfSpace);
		r2.inflate(2,2);
		this.target.get_graphics().drawRect(r2.x,r2.y,r2.width,r2.height);
	}
	,note: function(x,y,dnote) {
		this.heads(x,y,dnote);
		this.stave(x,y,dnote);
		this.target.get_graphics().lineStyle(1,16755370);
		var r = dnote.get_headsRect().toRectangle();
		var r2 = new flash.geom.Rectangle(x + r.x * this.scaling.halfNoteWidth,y + r.y * this.scaling.halfSpace,r.width * this.scaling.halfNoteWidth,r.height * this.scaling.halfSpace);
		r2.inflate(2,2);
		this.target.get_graphics().drawRect(r2.x,r2.y,r2.width,r2.height);
		this.target.get_graphics().lineStyle(1,11184810);
		this.target.get_graphics().drawCircle(x,y,2);
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
nx3.render.MultiRenderer = function(target,scaling,renderers) {
	this.target = target;
	this.scaling = scaling;
	this.renderers = [];
	var _g = 0;
	while(_g < renderers.length) {
		var r = renderers[_g];
		++_g;
		var renderer = Type.createInstance(r,[target,scaling]);
		this.renderers.push(renderer);
	}
};
$hxClasses["nx3.render.MultiRenderer"] = nx3.render.MultiRenderer;
nx3.render.MultiRenderer.__name__ = ["nx3","render","MultiRenderer"];
nx3.render.MultiRenderer.__interfaces__ = [nx3.render.IRenderer];
nx3.render.MultiRenderer.prototype = {
	signs: function(x,y,dcomplex) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.signs(x,y,dcomplex);
		}
	}
	,complex: function(x,y,dcomplex) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.complex(x,y,dcomplex);
		}
	}
	,note: function(x,y,dnote) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.note(x,y,dnote);
		}
	}
	,heads: function(x,y,dnote) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.heads(x,y,dnote);
		}
	}
	,stave: function(x,y,dnote) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.stave(x,y,dnote);
		}
	}
	,notelines: function(x,y,width) {
		var _g = 0, _g1 = this.renderers;
		while(_g < _g1.length) {
			var r = _g1[_g];
			++_g;
			r.notelines(x,y,width);
		}
	}
	,renderers: null
	,scaling: null
	,target: null
	,__class__: nx3.render.MultiRenderer
}
nx3.render.scaling = {}
nx3.render.scaling.Scaling = function() { }
$hxClasses["nx3.render.scaling.Scaling"] = nx3.render.scaling.Scaling;
nx3.render.scaling.Scaling.__name__ = ["nx3","render","scaling","Scaling"];
nx3.render.svg = {}
nx3.render.svg.Elements = function() { }
$hxClasses["nx3.render.svg.Elements"] = nx3.render.svg.Elements;
nx3.render.svg.Elements.__name__ = ["nx3","render","svg","Elements"];
nx3.render.svg.ShapeTools = function() { }
$hxClasses["nx3.render.svg.ShapeTools"] = nx3.render.svg.ShapeTools;
nx3.render.svg.ShapeTools.__name__ = ["nx3","render","svg","ShapeTools"];
nx3.render.svg.ShapeTools.getShape = function(xmlStr,scaling) {
	if(xmlStr == null) return null;
	var svg = new format.svg.SVG2Gfx(Xml.parse(xmlStr));
	var shape = svg.createShape();
	shape.set_scaleX(shape.set_scaleY(scaling.svgScale));
	shape.cacheAsBitmap = true;
	return shape;
}
nx3.render.svg.ShapeTools.getElementStr = function(element) {
	try {
		var str = Reflect.field(nx3.render.svg.Elements,element);
		return str;
	} catch( err ) {
		return nx3.render.svg.Elements.noteBlack;
	}
	return null;
}
nx3.render.tools = {}
nx3.render.tools.RenderTools = function() { }
$hxClasses["nx3.render.tools.RenderTools"] = nx3.render.tools.RenderTools;
nx3.render.tools.RenderTools.__name__ = ["nx3","render","tools","RenderTools"];
nx3.render.tools.RenderTools.spriteToPng = function(sprite,filename,extraHeight) {
	if(extraHeight == null) extraHeight = 100;
}
nx3.units = {}
nx3.units.Constants = function() { }
$hxClasses["nx3.units.Constants"] = nx3.units.Constants;
nx3.units.Constants.__name__ = ["nx3","units","Constants"];
nx3.units._Level = {}
nx3.units._Level.Level_Impl_ = function() { }
$hxClasses["nx3.units._Level.Level_Impl_"] = nx3.units._Level.Level_Impl_;
nx3.units._Level.Level_Impl_.__name__ = ["nx3","units","_Level","Level_Impl_"];
nx3.units._Level.Level_Impl_._new = function(value) {
	return nx3.units._Level.Level_Impl_.inRange(value);
}
nx3.units._Level.Level_Impl_.fromInt = function(value) {
	return nx3.units._Level.Level_Impl_.inRange(value);
}
nx3.units._Level.Level_Impl_.toInt = function(this1) {
	return this1;
}
nx3.units._Level.Level_Impl_.add = function(l,h) {
	return nx3.units._Level.Level_Impl_.inRange(l + h);
}
nx3.units._Level.Level_Impl_.addPlusPlus = function(l) {
	return nx3.units._Level.Level_Impl_.inRange(l);
}
nx3.units._Level.Level_Impl_.addPlusPlusAfter = function(l) {
	return nx3.units._Level.Level_Impl_.inRange(l);
}
nx3.units._Level.Level_Impl_.addInteger = function(l,r) {
	return nx3.units._Level.Level_Impl_.inRange(l + r);
}
nx3.units._Level.Level_Impl_.addFloat = function(l,r) {
	return nx3.units._Level.Level_Impl_.inRange(l + r);
}
nx3.units._Level.Level_Impl_.gtFloat = function(l,r) {
	return l > r;
}
nx3.units._Level.Level_Impl_.gtInt = function(l,r) {
	return l > r;
}
nx3.units._Level.Level_Impl_.ltFloat = function(l,r) {
	return l < r;
}
nx3.units._Level.Level_Impl_.ltInt = function(l,r) {
	return l < r;
}
nx3.units._Level.Level_Impl_.inRange = function(value) {
	return Math.min(Math.max(value,nx3.units._Level.Level_Impl_.MIN_LEVEL),nx3.units._Level.Level_Impl_.MAX_LEVEL) | 0;
}
nx3.units.NRect = function(inX,inY,inWidth,inHeight) {
	if(inHeight == null) inHeight = 0;
	if(inWidth == null) inWidth = 0;
	if(inY == null) inY = 0;
	if(inX == null) inX = 0;
	this.x = inX;
	this.y = inY;
	this.width = inWidth;
	this.height = inHeight;
};
$hxClasses["nx3.units.NRect"] = nx3.units.NRect;
nx3.units.NRect.__name__ = ["nx3","units","NRect"];
nx3.units.NRect.prototype = {
	toRectangle: function() {
		return new flash.geom.Rectangle(this.x,this.y,this.width,this.height);
	}
	,set_top: function(t) {
		this.height = nx3.units._NY.NY_Impl_.sub(this.height,nx3.units._NY.NY_Impl_.sub(t,this.y));
		this.y = t;
		return t;
	}
	,get_top: function() {
		return this.y;
	}
	,set_right: function(r) {
		this.width = nx3.units._NX.NX_Impl_.sub(r,this.x);
		return r;
	}
	,get_right: function() {
		return nx3.units._NX.NX_Impl_.add(this.x,this.width);
	}
	,set_left: function(l) {
		this.width = nx3.units._NX.NX_Impl_.sub(this.width,nx3.units._NX.NX_Impl_.sub(l,this.x));
		this.x = l;
		return l;
	}
	,get_left: function() {
		return this.x;
	}
	,set_bottom: function(b) {
		this.height = nx3.units._NY.NY_Impl_.sub(b,this.y);
		return b;
	}
	,get_bottom: function() {
		return nx3.units._NY.NY_Impl_.add(this.y,this.height);
	}
	,union: function(toUnion) {
		var x0 = nx3.units._NX.NX_Impl_.gt(this.x,toUnion.x)?toUnion.x:this.x;
		var x1 = nx3.units._NX.NX_Impl_.lt(this.get_right(),toUnion.get_right())?toUnion.get_right():this.get_right();
		var y0 = nx3.units._NY.NY_Impl_.gt(this.y,toUnion.y)?toUnion.y:this.y;
		var y1 = nx3.units._NY.NY_Impl_.lt(this.get_bottom(),toUnion.get_bottom())?toUnion.get_bottom():this.get_bottom();
		return new nx3.units.NRect(x0,y0,nx3.units._NX.NX_Impl_.sub(x1,x0),nx3.units._NY.NY_Impl_.sub(y1,y0));
	}
	,offset: function(dx,dy) {
		this.x = nx3.units._NX.NX_Impl_.add(this.x,dx);
		this.y = nx3.units._NY.NY_Impl_.add(this.y,dy);
	}
	,intersects: function(toIntersect) {
		var x0 = nx3.units._NX.NX_Impl_.lt(this.x,toIntersect.x)?toIntersect.x:this.x;
		var x1 = nx3.units._NX.NX_Impl_.gt(this.get_right(),toIntersect.get_right())?toIntersect.get_right():this.get_right();
		if(nx3.units._NX.NX_Impl_.lt_like(x1,x0)) return false;
		var y0 = nx3.units._NY.NY_Impl_.lt(this.y,toIntersect.y)?toIntersect.y:this.y;
		var y1 = nx3.units._NY.NY_Impl_.gt(this.get_bottom(),toIntersect.get_bottom())?toIntersect.get_bottom():this.get_bottom();
		return nx3.units._NY.NY_Impl_.gt(y1,y0);
	}
	,intersection: function(toIntersect) {
		var x0 = nx3.units._NX.NX_Impl_.lt(this.x,toIntersect.x)?toIntersect.x:this.x;
		var x1 = nx3.units._NX.NX_Impl_.gt(this.get_right(),toIntersect.get_right())?toIntersect.get_right():this.get_right();
		if(nx3.units._NX.NX_Impl_.lt_like(x1,x0)) return new nx3.units.NRect();
		var y0 = nx3.units._NY.NY_Impl_.lt(this.y,toIntersect.y)?toIntersect.y:this.y;
		var y1 = nx3.units._NY.NY_Impl_.gt(this.get_bottom(),toIntersect.get_bottom())?toIntersect.get_bottom():this.get_bottom();
		if(nx3.units._NY.NY_Impl_.lt_like(y1,y0)) return new nx3.units.NRect();
		return new nx3.units.NRect(x0,y0,nx3.units._NX.NX_Impl_.sub(x1,x0),nx3.units._NY.NY_Impl_.sub(y1,y0));
	}
	,inflate: function(dx,dy) {
		this.x = nx3.units._NX.NX_Impl_.sub(this.x,dx);
		this.width = nx3.units._NX.NX_Impl_.add(this.width,nx3.units._NX.NX_Impl_.mulInt(dx,2));
		this.y = nx3.units._NY.NY_Impl_.sub(this.y,dy);
		this.height = nx3.units._NY.NY_Impl_.add(this.height,nx3.units._NY.NY_Impl_.mulInt(dy,2));
	}
	,equals: function(toCompare) {
		return this.x == toCompare.x && this.y == toCompare.y && this.width == toCompare.width && this.height == toCompare.height;
	}
	,contains: function(inX,inY) {
		return nx3.units._NX.NX_Impl_.gt_like(inX,this.x) && nx3.units._NY.NY_Impl_.gt_like(inY,this.y) && nx3.units._NX.NX_Impl_.lt(inX,this.get_right()) && nx3.units._NY.NY_Impl_.lt(inY,this.get_bottom());
	}
	,clone: function() {
		return new nx3.units.NRect(this.x,this.y,this.width,this.height);
	}
	,height: null
	,width: null
	,y: null
	,x: null
	,__class__: nx3.units.NRect
	,__properties__: {set_bottom:"set_bottom",get_bottom:"get_bottom",set_top:"set_top",get_top:"get_top",set_left:"set_left",get_left:"get_left",set_right:"set_right",get_right:"get_right"}
}
nx3.units._NX = {}
nx3.units._NX.NX_Impl_ = function() { }
$hxClasses["nx3.units._NX.NX_Impl_"] = nx3.units._NX.NX_Impl_;
nx3.units._NX.NX_Impl_.__name__ = ["nx3","units","_NX","NX_Impl_"];
nx3.units._NX.NX_Impl_._new = function(value) {
	return value;
}
nx3.units._NX.NX_Impl_.fromFloat = function(value) {
	return value;
}
nx3.units._NX.NX_Impl_.toFloat = function(this1) {
	return this1;
}
nx3.units._NX.NX_Impl_.fromX = function(value) {
	return value / 1;
}
nx3.units._NX.NX_Impl_.toX = function(this1) {
	return this1;
}
nx3.units._NX.NX_Impl_.sw = function(x1) {
	return -x1;
}
nx3.units._NX.NX_Impl_.add = function(x1,x2) {
	return x1 + x2;
}
nx3.units._NX.NX_Impl_.sub = function(x1,x2) {
	return x1 - x2;
}
nx3.units._NX.NX_Impl_.mul = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NX.NX_Impl_.mulFloat = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NX.NX_Impl_.mulInt = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NX.NX_Impl_.div = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NX.NX_Impl_.divFloat = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NX.NX_Impl_.divInt = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NX.NX_Impl_.gt_like = function(x1,x2) {
	return x1 >= x2;
}
nx3.units._NX.NX_Impl_.lt_like = function(x1,x2) {
	return x1 <= x2;
}
nx3.units._NX.NX_Impl_.lt = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NX.NX_Impl_.ltFloat = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NX.NX_Impl_.ltInt = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NX.NX_Impl_.gt = function(x1,x2) {
	return x1 > x2;
}
nx3.units._NX.NX_Impl_.gtFloat = function(x1,x2) {
	return x1 > x2;
}
nx3.units._NX.NX_Impl_.gtInt = function(x1,x2) {
	return x1 > x2;
}
nx3.units._NY = {}
nx3.units._NY.NY_Impl_ = function() { }
$hxClasses["nx3.units._NY.NY_Impl_"] = nx3.units._NY.NY_Impl_;
nx3.units._NY.NY_Impl_.__name__ = ["nx3","units","_NY","NY_Impl_"];
nx3.units._NY.NY_Impl_._new = function(value) {
	return value;
}
nx3.units._NY.NY_Impl_.fromFloat = function(value) {
	return value;
}
nx3.units._NY.NY_Impl_.fromInt = function(value) {
	return value;
}
nx3.units._NY.NY_Impl_.toFloat = function(this1) {
	return this1;
}
nx3.units._NY.NY_Impl_.fromX = function(value) {
	return value / 1;
}
nx3.units._NY.NY_Impl_.toY = function(this1) {
	return this1;
}
nx3.units._NY.NY_Impl_.add = function(x1,x2) {
	return x1 + x2;
}
nx3.units._NY.NY_Impl_.sub = function(x1,x2) {
	return x1 - x2;
}
nx3.units._NY.NY_Impl_.mul = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NY.NY_Impl_.mulFloat = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NY.NY_Impl_.mulInt = function(x1,x2) {
	return x1 * x2;
}
nx3.units._NY.NY_Impl_.div = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NY.NY_Impl_.divFloat = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NY.NY_Impl_.divInt = function(x1,x2) {
	return x1 / x2;
}
nx3.units._NY.NY_Impl_.gt_like = function(x1,x2) {
	return x1 >= x2;
}
nx3.units._NY.NY_Impl_.lt_like = function(x1,x2) {
	return x1 <= x2;
}
nx3.units._NY.NY_Impl_.lt = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NY.NY_Impl_.ltFloat = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NY.NY_Impl_.ltInt = function(x1,x2) {
	return x1 < x2;
}
nx3.units._NY.NY_Impl_.gt = function(x1,x2) {
	return x1 > x2;
}
nx3.units._NY.NY_Impl_.gtFloat = function(x1,x2) {
	return x1 > x2;
}
nx3.units._NY.NY_Impl_.gtInt = function(x1,x2) {
	return x1 > x2;
}
var openfl = {}
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
format.gfx.GfxBytes.EOF = 0;
format.gfx.GfxBytes.SIZE = 1;
format.gfx.GfxBytes.BEGIN_FILL = 10;
format.gfx.GfxBytes.GRADIENT_FILL = 11;
format.gfx.GfxBytes.END_FILL = 12;
format.gfx.GfxBytes.LINE_STYLE = 20;
format.gfx.GfxBytes.END_LINE_STYLE = 21;
format.gfx.GfxBytes.MOVE = 30;
format.gfx.GfxBytes.LINE = 31;
format.gfx.GfxBytes.CURVE = 32;
format.gfx.GfxBytes.base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
format.gfx.GfxBytes.scaleModes = [flash.display.LineScaleMode.NORMAL,flash.display.LineScaleMode.NONE,flash.display.LineScaleMode.VERTICAL,flash.display.LineScaleMode.HORIZONTAL];
format.gfx.GfxBytes.capsStyles = [flash.display.CapsStyle.ROUND,flash.display.CapsStyle.NONE,flash.display.CapsStyle.SQUARE];
format.gfx.GfxBytes.jointStyles = [flash.display.JointStyle.ROUND,flash.display.JointStyle.MITER,flash.display.JointStyle.BEVEL];
format.gfx.GfxBytes.spreadMethods = [flash.display.SpreadMethod.PAD,flash.display.SpreadMethod.REPEAT,flash.display.SpreadMethod.REFLECT];
format.gfx.GfxBytes.interpolationMethods = [flash.display.InterpolationMethod.RGB,flash.display.InterpolationMethod.LINEAR_RGB];
format.svg.PathParser.MOVE = 77;
format.svg.PathParser.MOVER = 109;
format.svg.PathParser.LINE = 76;
format.svg.PathParser.LINER = 108;
format.svg.PathParser.HLINE = 72;
format.svg.PathParser.HLINER = 104;
format.svg.PathParser.VLINE = 86;
format.svg.PathParser.VLINER = 118;
format.svg.PathParser.CUBIC = 67;
format.svg.PathParser.CUBICR = 99;
format.svg.PathParser.SCUBIC = 83;
format.svg.PathParser.SCUBICR = 115;
format.svg.PathParser.QUAD = 81;
format.svg.PathParser.QUADR = 113;
format.svg.PathParser.SQUAD = 84;
format.svg.PathParser.SQUADR = 116;
format.svg.PathParser.ARC = 65;
format.svg.PathParser.ARCR = 97;
format.svg.PathParser.CLOSE = 90;
format.svg.PathParser.CLOSER = 122;
format.svg.PathParser.UNKNOWN = -1;
format.svg.PathParser.SEPARATOR = -2;
format.svg.PathParser.FLOAT = -3;
format.svg.PathParser.FLOAT_SIGN = -4;
format.svg.PathParser.FLOAT_DOT = -5;
format.svg.PathParser.FLOAT_EXP = -6;
format.svg.PathSegment.MOVE = 1;
format.svg.PathSegment.DRAW = 2;
format.svg.PathSegment.CURVE = 3;
format.svg.PathSegment.CUBIC = 4;
format.svg.PathSegment.ARC = 5;
format.svg.SVGData.SIN45 = 0.70710678118654752440084436210485;
format.svg.SVGData.TAN22 = 0.4142135623730950488016887242097;
format.svg.SVGData.mStyleSplit = new EReg(";","g");
format.svg.SVGData.mStyleValue = new EReg("\\s*(.*)\\s*:\\s*(.*)\\s*","");
format.svg.SVGData.mTranslateMatch = new EReg("translate\\((.*)[, ](.*)\\)","");
format.svg.SVGData.mScaleMatch = new EReg("scale\\((.*)\\)","");
format.svg.SVGData.mMatrixMatch = new EReg("matrix\\((.*)[, ](.*)[, ](.*)[, ](.*)[, ](.*)[, ](.*)\\)","");
format.svg.SVGData.mURLMatch = new EReg("url\\(#(.*)\\)","");
format.svg.SVGData.defaultFill = format.svg.FillType.FillSolid(0);
haxe.Template.splitter = new EReg("(::[A-Za-z0-9_ ()&|!+=/><*.\"-]+::|\\$\\$([A-Za-z0-9_-]+)\\()","");
haxe.Template.expr_splitter = new EReg("(\\(|\\)|[ \r\n\t]*\"[^\"]*\"[ \r\n\t]*|[!+=/><*.&|-]+)","");
haxe.Template.expr_trim = new EReg("^[ ]*([^ ]+)[ ]*$","");
haxe.Template.expr_int = new EReg("^[0-9]+$","");
haxe.Template.expr_float = new EReg("^([+-]?)(?=\\d|,\\d)\\d*(,\\d*)?([Ee]([+-]?\\d+))?$","");
haxe.Template.globals = { };
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
nx3.display.DComplex.SECOND_CLASH_ADJUST_X = 3.0;
nx3.display.DComplex.THIRD_CLASH_ADJUST_X = 4.0;
nx3.display.tools.SignsTools.BREAKPOINT = 5;
nx3.enums.ENoteValue.DOT = 1.5;
nx3.enums.ENoteValue.DOTDOT = 1.75;
nx3.enums.ENoteValue.TRI = 2 / 3;
nx3.enums.ENoteValue.N1 = 4;
nx3.enums.ENoteValue.N2 = 2;
nx3.enums.ENoteValue.N8 = .5;
nx3.enums.ENoteValue.N16 = .25;
nx3.enums.ENoteValue.N32 = .125;
nx3.enums.ENoteValue.Nv1 = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N1 * 3024,nx3.enums.EHeadValuetype.HVT1);
nx3.enums.ENoteValue.Nv1dot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT1);
nx3.enums.ENoteValue.Nv1ddot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT1);
nx3.enums.ENoteValue.Nv1tri = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N1 * 3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT1);
nx3.enums.ENoteValue.Nv2 = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N2 * 3024,nx3.enums.EHeadValuetype.HVT2);
nx3.enums.ENoteValue.Nv2dot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT2);
nx3.enums.ENoteValue.Nv2ddot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT2);
nx3.enums.ENoteValue.Nv2tri = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N2 * 3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT2);
nx3.enums.ENoteValue.Nv4 = new nx3.enums.ENoteValue(3024,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv4dot = new nx3.enums.ENoteValue(3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv4ddot = new nx3.enums.ENoteValue(3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv4tri = new nx3.enums.ENoteValue(3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv8 = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N8 * 3024,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv8dot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv8ddot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv8tri = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N8 * 3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv16 = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N16 * 3024,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv16dot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv16ddot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv16tri = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N16 * 3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv32 = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N32 * 3024,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv32dot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.DOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv32ddot = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.DOTDOT,nx3.enums.EHeadValuetype.HVT4);
nx3.enums.ENoteValue.Nv32tri = new nx3.enums.ENoteValue(nx3.enums.ENoteValue.N32 * 3024 * nx3.enums.ENoteValue.TRI,nx3.enums.EHeadValuetype.HVT4);
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
nx3.io.NoteXML.XNOTE_TYPE_NOTE_VARIANT = "variant";
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
nx3.render.scaling.Scaling.NORMAL = { linesWidth : .5, space : 8.0, halfSpace : 4.0, noteWidth : 7.0, halfNoteWidth : 3.5, quarterNoteWidth : 1.75, signPosWidth : 9.5, svgScale : .175, svgX : -5.5, svgY : -40.0, fontScaling : 4.0};
nx3.render.scaling.Scaling.SMALL = { linesWidth : .5, space : 6.0, halfSpace : 3.0, noteWidth : 5.0, halfNoteWidth : 2.5, quarterNoteWidth : 1.25, signPosWidth : 7.0, svgScale : .14, svgX : -5.0, svgY : -32.0, fontScaling : 3.0};
nx3.render.svg.Elements.clefG = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"m 95.72971,266.7949 c -5.57504,2.79274 -12.48498,4.1891 -20.72511,4.1891 -9.69981,0 -18.99938,-1.66998 -27.91049,-5.00757 -8.90876,-3.33996 -16.75807,-7.86163 -23.54558,-13.56975 -6.78751,-5.70339 -12.24248,-12.38094 -16.36254,-20.03029 -4.12007,-7.64934 -6.1801,-15.78458 -6.1801,-24.40572 0,-29.26234 20.72746,-61.31506 62.18472,-96.1605 -1.3349,-5.34251 -2.33313,-10.74399 -2.99941,-16.209153 -0.66627,-5.460449 -1.00058,-11.107236 -1.00058,-16.938007 0,-8.010226 0.66392,-15.871864 1.99646,-23.582532 1.3302,-7.710668 3.23955,-14.935434 5.72336,-21.674325 2.48617,-6.738864 5.54208,-12.869193 9.17715,-18.393316 3.63272,-5.5265031 7.814,-10.1708424 12.53677,-13.9306366 16.47555,22.8253826 24.71097,44.6247216 24.71097,65.3862176 0,13.480109 -3.18069,26.321 -9.54442,38.522682 -6.36138,12.20404 -16.32959,24.07079 -29.90225,35.60967 l 7.99763,38.42834 c 4.36256,-0.35616 6.78751,-0.53307 7.2725,-0.53307 6.05767,0 11.72453,1.09209 16.99586,3.27863 5.27368,2.18418 9.88109,5.18919 13.82693,9.01269 3.94349,3.82349 7.07003,8.34517 9.37727,13.56502 2.30488,5.21986 3.4585,10.86193 3.46085,16.93329 -0.002,4.36836 -0.78869,8.68011 -2.36374,12.92581 -1.57504,4.25042 -3.814,8.28856 -6.72159,12.10969 -2.90994,3.82586 -6.36373,7.34272 -10.36137,10.55766 -3.99764,3.21965 -8.42141,5.98172 -13.26896,8.28856 0,-0.24294 0.18129,0.45523 0.54385,2.09218 0.36492,1.63932 0.8193,3.79048 1.36315,6.46291 0.5462,2.67008 1.18187,5.64443 1.90935,8.92306 0.72749,3.27626 1.36316,6.43224 1.90936,9.46556 0.5462,3.03568 1.02884,5.73878 1.45497,8.10222 0.42378,2.37052 0.63567,3.97681 0.63567,4.82595 0,5.70576 -1.21248,10.92561 -3.63508,15.65957 -2.42495,4.73396 -5.69746,8.80041 -9.81988,12.19933 -4.12006,3.39656 -8.90875,6.03833 -14.36136,7.9206 -5.45497,1.88226 -11.21364,2.82339 -17.27602,2.82339 -4.60506,0 -8.90641,-0.72885 -12.90875,-2.18654 -4,-1.45769 -7.515,-3.52157 -10.54502,-6.18929 -3.02765,-2.67244 -5.422,-5.91568 -7.18068,-9.73918 -1.75632,-3.82113 -2.63449,-8.03853 -2.63449,-12.64984 0,-3.27862 0.54621,-6.37563 1.63626,-9.2863 1.09005,-2.91066 2.60623,-5.39912 4.54384,-7.463 1.93996,-2.06389 4.3037,-3.7032 7.09122,-4.91323 2.78987,-1.21474 5.81989,-1.82329 9.09004,-1.82329 2.90994,0 5.63625,0.66988 8.18127,2.00492 2.54502,1.33503 4.72748,3.06634 6.54502,5.18919 1.81754,2.12521 3.27251,4.5547 4.36491,7.2861 1.09005,2.72905 1.63626,5.49111 1.63626,8.28384 0,6.31431 -2.33314,11.4752 -7.00176,15.48267 -4.66627,4.00512 -10.51205,6.37328 -17.54441,7.09976 5.57504,2.79509 11.329,4.19146 17.2666,4.1891 4.8452,0.002 9.57268,-0.87745 14.17773,-2.64177 4.6027,-1.75961 8.62859,-4.12777 12.08474,-7.10212 3.45379,-2.97436 6.24131,-6.43932 8.3602,-10.38547 2.11889,-3.94614 3.18069,-8.16354 3.18069,-12.65692 0,-1.70299 -0.18365,-3.58526 -0.54385,-5.64914 L 95.72971,266.7949 z M 95.18821,27.488123 c -1.21483,-0.243068 -2.30724,-0.365597 -3.27486,-0.365597 -3.75986,0 -7.24661,1.912917 -10.46026,5.738777 -3.21365,3.823478 -6.00352,8.80275 -8.36726,14.933079 -2.36374,6.132684 -4.21188,13.022518 -5.54914,20.671856 -1.33254,7.649365 -2.00117,15.298698 -2.00117,22.948042 0,3.158334 0.12478,6.194011 0.36492,9.10704 0.24485,2.91538 0.67333,5.70811 1.2831,8.37819 24.73216,-21.976242 37.09942,-41.768292 37.09942,-59.373819 0,-8.378205 -3.03237,-15.723276 -9.09475,-22.037568 z m 3.814,231.850857 c 5.94467,-4.37072 10.46026,-9.16837 13.55619,-14.39058 3.09123,-5.21986 4.63802,-10.86429 4.63802,-16.93801 0,-3.76216 -0.63802,-7.4347 -1.91171,-11.01996 -1.27134,-3.57818 -3.08887,-6.76718 -5.45497,-9.56227 -2.36609,-2.78801 -5.18657,-5.03588 -8.46143,-6.7318 -3.27486,-1.69828 -6.85108,-2.54506 -10.72865,-2.54506 -0.24249,0 -0.72749,0.0307 -1.45497,0.0873 -0.72513,0.0613 -1.75633,0.15097 -3.08887,0.2689 l 12.90639,60.83151 z M 81.56374,199.26225 c -3.75749,0.48354 -7.2725,1.42468 -10.545,2.82104 -3.27251,1.39637 -6.08828,3.12767 -8.45202,5.19155 -2.36374,2.06389 -4.24249,4.43205 -5.63625,7.10212 -1.39376,2.67244 -2.09064,5.58546 -2.09064,8.7438 0,9.34762 4.96527,17.11962 14.88874,23.31127 -8.24013,-1.33503 -14.84636,-4.52167 -19.81634,-9.56227 -4.96997,-5.03823 -7.45378,-11.38084 -7.45378,-19.03255 0,-4.49101 0.93937,-8.83106 2.81812,-13.02016 1.87875,-4.18909 4.39317,-7.95598 7.54325,-11.30065 3.15479,-3.34703 6.85108,-6.23647 11.09121,-8.66595 4.24249,-2.43421 8.72748,-4.13721 13.45261,-5.10664 l -7.63507,-36.42579 c -17.08768,12.86684 -30.02468,25.49546 -38.81101,37.88112 -8.78633,12.38567 -13.1795,24.64868 -13.1795,36.79139 0,6.67755 1.48322,12.99421 4.45438,18.94292 2.97115,5.95106 6.9735,11.14026 12.00469,15.5723 5.03119,4.4344 10.85107,7.92531 17.45966,10.47274 6.60623,2.55214 13.60563,3.82821 20.9982,3.82821 4.24249,0 8.18127,-0.39627 11.81634,-1.18408 3.63743,-0.79017 7.03001,-2.03558 10.1801,-3.73386 L 81.56374,199.26225 z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.clefC = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"M 90,276 C 86,276 81,275 77,274 73,273 70,271 67,268 64,266 61,263 60,260 58,256 57,253 57,249 57,247 57,245 58,243 59,241 60,239 61,238 63,236 64,235 66,234 68,233 70,232 72,232 74,232 76,233 77,233 79,234 81,236 82,237 84,238 85,240 86,242 87,244 87,246 87,248 87,250 86,252 85,253 84,255 82,256 80,258 79,259 77,260 76,261 75,262 74,262 74,263 74,267 79,269 88,269 92,269 96,268 98,267 101,266 103,264 105,261 107,258 108,255 109,250 110,245 110,239 110,232 110,228 110,224 109,220 108,216 107,212 105,210 104,207 102,204 100,203 98,201 96,200 93,200 84,200 76,207 67,222 66,217 65,213 64,209 63,205 62,201 60,199 59,196 57,193 55,192 53,190 52,189 49,189 48,189 47,189 46,190 L 46,275 39,275 39,93 46,93 46,179 C 46,179 47,179 47,179 48,180 48,180 49,180 51,180 53,179 55,177 57,175 59,173 60,170 62,167 63,163 64,159 65,155 66,151 67,147 77,160 86,166 92,166 94,166 97,165 99,164 101,162 103,160 104,157 106,155 107,151 108,148 109,144 109,140 109,135 109,128 109,122 108,117 107,113 106,109 104,107 102,104 99,102 96,101 93,100 89,100 84,100 75,100 71,102 71,105 71,106 73,107 75,108 80,110 83,112 85,114 86,116 87,118 87,121 87,123 87,124 86,126 85,128 84,130 83,131 81,133 80,134 78,135 76,136 74,137 72,137 68,137 64,135 61,132 58,129 56,125 56,120 56,114 58,108 62,102 66,98 70,95 74,94 79,93 83,92 88,92 95,92 101,93 106,95 112,96 116,99 120,102 124,105 127,110 129,114 131,119 132,125 132,131 132,136 131,142 129,147 128,152 125,157 122,161 119,165 116,168 112,170 108,173 103,174 98,174 89,174 81,172 76,169 L 76,169 C 74,169 72,170 71,173 70,175 69,178 69,182 69,184 69,186 69,188 70,191 70,193 71,194 72,196 72,197 73,198 74,199 75,200 76,200 79,197 82,194 86,193 89,191 93,190 97,190 102,190 107,191 111,194 116,196 120,200 123,204 126,209 129,214 130,219 132,225 133,231 133,237 133,250 129,259 122,266 114,273 104,276 90,276 Z M 27,93 L 27,275 4,275 4,93 27,93 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.clefF = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"M 8,240 C 21,236 32,230 39,224 45,218 51,211 57,204 62,197 67,190 70,183 74,176 77,168 79,161 81,153 82,146 82,139 82,133 81,127 80,122 78,118 76,113 73,110 70,106 66,103 62,101 58,99 53,98 48,98 44,98 41,99 37,100 33,101 30,103 27,106 24,108 22,111 20,114 18,117 17,120 17,123 17,125 17,126 18,126 18,126 18,126 19,125 20,125 20,124 22,123 23,123 24,122 26,122 27,121 29,121 31,121 33,121 35,121 36,122 38,123 40,124 41,126 42,127 43,129 44,131 45,133 45,135 45,137 45,143 43,147 40,151 36,155 32,157 26,157 23,157 20,156 18,155 16,154 14,152 12,149 10,147 9,144 8,141 7,138 7,134 7,131 7,126 8,121 11,116 13,111 16,107 21,104 25,101 29,98 35,96 40,94 46,93 52,93 62,93 71,95 78,98 85,101 91,105 95,111 99,116 102,122 104,128 105,134 106,140 106,147 106,150 106,154 105,157 105,161 104,164 102,168 101,172 99,176 97,180 94,185 91,190 88,195 84,202 78,209 71,215 64,221 57,226 50,230 43,235 36,238 29,240 23,243 18,244 14,244 10,244 8,243 8,240 Z M 121,116 C 121,113 122,111 124,110 125,108 127,107 130,107 133,107 135,108 136,110 138,111 139,113 139,116 139,119 138,121 136,122 135,124 133,125 130,125 127,125 125,124 124,122 122,121 121,119 121,116 Z M 121,162 C 121,159 122,157 124,156 125,154 127,153 130,153 133,153 135,154 136,156 138,157 139,159 139,162 139,165 138,167 136,168 135,170 133,171 130,171 127,171 125,170 124,168 122,167 121,165 121,162 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.HVT4 = nx3.render.svg.Elements.noteBlack;
nx3.render.svg.Elements.noteBlack = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td = \"m 20.557649,250.57631 c -5.81753,-0.002 -10.6650905,-1.36806 -14.5450105,-4.0971 -3.87756,-2.73612 -5.81516995,-6.6516 -5.81516995,-11.74881 0,-4.12777 1.30193995,-8.10458 3.90816995,-11.92807 2.60387,-3.82585 5.9069905,-7.19411 9.9070005,-10.1095 3.99998,-2.91302 8.452014,-5.24816 13.360774,-7.01013 4.90876,-1.7596 9.66448,-2.63941 14.2719,-2.63941 6.1801,0 11.17834,1.42467 14.99703,4.27637 3.81636,2.85406 5.72572,6.70821 5.72572,11.56483 0,4.00747 -1.30195,7.92295 -3.90817,11.7488 -2.60623,3.8235 -5.93761,7.19412 -9.99882,10.10714 -4.05885,2.91303 -8.54382,5.27883 -13.45258,7.10448 -4.90878,1.81858 -9.72573,2.72905 -14.450844,2.7314 z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.HVT2 = nx3.render.svg.Elements.noteWhite;
nx3.render.svg.Elements.noteWhite = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"m -0.01820308,235.29885 c 0,-4.12777 1.15125988,-8.19421 3.45376988,-12.20168 2.30253,-4.00747 5.3325496,-7.55735 9.0900592,-10.65436 3.7575,-3.09701 7.96936,-5.58546 12.63565,-7.46772 4.66627,-1.88227 9.30428,-2.8234 13.90934,-2.8234 7.63741,0 13.69743,1.60865 18.18243,4.82831 4.48262,3.2173 6.72393,7.73898 6.72863,13.56739 -0.005,4.25042 -1.21482,8.25553 -3.63977,12.02006 -2.4226,3.76452 -5.57504,7.04315 -9.4526,9.83588 -3.87756,2.79037 -8.30134,5.00522 -13.27367,6.64689 -4.96763,1.63695 -10.06001,2.45779 -15.27249,2.46015 -6.18245,-0.002 -11.45615,-1.42939 -15.8186992,-4.28109 -4.36254,-2.85641 -6.54264988,-6.83322 -6.54264988,-11.93043 z M 49.439026,207.62158 c -1.93759,0 -4.39551,0.48589 -7.3643,1.45769 -2.97117,0.96944 -6.15186,2.2455 -9.54915,3.82113 -3.39257,1.57799 -6.75924,3.39893 -10.09297,5.46517 -3.33606,2.06388 -6.36843,4.18438 -9.09475,6.37091 -2.731,2.18182 -4.9417295,4.39902 -6.6391792,6.64453 -1.69512,2.24787 -2.54502,4.28109 -2.54738,6.10202 0.002,5.7034 3.4561299,8.55746 10.3684392,8.55746 3.27486,0 7.45849,-1.06143 12.55087,-3.18664 5.09241,-2.12285 10.0624,-4.73396 14.91464,-7.82861 4.84756,-3.097 9.03119,-6.34497 12.54619,-9.74153 3.51735,-3.40128 5.27603,-6.4346 5.27603,-9.10468 0,-5.7034 -3.45377,-8.55745 -10.36844,-8.55745 z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.HVT1 = nx3.render.svg.Elements.noteWhole;
nx3.render.svg.Elements.noteWhole = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"m 0.14197458,226.9183 c 0,-3.64187 1.21011002,-6.97946 3.63271012,-10.01514 2.4226,-3.03568 5.66217,-5.64679 9.7233503,-7.83569 4.0565,-2.18182 8.692204,-3.85179 13.899944,-5.00757 5.21012,-1.15106 10.54031,-1.72894 15.99057,-1.7313 5.09006,0.002 10.08827,0.64157 14.99232,1.91292 4.9064,1.27843 9.32782,3.00738 13.26661,5.19156 3.93643,2.18653 7.11712,4.76698 9.54208,7.74133 2.42025,2.97671 3.63271,6.22468 3.63271,9.74389 0,3.88718 -1.0312,7.34743 -3.08885,10.38311 -2.06004,3.03568 -4.99825,5.58546 -8.81461,7.64935 -3.81636,2.06388 -8.38843,3.67253 -13.71862,4.8283 -5.33019,1.15106 -11.26544,1.72895 -17.8081,1.73131 -5.81517,-0.002 -11.23482,-0.58025 -16.26603,-1.73131 -5.026479,-1.15577 -9.389044,-2.79508 -13.082984,-4.9203 -3.6962903,-2.12521 -6.6015203,-4.70565 -8.7204103,-7.73897 -2.1212401,-3.03568 -3.18069012,-6.43696 -3.18069012,-10.20149 z m 65.06407442,9.28158 c 0,-4.00511 -1.39376,-8.80276 -4.18363,-14.38822 -1.33254,-2.67007 -2.75691,-5.00757 -4.27074,-7.01248 -1.51618,-2.00256 -3.18305,-3.61121 -5.00057,-4.82595 -1.81754,-1.21239 -3.90817,-2.12522 -6.27193,-2.73141 -2.36373,-0.60619 -5.06179,-0.91047 -8.09181,-0.91047 -11.63506,0 -17.452602,4.675 -17.452602,14.02498 0,3.51922 0.696896,6.88984 2.090662,10.10714 1.39376,3.2173 3.24189,6.10202 5.54443,8.6518 2.30253,2.54978 4.84756,4.583 7.63508,6.09966 2.78751,1.51902 5.63859,2.27853 8.54853,2.27853 2.6651,0 5.17951,-0.12266 7.54324,-0.3656 2.36376,-0.24296 4.485,-0.72885 6.36375,-1.45769 1.8811,-0.72649 3.48674,-1.8516 4.81694,-3.36826 1.33489,-1.51666 2.24367,-3.55224 2.72865,-6.10203 z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.signNatural = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline\"\r\n\t\t\td=\"m 27.763524,289.1105 0,-36.43051 -27.82574358,9.65191 0,-97.8116 4.52499988,0 0.0183,36.60977 27.8092637,-9.83589 0,97.81632 -4.52736,0 z m -23.3007437,-42.80378 23.3007437,-8.38055 -0.0157,-30.60209 -23.2842537,8.55981 0,30.42283 z\" />\t\r\n\t\t</g></svg>";
nx3.render.svg.Elements.signSharp = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline\"\r\n\t\t\td=\"m 31.526296,208.23455 -17.48556,5.8284 0.0157,31.51021 17.46908,-5.82841 0,-31.5102 z m 4.52736,-43.89588 0.0131,26.0474 9.44083,-3.09464 0,16.5724 -9.4526,3.097 0,31.50785 9.4526,-3.09701 0,16.57476 -9.4526,3.09701 0,28.59482 -4.52736,0 0,-27.32111 -17.48556,5.82841 0,27.31875 -4.52736,0 0,-26.04268 -9.4526,3.09464 0,-16.57239 9.4526,-3.09701 -0.0131,-31.50785 -9.43847,3.09465 0,-16.5724 9.4526,-3.09701 0,-28.59482 4.52736,0 0.0157,27.32111 17.46908,-5.82841 0,-27.32347 4.52736,0 z\" />\t\r\n\t\t</g></svg>";
nx3.render.svg.Elements.signFlat = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;display:inline\"\r\n\t\t\t\td=\"m 0.119631,150.69109 5.81283,0 -1.25721,57.37598 c 3.63742,-5.96993 9.26898,-8.95607 16.901689,-8.95371 2.66507,-0.002 5.23835,0.45287 7.72451,1.3657 2.48383,0.91046 4.63332,2.15823 6.45084,3.73622 1.8152,1.58034 3.27018,3.46025 4.36022,5.64914 1.09004,2.18654 1.63625,4.55234 1.63625,7.10684 -0.24254,3.52158 -1.54679,7.44178 -3.90817,11.75353 -2.36373,4.3141 -6.39435,8.53622 -12.08944,12.66399 l -25.631519,18.95235 0,-109.65004 z m 16.901689,55.71308 c -5.082969,0 -8.960559,2.55214 -11.620919,7.65407 -0.71102,6.92521 -1.06652,12.87863 -1.06652,17.86026 0,8.62586 0.29665,14.63825 0.88758,18.03953 2.30253,-1.45769 4.75337,-3.61121 7.35491,-6.46763 2.603867,-2.85641 4.991139,-5.89445 7.171249,-9.11175 2.17775,-3.21966 3.96469,-6.43696 5.35609,-9.65898 1.39141,-3.21966 2.08592,-6.04541 2.08827,-8.47254 -0.002,-2.79509 -0.96997,-5.13494 -2.90523,-7.0172 -1.93762,-1.88463 -4.35784,-2.82576 -7.26543,-2.82576 z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.flagDown8 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 10,227 C 12,227 14,227 15,227 16,227 17,226 19,226 20,225 22,224 23,223 25,222 27,220 30,218 39,211 44,206 46,205 54,195 58,185 58,174 58,166 55,156 48,144 48,143 47,142 47,141 47,140 48,139 48,139 49,139 50,140 52,142 53,144 55,146 56,149 57,152 59,155 60,158 61,161 62,164 62,166 63,171 64,176 64,181 64,186 63,190 61,195 60,200 57,204 54,209 50,213 47,216 43,220 39,224 36,228 33,232 29,237 25,243 22,249 18,255 15,262 13,269 12,269 12,270 12,271 12,271 12,272 13,272 13,273 12,273 10,273 L 10,227 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.flagUp8 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 12,181 C 14,181 15,181 14,181 14,181 14,182 14,182 14,183 14,184 14,184 20,199 27,211 35,221 45,234 50,241 52,243 56,250 58,258 58,266 L 58,267 C 58,273 58,278 57,282 56,287 55,291 53,294 52,297 51,299 50,301 48,302 48,303 47,303 46,303 46,303 46,302 46,301 46,300 47,298 48,295 49,293 50,291 50,290 51,288 51,286 51,284 52,282 52,280 52,277 52,274 52,270 L 52,269 C 52,256 45,245 30,234 28,233 27,232 26,231 25,230 24,230 22,229 21,228 20,228 18,227 16,227 14,227 12,227 L 12,181 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.flagDown16 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 65,152 C 65,157 64,162 63,165 65,169 66,175 66,181 66,186 65,191 64,196 62,200 59,205 56,209 52,213 49,217 45,221 42,224 38,228 35,232 31,238 27,243 23,250 20,256 17,262 15,269 15,269 15,270 15,271 15,271 15,272 15,272 15,273 14,273 12,273 L 12,192 C 16,192 20,192 24,190 28,188 32,186 36,183 39,181 42,178 45,176 47,174 49,172 50,171 55,165 58,158 58,150 58,143 56,135 53,127 52,125 51,124 51,123 51,122 52,122 53,122 55,122 56,123 58,126 59,129 60,132 61,136 62,139 63,143 64,146 65,149 65,151 65,152 Z M 60,179 C 60,178 60,177 60,177 60,176 60,175 60,174 59,175 58,177 55,180 53,182 50,185 47,187 45,190 42,192 40,194 37,196 36,198 35,199 29,207 23,216 19,226 20,225 22,225 24,224 26,222 28,221 30,219 36,214 41,210 44,207 48,204 50,202 50,202 57,195 60,187 60,179 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.flagUp16 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 52,321 C 51,321 50,321 50,320 50,319 51,318 51,316 51,314 52,312 52,310 53,308 53,305 53,303 54,301 54,299 54,297 54,295 54,293 53,291 52,290 51,288 50,286 48,284 46,281 43,279 40,276 36,273 31,269 28,268 27,266 25,265 23,264 22,263 21,263 20,262 19,262 17,262 16,262 15,262 13,262 L 13,181 14,181 C 14,181 15,181 15,182 15,182 15,183 16,184 19,196 26,208 36,221 39,225 41,228 45,232 48,235 51,239 53,242 56,246 58,250 59,255 60,259 61,264 61,269 61,275 60,281 58,285 59,286 59,288 59,290 60,292 60,295 60,298 L 60,298 C 60,300 60,302 59,305 59,307 58,310 57,312 56,315 56,317 55,318 54,320 53,321 52,321 Z M 55,272 C 55,263 53,256 48,250 48,250 46,249 44,247 42,245 40,242 37,240 34,237 31,235 28,233 24,230 22,229 19,228 22,233 24,238 27,243 30,247 32,252 36,255 36,256 37,257 39,259 41,260 43,262 45,264 47,267 49,269 51,271 53,273 54,275 55,277 55,276 55,275 55,274 55,273 55,272 55,272 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.pauseNv4 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"M 54,263 C 49,261 43,260 38,260 34,260 30,261 27,263 24,266 22,269 22,273 22,280 26,287 34,294 33,295 33,295 32,295 31,295 29,294 26,292 23,291 20,288 17,285 14,283 12,280 9,276 7,273 6,269 6,266 6,264 6,261 7,258 8,256 9,254 11,252 12,250 14,248 17,247 19,246 21,245 24,245 28,245 31,246 35,248 34,246 32,244 30,241 29,239 27,237 24,234 22,231 20,228 17,225 14,221 11,217 7,213 20,201 26,191 26,181 26,179 25,176 24,173 23,170 21,167 19,165 18,162 16,160 15,158 13,156 13,155 13,155 13,154 14,153 16,153 L 48,198 C 37,212 31,222 31,228 31,231 32,233 34,236 35,239 37,242 40,245 42,248 45,251 47,254 50,257 52,260 54,263 Z\" />\r\n\t\t</g></svg>";
nx3.render.svg.Elements.pauseNv8 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"M 30,273 L 22,273 52,208 C 42,211 34,213 28,213 17,213 11,208 11,199 11,197 12,194 15,193 18,191 21,190 24,190 31,190 34,193 34,199 34,202 33,205 31,209 32,209 32,209 34,209 42,209 50,205 60,197 L 30,273 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.pauseNv16 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\"\r\n\t\t\td=\"M 26,314 L 18,314 44,253 C 37,256 30,258 23,258 12,258 6,254 6,245 6,242 8,240 10,238 13,236 16,235 20,235 27,235 30,238 30,244 30,246 29,249 27,253 28,253 29,253 29,253 30,253 31,253 31,253 34,253 39,252 46,249 L 65,207 C 57,210 49,212 42,212 31,212 25,208 25,200 25,197 26,194 29,192 31,190 34,189 38,189 44,189 48,192 48,198 48,201 47,204 45,208 46,208 47,208 48,208 53,208 62,204 73,196 L 26,314 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time0 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 81,227 C 81,232 80,238 78,243 76,248 74,252 70,256 67,260 63,263 59,265 54,268 50,269 45,269 40,269 35,268 30,265 26,263 22,260 19,256 16,252 13,247 11,242 9,237 8,232 8,227 8,222 9,216 11,211 13,206 16,202 19,197 22,193 26,190 30,188 35,185 40,184 45,184 49,184 54,185 58,188 63,190 67,193 70,197 73,201 76,206 78,211 80,216 81,221 81,227 Z M 58,229 C 58,202 54,189 45,189 36,189 31,202 31,227 31,252 36,264 45,264 54,264 58,252 58,229 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time1 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 10,269 C 10,266 11,264 13,264 16,263 18,262 19,261 20,259 20,257 20,253 L 20,215 C 20,211 20,208 19,207 19,207 18,208 17,210 16,211 15,212 13,214 12,216 11,217 9,219 8,220 8,221 7,221 7,221 6,221 5,221 14,203 19,191 20,184 21,184 23,185 25,185 26,185 29,185 31,185 37,185 41,185 43,184 L 43,253 C 43,257 44,259 45,261 46,262 47,262 48,263 50,263 51,264 52,264 53,265 54,266 54,269 L 10,269 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time2 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 76,239 C 75,260 68,271 55,271 53,271 51,270 48,269 45,268 41,267 38,266 35,265 32,263 29,262 26,261 24,261 23,261 21,261 19,261 18,262 17,263 16,263 15,264 14,265 13,266 12,267 11,267 10,268 9,268 8,268 7,267 7,267 7,263 8,259 10,257 12,255 13,252 15,250 18,245 23,240 29,236 34,232 38,229 40,227 43,225 45,223 47,221 48,219 49,217 49,215 50,213 50,211 50,209 50,204 49,199 46,196 43,193 39,191 34,191 28,191 24,193 22,196 24,197 27,199 29,201 31,203 32,205 32,208 32,210 32,211 31,213 30,214 29,215 28,216 27,217 25,218 24,219 22,219 21,220 19,220 12,220 8,216 8,208 8,200 11,194 17,189 23,185 31,183 42,183 48,183 54,184 58,186 62,188 65,190 68,192 70,195 72,198 73,201 74,204 74,206 74,208 74,214 72,219 68,223 67,224 64,225 61,227 57,229 53,231 49,233 44,235 40,237 36,239 32,241 29,243 27,245 L 27,245 C 27,245 28,245 29,245 29,245 30,245 31,245 33,245 35,245 38,246 41,247 44,247 48,248 51,249 54,250 56,251 59,252 61,252 62,252 65,252 68,251 69,249 69,249 70,248 71,246 71,244 73,242 76,239 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time3 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 70,245 C 70,253 67,260 61,264 56,268 48,270 37,270 33,270 29,270 25,269 21,268 18,267 15,265 12,263 10,261 8,259 7,257 6,254 6,251 6,248 7,245 10,243 12,241 15,240 18,240 21,240 24,241 26,243 28,245 29,247 29,250 29,255 27,259 24,262 26,264 30,265 35,265 39,265 43,263 45,260 48,257 49,253 49,249 49,243 48,239 46,237 44,234 41,232 37,231 33,231 30,231 28,230 25,230 24,229 24,228 24,227 24,225 24,225 24,224 25,223 25,223 26,223 27,223 28,223 29,223 30,222 32,222 37,222 41,220 44,218 47,216 48,212 48,206 48,195 43,189 32,189 28,189 25,190 23,192 25,194 26,196 28,198 29,200 30,202 30,205 30,208 29,211 27,212 24,214 22,215 19,215 15,215 13,214 10,212 8,210 7,207 7,203 7,197 10,192 15,189 21,186 28,184 37,184 46,184 54,186 60,190 65,194 68,199 68,207 68,211 67,215 64,219 61,222 58,225 53,226 L 54,227 C 58,228 62,230 65,233 68,236 70,240 70,245 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time4 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 66,250 L 66,255 C 66,256 66,256 66,257 66,257 66,258 66,258 66,260 67,262 68,262 69,263 72,264 76,264 L 77,269 32,269 32,264 C 38,264 41,262 42,261 43,260 43,256 43,250 L 6,250 6,243 C 8,239 11,235 14,230 16,225 19,220 21,215 23,209 25,204 26,199 28,193 29,189 29,184 L 60,184 C 58,192 52,202 41,213 28,226 21,235 18,242 L 43,242 43,221 66,201 66,242 78,242 78,250 66,250 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time5 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 4,249 C 4,245 5,242 8,239 10,236 13,235 16,235 25,235 29,239 29,247 29,248 29,250 28,251 27,253 27,254 26,255 25,256 24,258 24,258 23,259 22,260 22,260 24,263 28,264 32,264 43,264 48,256 48,241 48,234 47,230 44,226 42,222 38,220 33,220 29,220 24,222 18,225 17,225 17,225 17,226 17,226 16,226 16,226 16,227 15,227 14,227 13,227 11,227 9,228 9,223 10,217 10,209 11,202 11,193 12,183 20,185 31,186 44,186 52,186 61,185 69,184 68,197 56,204 34,204 34,204 32,204 31,204 30,204 28,204 27,204 25,203 23,203 22,203 21,203 20,203 19,203 19,203 18,204 18,205 18,206 18,207 18,209 18,210 17,212 17,213 17,215 17,217 17,218 24,215 31,213 39,213 43,213 47,214 51,215 56,216 59,218 62,220 65,223 68,226 69,229 71,232 72,236 72,240 72,245 71,249 69,252 67,256 65,259 62,261 58,264 55,266 50,267 46,268 41,269 36,269 31,269 26,268 23,267 19,266 15,265 13,263 10,261 8,259 6,256 5,254 4,251 4,249 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time6 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 74,241 C 74,245 73,249 72,253 70,257 68,260 65,262 62,265 59,267 55,268 51,269 46,270 42,270 30,270 21,266 15,259 9,251 6,240 6,227 6,221 7,215 9,210 10,204 13,200 16,196 19,192 23,189 27,186 31,184 36,183 41,183 46,183 49,183 53,184 57,185 60,186 63,188 66,189 68,191 69,193 71,196 72,198 72,201 72,204 71,207 68,210 66,212 63,213 59,213 55,213 52,212 50,209 47,207 46,204 46,201 46,200 46,198 47,196 48,195 48,193 48,192 48,189 46,188 42,188 40,188 38,189 36,190 34,192 33,194 32,196 31,198 30,201 29,204 28,207 28,211 28,214 28,214 28,215 28,217 28,219 28,221 28,223 35,220 43,218 50,218 57,218 63,220 67,224 72,228 74,234 74,241 Z M 43,226 C 34,226 29,232 29,245 29,258 33,264 41,264 49,264 53,258 53,245 53,232 50,226 43,226 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time7 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 77,188 C 77,194 72,207 63,227 54,245 50,259 50,269 L 50,271 C 47,270 42,270 34,270 32,270 29,270 27,270 25,270 24,271 22,271 23,257 32,242 49,225 55,219 59,214 61,209 56,212 50,213 45,213 44,213 41,213 39,212 36,211 34,210 31,209 28,208 26,207 23,206 21,206 20,205 19,205 18,205 16,207 15,209 14,212 13,214 12,217 10,215 9,213 8,211 L 8,203 C 8,203 8,201 8,200 8,198 8,197 8,195 L 8,186 C 14,188 17,190 17,190 18,190 18,189 20,189 21,188 23,187 25,186 26,185 28,185 30,184 32,183 34,183 36,183 38,183 40,184 42,185 45,186 48,188 50,190 53,192 55,193 57,195 59,196 61,197 62,197 67,197 71,193 72,187 L 74,187 C 76,187 77,187 77,188 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time8 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 75,244 C 75,248 74,251 72,255 71,258 68,260 65,263 62,265 58,267 54,268 50,269 46,270 42,270 37,270 32,269 28,268 24,267 21,266 18,264 15,262 12,259 11,256 9,253 8,250 8,246 8,242 9,238 12,234 14,231 18,229 22,227 14,223 10,216 10,207 10,203 11,200 12,197 14,195 16,192 19,190 21,188 25,187 28,186 32,185 36,184 40,184 50,184 58,186 64,189 70,193 73,198 73,204 73,213 69,219 61,225 70,229 75,235 75,244 Z M 60,203 C 60,198 58,195 55,192 52,190 47,189 41,189 31,189 26,193 26,200 26,208 34,214 50,219 57,215 60,210 60,203 L 60,203 Z M 58,252 C 58,249 57,247 56,246 54,244 52,242 49,240 47,239 44,237 40,235 37,234 33,232 30,231 23,234 20,240 20,246 20,251 22,256 26,259 30,262 35,263 41,263 45,263 49,262 53,260 56,258 58,255 58,252 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.time9 = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 4,212 C 4,202 7,195 13,190 20,185 28,183 39,183 50,183 58,187 64,195 70,203 73,213 73,227 73,233 72,238 70,244 68,249 66,253 63,257 59,261 55,264 51,267 46,269 41,270 36,270 32,270 29,270 25,269 22,268 19,267 16,265 14,263 11,262 10,259 8,257 7,255 7,252 7,249 8,246 11,244 13,241 15,240 19,240 23,240 26,241 28,244 30,246 31,249 31,253 31,254 31,255 30,257 30,259 29,260 29,261 29,264 31,265 35,265 45,265 50,254 50,232 L 50,229 C 42,233 35,235 29,235 21,235 15,233 11,229 6,225 4,219 4,212 Z M 38,189 C 34,189 30,191 28,195 25,198 24,203 24,209 24,214 25,218 27,222 29,225 32,227 36,227 45,227 50,221 50,209 50,203 49,199 47,195 45,191 42,189 38,189 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.timeCommon = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 78,247 C 77,250 76,253 74,255 72,258 70,261 67,263 64,265 61,267 58,268 55,269 52,270 49,270 43,270 37,269 32,267 27,264 23,261 19,257 16,253 13,248 11,243 9,238 8,232 8,226 8,220 9,214 11,209 13,204 15,199 19,196 22,192 26,189 31,187 36,185 42,184 48,184 51,184 55,184 59,185 62,186 66,187 68,189 71,190 73,192 75,194 76,197 77,199 77,202 77,205 76,208 73,210 71,212 68,213 65,213 62,213 59,212 56,210 53,208 52,205 52,202 52,198 54,193 59,189 56,189 54,189 52,189 48,189 45,190 42,192 39,193 36,196 34,199 32,202 31,205 30,210 29,214 28,218 28,224 28,229 29,234 30,239 31,244 33,248 35,252 37,256 39,259 42,261 45,264 48,265 52,265 60,265 69,259 78,247 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.timeAllabreve = "<svg><g><path style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none\" \r\n\t\t\td=\"M 39,191 C 30,197 26,207 26,223 26,227 26,230 27,234 28,238 29,241 30,245 31,248 32,251 34,254 35,257 37,259 39,261 L 39,191 Z M 74,247 C 73,250 72,253 70,256 68,259 66,261 63,263 61,265 58,267 55,268 52,270 49,270 46,270 L 45,270 45,284 39,284 39,270 C 34,269 29,267 25,264 21,262 18,259 15,255 12,251 10,246 8,241 7,236 6,231 6,225 6,220 7,215 8,210 10,205 12,201 15,198 18,194 21,191 25,188 29,186 34,185 39,184 L 39,171 45,171 45,184 C 49,184 52,184 56,185 59,186 63,187 65,189 68,191 70,192 72,195 73,197 74,199 74,202 74,205 73,207 70,210 68,212 65,213 62,213 59,213 56,212 53,210 50,208 49,205 49,202 49,198 51,193 56,189 55,189 54,189 52,189 51,188 50,188 49,188 48,188 48,188 47,188 46,188 46,188 45,189 L 45,265 C 46,265 48,265 49,265 57,265 66,259 74,247 Z\"/>\r\n\t\t</g></svg>";
nx3.render.svg.Elements.tplCircle = "<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#FFFFFFF\"><path d=\"M 93,253 C 78,253 66,250 53,242 41,235 32,226 25,214 17,201 14,189 14,175 14,160 17,148 25,135 32,123 41,114 53,107 66,99 78,96 92,96 107,96 119,99 132,107 144,114 153,123 160,135 168,148 171,160 171,174 171,189 168,201 160,214 153,226 144,235 132,242 119,250 107,253 93,253 L 93,253 Z\"/></g><g style=\"stroke:#000000;fill:none\"><path style=\"fill:none\" d=\"M 93,253 C 78,253 66,250 53,242 41,235 32,226 25,214 17,201 14,189 14,175 14,160 17,148 25,135 32,123 41,114 53,107 66,99 78,96 92,96 107,96 119,99 132,107 144,114 153,123 160,135 168,148 171,160 171,174 171,189 168,201 160,214 153,226 144,235 132,242 119,250 107,253 93,253\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 71,256 C 64,254 57,252 50,248 44,244 38,239 33,234 28,229 23,223 19,217 15,210 13,203 11,196 9,189 8,182 8,175 8,167 9,160 11,153 13,146 15,139 19,132 23,126 28,120 33,115 38,110 44,105 50,101 57,97 64,95 71,93 78,91 85,90 92,90 100,90 107,91 114,93 121,95 128,97 135,101 141,105 147,110 152,115 157,120 162,126 166,132 170,139 172,146 174,153 176,160 177,167 177,174 177,182 176,189 174,196 172,203 170,210 166,217 162,223 157,229 152,234 147,239 141,244 135,248 128,252 121,254 114,256 107,258 100,259 93,259 85,259 78,258 71,256 Z M 130,239 C 136,236 141,232 145,227 150,223 154,218 157,212 160,206 163,200 165,194 166,188 167,181 167,174 167,168 166,161 165,155 163,149 160,143 157,137 154,131 150,126 145,122 141,117 136,113 130,110 124,107 118,104 112,102 106,101 99,100 92,100 86,100 79,101 73,102 67,104 61,107 55,110 49,113 44,117 40,122 35,126 31,131 28,137 25,143 22,149 20,155 19,161 18,168 18,175 18,181 19,188 20,194 22,200 25,206 28,212 31,218 35,223 40,227 44,232 49,236 55,239 61,242 67,245 73,247 79,248 86,249 93,249 99,249 106,248 112,247 118,245 124,242 130,239 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"8\" y=\"89\" width=\"170\" height=\"171\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"854\" height=\"964\"/></g><g/></g></g></g></svg>";
nx3.render.svg.Elements.tplCircleUp = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 71,256 C 64,254 57,252 50,248 44,244 38,239 33,234 28,229 23,223 19,217 15,210 13,203 11,196 9,189 8,182 8,175 8,167 9,160 11,153 13,146 15,139 19,132 23,126 28,120 33,115 38,110 44,105 50,101 57,97 64,95 71,93 78,91 85,90 92,90 100,90 107,91 114,93 121,95 128,97 135,101 141,105 147,110 152,115 157,120 162,126 166,132 170,139 172,146 174,153 176,160 177,167 177,174 177,182 176,189 174,196 172,203 170,210 166,217 162,223 157,229 152,234 147,239 141,244 135,248 128,252 121,254 114,256 107,258 100,259 93,259 85,259 78,258 71,256 Z M 130,239 C 136,236 141,232 145,227 150,223 154,218 157,212 160,206 163,200 165,194 166,188 167,181 167,174 167,168 166,161 165,155 163,149 160,143 157,137 154,131 150,126 145,122 141,117 136,113 130,110 124,107 118,104 112,102 106,101 99,100 92,100 86,100 79,101 73,102 67,104 61,107 55,110 49,113 44,117 40,122 35,126 31,131 28,137 25,143 22,149 20,155 19,161 18,168 18,175 18,181 19,188 20,194 22,200 25,206 28,212 31,218 35,223 40,227 44,232 49,236 55,239 61,242 67,245 73,247 79,248 86,249 93,249 99,249 106,248 112,247 118,245 124,242 130,239 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"8\" y=\"89\" width=\"170\" height=\"171\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"854\" height=\"964\"/></g><g/></g></g><g><desc>Group</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 70,52 L 92,10 114,52 70,52 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"70\" y=\"10\" width=\"45\" height=\"44\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 92,95 L 84,95 84,43 100,43 100,95 92,95 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"84\" y=\"43\" width=\"17\" height=\"53\"/></g><g/></g></g></g></g></svg>\r\n\t";
nx3.render.svg.Elements.tplArrowDown = "\t\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"854\" height=\"964\"/></g><g/></g></g><g><desc>Group</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 69,298 L 92,344 115,298 69,298 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"69\" y=\"298\" width=\"47\" height=\"47\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 92,252 L 100,252 100,309 84,309 84,252 92,252 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"83\" y=\"252\" width=\"18\" height=\"59\"/></g><g/></g></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tplArrowUp = "\t\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"854\" height=\"964\"/></g><g/></g></g><g><desc>Group</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 70,52 L 92,10 114,52 70,52 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"70\" y=\"10\" width=\"45\" height=\"44\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 92,95 L 84,95 84,43 100,43 100,95 92,95 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"84\" y=\"43\" width=\"17\" height=\"53\"/></g><g/></g></g></g></g></svg>\r\n\t";
nx3.render.svg.Elements.tpl1 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 106,225 L 93,225 93,146 C 90,149 86,152 82,155 77,158 73,160 69,161 L 69,149 C 76,146 82,142 87,137 92,133 96,128 98,124 L 106,124 106,225 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"69\" y=\"124\" width=\"38\" height=\"103\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl2 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 124,212 L 124,225 58,225 C 58,222 58,219 59,216 61,211 64,207 67,202 71,197 76,192 83,187 93,178 101,171 104,166 108,161 110,157 110,152 110,148 108,144 105,141 102,138 97,136 92,136 86,136 82,138 78,141 75,144 73,148 73,154 L 60,152 C 61,143 64,136 70,131 75,126 83,124 92,124 102,124 109,127 115,132 120,137 123,144 123,152 123,156 122,160 121,164 119,168 117,172 113,176 109,180 103,186 95,193 87,199 83,203 80,206 78,208 77,210 75,212 L 124,212 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"57\" y=\"124\" width=\"68\" height=\"103\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl3 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 60,198 L 73,196 C 74,202 77,207 80,210 83,213 87,214 92,214 99,214 104,212 107,208 111,204 113,200 113,194 113,189 111,184 108,181 104,177 99,176 94,176 91,176 88,176 85,177 L 86,165 C 87,165 88,165 88,165 93,165 98,164 102,161 106,159 108,155 108,150 108,146 106,143 103,140 100,137 97,136 92,136 87,136 83,137 80,140 77,143 75,147 74,152 L 61,150 C 63,142 66,135 71,131 77,126 83,124 91,124 97,124 102,125 107,127 111,130 115,133 117,137 120,141 121,145 121,150 121,154 120,158 117,161 115,165 112,167 107,169 113,171 118,174 121,178 124,182 126,188 126,194 126,203 123,211 116,217 110,223 102,226 92,226 83,226 76,223 70,218 64,213 61,206 60,198 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"60\" y=\"124\" width=\"67\" height=\"104\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl4 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 101,225 L 101,201 56,201 56,188 104,125 114,125 114,188 126,188 126,201 114,201 114,225 101,225 Z M 101,188 L 101,145 69,188 101,188 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"55\" y=\"125\" width=\"72\" height=\"101\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl5 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 60,198 L 73,197 C 74,203 76,207 79,210 83,213 87,214 92,214 98,214 103,212 107,208 111,204 113,198 113,191 113,185 111,179 108,176 104,172 99,170 93,170 88,170 85,171 82,173 79,174 77,176 75,179 L 62,177 72,125 121,125 121,138 83,138 78,165 C 84,160 90,158 96,158 104,158 112,161 117,167 123,173 126,181 126,190 126,199 123,207 118,214 112,222 103,226 92,226 83,226 76,223 70,218 64,213 61,206 60,198 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"60\" y=\"125\" width=\"67\" height=\"103\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl6x = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 124,150 L 111,151 C 110,146 108,143 106,141 103,138 99,136 94,136 90,136 86,137 83,139 80,142 77,145 74,150 72,155 71,162 71,172 74,168 78,165 82,162 86,160 91,159 96,159 104,159 111,162 117,168 123,174 126,182 126,192 126,198 125,204 122,209 119,215 115,219 110,222 105,225 100,226 94,226 83,226 75,222 68,215 61,207 58,195 58,178 58,158 62,144 69,135 75,128 84,124 95,124 103,124 110,126 115,131 120,136 123,142 124,150 Z M 71,191 C 71,195 72,199 74,203 76,206 78,209 82,211 85,213 89,214 93,214 99,214 103,212 107,208 111,204 113,199 113,192 113,186 111,180 107,177 104,173 99,171 92,171 86,171 81,173 77,177 73,180 71,185 71,191 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"58\" y=\"124\" width=\"69\" height=\"104\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl6 = "\r\n<svg ><g style=\"stroke:none;fill:#000000\"><path d=\"M 124,150 L 111,151 C 110,146 108,143 106,141 103,138 99,136 94,136 90,136 86,137 83,139 80,142 77,145 74,150 72,155 71,162 71,172 74,168 78,165 82,162 86,160 91,159 96,159 104,159 111,162 117,168 123,174 126,182 126,192 126,198 125,204 122,209 119,215 115,219 110,222 105,225 100,226 94,226 83,226 75,222 68,215 61,207 58,195 58,178 58,158 62,144 69,135 75,128 84,124 95,124 103,124 110,126 115,131 120,136 123,142 124,150 Z M 71,191 C 71,195 72,199 74,203 76,206 78,209 82,211 85,213 89,214 93,214 99,214 103,212 107,208 111,204 113,199 113,192 113,186 111,180 107,177 104,173 99,171 92,171 86,171 81,173 77,177 73,180 71,185 71,191 Z\"/></g></svg>\t\r\n\t";
nx3.render.svg.Elements.tpl7 = "\r\n<svg ><g visibility=\"visible\" id=\"page1\"><desc>Slide</desc><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:none\"><rect x=\"0\" y=\"464\" width=\"503\" height=\"1205\"/></g><g/></g></g><g><desc>Drawing</desc><g><g style=\"stroke:none;fill:#000000\"><path d=\"M 61,138 L 61,125 126,125 126,136 C 120,142 114,152 108,163 102,174 97,186 94,197 91,206 90,215 89,225 L 76,225 C 76,217 78,208 81,196 83,185 87,175 93,164 98,154 104,145 110,138 L 61,138 Z\"/></g><g style=\"stroke:none;fill:none\"><rect x=\"61\" y=\"125\" width=\"67\" height=\"101\"/></g><g/></g></g></g></svg>\t\r\n\t";
nx3.units.Constants.BASE_NOTE_VALUE = 3024;
nx3.units.Constants.STAVE_LENGTH = 6.8;
nx3.units.Constants.SIGN_TO_NOTE_DISTANCE = 0.8;
nx3.units.Constants.COMPLEX_COLLISION_OVERLAP_XTRA = 0.6;
nx3.units.Constants.SIGN_NORMAL_WIDTH = 2.6;
nx3.units.Constants.SIGN_PARENTHESIS_WIDTH = 4.4;
nx3.units.Constants.HEAD_ADJUST_X = 0;
nx3.units._Level.Level_Impl_.MAX_LEVEL = 15;
nx3.units._Level.Level_Impl_.MIN_LEVEL = -15;
nx3.units._NX.NX_Impl_.XUNIT = 1;
nx3.units._NY.NY_Impl_.YUNIT = 1;
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

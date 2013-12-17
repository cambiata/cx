package scorx.data;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import sx.mvc.view.enums.ScrollWidgetZoom;
/**
 * ...
 * @author Jonas Nyström
 */
class Zooma
{
	public var zoomSignal:Signal1<ScrollWidgetZoom>;
	
	public var zoomResetTopSignal:Signal0;
	
	
	private var zoom:ScrollWidgetZoom;
	public function new() 
	{
		this.zoomSignal = new Signal1<ScrollWidgetZoom>();
		this.zoomResetTopSignal = new Signal0();
		this.zoom = ScrollWidgetZoom.ZoomFullHeight;
	}
	
	public function setZoom(zoom:ScrollWidgetZoom)
	{
		this.zoom = zoom;
		this.zoomSignal.dispatch(this.zoom);		
	}
	
	public function getZoom():ScrollWidgetZoom
	{
		return this.zoom;
	}
	
	public function doZoomResetTop()
	{
		this.zoomResetTopSignal.dispatch();
	}
	
}
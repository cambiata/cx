package smd.server.sxjs.controller;
import dtx.Tools;
import js.Lib;
import smd.server.sxjs.MainController;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;

class ScorxplayerController extends Controller
{	
	
	private var main:MainController;	
	private var divPlayer: DOMCollection;
	private var divPlayerEmbedWrapper: DOMCollection;
	
	private var currentId:Int = 0;
	
	
	public function new(main:MainController) {
		this.main = main;
		this.divPlayer = this.findElement("#scorxplayer");
		this.divPlayerEmbedWrapper = this.findElement("#playerEmbedWrapper");
		
		var path = Tools.window.location.pathname;
		//trace('path ' + path);
		
		
		"#playerClear".find().click(function (e) { 
			this.clearPlayer();
		} );
		
		"#playerLoad".find().click(function (e) { 
			this.loadPlayer(123);
		} );		
		
		"#playerShow".find().click(function (e) { 
			this.showPlayer();
		} );		
		
		"#playerHide".find().click(function (e) { 
			this.hidePlayer();
		} );	
		
		"#btnPlayerClose".find().click(function (e) {
			this.hidePlayer();
		});
		
	}
	
	public function clearPlayer() {
		//trace('Clear');		
		this.divPlayerEmbedWrapper.removeChildren(null, "#playerEmbed".find());
	}
	
	public function loadPlayer(id:Int) {
		
		if (id == 0) {
			hidePlayer();
			return;
		}
		
		if (id == this.currentId) {
			showPlayer();
			return;
		}
		
		this.currentId = id;
		this.clearPlayer();
		
		//Lib.alert(id);		
		var playerEmbed = "embed".create();
		playerEmbed.setCSS('backgroundColor', '#555555');
		
		playerEmbed.setAttr('id', 'playerEmbed');
		playerEmbed.setAttr('width', '100%');
		playerEmbed.setAttr('height', '100%');		
		playerEmbed.setAttr('allowfullscreen', 'true');
		playerEmbed.setAttr('type', 'application/x-shockwave-flash');
		playerEmbed.setAttr('src', '/app/swf/ScorxClientFlex.swf');
		
		playerEmbed.setAttr('flashvars', 'host=scorxplayer.com&id=' + id + '&domain=smdhx&uri=%2Furi&exampleId=428&userId=jonasnys%40gmail.com');
		
		
		this.divPlayerEmbedWrapper.append(playerEmbed);		
		showPlayer();
	}
	
	public function hidePlayer() {
		this.divPlayer.setCSS('top', '-10000px');
		this.divPlayer.setCSS('bottom', '10000px');	
		if (this.currentId != 0) {
			"#playerShow".find().setCSS('visibility', 'visible');
		}
	}
	
	public function showPlayer() {
		this.divPlayer.setCSS('top', '0px');
		this.divPlayer.setCSS('bottom', '2px');				
		"#playerShow".find().setCSS('visibility', 'hidden');
	}
	
}
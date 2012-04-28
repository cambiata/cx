package cx;

import neko.Lib;
import neko.Sys;
import neko.Utf8;

class CliBase {	
	static public var DIVIDER1:String = '---------------------------------------------------------------------------------------------';
	static public var DIVIDER2:String = '*********************************************************************************************';
	static public var DIVIDER3:String = '- - - - - - - - - - - -';
	private var apiClass:Class<Dynamic>;
	
	public function new(apiClass:Class<Dynamic>, cmds:Array<Dynamic>, toolTitle:String) {
		
		Lib.println(DIVIDER1);
		Lib.println(CliBase.decode(toolTitle) + cx.CliBase.MyMacro.getDate() );
		Lib.println(DIVIDER1);
		this.apiClass = apiClass;
		Reflect.callMethod(this.apiClass, Reflect.field(this.apiClass, 'init'), []);
		this.printAndWait(cmds);
	}
	
	static public function init() {
		trace('CliBase.init()');
	}

	static public function beforePrintAndWait() {
		
	}
	
	private function printAndWait(cmds:Array<Dynamic>, prevCmds:Array<Dynamic> = null) {			
		
		if (prevCmds == null) prevCmds = [];
		if (prevCmds.length == 0) {
			Reflect.callMethod(this.apiClass, Reflect.field(this.apiClass, 'beforePrintAndWait'), []);
		} else {
		}
		

		var key = 0;
		var keys = ['q'];
		var cmdsArray:Array<Dynamic> = (Std.is(cmds, Array)) ? cmds : [cmds];
		
		var cmdLabels = new Array<String>();
		
		for (c in cmdsArray) {
			if (Std.is(c, String)) {
				cmdLabels.push(' ' + (key + 1) + ' : ' + commandLabel(c));
			} else if (Std.is(c, Array)) {
				cmdLabels.push(' ' + (key + 1) + ' : ' + commandLabel(c[0]) + ' >');
			}
			keys.push(Std.string(key + 1));
			key++;
		}	
		
		Lib.println('');
		Lib.println(DIVIDER1);
		Lib.println('');
		Lib.println('MENY:');
		for (l in cmdLabels) {
			Lib.println(l);			
		}
			
		//----------------------------------------------------
		if (prevCmds.length == 0) {
			Lib.println (' q : AVSLUTA ');
		} else {
			Lib.println (' q : ROTMENY <');
		}
		Lib.println('');
		var r = '*';
		while (Lambda.indexOf(keys, r) < 0) {
			r = prompt(CliBase.decode(' > Välj menyalternativ nummer'));
		} 	
		
		if (r == 'q') {
			if (prevCmds.length == 0) {
				Lib.println('');
				Lib.println(CliBase.decode(' Hej då, och välkommen tillbaka! säger Kalle.'));
				Lib.println('');
				Sys.exit(0);
			}

			var lastCmds = prevCmds.pop();
			//trace(lastCmds);
			
	
	
			
			printAndWait(lastCmds,  prevCmds);
			
			
			
		} else {
			//trace('command');
			var i = Std.parseInt(r)-1;
			
			//trace(selectedCmd);
			if (Std.is(cmdsArray[i], String)) {
				//trace('execute string ' + selectedCmd);
				var selectedCmd:String = commandFunction(cmdsArray[i]);
				//trace('Hello ' + selectedCmd);
				doCommand(selectedCmd);
				printAndWait(cmds,  prevCmds);
			} else if (Std.is(cmdsArray[i], Array)) {				
				var selectedCmds:Array<Dynamic> = cmdsArray[i].copy();
				if (selectedCmds.length == 1) {
					trace('execute array 1 item');
				} else {
					//trace('print and wait array...');
					//trace(selectedCmds);
					selectedCmds.shift();
					//trace(selectedCmds);
					prevCmds.push(cmds);
					printAndWait(selectedCmds, prevCmds);
				}
			}
		}								
	}
	
	static public function commandLabel(label:String):String {		
		if (label.indexOf('|') > 0) {
			label = label.substr(0, label.indexOf('|'));
		}
		return '' + CliBase.decode(label);		
	}
	
	static public function commandFunction(label:String):String {		
		label = label.toLowerCase();
		label = StringTools.replace(label, '|', '');
		label = StringTools.replace(label, ' ', '_');
		label = StringTools.replace(label, 'å', 'a');
		label = StringTools.replace(label, 'ä', 'a');
		label = StringTools.replace(label, 'ö', 'o');
		label = StringTools.replace(label, 'Å', 'A');
		label = StringTools.replace(label, 'Ä', 'A');
		label = StringTools.replace(label, 'Ö', 'O');	
		return '__' + label;
	}

	
	public function doCommand(method:String) {
		//trace(method);
		var methods = Type.getClassFields(this.apiClass);
		
		if (Lambda.indexOf(methods, method) > -1) {
			try {
				//trace(method);
				Reflect.callMethod(this.apiClass, Reflect.field(this.apiClass, method), []);
			} catch (msg:String) {
				trace(msg);
				trace(method);
			}
			
			
		} else {
			Lib.println(DIVIDER2);
			Lib.println('Fel: Kommando "' + method + '" saknas!');
			Lib.println('');
		}
	}
	
	public function doSubCommand(method:String):Bool {
		var subMethod = 'sub_' + method;
		var methods = Type.getClassFields(this.apiClass);
				
		if (Lambda.indexOf(methods, subMethod) > -1) {
			try {
			return Reflect.callMethod(this.apiClass, Reflect.field(this.apiClass, subMethod), []);
			} catch (msg:String) {
				trace(msg);
				trace(subMethod);
			}
			
		} else {			
			return true;
		}
		
		return false;
	}	
	
	/*
	static private function commandTextify(c:String):String {		
		c = StringTools.replace(c, '_', ' ');
		var first = c.substr(0, 1).toUpperCase();
		return first + c.substr(1);			
	}
	*/
		
	static public function prompt(promptMsg:String, rpad:Int=0):String {
		neko.Lib.print(StringTools.rpad(promptMsg + " ", " ", rpad) + ": ");
		var str:String = neko.io.File.stdin().readLine();
		if(str.length == 0)
		{
		str = null;
		}

		return str;
	} 		
	
	public function promptText(msg:String):String {
		Lib.println('');
		var keys = ['q'];		
		var r = '';		
		while (r.length < 1) {
			r = prompt(msg);
		} 
		if (r == 'q') return '';		
		return r;		
	}

	public function promptTextNotEmpty(msg:String):String {
		Lib.println('');
		var r:String = prompt(msg);
		if (r == null) r = '';
		return r;		
	}	
	
	static public function subcommandPrintAndWait(items:List<String>, label:String='', addAll:Bool=false, addNone:Bool=false):Int {
		var key = 0;
		var keys = ['q'];				
		
		if (addAll) keys.push('a');
		if (addNone) keys.push('n');
		
		var labels = new Array<String>();
		for (item in items) {
			labels.push(' ' + (key + 1) + ' : ' + CliBase.decode(item));
			keys.push(Std.string(key + 1));
			key++;
		}	

		Lib.println(DIVIDER3);
		if (addAll) Lib.println (' a : Add all ');
		if (addNone) Lib.println (' n : Remove all ');
		//Lib.println('');		
		
		for (label in labels) {
			Lib.println(label);			
		}
		
		Lib.println('');
		Lib.println (' q : Exit ');		
		Lib.println(DIVIDER3);		
		
		var r = '*';
		while (Lambda.indexOf(keys, r) < 0) {
			r = prompt(CliBase.decode(label));
		} 			
		if (r == 'q') return -1;
		if (r == 'a') return -2;
		if (r == 'n') return -3;
		return Std.parseInt(r)-1;
	}
	
	
			
	static public function decode(str:String):String {
		if (str == null) return null;
		if (!Utf8.validate(str)) throw 'Error: string ' + str + ' must be Utf8 encoded!';
		
		var r:String = '';		
		var ii = 0;
		
		for (i in 0...Utf8.length(str)) {
			var cc = Utf8.charCodeAt(str, i);
			var ccc = Utf8.sub(str, i, 1);
			var c = str.charAt(i);
			switch(cc) {
				case 229: { r += String.fromCharCode(134); ii += 2;	}
				case 228: { r += String.fromCharCode(132); ii += 2;	}
				case 246: { r += String.fromCharCode(148); ii += 2;	}
				case 197: { r += String.fromCharCode(143); ii += 2;	}
				case 196: { r += String.fromCharCode(142); ii += 2;	}
				case 214: { r += String.fromCharCode(153); ii += 2;	}				
				
				case 224: { r += String.fromCharCode(160); ii += 2;	} 
				case 225: { r += String.fromCharCode(133); ii += 2;	}
				case 193: { r += String.fromCharCode(181); ii += 2;	}
				case 192: { r += String.fromCharCode(183); ii += 2;	}
				
				case 243: { r += String.fromCharCode(162); ii += 2;	} 
				case 242: { r += String.fromCharCode(149); ii += 2;	}
				case 211: { r += String.fromCharCode(224); ii += 2;	}
				case 210: { r += String.fromCharCode(227); ii += 2;	}
				
				case 233: { r += String.fromCharCode(130); ii += 2;	} 
				case 232: { r += String.fromCharCode(138); ii += 2;	}
				case 201: { r += String.fromCharCode(144); ii += 2;	}
				case 200: { r += String.fromCharCode(212); ii += 2;	}

				case 252: { r += String.fromCharCode(129); ii += 2;	}
				case 220: { r += String.fromCharCode(154); ii += 2;	}
				
				default: r += str.charAt(ii++);
			}
		}
		
		return r;
	}
	
	static public function encode(str:String):String {
		if (Utf8.validate(str)) str = Utf8.decode(str);
		
		//throw 'Error: string ' + str + ' must NOT be Utf8 encoded!';
		var r:String = Utf8.encode('');
		for (i in 0...str.length) {
			
			var cc = str.charCodeAt(i);
			var c = str.charAt(i);
			
			switch(cc) {
				
				case 134: r += 'å';
				case 132: r += 'ä';
				case 148: r += 'ö';
				case 143: r += 'Å';
				case 142: r += 'Ä';
				case 153: r += 'Ö';
				
				case 160: r += 'á';
				case 133: r += 'à';
				case 181: r += 'Á';
				case 183: r += 'À';
				
				case 162: r += 'ó';
				case 149: r += 'ò';
				case 224: r += 'Ó';
				case 227: r += 'Ò';				
				
				
				case 130: r += 'é';
				case 138: r += 'è';
				case 144: r += 'É';
				case 212: r += 'È';				
				
				case 129: r += 'ü';
				case 154: r += 'U';
				
				
				default: r += c;
			}			
		}
		return r;
	}	
	
		
}


import haxe.macro.Expr;
class MyMacro {
    @:macro public static function getDate() {
        var date = Date.now().toString();
        var pos = haxe.macro.Context.currentPos();
        return { expr : EConst(CString(date)), pos : pos };
    }
}
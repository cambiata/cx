package kx.data;
import cx.ArrayTools;
import cx.CryptTools;
import cx.EncodeTools;
import cx.FileTools;
import cx.OdtTools;
import cx.PathTools;
import cx.StrTools;
import harfang.SessionManager;
import harfang.UserBase.User;
import haxe.ds.StringMap.StringMap;
import haxe.Utf8;
import hxdom.Attr;
import hxdom.Elements.EAnchor;
import hxdom.Elements.EBody;
import hxdom.Elements.EForm;
import hxdom.Elements.EHead;
import hxdom.Elements.EDiv;
import hxdom.Elements.EHeader1;
import hxdom.Elements.EHtml;
import hxdom.Elements.EImage;
import hxdom.Elements.EInput;
import hxdom.Elements.ELink;
import hxdom.Elements.EListItem;
import hxdom.Elements.EMeta;
import hxdom.Elements.EScript;
import hxdom.Elements.ESmall;
import hxdom.Elements.ESpan;
import hxdom.Elements.ETitle;
import hxdom.Elements.EUnorderedList;
import hxdom.Elements.Text;
import hxdom.Elements.InputType;

import hxdom.HtmlSerializer;
import kx.data.TreeUtils.BigMenuLi;
import kx.data.TreeUtils.BigMenuUl;
import kx.data.TreeUtils.Breadcrumbs;
import kx.data.TreeUtils.MainContent;
import kx.data.TreeUtils.Navbar;
import kx.data.TreeUtils.PageContent;
import kx.data.TreeUtils.PageElements;
import kx.data.TreeUtils.PageHeader;
import kx.data.TreeUtils.Sidebar;
import kx.data.TreeUtils.Sidemenu;
import kx.data.TreeUtils.Submenu;
import neko.Web;
import nx.enums.EHeadType;
import server.Config;
import sys.FileSystem;
import sys.io.File;
import thx.xml.XmlFormat;

/**
 * ...
 * @author Jonas Nyström
 */
using Lambda;
using StringTools;
using hxdom.DomTools;

typedef DocInfo = {
	safepath: String,
	filepath: String,
	docname: String,
	sort: String,
	isDir: Bool,
	ext: String,	
}



class TreeUtils
{
	public function new() 
	{
		
	}
	
	static public function getTree(dir:String, filefilter:Array<String>=null): StringMap<DocInfo>
	{
		var map = new StringMap<DocInfo>();
	
		dir = FileTools.correctPath(dir);
		var dirPath = dir; // StrTools.untilLast(dir, '/', true);
		
		//map.set(StrTools.afterLast(dir, '/') + '.dir', '');
		
		var files = FileTools.getDirectories(dir, true, null);
		var files = files.map(function(f) { return StringTools.replace(f, dirPath, ''); } ) ;	
		files = files.filter(function(val) { return (!val.startsWith('/x-')); } );
		
		for (filepath in files)
		{	
			var cont = false;
			for (filter in filefilter)
			{
				if (filepath.toLowerCase().endsWith(filter)) 
				{
					cont = true;
					break;
				}
			}			
			if (cont) continue;
			
			var safepath = /*'doc' +*/ cleanPathFromSortnumbers(filepath); 			
			safepath = EncodeTools.pathsafe(safepath);
			safepath = FileTools.excludeExtension(safepath);
			
			var docname = FileTools.getFilename(filepath, true);
			var sortStr = docname.substr(0, 3);
			var sortvalue = Std.parseInt(sortStr);			
			if (sortvalue != null) 
			{					
				docname = docname.substring(4);
			} 
			else 
			{
				sortStr = docname;
			}
			
			var docinfo = {
				filepath: dir + filepath,
				safepath: safepath,
				docname: docname,			
				sort: sortStr,
				isDir: FileSystem.isDirectory(dir + filepath),
				ext: FileTools.getExtension(filepath),				
			}
			
			map.set(safepath, docinfo);			
		}			
		//trace(map);
		return map;	
	}	
	
	static public function cleanPathFromSortnumbers(path:String):String
	{
		var pathCleaned = '';
		var segments:Array<String> = [];
		for (s in path.split('/'))
		{
			var sortVal = s.substr(0, 4);
			var segment = s;
			if (Std.parseInt(sortVal) != null) 
			{
				segment = s.substring(4);
			}
			segments.push(segment);			
		}
		return segments.join('/');		
	}
	
	
	static public function getSortedKeys(tree:StringMap<DocInfo>): Array<DocInfo>
	{	
		var a = Lambda.array(tree);
		a.sort(function(a, b) { return Reflect.compare(a.filepath, b.filepath); } );
		return a;
	}
	
	static public function getLevels(trees:StringMap<String>): StringMap<Int>
	{
		var map = new StringMap<Int>();
		for (key in trees.keys())
		{
			var level = key.length - key.replace('/', '').length;
			map.set(key, level);			
		}
		return map;
	}
	
	static public function getSubtree(tree:StringMap<DocInfo>, levelKey:String, depth:Int=1): StringMap<DocInfo>
	{
		var map = new StringMap<DocInfo>();
		var level = StrTools.countSub(levelKey, '/');
		
		
		for (key in tree.keys())
		{
			if (key.startsWith(levelKey)) 
			{
				var subLevel = StrTools.countSub(key, '/');
				//trace([subLevel, level]);
				if (subLevel <= level + depth) 
				{
					map.set(key, tree.get(key));
				}
			}
		}
		return map;
	}
	
	static public function getSublevels(tree:StringMap<DocInfo>, depth:Int=1): StringMap<DocInfo>
	{
		var map = new StringMap<DocInfo>();
		
		for (key in tree.keys())
		{
			var subLevel = StrTools.countSub(key, '/');
			if (subLevel <= depth) 
			{
				trace([subLevel]);
				map.set(key, tree.get(key));
			}
		}
		return map;
	}	
	
	static public function createIndex(pageElements:PageElements): EHtml
	{
		var html = new EHtml();
		
		var head = getHead('Körakademin', [
			"/assets/css/bootstrap.min.css",
			"/assets/css/font-awesome.min.css",
			"/assets/css/ace.min.css",
			"/assets/css/kak.css",
		]);
		
		var body = getBody(pageElements);
		
		html.appendChild(head);
		html.appendChild(body);		
		
		return html;		
		
	}
	

	
	
	static public function getBody(pageElements:PageElements)
	{
		var body = new EBody();
		
		var navbar = new NavbarUser(); // EDiv().attr(Attr.ClassName, "navbar navbar-default").attr(Attr.Id, "navbar");
		
		body.appendChild(navbar);
		
		var mainContainer = new EDiv().attr(Attr.ClassName, "main-container").attr(Attr.Id, "main-container");
		//var script = new EScript().attr(Attr.Type, "text/javascript");
		//script.addText("try{ace.settings.check('main-container' , 'fixed')}catch(e){}");
		//mainContainer.add(script);
		
		body.appendChild(mainContainer);
		
		
		var mainContainerInner = new EDiv().attr(Attr.ClassName, "main-container-inner");
		mainContainer.appendChild(mainContainerInner);
		var aMenuToggler = new EAnchor().attr(Attr.ClassName, "menu-toggler").attr(Attr.Id, "menu-toggler").attr(Attr.Href, "#");
		mainContainerInner.appendChild(aMenuToggler);
		
		/*
		var bigmenuItems:Array<BigmenuItem> = [
			{title: 'Rösten', url: 'rosten.html', clss: 'bigmenu-rosten' },
			{title: 'Noterna',  url: 'noterna.html',  clss: 'bigmenu-empty' },
			{title: 'Repertoar',  url: 'repertoar.html',  clss: 'bigmenu-empty'},
		];

		var test2sub = new Submenu();
		test2sub.appendChild(new NavlistLi('test2subA', 'linksub1.html'));
		test2sub.appendChild(new NavlistLi('test2subB', 'linksub2.html'));					
		var sidemenuItems:Array<SidemenuItem> = 		
		[
			{title: 'test', url:'/test' },
			{title: 'test2', url:'/test2', submenu: test2sub },
			{title: 'test3', url:'/test3' },
		];		
		*/
		
		var sidebar = new Sidebar(pageElements.bigmenuItems, pageElements.sidemenuItems); // new EDiv().attr(Attr.ClassName, "sidebar").attr(Attr.Id, "sidebar");
		mainContainerInner.appendChild(sidebar);
		
		var url = Web.getURI();
		url = url.substr(1, url.length - 1);
		var segments = url.split('/');
		var crumbs:Array<String> = [];
		var path = '/';
		
		
		try
		{
			var fileSegments = pageElements.filename.substr(Config.DOCPATH.length).split('/');
			var i = 0;
			for (segment in segments)
			{
				path = path + segment  + '/';
				
				var fileSegment = fileSegments[i];				
				fileSegment = FileTools.excludeExtension(fileSegment);
				var orderval = Std.parseInt(fileSegment.substring(0, 3));
				if (orderval != null) fileSegment = fileSegment.substr(4);
				
				crumbs.push(segment + '|' + path + '|' + fileSegment);
				
				i++;
			}
			//trace(crumbs);
		}
		catch (e:Dynamic)
		{
			
		}
		var breadcrumbs = new Breadcrumbs(crumbs);
		
		var content:PageContent = null;		
		if (pageElements.pageContent != null) 
		{
			content = pageElements.pageContent;
		}
		else
		{
			content = new PageContent();			
		}
		
		var mainContent = new MainContent(breadcrumbs, content); // new EDiv().attr(Attr.ClassName, "main-content").attr(Attr.Id, "main-content");		
		mainContainerInner.appendChild(mainContent);

		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "/assets/js/bootstrap.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "/assets/js/ace.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "/assets/video/swfobject.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "/assets/video/flowplayer.min.js"));
		
		return body;
	}
	
	static public function getHead(title:String, styles: Array<String> = null)
	{
		var head = new EHead();
		head.appendChild(new EMeta().attr(Attr.Charset, 'utf-8'));
		head.appendChild(new ETitle().addText(title));
		
		for (style in styles) head.appendChild(new ELink().attr(Attr.Href, style).attr(Attr.Rel, "stylesheet"));
		
		/*
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/font-awesome.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/ace.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/kak.css").attr(Attr.Rel, "stylesheet"));		
		*/
		
		
		return head;
	}
	
	
	static public function buildIndex()
	{
		
		var html = new EHtml();

		var head = new EHead();
		head.appendChild(new EMeta().attr(Attr.Charset, 'utf-8'));
		head.appendChild(new ETitle().addText('Körakademin'));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/bootstrap.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/font-awesome.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/ace.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "/assets/css/kak.css").attr(Attr.Rel, "stylesheet"));
		
		
		var body = new EBody();
		
		var navbar = new NavbarUser(); // EDiv().attr(Attr.ClassName, "navbar navbar-default").attr(Attr.Id, "navbar");
		body.appendChild(navbar);
		
		var mainContainer = new EDiv().attr(Attr.ClassName, "main-container").attr(Attr.Id, "main-container");
		var script = new EScript().attr(Attr.Type, "text/javascript");
		script.addText("try{ace.settings.check('main-container' , 'fixed')}catch(e){}");
		mainContainer.add(script);
		
		body.appendChild(mainContainer);
		
		var mainContainerInner = new EDiv().attr(Attr.ClassName, "main-container-inner");
		mainContainer.appendChild(mainContainerInner);
		var aMenuToggler = new EAnchor().attr(Attr.ClassName, "menu-toggler").attr(Attr.Id, "menu-toggler").attr(Attr.Href, "#");
		mainContainerInner.appendChild(aMenuToggler);
		
		var bigmenuItems:Array<BigmenuItem> = [
			{title: 'Rösten', url: 'rosten.html', clss: 'bigmenu-rosten' },
			{title: 'Noterna',  url: 'noterna.html',  clss: 'bigmenu-empty' },
			{title: 'Repertoar',  url: 'repertoar.html',  clss: 'bigmenu-empty'},
		];		
		
		var test2sub = new Submenu();
		test2sub.appendChild(new NavlistLi('test2subA', 'linksub1.html'));
		test2sub.appendChild(new NavlistLi('test2subB', 'linksub2.html'));					
		var sidemenuItems:Array<SidemenuItem> = 		
		[
			{title: 'test', url:'/test' },
			{title: 'test2', url:'/test2', submenu: test2sub },
			{title: 'test3', url:'/test3' },
		];			
		
		
		var sidebar = new Sidebar(bigmenuItems, sidemenuItems); // new EDiv().attr(Attr.ClassName, "sidebar").attr(Attr.Id, "sidebar");
		mainContainerInner.appendChild(sidebar);
		
		var breadcrumbs = new Breadcrumbs(['test|/test', 'test2|/test2']);
		var content = new PageContent();	
		var mainContent = new MainContent(breadcrumbs, content);
		
		mainContainerInner.appendChild(mainContent);

		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "assets/js/bootstrap.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "assets/js/ace.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "assets/video/jwplayer.js"));
		
		
		html.appendChild(head);
		html.appendChild(body);		
		//return toHtml(html);
		return html;
	}
	
	
	static public function testHxdom()
	{
		/*
		var ul = new BigMenuUl();
		
		ul.appendChild(new BigMenuLi('Rösten', 'rosten.html', 'bigmenu-rosten'));
		ul.appendChild(new BigMenuLi('Noterna', 'noterna.html', 'bigmenu-empty'));
		ul.appendChild(new BigMenuLi('Repertoar', 'repertoar.html', 'bigmenu-empty'));
		
		var html = new EHtml();
		html.appendChild(ul);		
		
		var out =  Xml.parse(HtmlSerializer.run(html)).firstElement().firstElement().toString();
		*/

		
		var sub = new NavlistUl(true);
		sub.appendChild(new NavlistLi('test', 'linksub1.html'));
		sub.appendChild(new NavlistLi('test2', 'linksub2.html'));
		var ul = new NavlistUl();		
		ul.appendChild(new NavlistLi('test', 'link.html'));
		ul.appendChild(new NavlistLi('testsub', 'sub.html', sub));
		
		
		
		
		var html = new EHtml();
		html.appendChild(ul);			
		var xml:Xml = Xml.parse(HtmlSerializer.run(html)).firstElement().firstElement();		
		var format = new XmlFormat('\t');	
		return format.format(xml).toString();
	}
	

	
}


typedef PageElements = {
	bigmenuItems:Array<BigmenuItem>,
	sidemenuItems:Array<SidemenuItem>,	
	pageContent: PageContent,
	filename: String,
	
}


class BigMenuUl extends EUnorderedList {
	
	public function new() {
		super();
		this.classes('bigmenu');
	}
	
	
}

class BigMenuLi extends EListItem {
	
	public function new(title:String, link:String, clss:String = 'btn-success', icon:String=null, iconRight:String=null, imgClss:String=null) 
	{
		super();
		
		/*this.attr(Attr.ClassName);*/
	
		
		var a = new EAnchor();
		
		a.attr(Attr.Href, link).attr(Attr.ClassName, 'btn $clss $imgClss');
		
		/*
		*/
		
		
		if (icon != null)
		{
			var span = new ESpan().attr(Attr.ClassName, icon);
			a.appendChild(span);
		}	
		
		
		a.addText(title);
		
		if (iconRight != null)
		{
			var span = new ESpan().attr(Attr.ClassName, '$iconRight' ); 
			a.appendChild(span);
		}		
		
		if (imgClss != null)
		{
			var span = new ESpan();
			span.attr(Attr.ClassName, 'span-right $imgClss');
			a.appendChild(span);
		}
		
		this.appendChild(a);


		
		

		/*
		var div = new EDiv();
		div.classes(imgClass);
		div.addText(title);
		a.appendChild(div);
		*/
		
		//this.classes('btn $imgClass');
		
	}
	
	
	
}

class NavlistUl extends EUnorderedList {
	
	public function new(isSubmenu:Bool=false) {
		super();
		var classes = (!isSubmenu) ? 'nav nav-list': 'submenu';
		this.classes(classes);
	}	
	
	
}

class NavlistLi extends EListItem {

	
	public function new(title:String, link:String, sub:EUnorderedList=null) 
	{
		super();
		var a = new EAnchor();
		a.attr(Attr.Href, link);
		this.appendChild(a);
		
		var i = new ESpan();		
		a.appendChild(i);
		
		var span = new ESpan();
		span.classes('menu-text');
		span.addText(title);		
		a.appendChild(span);
		
		if (sub != null) 
		{
			a.classes('dropdown-toggle');
			this.appendChild(sub);
			
			var b = new ESpan();
			b.classes('arrow icon-angle-down');
			a.appendChild(b);
			
			i.classes('icon-folder-close');
			
		} else {
			
			//i.classes('icon-edit');
		}
		
	}
}



class NavbarUser extends Navbar
{
/*
	public function new()
	{
		trace('ykkas');
		super();
	}
*/	
	
	override public function createChildren()
	{
		super.createChildren();
		
		
		var divUser = new EDiv().attr(Attr.ClassName, "navbar-user pull-right");
		var user:User = SessionManager.getUser();		
		var form:EForm = null;
		if (user != null)
		{
			divUser.addText('Välkommen, ${user.firstname} ${user.lastname}!');
			form = new EForm().classes('navbar-form form-inline pull-right').attr(Attr.Action, '/logout').attr(Attr.Method, 'post');			
			var submit = new EInput(InputType.Submit).classes('btn btn-primary btn-sm').attr(Attr.Value, 'Logga ut');			
			form.appendChild(submit);				
			this.appendChild(form);
		}
		else
		{
			/*
			divUser.addText('Gäst');
			form = new EForm().classes('navbar-form form-inline pull-right').attr(Attr.Action, '/loginform').attr(Attr.Method, 'post');
			var login = new EInput(InputType.IText).classes('span2').attr(Attr.Placeholder, 'Användarnamn').attr(Attr.Id, 'login').attr(Attr.Name, 'login');
			var pass = new EInput(InputType.Password).classes('input-small').attr(Attr.Placeholder, 'Lösenord').attr(Attr.Id, 'pass').attr(Attr.Name, 'pass');
			var submit = new EInput(InputType.Submit).classes('btn btn-success btn-sm').attr(Attr.Value, 'Logga in');
			form.appendChild(login);
			form.appendChild(pass);
			form.appendChild(submit);	
			this.appendChild(form);			
			*/
		}
		this.appendChild(divUser);		
		
		
	}
}


class Navbar extends EDiv {
	public function new()
	{
		super();
		this.attr(Attr.ClassName, "navbar navbar-default");
		this.attr(Attr.Id, "navbar");	
		this.createChildren();
	}
	
	public function createChildren()
	{
		var divContainer = new EDiv().attr(Attr.ClassName, "navbar-container").attr(Attr.Id, "navbar-container");
		this.appendChild(divContainer);
		var divHeader = new EDiv().attr(Attr.ClassName, "navbar-header pull-left");
		var aLogo = new EAnchor().attr(Attr.Href, '#').attr(Attr.ClassName, 'navbar-brand');
		var aImg = new EImage().attr(Attr.Src, "/assets/css/images/logo.png");
		aLogo.appendChild(aImg);		
		divHeader.appendChild(aLogo);
		divContainer.appendChild(divHeader);		
	}
	
}


class Breadcrumbs extends EDiv {
	public function new(crumbs:Array<String>)
	{
		super();
		this.attr(Attr.ClassName, "breadcrumbs");
		this.attr(Attr.Id, "breadcrumbs");	
		
		/*
		var script = new EScript().attr(Attr.Type, "text/javascript");
		script.addText("try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}");
		this.appendChild(script);				
		*/
		
		
		var breadcrumb = new EUnorderedList().attr(Attr.ClassName, "breadcrumb");
		this.appendChild(breadcrumb);	
		
		
		var crumb = new EListItem();		
		var i = new ESpan().classes("icon-home home-icon");
		crumb.appendChild(i);
		var a = new EAnchor().attr(Attr.Href, '/');
		a.addText('Hem');
		crumb.appendChild(a);
		breadcrumb.appendChild(crumb);
		
		
		for (crumb in crumbs)
		{
			//trace(crumb);
			var a = crumb.split('|');
			//var title = a[0];
			var title = EncodeTools.utf8(a[2]);
			var url = PathTools.removeSlash(a[1]);
			
			
			var cr = new EListItem();
			if (ArrayTools.isLast(crumbs, crumb))
			{
				cr.attr(Attr.ClassName, "active");
				cr.addText(title);
			}
			else
			{
				var a = new EAnchor().attr(Attr.Href, url);
				a.addText(title);			
				cr.appendChild(a);				
			}
			
			breadcrumb.appendChild(cr);
		}
	}
}

class PageContent extends EDiv {
	public function new()
	{
		super();
		this.attr(Attr.ClassName, "page-content");
		//this.appendChild(new PageHeader('Sidrubrik', 'Körakademin'));
	}
}

class PageStringContent extends PageContent {
	public function new(text:String)
	{
		super();
		this.attr(Attr.ClassName, "page-content");
		//this.appendChild(new PageHeader('Sidrubrik', 'Körakademin'));
		this.addHtml(text);
	}
}

class PageFlvContent extends PageContent {
	var filename:String;
	
	public function new (filename:String)
	{
		super();
		this.filename = filename;
		
	
		//trace(cryptFilename);
		
		
		this.addContent();
	}
	
	public function addContent()
	{
	
		var cryptFilename = CryptTools.crypt(filename);
		//trace(cryptFilename);
		var html = ''
		+'<link rel="stylesheet" type="text/css" href="/assets/video/skin/functional.css"></link>'
		+'<style type="text/css">   '
		+'	.flowplayer { width: 640px; height: 480px;}'
		+'</style>'
		+'<div class="flowplayer" data-swf="/assets/video/flowplayer.swf" data-ratio="0.4167">'
		+'	<video>'
		+'		<source type="video/flv" src="/video/$cryptFilename"></source>'
		+'	</video>'
		+'</div>'
		;
		//this.addText(html);
		this.addHtml(html);
				
		var filenamePng = FileTools.getDirectory(filename) + FileTools.getFilename(filename, false) + '.png';
		//trace(filenamePng);
		if (FileTools.exists(filenamePng))
		{
			var cryptFilename = CryptTools.crypt(filenamePng);			
			var img = new EImage().attr(Attr.Src, '/file/$cryptFilename').attr(Attr.ClassName, 'videoimage');
			
			this.appendChild(img);			
		}
		
	}

}

class PageOdtContent extends PageContent {
	var filename:String;
	
	public function new(filename:String, title:String=null, subtitle:String=null) {
		super();
		
		this.filename = filename;
		
		var copyfile = this.filename + '.copy.txt';
		if (FileTools.exists(copyfile)) {
			addCopyright(FileTools.getContent(copyfile));
		}
		
		this.attr(Attr.ClassName, "page-content content-max");
		if (title != null || subtitle != null) this.appendChild(new PageHeader(EncodeTools.utf8(title), EncodeTools.utf8(subtitle)));	
		this.addContent();		
	}
	
	public function addContent()
	{		
		var div:EDiv = new EDiv();
		this.appendChild(div);
		try {
			
			var html = new OdtTools().getHtmlFromOdt2(this.filename, false, 40, 2);
			
			
			if (html.toLowerCase().indexOf('href="player:') != -1)
			{
				//trace('replace player');
				html = this.replacePlayerTags(html);
			}
			
			
			//var html = OdtTools.getHtmlFromOdt(this.filename);
			div.addHtml(html);
		} catch (e:Dynamic)
		{
			div.addText(Std.string(e));
		}
	}
	
	public function addCopyright(html:String)	
	{
		var div:EDiv = new EDiv();
		div.attr(Attr.ClassName, 'alert alert-warning');
		div.addHtml(EncodeTools.utf8(html));
		this.appendChild(div);		
	}
	
	public function replacePlayerTags(html:String):String
	{
		var r = ~/<object[ .:a-zA-Z0-9="-_\/><\r\t\n]+object>/im;
		var compare = html;
		var rebuiltHtml = html;
		
		//trace(r.match(compare));
		while (r.match(compare))
		{
			r.match(compare);
			var match = r.matched(0);
			
			var pos = r.matchedPos();
			var beforeMatch = compare.substr(0, pos.pos);
			var afterMatch = compare.substr(pos.len + pos.pos);
			var r2 = ~/"player:([.a-zA-Z0-9\/_-]*)"/;
			r2.match(match);
			var fileAddress = r2.matched(1);
			var newTag = '<newtag src="$fileAddress" >testNewTag</newtag>';
			var newTag = playerTag(fileAddress);
			rebuiltHtml = StringTools.replace(rebuiltHtml, match, newTag);
			compare = compare.substr(pos.len + pos.pos);			
		}
		return rebuiltHtml;
	}	
	
	
	private function playerTag(file:String)
	{
		//trace(this.filename);
		var path = FileTools.getDirectory(this.filename);
		var filename = '$path$file';
		var cryptAdr = CryptTools.crypt(filename);
		var url = '/audio/$cryptAdr';
		
	return '
			<object id="wp-as-40_1-flash" type="application/x-shockwave-flash" data="/assets/audio/player.swf" width="290" height="24">
								<param name="movie" value="http://s0.wp.com/wp-content/plugins/audio-player/player.swf?m=1365086195g" />
								<param name="FlashVars" value="bg=0xF8F8F8&amp;leftbg=0xEEEEEE&amp;lefticon=0x666666&amp;rightbg=0xCCCCCC&amp;rightbghover=0x999999&amp;righticon=0x666666&amp;righticonhover=0xFFFFFF&amp;text=0x666666&amp;slider=0x666666&amp;track=0xFFFFFF&amp;border=0x666666&amp;loader=0x9FFFB8&amp;soundFile=$url" />
								<param name="quality" value="high" />
								<param name="menu" value="false" />
								<param name="bgcolor" value="#FFFFFF" />
								<param name="wmode" value="opaque" />
			</object>
			';
	}
	
	
}




class PageHeader extends EDiv {
	public function new(title:String, subtitle:String=null)
	{
		super();
		this.attr(Attr.ClassName, "page-header");	
		var h1 = new EHeader1().addText(title);
		this.appendChild(h1);
		if (subtitle != null) {
			var small = new ESmall();
			var i = new ESpan().attr(Attr.ClassName, "icon-double-angle-right");
			small.appendChild(i);
			small.addText(subtitle);			
			h1.appendChild(small);
		}
	}
}


class Sidebar extends EDiv {
	
	public function new(bigmenuItems:Array<BigmenuItem>=null, sidemenuItems:Array<SidemenuItem>=null) 
	{		
		super();
		this.attr(Attr.ClassName, "sidebar");
		this.attr(Attr.Id, "sidebar");		
				
		if (bigmenuItems != null) 
		{			
			var bigMenu = new Bigmenu(bigmenuItems);		
			this.appendChild(bigMenu);
		}
		
		/*
		var test2sub = new Submenu();
		test2sub.appendChild(new NavlistLi('test2subA', 'linksub1.html'));
		test2sub.appendChild(new NavlistLi('test2subB', 'linksub2.html'));					
		var sidemenu:Array<SidemenuItem> = 		
		[
			{title: 'test', url:'/test' },
			{title: 'test2', url:'/test2', submenu: test2sub },
			{title: 'test3', url:'/test3' },
		];		
		*/
		
		if (sidemenuItems != null)
		{
			var sideMenu = new Sidemenu(sidemenuItems);
			this.appendChild(sideMenu);
		}
	}
}

typedef BigmenuItem = {
	title: String,
	url: String,
	clss: String,
	?icon: String,
	?iconRight:String,
	?imgClss:String,
}


class Bigmenu extends EUnorderedList {
	public function new(items: Array<BigmenuItem>) 
	{		
		super();
		this.classes('bigmenu');
		
		for (item in items)
		this.appendChild(new BigMenuLi(item.title, item.url, item.clss, item.icon, item.iconRight, item.imgClss));
		
		/*
		this.appendChild(new BigMenuLi('Rösten', 'rosten.html', 'bigmenu-rosten'));
		this.appendChild(new BigMenuLi('Noterna', 'noterna.html', 'bigmenu-empty'));
		this.appendChild(new BigMenuLi('Repertoar', 'repertoar.html', 'bigmenu-empty'));
		*/
		
	}
}

typedef SidemenuItem = {
	title: String,
	url: String,
	?submenu: Submenu,
}

class Sidemenu extends EUnorderedList {
	public function new(items: Array<SidemenuItem>) {
		super();
		this.classes('nav nav-list');		
		
		for (item in items) this.appendChild(new NavlistLi(item.title, item.url, item.submenu));
		
		/*
		var subMenu = new Submenu();
		subMenu.appendChild(new NavlistLi('test', 'linksub1.html'));
		subMenu.appendChild(new NavlistLi('test2', 'linksub2.html'));	
		*/
		/*
		this.appendChild(new NavlistLi('test', 'link.html'));
		this.appendChild(new NavlistLi('testsub', 'sub.html'));		
		*/
	}		
	
}

class Submenu extends EUnorderedList {
	public function new(isSubmenu:Bool=false) {
		super();
		this.classes('submenu');
	}		
	
	
}

class MainContent extends EDiv {
	public function new(breadcrumbs:Breadcrumbs, content:PageContent) 
	{		
		super();
		this.attr(Attr.ClassName, "main-content");
		this.attr(Attr.Id, "main-content");		
		/*
		var breadcrumbs =  new Breadcrumbs(['test|/test', 'test2|/test2']);
		*/
		if (breadcrumbs != null) this.appendChild(breadcrumbs);
		
		if (content != null) this.appendChild(content);
		
	}
}

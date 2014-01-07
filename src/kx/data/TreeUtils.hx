package kx.data;
import cx.ArrayTools;
import cx.EncodeTools;
import cx.FileTools;
import cx.StrTools;
import haxe.ds.StringMap.StringMap;
import hxdom.Attr;
import hxdom.Elements.EAnchor;
import hxdom.Elements.EBody;
import hxdom.Elements.EHead;
import hxdom.Elements.EDiv;
import hxdom.Elements.EHeader1;
import hxdom.Elements.EHtml;
import hxdom.Elements.EImage;
import hxdom.Elements.ELink;
import hxdom.Elements.EListItem;
import hxdom.Elements.EMeta;
import hxdom.Elements.EScript;
import hxdom.Elements.ESmall;
import hxdom.Elements.ESpan;
import hxdom.Elements.ETitle;
import hxdom.Elements.EUnorderedList;
import hxdom.Elements.Text;
import hxdom.HtmlSerializer;
import kx.data.TreeUtils.BigMenuLi;
import kx.data.TreeUtils.BigMenuUl;
import kx.data.TreeUtils.Breadcrumbs;
import kx.data.TreeUtils.MainContent;
import kx.data.TreeUtils.Navbar;
import kx.data.TreeUtils.PageContent;
import kx.data.TreeUtils.PageHeader;
import kx.data.TreeUtils.Sidebar;
import kx.data.TreeUtils.Sidemenu;
import kx.data.TreeUtils.Submenu;
import nx.enums.EHeadType;
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
	
	static public function getTree(dir:String): StringMap<DocInfo>
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
				trace([subLevel, level]);
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
	
	static public function buildIndex()
	{
		
		var html = new EHtml();

		var head = new EHead();
		head.appendChild(new EMeta().attr(Attr.Charset, 'utf-8'));
		head.appendChild(new ETitle().addText('Körakademin'));
		head.appendChild(new ELink().attr(Attr.Href, "assets/css/bootstrap.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "assets/css/font-awesome.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "assets/css/ace.min.css").attr(Attr.Rel, "stylesheet"));
		head.appendChild(new ELink().attr(Attr.Href, "assets/css/kak.css").attr(Attr.Rel, "stylesheet"));
		
		
		var body = new EBody();
		
		
		
		var navbar = new Navbar(); // EDiv().attr(Attr.ClassName, "navbar navbar-default").attr(Attr.Id, "navbar");
		
		
		
		
		
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
		
		var sidebar = new Sidebar(); // new EDiv().attr(Attr.ClassName, "sidebar").attr(Attr.Id, "sidebar");
		mainContainerInner.appendChild(sidebar);
		
		var mainContent = new MainContent(); // new EDiv().attr(Attr.ClassName, "main-content").attr(Attr.Id, "main-content");		
		mainContainerInner.appendChild(mainContent);

		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "assets/js/bootstrap.min.js"));
		body.appendChild(new EScript().attr(Attr.Type, "text/javascript").attr(Attr.Src, "assets/js/ace.min.js"));
		
		
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


class BigMenuUl extends EUnorderedList {
	
	public function new() {
		super();
		this.classes('bigmenu');
	}
	
	
}

class BigMenuLi extends EListItem {
	
	public function new(title:String, link:String, imgClass:String = 'btn-success') 
	{
		super();

		
		var a = new EAnchor();
		a.attr(Attr.Href, link);
		this.appendChild(a);
		
		var div = new EDiv();
		div.classes(imgClass);
		div.addText(title);
		a.appendChild(div);
		
		this.classes('btn btn-success');
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
			
			i.classes('icon-edit');
		}
		
	}
}


class Navbar extends EDiv {
	public function new()
	{
		super();
		this.attr(Attr.ClassName, "navbar navbar-default");
		this.attr(Attr.Id, "navbar");	
		var divContainer = new EDiv().attr(Attr.ClassName, "navbar-container").attr(Attr.Id, "navbar-container");
		this.appendChild(divContainer);
		
		var divHeader = new EDiv().attr(Attr.ClassName, "navbar-header pull-left");
		var aLogo = new EAnchor().attr(Attr.Href, '#').attr(Attr.ClassName, 'navbar-brand');
		var aImg = new EImage().attr(Attr.Src, "assets/css/images/logo.png");
		aLogo.appendChild(aImg);
		divHeader.appendChild(aLogo);
		divContainer.appendChild(divHeader);
		
	}
}


class Breadcrumbs extends EDiv {
	public function new()
	{
		super();
		this.attr(Attr.ClassName, "breadcrumbs");
		this.attr(Attr.Id, "breadcrumbs");	
		
		
		var script = new EScript().attr(Attr.Type, "text/javascript");
		script.addText("try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}");
		this.appendChild(script);				

		var breadcrumb = new EUnorderedList().attr(Attr.ClassName, "breadcrumb");
		this.appendChild(breadcrumb);		
		var crumbHome = new EListItem();
		
		var i = new ESpan().classes("icon-home home-icon");
		crumbHome.appendChild(i);
		crumbHome.addText('Hem');
		breadcrumb.appendChild(crumbHome);
		
		var crumbNotlasning = new EListItem();
		crumbNotlasning.attr(Attr.ClassName, "active");
		crumbNotlasning.addText('Notläsning');
		breadcrumb.appendChild(crumbNotlasning);
	}
}

class PageContent extends EDiv {
	public function new()
	{
		super();
		this.attr(Attr.ClassName, "page-content");

		this.appendChild(new PageHeader('Testar rubrik', 'Lillemor Bodin Carlson'));
		
		
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
	
	public function new() 
	{		
		super();
		this.attr(Attr.ClassName, "sidebar");
		this.attr(Attr.Id, "sidebar");		
		
		var bigMenu = new Bigmenu();		
		this.appendChild(bigMenu);
		
		var sideMenu = new Sidemenu();		
		this.appendChild(sideMenu);

		
		
		
		
		
	}
}

class Bigmenu extends EUnorderedList {
	public function new() 
	{		
		super();
		this.classes('bigmenu');
		
		this.appendChild(new BigMenuLi('Rösten', 'rosten.html', 'bigmenu-rosten'));
		this.appendChild(new BigMenuLi('Noterna', 'noterna.html', 'bigmenu-empty'));
		this.appendChild(new BigMenuLi('Repertoar', 'repertoar.html', 'bigmenu-empty'));
		
		
	}
}

class Sidemenu extends EUnorderedList {
	public function new(isSubmenu:Bool=false) {
		super();
		this.classes('nav nav-list');
		
		var subMenu = new Submenu();
		subMenu.appendChild(new NavlistLi('test', 'linksub1.html'));
		subMenu.appendChild(new NavlistLi('test2', 'linksub2.html'));
		
		this.appendChild(new NavlistLi('test', 'link.html'));
		this.appendChild(new NavlistLi('testsub', 'sub.html', subMenu));
		
	}		
	
}

class Submenu extends EUnorderedList {
	public function new(isSubmenu:Bool=false) {
		super();
		this.classes('submenu');
	}		
	
	
}

class MainContent extends EDiv {
	public function new() 
	{		
		super();
		this.attr(Attr.ClassName, "main-content");
		this.attr(Attr.Id, "main-content");		
		
		var breadcrumbs =  new Breadcrumbs();
		this.appendChild(breadcrumbs);
		
		var pageContent = new PageContent();	
		this.appendChild(pageContent);		
		
	}
}

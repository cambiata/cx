/**
 * ...
 * @author Franco Ponticelli
 */

package cx;

#if neko
typedef Sys = neko.Sys;
#elseif php
typedef Sys = php.Sys;
#elseif cpp
typedef Sys = cpp.Sys;
#end
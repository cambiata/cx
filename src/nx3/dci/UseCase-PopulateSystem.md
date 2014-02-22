## PopulateSystem - Use case

<pre>
Take care of first bar in bar array
Reset BarConfig attributes visibility for current bar
    System has no bars
        Set BarConfig to SystemConfig
        Bar attributes differs from PrevBarConfig
            Adapt BarConfig to PrevBarConfig
    Bar has attribute visibility settings that differs conflicts with BarConfig            
        Adapt BarConfig to bar attribute visibility settings
    Sum attributes width (according to BarConfig) and bar content width
        Bar attributes width + content width exceeds page width
            Throw exception
Sum system width + current bar attributes and content width
    Sum exceeds page width (current bar doesn't fit in system)
        Use case ends
        
    Following bar's attribute(s) differ from current bar's
        Following bar attributes visibility settings make some of them visible
        Sum system width + current bar attrib + content width + cautionary attribute(s)
            Sum exceeds page width (cur bar incl caut attrib doesn't fit into system)
                ...
        Set BarConfig to show cautionary attribute(s)
Add the current bar and BarConfig to System
Increase the system width by the total width of the current bar
Shift the current bar from the bar array
</pre>

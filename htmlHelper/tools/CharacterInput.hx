package htmlHelper.tools;
import js.html.Event;
import js.html.KeyboardEvent;
import js.Browser;
// Needs more thought in regard to depreciated but works fine for my needs.
class CharacterInput {
    public var specialUpdate:      Void   -> Void;
    public var letterUpdate:       String -> Void;
    public var leftDown:           Bool = false;
    public var rightDown:          Bool = false;    
    public var downDown:           Bool = false;
    public var upDown:             Bool = false;
    public var shiftDown:          Bool = false;
    public var enterDown:          Bool = false;
    public var tabDown:            Bool = false;
    public var altDown:            Bool = false;
    public var cmdDown:            Bool = false;
    public var spaceDown:          Bool = false;
    public var controlDown:        Bool = false;
    public function new(){
        Browser.document.onkeydown  = keyDown;
        Browser.document.onkeyup    = keyUp;
    }
    public function buttonsDown(){
        var str = '';
        if( leftDown )    str += 'left,';
        if( rightDown )   str += 'right,';
        if( downDown )    str += 'down,';
        if( upDown )      str += 'up,';
        if( shiftDown )   str += 'shift,';
        if( enterDown )   str += 'enter,';
        if( tabDown )     str += 'tab,';
        if( altDown )     str += 'alt,';
        if( cmdDown )     str += 'cmd,';
        if( spaceDown )   str += 'space,';
        if( controlDown ) str += 'control,'; 
        return str;
    }
    inline
    function keyDown( e: KeyboardEvent ) {
        e.preventDefault();
        var keyCode = e.keyCode;
        var special = true;
        switch( keyCode ){
            case KeyboardEvent.DOM_VK_LEFT:
                leftDown    = true;
            case KeyboardEvent.DOM_VK_RIGHT:
                rightDown   = true;
            case KeyboardEvent.DOM_VK_UP:
                upDown      = true;
            case KeyboardEvent.DOM_VK_DOWN:
                downDown    = true;
            case KeyboardEvent.DOM_VK_SHIFT:
                shiftDown   = true;
            case KeyboardEvent.DOM_VK_RETURN:
                enterDown   = true;
            case KeyboardEvent.DOM_VK_TAB:
                tabDown     = true;
            case KeyboardEvent.DOM_VK_ALT:
                altDown     = true;
            case KeyboardEvent.DOM_VK_META:
                cmdDown     = true;
            case KeyboardEvent.DOM_VK_SPACE:
                spaceDown   = true;
            case KeyboardEvent.DOM_VK_CONTROL:
                controlDown = true;
            default:
                special = false;
                if( letterUpdate != null ) if( e.key != null ) letterUpdate( e.key );
        }
        if( special ) if( specialUpdate != null ) specialUpdate();
    }
    inline
    function keyUp( e: KeyboardEvent ) {
        e.preventDefault();
        var keyCode = e.keyCode;
        switch(keyCode){
            case KeyboardEvent.DOM_VK_LEFT:
                leftDown    = false;
            case KeyboardEvent.DOM_VK_RIGHT:
                rightDown   = false;
            case KeyboardEvent.DOM_VK_UP:
                upDown      = false;
            case KeyboardEvent.DOM_VK_DOWN:
                downDown    = false;
            case KeyboardEvent.DOM_VK_SHIFT:
                shiftDown   = false; 
            case KeyboardEvent.DOM_VK_RETURN:
                enterDown   = false;
            case KeyboardEvent.DOM_VK_TAB:
                tabDown     = false;
            case KeyboardEvent.DOM_VK_ALT:
                altDown     = false;
            case KeyboardEvent.DOM_VK_META:
                cmdDown     = false;
            case KeyboardEvent.DOM_VK_SPACE:
                spaceDown   = false;
            case KeyboardEvent.DOM_VK_CONTROL:
                controlDown = false;
            default: 
                
        }
    }
}

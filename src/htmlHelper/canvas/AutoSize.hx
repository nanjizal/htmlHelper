package htmlHelper.canvas;
#if !htmlHelperDoc
import geom.matrix.Matrix2x2;
#end
import js.Browser;
import js.html.CanvasElement;
class AutoSize {
    public function new(){
    
    }
    /**
     * Use to autosize canvas to cover whole screen
     */
    public
    function setFull( canvas: CanvasElement, defaultSize: Int = 768, autoColor: Bool = true ){
        var win            = Browser.window;
        var document       = win.document;
        var doc            = document;
        var docElement     = doc.documentElement;
        var docStyle       = docElement.style;
        var bodyStyle      = doc.body.style;
        docStyle.padding   = "0";
        docStyle.margin    = "0";
        bodyStyle.padding  = "0";
        bodyStyle.margin   = "0";
        if( autoColor ) bodyStyle.color    = "0x9B7031";
        var canvaStyle     = canvas.style;
        canvaStyle.display = "block";
        var resize = 
        function() {
            var dpRatio     = win.devicePixelRatio;
            canvas.width    = Std.int( win.innerWidth * dpRatio );
            canvas.height   = Std.int( win.innerHeight * dpRatio );
            var nWid        = Std.int( canvas.width  / dpRatio );
            var nHi         = Std.int( canvas.height / dpRatio );
            if( nHi != hi || nWid != wid ){
                wid         = nWid;
                hi          = nHi;
                var size    = ( hi > wid )? wid: hi;
                scale       = size/defaultSize; // may need more thought..
                canvaStyle.width  = docElement.clientWidth + "px";
                canvaStyle.height = docElement.clientHeight + "px";
                //transform         = scale * Matrix2x2.unit;
            }
        }
        win.onresize = resize;
        resize();
    }
    /**
     * Use to keep canvas to half screen width autosize
     * Untested
     */
    public
    function setVerticalSplit( canvas:      CanvasElement
                             , defaultSize: Int = 768
                             , autoColor: Bool = true ){
        var win            = Browser.window;
        var document       = win.document;
        var doc            = document;
        var docElement     = doc.documentElement;
        var docStyle       = docElement.style;
        var bodyStyle      = doc.body.style;
        docStyle.padding   = "0";
        docStyle.margin    = "0";
        bodyStyle.padding  = "0";
        bodyStyle.margin   = "0";
        if( autoColor ) bodyStyle.color    = "0x9B7031";
        var canvaStyle     = canvas.style;
        canvaStyle.display = "block";
        var resize = 
        function() {
            var dpRatio     = win.devicePixelRatio;
            canvas.width    = Std.int( win.innerWidth * dpRatio );
            canvas.height   = Std.int( win.innerHeight * dpRatio );
            var nWid        = Std.int( 0.5 * canvas.width  / dpRatio );
            var nHi         = Std.int( canvas.height / dpRatio );
            if( nHi != hi || nWid != wid ){
                wid         = nWid;
                hi          = nHi;
                var size    = ( hi > wid )? wid: hi;
                scale       = size/defaultSize; // may need more thought..
                canvaStyle.width  = docElement.clientWidth + "px";
                canvaStyle.height = docElement.clientHeight + "px";
                //transform         = scale * Matrix2x2.unit;
            }
        }
        win.onresize = resize;
        resize();
    }
    public var wid:        Int  = 0;
    public var hi:         Int  = 0;
    public var resize:     Void->Void;
    //public var transform:  Matrix2x2;
    public var scale:      Float = 1.;
}
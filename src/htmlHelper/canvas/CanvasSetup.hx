package htmlHelper.canvas;

// html setup code
import js.Browser;
import htmlHelper.tools.DivertTrace;
import htmlHelper.canvas.CanvasWrapper;
import htmlHelper.canvas.Surface;

class CanvasSetup {
    public var canvasWrapper:  CanvasWrapper;
    public var surface:        Surface;
    public var divertTrace:    DivertTrace;
    public var factor = 4.;
    public
    function new(){
        divertTrace = new DivertTrace();
        var canvas = new CanvasWrapper();
        canvas.width  = 1024;
        canvas.height = 768;
        var dom = cast canvas;
        var style = dom.style;
        style.background = 'black';
        Browser.document.body.appendChild( cast canvas );
        surface = new Surface({ x: 10, y: 10, me: canvas.getContext2d() });
        overSampleCanvas();
    }
    function overSampleCanvas(){
      var ctx = surface.me;
      var canvas = canvasWrapper;
      var width = canvas.width;
      var height = canvas.height;
      canvas.width = 0 | Std.int(width * factor);
      canvas.height = 0 | Std.int(height * factor);
      canvas.style.width = width + 'px';
      canvas.style.height = height + 'px';
      ctx.scale( factor, factor );
    }
    public inline
    function clear(){
        var ctx = surface.me;
        ctx.clearRect( 0, 0, canvas.width, canvas.height );
        overSampleCanvas( canvas, surface.me, factor );
    }
}

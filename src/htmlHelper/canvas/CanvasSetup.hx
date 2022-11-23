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
        canvasWrapper = new CanvasWrapper();
        canvasWrapper.width  = 1024;
        canvasWrapper.height = 768;
        var dom = cast canvasWrapper;
        var style = dom.style;
        style.background = 'black';
        Browser.document.body.appendChild( cast canvasWrapper );
        surface = new Surface({ x: 10, y: 10, me: canvasWrapper.getContext2d() });
        overSampleCanvas();
    }
    function overSampleCanvas(){
      var ctx = surface.me;
      var canvas = canvasWrapper;
      var width = canvas.width;
      var height = canvas.height;
      canvas.width = 0 | Std.int(width * factor);
      canvas.height = 0 | Std.int(height * factor);
      var dom = cast canvasWrapper;
      var style = dom.style;
      style.width = width + 'px';
      style.height = height + 'px';
      ctx.scale( factor, factor );
    }
    public inline
    function clear(){
        var ctx = surface.me;
        ctx.clearRect( 0, 0, canvasWrapper.width, canvasWrapper.height );
        overSampleCanvas();
    }
}

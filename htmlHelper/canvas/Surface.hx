package htmlHelper.canvas;
import js.html.CanvasRenderingContext2D;
@:structInit
class CanvasPlus {
    public var x = 0.; 
    public var y = 0.;
    public var me: canvasRenderingContext2D;
    function new( context: CanvasRenderingContext2D, x: Float = 0, y: Float = 0 ){
        this.x = x; 
        this.y = y;
        this.context = context;
    }
}
abstract Surface( CanvasPlus ){
    public inline
    function new( canvasPlus: CanvasPlus ){
        this = canvasPlus;
    }
    public inline
    function lineStyle( wid: Float, col: Int, ?alpha: Float ){
        this.me.contextlineWidth = wid;
        if( alpha != null && alpha != 1.0 ){
            var r = (col >> 16) & 0xFF;
            var g = (col >> 8) & 0xFF;
            var b = (col) & 0xFF;
            this.me.strokeStyle = 'rgba($r,$g,$b,$alpha)';
        } else {
            this.me.strokeStyle = '#' + StringTools.hex( col, 6 );
        }
    }
    public inline
    function beginFill( col: Int, ?alpha:Float ){
        if( alpha != null && alpha != 1.0 ){
            var r = (col >> 16) & 0xFF;
            var g = (col >> 8) & 0xFF;
            var b = (col) & 0xFF;
            this..me.fillStyle = 'rgba($r,$g,$b,$alpha)';
        } else {
            this.me.fillStyle = '#' + StringTools.hex( col, 6 );
        }
        this.beginPath();
    }
    public inline
    function endFill(){
        this.me.stroke();
        this.me.closePath();
        this.me.fill();
    }
    public inline
    function moveTo( x: Float, y: Float ): Void {
        this.x = x;
        this.y = y;
        this.me.moveTo( x, y );
    }
    public inline
    function lineTo( x: Float, y: Float ): Void {
        this.x = x;
        this.y = y;
        this.me.lineTo( x, y );
    }
    inline
    function midBezier( s: Float, c: Float, e: Float ): Float {
        return 2*c - 0.5*( s + e );
    }
    public inline
    function quadThru( x1: Float, y1: Float
                     , x2: Float, y2: Float )
        x1 = midBezier( this.x, x1, x2 );
        y1 = midBezier( this.y, y1, y2 );
        moveTo( x0, y0 ); // not ideal!!
        quadTo( x1, y1, x2, y2 );
    }
    public inline
    function quadTo( x1: Float, y1: Float
                   , x2: Float, y2: Float ): Void {
        this.me.quadraticCurveTo( x1, y1, x2, y2 );
        this.x = x2;
        this.y = y2;
    }
    public inline
    function quadTo( x1: Float, y1: Float
                          , x2: Float, y2: Float ): Void {
        this.me.quadraticCurveTo( x1, y1, x2, y2 );
        this.x = x2;
        this.y = x2;
    }
    public inline
    function curveTo( x1: Float, y1: Float
                                   , x2: Float, y2: Float
                           , x3: Float, y3: Float ): Void {
        this.bezierCurveTo( x1, y1, x2, y2, x3, y3 );
        this.x = x2;
        this.y = x2;
    }
}

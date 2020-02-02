package htmlHelper.webgl;
import js.Browser;
import js.html.Element;
import js.html.CanvasElement;
import js.html.BodyElement;
import js.html.webgl.RenderingContext;
import js.html.webgl.ContextAttributes;
import js.html.webgl.Shader;
import js.html.webgl.Program;
import js.html.webgl.UniformLocation;
import js.html.Image;
import haxe.io.UInt16Array;
import haxe.io.Float32Array;
import haxe.io.Int32Array;
import htmlHelper.webgl.WebGLSetup;
using htmlHelper.webgl.WebGLSetup;
typedef RGB = {
    var r: Float;
    var g: Float;
    var b: Float;
}
class WebGLSetup {
    public var gl:             RenderingContext;
    public var program:        Program;
    public var width:          Int;
    public var height:         Int;
    public var canvas:         CanvasElement;
    public var bgRed           = 1.;
    public var bgGreen         = 1.;
    public var bgBlue          = 1.;
    public var bgAlpha         = 1.;
    public var DEPTH_TEST      = true;
    public var CULL_FACE       = true; 
    public var BACK            = true;
    public var matrix32Array   : Float32Array; 
    var vertices               = new Float32Array(100);
    var triangleColors:        Array<UInt>;
    var indices                = new UInt16Array(100);
    var colors                 = new Float32Array(100);
    public
    function new( width_: Int, height_: Int, autoChild: Bool = true ){
        matrix32Array     = ident(); // internal matrix passed to shader
        width             = width_;
        height            = height_;
        canvas            = Browser.document.createCanvasElement();
        canvas.width      = width;
        canvas.height     = height;
        var dom           = cast canvas;
        var style         = dom.style;
        style.paddingLeft = "0px";
        style.paddingTop  = "0px";
        style.left        = Std.string( 0 + 'px' );
        style.top         = Std.string( 0 + 'px' );
        style.position    = "absolute";
        if( autoChild ) Browser.document.body.appendChild( cast canvas );
        gl = canvas.getContextWebGL();
    }
    public
    function setupProgram( vertexString: String, fragmentString: String ): Program {
        var vertex   = gl.shaderFromString( RenderingContext.VERTEX_SHADER,   vertexString );
        var fragment = gl.shaderFromString( RenderingContext.FRAGMENT_SHADER, fragmentString );
        program      = gl.createShaderProgram( vertex, fragment );
        return program;
    }
    public
    function addImage( img: Image ){
        uploadImage( gl, img );
    }
    public
    function clearVerticesAndColors(){
        var vl = vectices.length;
        var il = indices.length;
        var cl = colors.length;
        vertices = new Float32Array(vl);
        indices  = new UInt16Array(il);
        colors   = new Float32Array(cl);
        // texture?
    }
    static inline
    function passIndicesToShader( gl: RenderingContext, indices: UInt16Array ){
        var indexBuffer = gl.createBuffer(); // triangle indicies data 
        gl.bindBuffer( RenderingContext.ELEMENT_ARRAY_BUFFER, indexBuffer );
        gl.bufferData( RenderingContext.ELEMENT_ARRAY_BUFFER, untyped indices, RenderingContext.STATIC_DRAW );
        gl.bindBuffer( RenderingContext.ELEMENT_ARRAY_BUFFER, null );
    }
    public
    function setVerticesAndColors( vertices: Float32Array, triangleColors: Array<UInt> ){
        var rgb: RGB;
        var colorAlpha = 1.0;
        var len = colors.length;
        for (i in 0...Std.int( vertices.length/3 ) ) {
            rgb = toRGB( triangleColors[ i ] );
            for( j in 0...3 ){  // works but...
                colors[len++] = rgb.r;
                colors[len++] = rgb.g;
                colors[len++] = rgb.b;
                colors[len++] = colorAlpha;
            }
            indices.push( i );
        }
        gl.passIndicesToShader( indicies );
        gl.uploadDataToBuffers( program, vertices, colors );
    }
    public function render(){
        gl.clearColor( bgRed, bgGreen, bgBlue, bgAlpha );
        if( DEPTH_TEST ) gl.enable( RenderingContext.DEPTH_TEST );
        if( CULL_FACE )  gl.enable( RenderingContext.CULL_FACE ); 
        if( BACK )       gl.cullFace( RenderingContext.BACK );
        //gl.disable(RenderingContext.CULL_FACE);
        
        gl.clear( RenderingContext.COLOR_BUFFER_BIT );
        gl.viewport( 0, 0, canvas.width, canvas.height );
        var modelViewProjectionID = gl.getUniformLocation( program, 'modelViewProjection' );
        /// you can update matrix32Array in the render loop.
        gl.uniformMatrix4fv( modelViewProjectionID, false, untyped matrix32Array );
        gl.drawArrays( RenderingContext.TRIANGLES, 0, indices.length );
    }
    static inline
    function shaderFromString( gl:           RenderingContext
                             , shaderType:   Int
                             , shaderString: String ){
        var shader = gl.createShader( shaderType );
        gl.shaderSource(  shader, shaderString );
        gl.compileShader( shader );
        return shader;
    }
    static inline
    function createShaderProgram( gl: RenderingContext, vertex: Shader, fragment: Shader ): Program {
        var program = gl.createProgram();
        gl.attachShader( program, vertex );
        gl.attachShader( program, fragment );
        gl.linkProgram(  program );
        gl.useProgram(   program );
        return program;
    }
    static inline
    function shaderInput<T>( gl:      RenderingContext
                                           , program: Program
                                           , name:    String
                                           , att:     Int
                                           , arr:     T /*Float32Array */
                                           , number:  Int ){
        var buffer = gl.createBuffer();
        var arrBuffer = RenderingContext.ARRAY_BUFFER;
        gl.bindBuffer( arrBuffer, buffer );
        // RenderingContext.FLOAT, RenderingContext.INT, RenderingContext.UNSIGNED_INT
        // Float32Array,Int32Array, Uint16Array
        gl.bufferData( arrBuffer, untyped arr, RenderingContext.STATIC_DRAW );
        var flo = gl.getAttribLocation( program, name );
        gl.vertexAttribPointer( flo, att, number, false, 0, 0 ); 
        gl.enableVertexAttribArray( flo );
        gl.bindBuffer( arrBuffer, null );
    }
    static inline
    function uploadDataToBuffers( gl: RenderingContext, program: Program, vertices: Float32Array, colors: Float32Array, ?texture: Float32Array ){//, indices: Uint16Array ){
        gl.shaderInput( program, 'pos',   3, vertices, RenderingContext.FLOAT );
        gl.shaderInput( program, 'color', 4, colors, RenderingContext.FLOAT );
        if( texture != null ) gl.shaderInput( program, 'aTexture', 2, texture, RenderingContext.FLOAT );
    }
    // TODO: generalize
    static inline
    function uploadImage( gl: RenderingContext, image: Image ){
        var texture = gl.createTexture();
        gl.activeTexture( RenderingContext.TEXTURE0 );
        gl.bindTexture( RenderingContext.TEXTURE_2D, texture );
        gl.pixelStorei( RenderingContext.UNPACK_FLIP_Y_WEBGL, 1 );
        gl.texParameteri( RenderingContext.TEXTURE_2D
                        , RenderingContext.TEXTURE_WRAP_S
                        , RenderingContext.CLAMP_TO_EDGE );
        gl.texParameteri( RenderingContext.TEXTURE_2D
                        , RenderingContext.TEXTURE_WRAP_T
                        , RenderingContext.CLAMP_TO_EDGE );
        gl.texParameteri( RenderingContext.TEXTURE_2D
                        , RenderingContext.TEXTURE_MIN_FILTER
                        , RenderingContext.NEAREST );
        gl.texParameteri( RenderingContext.TEXTURE_2D
                        , RenderingContext.TEXTURE_MAG_FILTER
                        , RenderingContext.NEAREST );
        gl.texImage2D(    RenderingContext.TEXTURE_2D, 0
                        , RenderingContext.RGBA
                        , RenderingContext.RGBA
                        , RenderingContext.UNSIGNED_BYTE
                        , image );
    }
    public static inline
    function toRGB(int:Int) : RGB {
        return {
            r: ((int >> 16) & 255) / 255,
            g: ((int >> 8) & 255) / 255,
            b: (int & 255) / 255
        }
    }
    public static inline
    function ident(): Float32Array {
        var arr = new Float32Array(16);
        arr[0] = 1.0; arr[1] = 0.0; arr[2] = 0.0; arr[3] = 0.0;
        arr[4] = 1.0; arr[5] = 0.0; arr[6] = 0.0; arr[7] = 0.0;
        arr[8] = 1.0; arr[9] = 0.0; arr[10] = 0.0; arr[11] = 0.0;
        arr[12] = 1.0; arr[13] = 0.0; arr[14] = 0.0; arr[15] = 0.0;
        return arr;
    }
}

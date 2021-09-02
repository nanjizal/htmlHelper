package htmlHelper.tools;
import js.html.DivElement;
import js.Browser;
@:structInit
class CodeLocation{
    public var count: Int;
    public var fileName:String;
    public var lineNumber:Int;
    public var className:String;
    public var methodName:String;
    public var ?customParams:Array<Dynamic>;
    public
    function new( count: Int
                       , fileName: String
                       , lineNumber: Int
                       , className: String
                       , methodName: String
                       , ?customParams: Array<Dynamic>
                       ){
        this.count        = count;
        this.fileName     = fileName;
        this.lineNumber   = lineNumber;
        this.className    = className;
        this.methodName   = methodName;
        this.customParams = customParams;
    }
    public static inline
    function create( posInfos: haxe.PosInfos, count: Int = 0  ): CodeLocation {
        var codeLocation: CodeLocation { count, posInfos.fileName, posInofs.lineNumber, posInfos.className, posInfos.methodName, posInfo.customParams };
        return codeLocation;
    }
}
class DivertTrace{
    var traceDiv:               DivElement;
    var traceString:            String = '';
    var textStyle0 = '<span style="font-size:12px; color:Silver">';
    var textStyle1 = '<span style="font-size:14px; color:Grey">';
    public var arrCount = new Array<CodeLocation>();
    public
    function new( ?left: Float = 610, ?d: DivElement ){
        divertTrace( left, d );
    }
    public
    function traceCount( d: Dynamic, counting: Int
                                , ?pos:haxe.PosInfos ) {
        var exists = false;
        var v: CodeLocation;
        if( arrCount.length == 0 ){
            arrCount[ 0 ] = CodeLocation.create( pos );
        }
        for( i in 0...arr.length ){
            v = arrCount[ i ];
            if( v.fileName   == pos.fileName 
             && v.lineNumber == pos.lineNumber ){
                 exists = true;
                 if( v.count < counting ){
                     myTrace( d, pos );
                     v.count++;
                    }
             }
             break;
         }
         if( !exists ){
             myTrace( d, pos );
             arrCount[ arrCount.length ] = CodeLocation.create( pos );
         }
    }
    function divertTrace( left: Float, d: DivElement ){
        if( d == null ) {
            var doc = Browser.document;
            traceDiv = doc.createDivElement();
            doc.body.appendChild( cast traceDiv );
            var dom           = cast traceDiv;
            var style         = dom.style;
            style.position = 'absolute';
            style.top = '0px';
            style.left = Std.string( left ) + 'px';
            style.height = '500px';
            style.width = '500px';
            style.zIndex = '99';
            style.overflow = 'auto';
        } else {
            traceDiv = d;
        }
        haxe.Log.trace = myTrace;
    }
    function myTrace( v : Dynamic, ?inf : haxe.PosInfos ) {
        if( Std.string( v ) == '' ) return;
        traceString += textStyle0
            	    + inf.className
                    + '.' + inf.methodName 
                    + ' ( ' + Std.string( inf.lineNumber ) + ' )'
                    + '</span>'
                    + '<br> - '
                    + textStyle1
                    + Std.string( v ) 
                    + '</span>'
                    + '<br>';
        traceDiv.innerHTML = traceString;
        /* notes on PosInfos
            var fileName : String;
            var lineNumber : Int;
            var className : String;
            var methodName : String;
            var customParams : Array<Dynamic>;
        */
    }
}

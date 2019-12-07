package htmlHelper.tools;
import js.html.DivElement;
import js.Browser;
class DivertTrace{
    var traceDiv:               DivElement;
    var traceString:            String = '';
    var textStyle0 = '<span style="font-size:12px; color:Silver">';
    var textStyle1 = '<span style="font-size:14px; color:Grey">';
    public
    function new( ?d: DivElement ){
        divertTrace( d );
    }
    function divertTrace( ?d: DivElement ){
        if( d == null ) {
            var doc = Browser.document;
            traceDiv = doc.createDivElement();
            doc.body.appendChild( cast traceDiv );
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

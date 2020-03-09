package htmlHelper.tools;
import js.Lib;
import haxe.Http;
import js.Browser;
import haxe.ds.StringMap;
class TextLoader{
    public var contents:  StringMap<String>;
    var loaded: Void -> Void;
    var itemLoaded: String -> Void;
    var count: Int;
    public function new( fileNames: Array<String>, loaded_: Void -> Void, ?itemLoaded: String -> Void ){
        reload( fileNames, loaded_, itemLoaded_ );
    }
    public function reload( fileNames: Array<String>, loaded_: Void -> Void, ?itemLoaded_: String -> Void ){
        contents = new StringMap<String>();
        loaded = loaded_;
        if( itemLoaded_ != null ) itemLoaded = itemLoaded_;
        count = fileNames.length;
        for( file in fileNames ) load( file );
    }
    function load( file: String ){ 
        var r         = new Http( file );
        r.onError     = Browser.alert;
        r.onData      = store.bind( file.split('/').pop() );
        r.request( false );
    }
    function store( name: String,  data: String ){
        count--;
        if( itemLoaded != null ) itemLoaded( name );
        contents.set( name, data );
        if( count == 0 ){
            loaded();
        }
    }
}

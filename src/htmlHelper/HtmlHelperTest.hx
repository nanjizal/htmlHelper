package htmlHelper;
#if !htmlHelperDoc
import utest.Runner;
import utest.Test;
import utest.ui.Report;
import equals.Equal;
// subfolders
import htmlHelper.canvas.*;
import htmlHelper.svg.*;
import htmlHelper.tools.*;
import htmlHelper.webgl.*;

@:build(hx.doctest.DocTestGenerator.generateDocTests())
@:build(utest.utils.TestBuilder.build())
class HtmlHelperTest extends utest.Test {
    public static function main() {
        var runner = new Runner();
        runner.addCase( new HtmlHelperTest() );
        Report.create(runner);
        runner.run();
    }
    function new() {
        super();
    }
}
#end
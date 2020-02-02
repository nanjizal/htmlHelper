# htmlHelper
html helper abstracts and setup classes, to make working with Svg, Canvas, WebGL simpler for me.

[unit tests](https://nanjizal.github.io/htmlHelper/geomTest.html) ( using haxe-doctest and utest, not yet implemented )

[doc](https://nanjizal.github.io/htmlHelper/pages) ( using doc-gen to provide documentation )

### Library contents

  - **canvas**  
      AutoSize is to help with automatically sizing the canvas: setFull or setVerticalSplit  
      CanvasWrapper quick creation of Canvas context and provides x, y properties.  
      Leaf provides image offset rotations allowing IK construction uses only two canvas elements.  
      Surface provides basic flash style api for simplified canvas drawing.   
  - **svg** 
      SvgPath wrapper: path, x, y, color, thickness  
      SvgPathString wrapper provides simple path string creation using draw commands.  
      SvgRoot helps setup root svg node.  
  - **tools**
      AnimateTimer provides basic css enterframe and basic tween  
      Attributes helps deconstruct attributes to typed values.  
      CharacterInput quick keyboard listener helper  
      DivertTrace provides onscreen trace in the browser with styling.  
      ImageLoader has a hash of images loaded and wraps loading images.
  - **webgl**
      WebGLSetup provides fairly generic tools for helping setting up WebGL quickly.
      
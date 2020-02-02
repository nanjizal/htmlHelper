# htmlHelper
html helper abstracts and setup classes, to make working with Svg, Canvas, WebGL simpler for me.

[unit tests](https://nanjizal.github.io/htmlHelper/htmlHelperTest.html) ( using haxe-doctest and utest, not yet implemented )

[doc](https://nanjizal.github.io/htmlHelper/pages/) ( using doc-gen to provide documentation )

### Library contents

  - **canvas**   
      [AutoSize](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/canvas/AutoSize.html) is to help with automatically sizing the canvas: *setFull* or *setVerticalSplit*  
      [CanvasWrapper](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/canvas/CanvasWrapper.html) quick creation of Canvas context and provides x, y properties.  
      [Leaf](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/canvas/Leaf.html) provides image offset rotations allowing IK construction uses only two canvas elements, similar to bones.  
      [Surface](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/canvas/Surface.html) provides basic flash style api for simplified canvas drawing.   
  - **svg**  
      [SvgPath](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/svg/SvgPath.html)wrapper: path, x, y, color, thickness  
      [SvgPathString](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/svg/SvgPathString.html) wrapper provides simple path string creation using draw commands.  
      [SvgRoot](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/svg/SvgRoot.html) helps setup root svg node.  
  - **tools**  
      [AnimateTimer](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/tools/AnimateTimer.html) provides basic css enterframe and basic tween.  
      [Attributes](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/tools/Attributes.html) helps deconstruct attributes to typed values.  
      [CharacterInput](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/tools/CharacterInput.html) quick keyboard listener helper  
      [DivertTrace](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/tools/DivertTrace.html) provides onscreen trace in the browser with styling.  
      [ImageLoader](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/tools/ImageLoader.html)has a hash of images loaded and wraps loading images.
  - **webgl**  
      [WebGLSetup](https://nanjizal.github.io/htmlHelper/pages/htmlHelper/webgl/WebGLSetup.html) provides fairly generic tools for helping setting up WebGL quickly.
      

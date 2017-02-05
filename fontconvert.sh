#!/usr/bin/env fontforge
# https://fontforge.github.io/en-US/documentation/scripting/
i=1
format=".ttf"
while ( i<$argc )
  if ( $argv[i]=="-format" || $argv[i]=="--format" )
    i=i+1
    if ( i<$argc )
      format = $argv[i]
      if ( format!=".ttf" && format!=".otf" && \
      format!=".pfb" && format!=".svg" )
    Error( "Expected one of '.ttf', '.otf', '.pfb' or '.svg' for format" )
      endif
    endif
  else
    Open($argv[i])
    if ( $order==2 && (format==".otf" || format==".pfb" ))
      SetFontOrder(3)
      SelectAll()
      Simplify(128+32+8,1.5)
      ScaleToEm(1000)
    elseif ( $order==3 && format==".ttf" )
      ScaleToEm(2048)
      RoundToInt()
    endif
    Generate($argv[i]:r + format)
  endif
  i = i+1
endloop

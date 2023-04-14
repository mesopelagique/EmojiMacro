//%attributes = {}
#DECLARE($hexaPath : Text) : Collection

var $codePlace : Integer
$codePlace:=Formula from string:C1601($hexaPath).call()

var $highSurrogate; $lowSurrogate : Integer
$highSurrogate:=Trunc:C95((($codePlace-0x00010000)/0x0400)+0xD800; 0)
$lowSurrogate:=(($codePlace-0x00010000)%0x0400)+0xDC00

return New collection:C1472($highSurrogate; $lowSurrogate)
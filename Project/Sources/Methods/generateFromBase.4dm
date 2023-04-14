//%attributes = {}

var $macroFile; $baseFile : 4D:C1709.File

$macroFile:=Folder:C1567(fk database folder:K87:14).file("Macros v2/Macros.xml")

$baseFile:=Folder:C1567(fk resources folder:K87:11).file("emojibase.raw.json")
If (Not:C34($baseFile.exists))
	ASSERT:C1129(False:C215; "base file not exists")
	return 
End if 

var $base : Object
$base:=JSON Parse:C1218($baseFile.getText())

var $words : Variant

var $macroContent; $word : Text
$macroContent:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\n<!DOCTYPE macros SYSTEM \"http://www.4d.com/dtd/2007/macros.dtd\">\n<macros>\n"

var $hexas; $emoji; $hexa : Text
var $hexasCol : Collection
var $decimal : Integer
For each ($hexas; $base)
	
	$hexasCol:=Split string:C1554($hexas; "-")
	
	$words:=$base[$hexas]
	If (Value type:C1509($words)=Is text:K8:3)
		$words:=New collection:C1472($words)
	End if 
	
	$emoji:=""
	If ($words.indexOf("construction")=-1)
		//continue
	End if 
	
	For each ($hexa; $hexasCol)
		$decimal:=Formula from string:C1601("0x"+$hexa).call()
		If ($decimal<65535)  // <=?
			$emoji+=Char:C90($decimal)
		Else 
			$emoji+=HexaToCharCodes("0x"+$hexa).map(Formula:C1597(Char:C90($1.value))).join("")
		End if 
		
	End for each 
	
	//If ($hexasCol.length=Length($emoji)) // no more true for composed ones
	
	For each ($word; $words)
		
		$macroContent+="<macro name=\":"+$word+":\" type_ahead=\"true\" version=\"2\">\n    <text>"+$emoji+"</text>\n  </macro>"
		
	End for each 
	
	//End if 
	
End for each 

$macroContent+="\n</macros>"

$macroFile.setText($macroContent)
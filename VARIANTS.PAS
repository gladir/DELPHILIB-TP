{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit VARIANTS;

INTERFACE

Const
 VarTypeMask=$0FFF;

Type
 Variant=Record Case Integer of
  1:(I:Integer);       { Type entier }
  2:(F:Real);          { Type flottant }
  3:(S:String[255]);   { Type chaåne }
  4:(P:Pointer);       { Type pointeur, pour simuler un "null" }
 End;

 PVariant=^Variant;

Function Null:PVariant;

IMPLEMENTATION

Function Null:PVariant;Begin
 Null^.P:=Nil;
End;

END.
{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit STRUTILS;

INTERFACE

Function AnsiContainsStr(Const Text:String;Const SubText:String):Boolean;
Function AnsiContainsText(Const Text:String;Const SubText:String):Boolean;
Function AnsiEndsStr(Const SubText:String;Const Text:String):Boolean;
Function AnsiIndexStr(Const Text:String;Var Values:Array of String):Integer;
Function AnsiLeftStr(Const Text:String; Const Count:Integer):String;
Function AnsiReverseString(Const Text:String):String;
Function DupeString(Const Text:String;Count:Integer):String;

IMPLEMENTATION

Function AnsiContainsStr(Const Text:String;Const SubText:String):Boolean;
Var
 i,SubLen,TextLen:Integer;
Begin
 SubLen:=Length(SubText);
 TextLen:=Length(Text);
 If SubLen=0 Then AnsiContainsStr:=True Else
 If TextLen<SubLen Then AnsiContainsStr:=False
  Else
 Begin
  AnsiContainsStr:=False;
  For i:=1 to TextLen-SubLen+1 do If Copy(Text,i,SubLen)=SubText Then Begin
   AnsiContainsStr := True;
   Break;
  End;
 End;
End;

Function AnsiContainsText(Const Text:String;Const SubText:String):Boolean;
Var
 i,SubLen,TextLen:Integer;
 UpperText,UpperSubText:String;
Begin
 SubLen:=Length(SubText);
 TextLen:=Length(Text);
 If SubLen=0 Then AnsiContainsText:=True Else
 If SubLen>TextLen Then AnsiContainsText:=False
  Else
 Begin
  UpperText:='';
  UpperSubText:='';
  For i:=1 to TextLen do UpperText:=UpperText+UpCase(Text[i]);
  For i:=1 to SubLen do UpperSubText:=UpperSubText+UpCase(SubText[i]);
  AnsiContainsText:=False;
  For i:=1 to TextLen-SubLen+1 do If Copy(UpperText,i,SubLen)=UpperSubText Then Begin
   AnsiContainsText := True;
   Break;
  End;
 End;
End;

Function AnsiEndsStr(Const SubText:String;Const Text:String):Boolean;
Var
 SubLen,TextLen:Integer;
Begin
 SubLen:=Length(SubText);
 TextLen:=Length(Text);
 If(SubLen>TextLen)Then AnsiEndsStr:=False
                   Else AnsiEndsStr:=Copy(Text,TextLen-SubLen+1,SubLen)=SubText;
End;

Function AnsiIndexStr(Const Text:String;Var Values:Array of String):Integer;
Var
 i,Len:Integer;
 UpperText,UpperValue:String;
Begin
 UpperText:='';
 For i:=1 to Length(Text) do UpperText:=UpperText+UpCase(Text[i]);
 For i:=0 to High(Values) do Begin
  UpperValue:='';
  For Len:=1 to Length(Values[i]) do UpperValue:=UpperValue+UpCase(Values[i][Len]);
  If UpperText=UpperValue Then Begin
   AnsiIndexStr:=i;
   Exit;
  End;
 End;
 AnsiIndexStr:=-1;
End;


Function AnsiLeftStr(Const Text:String; Const Count:Integer):String;Begin
 AnsiLeftStr:=Copy(Text,1,Count);
End;

Function AnsiReverseString(Const Text:String):String;
Var
 i,Len:Integer;
 ResultStr:String;
Begin
 Len:=Length(Text);
 ResultStr:=Text;
 For i:=1 to Len do ResultStr[i]:=Text[Len-i+1];
 AnsiReverseString:=ResultStr;
End;

Function DupeString(Const Text:String;Count:Integer):String;
Var
 i:Integer;
 ResultStr:String;
Begin
 ResultStr:='';
 For i:=1 to Count do ResultStr:=ResultStr+Text;
 DupeString:=ResultStr;
End;

END.
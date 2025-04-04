{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit SysUtils;

{$N+,E+}

INTERFACE

Uses {$IFDEF FPC}DateUtil{$ELSE}DateUtils{$ENDIF};

Procedure Abort;
Procedure DecodeDate(Date:TDateTime;Var Year,Month,Day:Word);

Function  LowerCase(S:String):String;
Function  RenameFile(Const OldName,NewName:String):Boolean;
Function  SetCurrentDir(Const Dir:String):Boolean;

IMPLEMENTATION

Uses Crt;

Procedure Abort;Begin
 Halt(255);
End;

Procedure Beep;Begin
 Sound(440);
 Delay(200);
 NoSound;
End;

Procedure DecodeDate(Date:TDateTime;Var Year,Month,Day:Word);
Const
 Epoch=693594;
Var
 JD,L,N,I,J,K:LongInt;
Begin
 JD:=Trunc(Date)+Epoch+1;
 L:=JD + 68569;
 N:=(4 * L) div 146097;
 L:=L - (146097 * N + 3) div 4;
 I:=(4000 * (L + 1)) div 1461001;
 L:=L - (1461 * I) div 4 + 31;
 J:=(80 * L) div 2447;
 K:=L - (2447 * J) div 80;
 L:=J div 11;
 J:=J + 2 - (12 * L);
 I:=100 * (N - 49) + I + L;
 Year:=I;
 Month:=J;
 Day:=K;
End;

Function FileExists(Const FileName:String):Boolean;
Var
 f:File;
 R:Boolean;
Begin
 Assign(f,FileName);
 {$I-}Reset(f);{$I+}
 R:=IOResult=0;
 If(R)Then Close(f);
 FileExists:=R;
End;

Function LowerCase(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['A'..'Z']Then S[I]:=Chr(Ord(S[I])+32);
 End;
 LowerCase:=S;
End;

Function RenameFile(Const OldName,NewName:String):Boolean;
Var
 F:File;
Begin
 {$I-}Assign(F,OldName);
 Rename(F,NewName); {$I+}
 RenameFile:=IoResult=0;
End;

Function SetCurrentDir(Const Dir:String):Boolean;Begin
 {$I-} ChDir(Dir); {$I+}
 SetCurrentDir:=IOResult=0;
End;

END.
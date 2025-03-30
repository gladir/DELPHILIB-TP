{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit SysUtils;

INTERFACE

Procedure Abort;
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
{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit FILECTRL;

INTERFACE

Function  DirectoryExists(Name:String):Boolean;
Procedure ForceDirectories(Dir:String);
Procedure ProcessPath(Const EditText:String;Var Drive:Char;Var DirPart,FilePart:String);
Function  SelectDirectory(Var Directory:String):Boolean;

IMPLEMENTATION

Uses Crt,Dos;

Function LastPos(C:Char;S:String):Integer;
Var
 i:Integer;
Begin
 LastPos:=0;
 For i:=Length(S) downto 1 do If S[i] = C Then Begin
  LastPos := i;
  Exit;
 End;
End;

Function DirectoryExists(Name:String):Boolean;
Var
 F:SearchRec;
Begin
 FindFirst(Name,Directory,F);
 DirectoryExists:=(DosError=0)and((F.Attr and Directory)<>0);
End;

Procedure ForceDirectories(Dir:String);
Var
 Path:String;
Begin
 If(Dir[Length(Dir)]='\')or(Dir[Length(Dir)]='/')Then Delete(Dir,Length(Dir),1);
 If DirectoryExists(Dir)Then Exit;
 Path:=Dir;
 While(Length(Path)>0)and(Path[Length(Path)]<>'\')and(Path[Length(Path)]<>'/')do Begin
  Delete(Path,Length(Path),1);
 End;
 If Length(Path)>0 Then ForceDirectories(Path);
 MkDir(Dir);
End;

Procedure ProcessPath(Const EditText:String;Var Drive:Char;Var DirPart,FilePart:String);
Var
 P:Integer;
Begin
 Drive:=#0;
 DirPart:='';
 FilePart:='';
 If(Length(EditText)>1)and(EditText[2]=':')Then Begin
  Drive:=UpCase(EditText[1]);
  P:=3;
 End
  Else
 P:=1;
 P:=LastPos('\', EditText);
 If P>0 Then Begin
  DirPart:=Copy(EditText,1,P);
  FilePart:=Copy(EditText, P + 1, Length(EditText) - P); { Extraire le fichier }
 End
  Else
 FilePart:=EditText;
End;

Function SelectDirectory(Var Directory:String):Boolean;
Var
 Drive:Char;
 DirList:Array[1..20] of String;
 TotalDirs,Selection:Integer;
 SRec:SearchRec;
 Key:Char;
Begin
 ClrScr;
 WriteLn('S‚lectionnez un r‚pertoire :');
 Drive:=UpCase(Directory[1]);
 FindFirst(Directory + '\*.*', DOS.Directory, SRec);
 TotalDirs:=0;
 While(DosError=0)and(TotalDirs<20) do Begin
  If(SRec.Name<>'.')and(SRec.Name<>'..')Then Begin
   Inc(TotalDirs);
   DirList[TotalDirs]:=SRec.Name;
  End;
  FindNext(SRec);
 End;
 If TotalDirs = 0 Then Begin
  WriteLn('Aucun sous-r‚pertoire trouv‚.');
  SelectDirectory:=False;
  Exit;
 End;
 Selection:=1;
 Repeat
  ClrScr;
  WriteLn('S‚lectionnez un r‚pertoire sur ', Drive, ':\');
  For TotalDirs:=1 to TotalDirs do Begin
   If TotalDirs=Selection Then TextColor(LightGreen)
                          Else TextColor(White);
   WriteLn(' ', DirList[TotalDirs]);
  End;
  Key:=ReadKey;
  If Key=#72 then Dec(Selection); { Haut }
  If Key=#80 then Inc(Selection); { Bas }
  If Selection<1 Then Selection:=1;
  If Selection>TotalDirs then Selection:=TotalDirs;
 Until Key=#13;
 Directory:=Directory+'\'+DirList[Selection];
 SelectDirectory:=True;
End;

END.
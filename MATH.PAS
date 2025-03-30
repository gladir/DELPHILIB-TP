{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit MATH;

{$N+}

INTERFACE

Type
 TValueRelationship=(LessThan,Equals,GreaterThan);

Function ArcCos(a:Extended):Extended;
Function ArcCosH(x:Extended):Extended;
Function ArcSin(a:Extended):Extended;
Function ArcSinH(x:Extended):Extended;
Function ArcTan2(y,x:Extended):Extended;
Function ArcTanH(x:Extended):Extended;
Function Ceil(d:Extended):Extended;
Function CompareValue(Const A,B:Extended;Epsilon:Extended):TValueRelationship;
Function Cosh(x:Extended):Extended;
Function Cotan(X:Extended):Extended;
Function Tan(X:Extended):Extended;

IMPLEMENTATION

Function FAbs(a:Real):Real;Begin
 If a<0.0 Then a:=-a;
 FAbs:=a;
End;

Function ArcCos(a:Extended):Extended;Begin
 If FAbs(a)=1.0 Then ArcCos := (1-a)*PI/2.0
                Else ArcCos := Arctan(-a/Sqrt(1-a*a))+2*Arctan(1);
End;

Function ArcCosH(x:Extended):Extended;Begin
 If x<1 Then Begin
  Writeln('Erreur: x doit ˆtre sup‚rieur ou ‚gal … 1');
  Halt(1);
 End;
 ArcCosH:=Ln(x+Sqrt(x*x-1));
End;

Function ArcSin(a:Extended):Extended;Begin
 If FAbs(a)=1.0Then ArcSin:=PI/2.0
               Else ArcSin:=ArcTan(a/Sqrt(1.0-a*a));
End;

Function ArcSinH(x:Extended):Extended;Begin
 If x=0Then ArcSinH:=0
       Else ArcSinH:=Ln(x + Sqrt(x*x+1));
End;

Function ArcTan2(y,x:Extended):Extended;
Var
 R:Real;
Begin
 If(x=0)Then Begin
  If y=0 Then R:=0.0 Else
  If y>0 Then R:=pi/2 Else
  If y<0 Then R:=-pi/2;
 End
  Else
 R:=ArcTan(y/x);
 If x<0.0 Then R:=R+PI;
 If R>PI Then R:=R-2*PI;
 ArcTan2:=R;
End;

Function ArcTanH(x:Extended):Extended;Begin
 If(x<=-1)or(x>=1)Then Begin
  WriteLn('Erreur : arctanh(x) n''est d‚fini que pour -1 < x < 1');
  Halt;
 End;
 Arctanh:=0.5*Ln((1+x)/(1-x));
End;

Function Ceil(d:Extended):Extended;
Var
 R:Integer;
Begin
 R:=Trunc(d);
 If Frac(d)>0 Then R:=R+1;
 Ceil:=R;
End;

Function CompareValue(Const A,B:Extended;Epsilon:Extended):TValueRelationship;Begin
 If Abs(A-B) < Epsilon Then CompareValue:=Equals Else
 If A<B Then CompareValue:=LessThan
        Else CompareValue:=GreaterThan;
End;

Function Cosh(x:Extended):Extended;Begin
 x:=FAbs(x);
 If x > 88.029691931 Then
  Cosh:=0 { Infini }
 Else
  Cosh:=(Exp(x)+Exp(-x))/ 2.0;
End;

Function Cotan(X:Extended):Extended;Begin
 If Tan(X)=0 Then Begin
  WriteLn('Erreur : Cotangente ind‚finie pour X = ', X);
  Cotan:=0;
 End
  Else
 Cotan:=1/Tan(X);
End;

Function Tan(X:Extended):Extended;Begin
 Tan:=Sin(X)/Cos(X);
End;

END.
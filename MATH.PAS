{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit MATH;

{$N+,E+}

INTERFACE

Type
 TValueRelationship=(LessThan,Equals,GreaterThan);
 TPaymentTime=(tpEndOfPeriod, tpBeginOfPeriod);

Function  ArcCos(a:Extended):Extended;
Function  ArcCosH(x:Extended):Extended;
Function  ArcSin(a:Extended):Extended;
Function  ArcSinH(x:Extended):Extended;
Function  ArcTan2(y,x:Extended):Extended;
Function  ArcTanH(x:Extended):Extended;
Function  Ceil(d:Extended):Extended;
Function  CompareValue(Const A,B:Extended;Epsilon:Extended):TValueRelationship;
Function  Cosh(x:Extended):Extended;
Function  Cotan(X:Extended):Extended;
Function  DegToRad(Degrees:Extended):Extended;
Function  Floor(X:Extended):Integer;
Procedure Frexp(X:Extended;Var Mantissa:Extended;Var Exponent:Integer);
Function  FutureValue(Rate:Extended;NPeriods:Integer;Payment,PresentValue:Extended;
                      PaymentTime:TPaymentTime):Extended;
Function  GradToRad(Grads:Extended):Extended;
Function  Hypot(X,Y:Extended):Extended;
Function  InterestPayment(Rate:Extended;Period,NPeriods:Integer;
                          PresentValue,FutureValue:Extended;
                          PaymentTime:TPaymentTime):Extended;
Function  InterestRate(NPeriods:Integer;Payment,PresentValue,FutureValue:Extended;
                       PaymentTime:TPaymentTime):Extended;
Function  InternalRateOfReturn(Guess:Extended;Const CashFlows:Array of Double):Extended;
Function  IntPower(Base:Extended;Exponent:Integer):Extended;
Function  Ldexp(X:Extended;P:Integer):Extended;
Function  Power(Base,Exponent:Extended):Extended;
Function  Tan(X:Extended):Extended;

IMPLEMENTATION

Function FAbs(a:Real):Real;Begin
 If a<0.0 Then a:=-a;
 FAbs:=a;
End;

Function NPV(Guess:Extended;Const CashFlows:Array of Double):Extended;
Var
 i:Integer;
 Total:Extended;
Begin
 Total:=0;
 For i:=0 To High(CashFlows)do Total:=Total+CashFlows[i]/Power(1+Guess,i);
 NPV:=Total;
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

Function DegToRad(Degrees:Extended):Extended;Begin
 DegToRad:=Degrees*(Pi/180);
End;

Function Floor(X:Extended):Integer;Begin
 If X<0 Then Floor:=Trunc(X)-1
        Else Floor:=Trunc(X);
End;

Procedure Frexp(X:Extended;Var Mantissa:Extended;Var Exponent:Integer);Begin
 If X=0 Then Begin
  Mantissa:=0;
  Exponent:=0;
 End
  Else
 Begin
  Exponent:=Trunc(Ln(Abs(X))/Ln(2));
  Mantissa:=X/Power(2,Exponent);
  If Abs(Mantissa)<1 Then Begin
   Mantissa:=Mantissa*2;
   Exponent:=Exponent-1;
  End;
 End;
End;

Function FutureValue(Rate:Extended;NPeriods:Integer;Payment,PresentValue:Extended;
                     PaymentTime:TPaymentTime):Extended;
Var
 FV:Extended;
Begin
 If Rate=0 Then Begin
  FV:=PresentValue+Payment*NPeriods;
 End
  Else
 Begin
  If PaymentTime=tpEndOfPeriod Then Begin
   FV:=PresentValue*Power(1+Rate,NPeriods)+Payment*((Power(1+Rate,NPeriods)-1)/Rate);
  End
   Else
  If(PaymentTime=tpBeginOfPeriod)Then Begin
   FV:=PresentValue*Power(1+Rate,NPeriods)+Payment*((Power(1+Rate,NPeriods)-1)/Rate)*(1+Rate);
  End;
 End;
 FutureValue:=FV;
End;

Function GradToRad(Grads:Extended):Extended;Begin
 GradToRad:=Grads*Pi/200;
End;

Function Hypot(X,Y:Extended):Extended;Begin
 Hypot:=Sqrt(X*X+Y*Y);
End;

Function InterestPayment(Rate:Extended;Period,NPeriods:Integer;
                         PresentValue,FutureValue:Extended;
                         PaymentTime:TPaymentTime):Extended;
Var
 Payment:Extended;
Begin
 If Rate=0 Then Payment:=(PresentValue-FutureValue)/NPeriods
  Else
 Begin
  If PaymentTime=tpEndOfPeriod Then Begin
   Payment:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1);
  End
   Else
  If PaymentTime=tpBeginOfPeriod Then Begin
   Payment:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1)*(1+Rate);
  End;
 End;
 InterestPayment:=Payment;
End;

Function InterestRate(NPeriods:Integer;Payment,PresentValue,FutureValue:Extended;
                      PaymentTime:TPaymentTime):Extended;
Var
 Rate,RatePrev,PaymentCalc:Extended;
 Iterations,MaxIterations:Integer;
 Tolerance:Extended;
Begin
 Rate:=0.05;
 MaxIterations:=100;
 Tolerance:=0.0001;
 Iterations:=0;
 Repeat
  If PaymentTime=tpEndOfPeriod Then Begin
   PaymentCalc:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1);
  End
   Else
  If PaymentTime=tpBeginOfPeriod Then Begin
   PaymentCalc:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1)*(1+Rate);
  End;
  If(Abs(Payment-PaymentCalc)<Tolerance)Then Break;
  RatePrev:=Rate;
  Rate:=Rate+0.001;
  Iterations:=Iterations+1;
 Until (Iterations>=MaxIterations)or(Abs(Rate-RatePrev)<Tolerance);
 InterestRate := Rate;
End;

Function InternalRateOfReturn(Guess:Extended;Const CashFlows:Array of Double):Extended;
Var
 Rate,RatePrev,Delta:Extended;
 Iterations,MaxIterations:Integer;
 Tolerance:Extended;
Begin
 Rate:=Guess;
 MaxIterations:=100;
 Tolerance:=0.0001;
 Iterations:=0;
 Repeat
  RatePrev:=Rate;
  Delta:=NPV(Rate,CashFlows)/NPV(Rate+Tolerance,CashFlows)-NPV(Rate-Tolerance,CashFlows);
  If Delta<>0 Then Rate:=Rate-NPV(Rate,CashFlows)/Delta
              Else Rate:=Rate+Tolerance;
  Iterations:=Iterations+1;
 Until (Abs(NPV(Rate,CashFlows))<Tolerance)or(Iterations>=MaxIterations);
 InternalRateOfReturn:=Rate;
End;

Function IntPower(Base:Extended;Exponent:Integer):Extended;
Var
 Resultat:Extended;
 i:Integer;
Begin
 Resultat:=1.0;
 If Exponent<0 Then Begin
  Base:=1.0/Base;
  Exponent:=-Exponent;
 End;
 For i:=1 To Exponent do Resultat:=Resultat*Base;
 IntPower:=Resultat;
End;

Function Ldexp(X:Extended;P:Integer):Extended;
Var
 i:Integer;
Begin
 If X=0.0 Then Begin
  Ldexp:=0.0;
  Exit;
 End;
 If P>0 Then For i:=1 To P do X:=X*2.0
        Else For i:=P To -1 Do X:=X/2.0;
 Ldexp:=X;
End;



Function Power(Base,Exponent:Extended):Extended;
Var
 I:Integer;
 R:Extended;
Begin
 If Exponent=0 Then Power:=1 Else
 If Exponent > 0 Then Begin
  R:=1;
  For I:=1 to Trunc(Exponent) Do R:=R*Base;
  Power:=R;
 End
  Else
 Power:=1/Power(Base,-Exponent);
End;


Function Tan(X:Extended):Extended;Begin
 Tan:=Sin(X)/Cos(X);
End;

END.
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
 TPaymentTime=(ptEndOfPeriod, ptBeginningOfPeriod);

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
Function  LnXP1(X:Extended):Extended;
Function  Log10(X:Extended):Extended;
Function  Log2(X:Extended):Extended;
Function  LogN(Base,X:Extended):Extended;
Function  MaxIntValue(Const Data:Array of Integer):Integer;
Function  MaxValue(Const Data:Array of Double):Double;
Function  Mean(Const Data:Array of Double):Extended;
Procedure MeanAndStdDev(Const Data:Array of Double;Var Mean,StdDev:Extended);
Function  MinIntValue(Const Data:Array of Integer):Integer;
Function  MinValue(Const Data:Array of Double):Double;
Function  NetPresentValue(Rate:Extended;Const CashFlows:Array of Double;
                          PaymentTime:TPaymentTime):Extended;
Function  Norm(Const Data:Array of Double):Extended;
Function  NumberOfPeriods(Rate,Payment,PresentValue,FutureValue:Extended;
                          PaymentTime:TPaymentTime):Extended;
Function  Payment(Rate:Extended;NPeriods:Integer;PresentValue,FutureValue:Extended;
                  PaymentTime:TPaymentTime):Extended;
Function  Poly(X:Extended;Const Coefficients:Array of Double):Extended;
Function  Power(Base,Exponent:Extended):Extended;
Function  RadToCycle(Radians:Extended):Extended;
Function  RadToDeg(Radians:Extended):Extended;
Function  RadToGrad(Radians:Extended):Extended;
Function  RandG(Mean,StdDev:Extended):Extended;
Function  SinH(X:Extended):Extended;
Function  SLNDepreciation(Cost,Salvage:Extended;Life:Integer):Extended;
Function  StdDev(Const Data:Array of Double):Extended;
Function  Sum(Const Data:Array of Double):Extended;
Function  SumInt(Const Data:Array of Integer):Integer;
Function  SumOfSquares(Const Data:Array of Double):Extended;
Procedure SumsAndSquares(Const Data:Array of Double;Var Sum,SumOfSquares:Extended);
Function  SYDDepreciation(Cost,Salvage:Extended;Life,Period:Integer):Extended;
Function  Tan(X:Extended):Extended;
Function  TanH(X:Extended):Extended;
Function  Variance(Const Data:Array of Double):Extended;

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
  If PaymentTime=ptEndOfPeriod Then Begin
   FV:=PresentValue*Power(1+Rate,NPeriods)+Payment*((Power(1+Rate,NPeriods)-1)/Rate);
  End
   Else
  If(PaymentTime=ptBeginningOfPeriod)Then Begin
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
  If PaymentTime=ptEndOfPeriod Then Begin
   Payment:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1);
  End
   Else
  If PaymentTime=ptBeginningOfPeriod Then Begin
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
  If PaymentTime=ptEndOfPeriod Then Begin
   PaymentCalc:=(PresentValue*Rate*Power(1+Rate,NPeriods)-FutureValue*Rate)/(Power(1+Rate,NPeriods)-1);
  End
   Else
  If PaymentTime=ptBeginningOfPeriod Then Begin
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

Function LnXP1(X:Extended):Extended;
Const
 Epsilon=1E-12;
Var
 Term,Sum:Extended;
 N:Integer;
Begin
 If X=0.0 Then Begin
  LnXP1:=0.0;
  Exit;
 End;
 If X<=-1.0 Then Begin
  LnXP1:=-MaxInt;
  Exit;
 End;
 If Abs(X)<0.5 Then Begin
  Sum:=0.0;
  Term:=X;
  N:=1;
  While Abs(Term)>Epsilon do Begin
   Sum:=Sum+Term/N;
   Term:=-Term*X;
   Inc(N);
  End;
  LnXP1:=Sum;
 End
  Else
 LnXP1:=Ln(1.0+X);
End;

Function Log10(X:Extended):Extended;
Const
 Ln10=2.302585092994045684; { ln(10) }
Begin
 If X<=0.0 Then Begin
  Log10:=-MaxInt;
  Exit;
 End;
 Log10:=Ln(X)/Ln10;
End;

Function Log2(X:Extended):Extended;
Const
 Ln2=0.6931471805599453; { ln(2) }
Begin
 If X<=0.0 Then Begin
  Log2:=-MaxInt;
  Exit;
 End;
 Log2:=Ln(X)/Ln2;
End;

Function LogN(Base,X:Extended):Extended;Begin
 If(X<=0.0)or(Base<=0.0)or(Base=1.0)Then Begin
  LogN:=-MaxInt;
  Exit;
 End;
 LogN:=Ln(X)/Ln(Base);
End;

Function MaxIntValue(Const Data:Array of Integer):Integer;
Var
 I,MaxValue:Integer;
Begin
 If High(Data)=0 Then Begin
  MaxIntValue:=-MaxInt;
  Exit;
 End;
 MaxValue:=Data[Low(Data)];
 For I:=Low(Data)+1 To High(Data) do Begin
  If Data[I]>MaxValue Then MaxValue:=Data[I];
 End;
 MaxIntValue:=MaxValue;
End;

Function MaxValue(Const Data:Array of Double):Double;
Var
 I:Integer;
 MaxVal:Double;
Begin
 If High(Data)=0 Then Begin
  MaxValue:=-1.7E+308;
  Exit;
 End;
 MaxVal:=Data[Low(Data)];
 For I:=Low(Data)+1 To High(Data) do Begin
  If Data[I]>MaxVal Then MaxVal:=Data[I];
 End;
 MaxValue:=MaxVal;
End;

Function Mean(Const Data:Array of Double):Extended;
Var
 I,N:Integer;
 Sum:Extended;
Begin
 N:=High(Data);
 If N=0 Then Begin
  Mean:=0.0;
  Exit;
 End;
 Sum:=0.0;
 For I:=Low(Data) To High(Data) do Sum:=Sum+Data[I];
 Mean:=Sum/N;
End;

Procedure MeanAndStdDev(Const Data:Array of Double;Var Mean,StdDev:Extended);
Var
 Sum,SumSquares:Extended;
 I,N:Integer;
Begin
 N:=High(Data);
 If N=0 Then Begin
  Mean:=0;
  StdDev:=0;
  Exit;
 End;
 Sum:=0;
 SumSquares:=0;
 For I:=0 To N-1 do Begin
  Sum:=Sum+Data[I];
  SumSquares:=SumSquares+Sqr(Data[I]);
 End;
 Mean:=Sum/N;
 StdDev:=Sqrt((SumSquares/N)-Sqr(Mean));
End;

Function MinIntValue(Const Data:Array of Integer):Integer;
Var
 I,MinVal,N:Integer;
Begin
 N:=High(Data);
 If N=0 Then Begin
  MinIntValue:=0;
  Exit;
 End;
 MinVal:=Data[0];
 For I:=1 To N-1 Do If Data[I]<MinVal Then MinVal:=Data[I];
 MinIntValue:=MinVal;
End;

Function MinValue(Const Data:Array of Double):Double;
Var
 I,N:Integer;
 MinVal:Double;
Begin
 N:=High(Data);
 If N=0 Then Begin
  MinValue := 0.0;
  Exit;
 End;
 MinVal:=Data[0];
 For I:=1 To N-1 Do If Data[I]<MinVal Then MinVal := Data[I];
 MinValue:=MinVal;
End;

Function NetPresentValue(Rate:Extended;Const CashFlows:Array of Double;
                        PaymentTime:TPaymentTime):Extended;
Var
 I,N:Integer;
 NPV:Extended;
Begin
 N:=High(CashFlows);
 NPV:=0.0;
 If N=0 Then Begin
  NetPresentValue := 0.0;
  Exit;
 End;
 For I:=0 To N-1 do Begin
  If PaymentTime=ptBeginningOfPeriod Then NPV:=NPV+(CashFlows[I]/Power(1+Rate,I))
                             Else NPV:=NPV+(CashFlows[I]/Power(1+Rate,I+1));
 End;
 NetPresentValue:=NPV;
End;

Function Norm(Const Data:Array of Double):Extended;
Var
 I:Integer;
 SumSquares:Extended;
Begin
 SumSquares:=0.0;
 For I:=Low(Data) To High(Data) Do SumSquares:=SumSquares+Sqr(Data[I]);
 Norm:=Sqrt(SumSquares);
End;

Function NumberOfPeriods(Rate,Payment,PresentValue,FutureValue:Extended;
                         PaymentTime:TPaymentTime):Extended;
Var
 AdjustFactor,Num,Denom:Extended;
Begin
 If PaymentTime=ptBeginningOfPeriod Then AdjustFactor:=1+Rate
                                    Else AdjustFactor:=1;
 If Rate=0 Then Begin
  If Payment=0 Then NumberOfPeriods:=0
               Else NumberOfPeriods:=(FutureValue-PresentValue)/Payment;
  Exit;
 End;
 Num:=Payment*AdjustFactor+Rate*FutureValue;
 Denom:=Payment*AdjustFactor+Rate*PresentValue;
 If(Denom=0)or(Num/Denom<=0)Then NumberOfPeriods:=0
                            Else NumberOfPeriods:=Log10(Num/Denom)/Log10(1+Rate);
End;

Function Payment(Rate:Extended;NPeriods:Integer;PresentValue,FutureValue:Extended;
                 PaymentTime:TPaymentTime):Extended;
Var
 AdjustFactor:Extended;
Begin
 If PaymentTime=ptBeginningOfPeriod Then AdjustFactor:=1+Rate
                                    Else AdjustFactor:=1;
 If Rate=0 Then Payment:=(PresentValue+FutureValue)/NPeriods
           Else Payment:=(Rate*(PresentValue*AdjustFactor+FutureValue))/(1-Power(1+Rate,-NPeriods));
End;

Function PeriodPayment(Rate:Extended;Period,NPeriods:Integer;
                      PresentValue,FutureValue:Extended;
                      PaymentTime:TPaymentTime):Extended;
Var
 AdjustFactor:Extended;
Begin
 If PaymentTime=ptBeginningOfPeriod Then AdjustFactor:=1+Rate
                                    Else AdjustFactor:=1;
 If Rate=0 Then PeriodPayment:=(PresentValue+FutureValue)/NPeriods
           Else PeriodPayment:=(Rate*(PresentValue*AdjustFactor+FutureValue))/(1-Power(1+Rate,-NPeriods));
End;

Function Poly(X:Extended;Const Coefficients:Array of Double):Extended;
Var
 I:Integer;
 R:Extended;
Begin
 R:=0;
 For I:=Low(Coefficients) to High(Coefficients) do Begin
  R:=R*X+Coefficients[I];
 End;
 Poly:=R;
End;

Function Power(Base,Exponent:Extended):Extended;
Var
 I:Integer;
 R:Extended;
Begin
 If Exponent=0 Then Power:=1 Else
 If Exponent>0 Then Begin
  R:=1;
  For I:=1 to Trunc(Exponent) Do R:=R*Base;
  Power:=R;
 End
  Else
 Power:=1/Power(Base,-Exponent);
End;

Function RadToCycle(Radians:Extended):Extended;Begin
 RadToCycle:=Radians/(2*Pi);
End;

Function RadToDeg(Radians:Extended):Extended;
Const
 RadToDegFactor=180/3.141592653589793; { 180 / Pi }
Begin
 RadToDeg:=Radians*RadToDegFactor;
End;

Function RadToGrad(Radians:Extended):Extended;
Const
 RadToGradFactor = 200/3.141592653589793; { 200 / Pi }
Begin
 RadToGrad:=Radians*RadToGradFactor;
End;

Function RandG(Mean,StdDev:Extended):Extended;
Var
 U1,U2,Z:Extended;
Begin
 Repeat
  U1:=Random;
 Until U1>0;
 U2:=Random;
 Z:=Sqrt(-2*Ln(U1))*Cos(2*Pi*U2);
 RandG:=Mean+StdDev*Z;
End;

Procedure SinCos(Theta:Extended;Var Sin,Cos:Extended);Begin
 Sin:=System.Sin(Theta);
 Cos:=System.Cos(Theta);
End;

Function SinH(X:Extended):Extended;Begin
 SinH:=(Exp(X)-Exp(-X))/2;
End;

Function SLNDepreciation(Cost,Salvage:Extended;Life:Integer):Extended;Begin
 If Life>0 Then SLNDepreciation:=(Cost-Salvage)/Life
           Else SLNDepreciation:=0;
End;

Function StdDev(Const Data:Array of Double):Extended;
Var
 Mean,Sum,Variance:Extended;
 I,N:Integer;
Begin
 N:=High(Data);
 If N=0 Then Begin
  StdDev:=0;
  Exit;
 End;
 Sum:=0;
 For I:=0 To N-1 do Sum:=Sum+Data[I];
 Mean:=Sum/N;
 Sum:=0;
 For I:=0 To N - 1 do Sum:=Sum+Sqr(Data[I]-Mean);
 Variance:=Sum/N;
 StdDev:=Sqrt(Variance);
End;

Function Sum(Const Data:Array of Double):Extended;
Var
 I:Integer;
 Total:Extended;
Begin
 Total:=0;
 For I:=0 To High(Data) Do Total:=Total+Data[I];
 Sum:=Total;
End;

Function SumInt(Const Data:Array of Integer):Integer;
Var
 I,Total:Integer;
Begin
 Total:=0;
 For I:=0 To High(Data) Do Total:=Total+Data[I];
 SumInt := Total;
End;

Function SumOfSquares(Const Data:Array of Double):Extended;
Var
 I:Integer;
 Total:Extended;
Begin
 Total:=0.0;
 For I:=0 To High(Data) Do Total:=Total+Sqr(Data[I]);
 SumOfSquares:=Total;
End;

Procedure SumsAndSquares(Const Data:Array of Double;Var Sum,SumOfSquares:Extended);
Var
 I:Integer;
Begin
 Sum:=0.0;
 SumOfSquares:=0.0;
 For I:=0 To High(Data) do Begin
  Sum:=Sum+Data[I];
  SumOfSquares:=SumOfSquares+Sqr(Data[I]);
 End;
End;

Function SYDDepreciation(Cost,Salvage:Extended;Life,Period:Integer):Extended;
Var
 SumOfYears:Integer;
Begin
 SumOfYears:=(Life*(Life+1)) Div 2;
 SYDDepreciation:=((Life-Period+1)/SumOfYears)*(Cost-Salvage);
End;

Function Tan(X:Extended):Extended;Begin
 Tan:=Sin(X)/Cos(X);
End;

Function TanH(X:Extended):Extended;Begin
 TanH:=(Exp(X)-Exp(-X))/(Exp(X)+Exp(-X));
End;

Function Variance(Const Data:Array of Double):Extended;
Var
 I,N:Integer;
 Mean,Sum,SumSquares:Extended;
Begin
 N:=High(Data);
 If N=0 Then Begin
  Variance:=0;
  Exit;
 End;
 Sum:=0;
 SumSquares:=0;
 For I:=0 To N-1 do Begin
  Sum:=Sum+Data[I];
  SumSquares:=SumSquares+Sqr(Data[I]);
 End;
 Mean:=Sum/N;
 Variance:=(SumSquares/N)-Sqr(Mean);
End;

END.
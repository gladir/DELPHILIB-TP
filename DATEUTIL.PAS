{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit DATEUTIL;

{$N+,E+}

INTERFACE

Type
 TDateTime=Double;

Function DayOfTheMonth(Const Value:TDateTime):Word;

IMPLEMENTATION

Uses Dos,SysUtils;

Function DayOfTheMonth(Const Value:TDateTime):Word;
Var
 Year,Month,Day:Word;
Begin
 DecodeDate(Value,Year,Month,Day);
 DayOfTheMonth:=Day;
End;


END.
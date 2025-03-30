{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2025
  @website(https://www.gladir.com/DELPHILIB-TP)
  @abstract(Target: Turbo Pascal 7)
  @type: Library
}

Unit TYPES;

INTERFACE

Type
 TPoint=Record
  X,Y:Integer;
 End;

 TRect=Packed Record Case Integer of
  0:(Left, Top, Right, Bottom: Integer);
  1:(TopLeft, BottomRight: TPoint);
 End;


Function PtInRect(Var Rect:TRect; Var P:TPoint):Boolean;

IMPLEMENTATION

Function PtInRect(Var Rect:TRect;Var P:TPoint):Boolean;Begin
  PtInRect := (P.X >= Rect.Left) and (P.X <= Rect.Right) and
              (P.Y >= Rect.Top) and (P.Y <= Rect.Bottom);
End;

END.

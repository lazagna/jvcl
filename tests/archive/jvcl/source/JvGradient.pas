{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing Rights and limitations under the License.

The Original Code is: JvGradient.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is Sébastien Buysse [sbuysse@buypin.com]
Portions created by Sébastien Buysse are CopyRight (C) 2001 Sébastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck@bigfoot.com].

Last Modified: 2000-02-28

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}

{$I JVCL.INC}

unit JvGradient;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls,
  JvTypes, JVCLVer;

type
  TJvGradient = class(TGraphicControl)
  private
    FAboutJVCL: TJVCLAboutInfo;
    FStyle: TGradStyle;
    FStartColor: TColor;
    FEndColor: TColor;
    FSteps: Word;
    FOldB: TBitmap;
    FOldX: Integer;
    FOldY: Integer;
    procedure SetSteps(Value: Word);
    procedure SetStartColor(Value: TColor);
    procedure SetEndColor(Value: TColor);
    procedure SetStyle(Value: TGradStyle);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AboutJVCL: TJVCLAboutInfo read FAboutJVCL write FAboutJVCL stored False;
    property Align;
    property ShowHint;
    property Visible;
    property ParentShowHint;
    property Enabled;
    property PopupMenu;
    property Style: TGradStyle read FStyle write SetStyle default grHorizontal;
    property StartColor: TColor read FStartColor write SetStartColor default clBlue;
    property EndColor: TColor read FEndColor write SetEndColor default clBlack;
    property Steps: Word read FSteps write SetSteps default 100;
  end;

implementation

constructor TJvGradient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldX := 0;
  FOldY := 0;
  FSteps := 100;
  FOldB := TBitmap.Create;
  FStyle := grHorizontal;
  FEndColor := clBlack;
  FStartColor := clBlue;
  Align := alClient;
  ControlStyle := ControlStyle + [csOpaque];
end;

destructor TJvGradient.Destroy;
begin
  FOldB.Free;
  inherited Destroy;
end;

procedure TJvGradient.Paint;
var
  bt: TBitmap;
  i: Integer;
  j, k: Real;
  Deltas: array [0..2] of Real; //R,G,B
  r: TRect;
  FStart, FEnd: TColor;
  FInternalSteps:word;
begin
  if csDestroying in ComponentState then
    Exit;
  if (FOldX <> Width) or (FOldY <> Height) then
  begin
    FInternalSteps := FSteps;
    FStart := ColorToRGB(FStartColor);
    FEnd := ColorToRGB(FEndColor);

    FOldX := Width;
    FOldY := Height;
    bt := TBitmap.Create;
    bt.Width := Width;
    bt.Height := Height;
    case FStyle of
      grFilled:
        begin
          bt.Canvas.Brush.Color := FStart;
          bt.Canvas.Brush.Style := bsSolid;
          bt.Canvas.FillRect(Rect(0, 0, Width, Height));
        end;
      grEllipse:
        begin
          bt.Canvas.Brush.Color := FStart;
          bt.Canvas.Brush.Style := bsSolid;
          bt.Canvas.FillRect(Rect(0, 0, Width, Height));
          if FInternalSteps > (Width div 2) then
            FInternalSteps := Trunc(Width / 2);
          if FInternalSteps > (Height div 2) then
            FInternalSteps := Trunc(Height / 2);
          Deltas[0] := (GetRValue(FEnd) - GetRValue(FStart)) / FInternalSteps;
          Deltas[1] := (GetGValue(FEnd) - GetGValue(FStart)) / FInternalSteps;
          Deltas[2] := (GetBValue(FEnd) - GetBValue(FStart)) / FInternalSteps;
          bt.Canvas.Brush.Style := bsSolid;
          j := (Width / FInternalSteps) / 2;
          k := (Height / FInternalSteps) / 2;
          for i := 0 to FInternalSteps do
          begin
            r.Top := Round(i * k);
            r.Bottom := Height - r.Top;
            r.Right := Round(i * j);
            r.Left := Width - r.Right;
            bt.Canvas.Brush.Color := RGB(Round(GetRValue(FStart) + i * Deltas[0]), Round(GetGValue(FStart) + i *
              Deltas[1]), Round(GetBValue(FStart) + i * Deltas[2]));
            bt.Canvas.Pen.Color := bt.Canvas.Brush.Color;
            bt.Canvas.Ellipse(r.Right, r.Top, r.Left, r.Bottom);
          end;
        end;
      grHorizontal:
        begin
          if FInternalSteps > Width then
            FInternalSteps := Width;
          Deltas[0] := (GetRValue(FEnd) - GetRValue(FStart)) / FInternalSteps;
          Deltas[1] := (GetGValue(FEnd) - GetGValue(FStart)) / FInternalSteps;
          Deltas[2] := (GetBValue(FEnd) - GetBValue(FStart)) / FInternalSteps;
          bt.Canvas.Brush.Style := bsSolid;
          j := Width / FInternalSteps;
          for i := 0 to FInternalSteps do
          begin
            r.Top := 0;
            r.Bottom := Height;
            r.Left := Round(i * j);
            r.Right := Round((i + 1) * j);
            bt.Canvas.Brush.Color := RGB(Round(GetRValue(FStart) + i * Deltas[0]), Round(GetGValue(FStart) + i *
              Deltas[1]), Round(GetBValue(FStart) + i * Deltas[2]));
            bt.Canvas.FillRect(r);
          end;
        end;
      grVertical:
        begin
          if FInternalSteps > Height then
            FInternalSteps := Height;
          Deltas[0] := (GetRValue(FEnd) - GetRValue(FStart)) / FInternalSteps;
          Deltas[1] := (GetGValue(FEnd) - GetGValue(FStart)) / FInternalSteps;
          Deltas[2] := (GetBValue(FEnd) - GetBValue(FStart)) / FInternalSteps;
          bt.Canvas.Brush.Style := bsSolid;
          j := Height / FInternalSteps;
          for i := 0 to FInternalSteps do
          begin
            r.Left := Width;
            r.Right := 0;
            r.Top := Round(i * j);
            r.Bottom := Round((i + 1) * j);
            bt.Canvas.Brush.Color := RGB(Round(GetRValue(FStart) + i * Deltas[0]), Round(GetGValue(FStart) + i *
              Deltas[1]), Round(GetBValue(FStart) + i * Deltas[2]));
            bt.Canvas.FillRect(r);
          end;
        end;
      grMount:
        begin
          bt.Canvas.Brush.Color := FStart;
          bt.Canvas.Brush.Style := bsSolid;
          bt.Canvas.FillRect(Rect(0, 0, Width, Height));
          if FInternalSteps > (Width div 2) then
            FInternalSteps := Trunc(Width / 2);
          if FInternalSteps > (Height div 2) then
            FInternalSteps := Trunc(Height / 2);
          Deltas[0] := (GetRValue(FEnd) - GetRValue(FStart)) / FInternalSteps;
          Deltas[1] := (GetGValue(FEnd) - GetGValue(FStart)) / FInternalSteps;
          Deltas[2] := (GetBValue(FEnd) - GetBValue(FStart)) / FInternalSteps;
          bt.Canvas.Brush.Style := bsSolid;
          j := (Width / FInternalSteps) / 2;
          k := (Height / FInternalSteps) / 2;
          for i := 0 to FInternalSteps do
          begin
            r.Top := Round(i * k);
            r.Bottom := Height - r.Top;
            r.Right := Round(i * j);
            r.Left := Width - r.Right;
            bt.Canvas.Brush.Color := RGB(Round(GetRValue(FStart) + i * Deltas[0]), Round(GetGValue(FStart) + i *
              Deltas[1]), Round(GetBValue(FStart) + i * Deltas[2]));
            bt.Canvas.Pen.Color := bt.Canvas.Brush.Color;
            bt.Canvas.RoundRect(r.Right, r.Top, r.Left, r.Bottom, ((r.Left - r.Right) div 2), ((r.Bottom - r.Top) div
              2));
          end;
        end;
      grPyramid:
        begin
          bt.Canvas.Brush.Color := FStart;
          bt.Canvas.Brush.Style := bsSolid;
          bt.Canvas.FillRect(Rect(0, 0, Width, Height));
          if FInternalSteps > (Width div 2) then
            FInternalSteps := Trunc(Width / 2);
          if FInternalSteps > (Height div 2) then
            FInternalSteps := Trunc(Height / 2);
          Deltas[0] := (GetRValue(FEnd) - GetRValue(FStart)) / FInternalSteps;
          Deltas[1] := (GetGValue(FEnd) - GetGValue(FStart)) / FInternalSteps;
          Deltas[2] := (GetBValue(FEnd) - GetBValue(FStart)) / FInternalSteps;
          bt.Canvas.Brush.Style := bsSolid;
          j := (Width / FInternalSteps) / 2;
          k := (Height / FInternalSteps) / 2;
          for i := 0 to FInternalSteps do
          begin
            r.Top := Round(i * k);
            r.Bottom := Height - r.Top;
            r.Right := Round(i * j);
            r.Left := Width - r.Right;
            bt.Canvas.Brush.Color := RGB(Round(GetRValue(FStart) + i * Deltas[0]), Round(GetGValue(FStart) + i *
              Deltas[1]), Round(GetBValue(FStart) + i * Deltas[2]));
            bt.Canvas.Pen.Color := bt.Canvas.Brush.Color;
            bt.Canvas.FillRect(Rect(r.Right, r.Top, r.Left, r.Bottom));
          end;
        end;
    end;
    FOldB.Assign(bt);
    bt.Free;
  end;
  Canvas.Draw(0, 0, FOldB);
end;

procedure TJvGradient.SetStyle(Value: TGradStyle);
begin
  FStyle := Value;
  FOldX := 0;
  Invalidate;
end;

procedure TJvGradient.SetStartColor(Value: TColor);
begin
  FStartColor := Value;
  FOldX := 0;
  Invalidate;
end;

procedure TJvGradient.SetSteps(Value: Word);
begin
  FSteps := Value;
  FOldX := 0;
  Invalidate;
end;

procedure TJvGradient.SetEndColor(Value: TColor);
begin
  FEndColor := Value;
  FOldX := 0;
  Invalidate;
end;

end.

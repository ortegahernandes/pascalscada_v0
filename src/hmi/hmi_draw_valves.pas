unit HMI_Draw_Valves;

{$mode delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  hmi_draw_basiccontrol, BGRABitmap, BGRABitmapTypes;

type

  { THMIPneumaticValve }

  { THMIBasicValve }

  THMIBasicValve = class(THMIBasicControl)
  private
    FMirrored: Boolean;
    FValveBodyPercent: Double;
    procedure SetMirrored(AValue: Boolean);
    procedure SetValveBodyPercent(AValue: Double);
  protected
    procedure DrawControl; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BodyColor;
    property BorderColor;
    property BorderWidth;

    property Mirrored:Boolean read FMirrored write SetMirrored default false;
    property ValveBodyPercent:Double read FValveBodyPercent write SetValveBodyPercent;
  end;

implementation

procedure THMIBasicValve.SetMirrored(AValue: Boolean);
begin
  if FMirrored=AValue then Exit;
  FMirrored:=AValue;
  InvalidateDraw;
end;

procedure THMIBasicValve.SetValveBodyPercent(AValue: Double);
begin
  if FValveBodyPercent=AValue then Exit;
  if (FValveBodyPercent<0) or (FValveBodyPercent>1) then
    raise exception.Create('ValveBodyPercent accepts values between [0.0 .. 1.0]');
  FValveBodyPercent:=AValue;
  InvalidateDraw;
end;

procedure THMIBasicValve.DrawControl;
var
  emptyArea: TBGRABitmap;
  p:array of TPointF;
begin
  if (Width=0) or (Height=0) then begin
    emptyArea := TBGRABitmap.Create;
  end else begin
    if Height<=Width then
      emptyArea := TBGRABitmap.Create(Width, Height)
    else
      emptyArea := TBGRABitmap.Create(Height, Width);
  end;
  //----------------------------------------------------------------------------
  try
    FControlArea.Assign(emptyArea);
  finally
    FreeAndNil(emptyArea);
  end;

  if (Width=0) or (Height=0) then exit;

  SetLength(p, 4);

  p[0].x:=FBorderWidth/2;
  p[0].y:=(1-FValveBodyPercent)*Height;

  p[1].x:=Width-(FBorderWidth/2);
  p[1].y:=Height-(FBorderWidth/2);

  p[2].x:=Width-(FBorderWidth/2);
  p[2].y:=(1-FValveBodyPercent)*Height;

  p[3].x:=FBorderWidth/2;
  p[3].y:=Height-(FBorderWidth/2);

  FControlArea.CanvasBGRA.Brush.Color:= FBodyColor;
  FControlArea.CanvasBGRA.Pen.Color  := FBorderColor;
  FControlArea.CanvasBGRA.Pen.Width  := FBorderWidth;

  FControlArea.CanvasBGRA.PolygonF(p);

  if Height>Width then
    FControlArea.RotateCCW;

  if FMirrored then begin
    if Height<=Width then
      FControlArea.HorizontalFlip
    else
      FControlArea.VerticalFlip;
  end;
end;

constructor THMIBasicValve.Create(AOwner: TComponent);
begin
  FMirrored:=false;
  FValveBodyPercent:=0.7;
  inherited Create(AOwner);
end;

end.
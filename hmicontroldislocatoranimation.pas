{$IFDEF PORTUGUES}
{:
  @abstract(Controle de deslocamento de controles (animação) nos eixos X e Y da janela.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ELSE}
{:
  @abstract(Unit that implements a component that moves controls on axis X and Y
  of the window.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ENDIF}
unit HMIControlDislocatorAnimation;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, Controls, LinearScaleProcessor, PLCNumber, Tag,
  ProtocolTypes;

type

  {$IFDEF PORTUGUES}
  {:
  @abstract(Controle de deslocamento de controles (animação) nos eixos X e Y da janela.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
  }
  {$ELSE}
  {:
  @abstract(Class of component that moves controls on axis X and Y of the window.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
  }
  {$ENDIF}
  THMIControlDislocatorAnimation = class(TComponent, IHMITagInterface)
  private
    FStartLeft,
    FEndLeft:Integer;
    FStartTop,
    FEndTop:Integer;
    FStartValue,
    FEndValue:Double;
    FTarget:TControl;
    FXLinearScale,
    FYLinearScale:TLinearScaleProcessor;
    FTag:TPLCNumber;
    FMinX, FMaxX,
    FMinY, FMaxY:Boolean;
    FMinXValue, FMaxXValue,
    FMinYValue, FMaxyValue:Integer;

    FGetPositionP0,
    FGetPositionP1,
    FGoToP0:String;

    procedure MoveObject;
    procedure SetStartLeft(v:Integer);
    procedure SetStartTop(v:Integer);
    procedure SetEndLeft(v:Integer);
    procedure SetEndTop(v:Integer);
    procedure SetValueStart(v:Double);
    procedure SetValueEnd(v:Double);
    procedure SetPLCTag(t:TPLCNumber);
    procedure SetControl(t:TControl);

    procedure PropertyDoesNothing(v:String);

    procedure SetEnableMinX(v:Boolean);
    procedure SetEnableMaxX(v:Boolean);
    procedure SetEnableMinY(v:Boolean);
    procedure SetEnableMaxY(v:Boolean);

    procedure SetMinX(v:Integer);
    procedure SetMaxX(v:Integer);
    procedure SetMinY(v:Integer);
    procedure SetMaxY(v:Integer);

    //implements the ihmiTagInterface
    procedure NotifyReadOk;
    procedure NotifyReadFault;
    procedure NotifyWriteOk;
    procedure NotifyWriteFault;
    procedure NotifyTagChange(Sender:TObject);
    procedure RemoveTag(Sender:TObject);
  protected
    //@exclude
    procedure Loaded; override;
  public
    //: @exclude
    constructor Create(AOwner:TComponent); override;
    //: @exclude
    destructor  Destroy; override;
  published
    {$IFDEF PORTUGUES}
    //: Posição inicial no eixo X (propriedade Left do controle)
    {$ELSE}
    //: Initial position on X axis (Left property of the control)
    {$ENDIF}
    property P0_X:Integer read FStartLeft write SetStartLeft;

    {$IFDEF PORTUGUES}
    //: Posição inicial no eixo Y (propriedade Top do controle)
    {$ELSE}
    //: Initial position on Y axis (Top property of the control)
    {$ENDIF}
    property P0_Y:Integer read FStartTop write SetStartTop;

    {$IFDEF PORTUGUES}
    //: Posição final no eixo X (propriedade Left do controle)
    {$ELSE}
    //: Final position on X axis (Left property of the control)
    {$ENDIF}
    property P1_X:Integer read FEndLeft write SetEndLeft;

    {$IFDEF PORTUGUES}
    //: Posição final no eixo y (propriedade Top do controle)
    {$ELSE}
    //: Final position on Y axis (Top property of the control)
    {$ENDIF}
    property P1_Y:Integer read FEndTop write SetEndTop;

    {$IFDEF PORTUGUES}
    //: Valor do tag que irá fazer o controle ir para as coordenadas Inicias (P0_X; P0_Y);
    {$ELSE}
    //: Value of the tag that will move the control to the Initial coordinates (P0_X; P0_Y);
    {$ENDIF}
    property ValueP0:Double read FStartValue write SetValueStart;

    {$IFDEF PORTUGUES}
    //: Valor do tag que irá fazer o controle ir para as coordenadas finais (P1_X; P1_Y);
    {$ELSE}
    //: Value of the tag that will move the control to the final coordinates (P1_X; P1_Y);
    {$ENDIF}
    property ValueP1:Double read FEndValue write SetValueEnd;

    {$IFDEF PORTUGUES}
    //: Tag numérico que irá controlar a animação.
    {$ELSE}
    //: Numeric tag that will control the animation.
    {$ENDIF}
    property PLCTag:TPLCNumber read FTag write SetPLCTag;

    {$IFDEF PORTUGUES}
    //: Controle que será manipulado.
    {$ELSE}
    //: Control that will be manipulated.
    {$ENDIF}
    property Control:TControl read FTarget write SetControl;

    {$IFDEF PORTUGUES}
    //: Habilita o valor mínimo no eixo X.
    {$ELSE}
    //: Enables a minimum value on X axis.
    {$ENDIF}
    property EnableXMin:Boolean read FMinX write SetEnableMinX;

    {$IFDEF PORTUGUES}
    //: Habilita o valor máximo no eixo X.
    {$ELSE}
    //: Enables a maximum value on X axis.
    {$ENDIF}
    property EnableXMax:Boolean read FMaxX write SetEnableMaxX;

    {$IFDEF PORTUGUES}
    //: Habilita o valor mínimo no eixo Y.
    {$ELSE}
    //: Enables a minimum value on Y axis.
    {$ENDIF}
    property EnableYMin:Boolean read FMinY write SetEnableMinY;

    {$IFDEF PORTUGUES}
    //: Habilita o valor máximo no eixo Y.
    {$ELSE}
    //: Enables a maximum value on Y axis.
    {$ENDIF}
    property EnableYMax:Boolean read FMaxY write SetEnableMaxY;

    {$IFDEF PORTUGUES}
    //: Caso valor mínimo de X caso EnableXMin seja @true.
    {$ELSE}
    //: Minimum value of X axis if EnableXMin is @true.
    {$ENDIF}
    property MinXValue:Integer read FMinXValue write SetMinX;

    {$IFDEF PORTUGUES}
    //: Caso valor máximo de X caso EnableXMax seja @true.
    {$ELSE}
    //: Minimum value of X axis if EnableXMax is @true.
    {$ENDIF}
    property MaxXValue:Integer read FMaxXValue write SetMaxX;

    {$IFDEF PORTUGUES}
    //: Caso valor mínimo de Y caso EnableyMin seja @true.
    {$ELSE}
    //: Minimum value of y axis if EnableYMin is @true.
    {$ENDIF}
    property MinYValue:Integer read FMinYValue write SetMinY;

    {$IFDEF PORTUGUES}
    //: Caso valor máximo de Y caso EnableYMax seja @true.
    {$ELSE}
    //: Minimum value of Y axis if EnableYMax is @true.
    {$ENDIF}
    property MaxYValue:Integer read FMaxyValue write SetMaxY;

    {$IFDEF PORTUGUES}
    //: Pega a posição atual do controle como posição inicial (P0).
    {$ELSE}
    //: Gets the actual position of the control as the initial position (P0).
    {$ENDIF}
    property Gets_P0_Position:String read FGetPositionP0 write PropertyDoesNothing;
    {$IFDEF PORTUGUES}
    //: Pega a posição atual do controle como posição final (P1).
    {$ELSE}
    //: Gets the actual position of the control as the final position (P1).
    {$ENDIF}
    property Gets_P1_Position:String read FGetPositionP1 write PropertyDoesNothing;

    {$IFDEF PORTUGUES}
    //: Reposiciona o controle para a posição inicial definida.
    {$ELSE}
    //: Puts the control in the initial position defined.
    {$ENDIF}
    property GoTo_P0_Position:String read FGoToP0        write PropertyDoesNothing;
  end;


implementation

uses hsstrings;

constructor THMIControlDislocatorAnimation.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FGetPositionP0:=SGetP0;
  FGetPositionP1:=SGetP1;
  FGoToP0:=SGotoP0;
  FXLinearScale:=TLinearScaleProcessor.Create(Self);
  FYLinearScale:=TLinearScaleProcessor.Create(Self);
end;

destructor  THMIControlDislocatorAnimation.Destroy;
begin

  if FTag<>nil then begin
    FTag.RemoveCallBacks(self as IHMITagInterface);
  end;

  FXLinearScale.Destroy;
  FYLinearScale.Destroy;
  inherited Destroy;
end;

procedure THMIControlDislocatorAnimation.Loaded;
begin
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.MoveObject;
var
  outX, outY:Double;
begin
  if (FTarget=nil) or (FTag=nil) then exit;

  FXLinearScale.Input:=FTag.Value;
  FYLinearScale.Input:=FTag.Value;

  if FMinX and (FXLinearScale.Output<FMinXValue) then
     outx:=FMinXValue
  else
     outx:=FXLinearScale.Output;

  if FMaxX and (FXLinearScale.Output>FMaxXValue) then
     outx:=FMaxXValue
  else
     outx:=FXLinearScale.Output;


  if FMinY and (FYLinearScale.Output<FMinYValue) then
     outY:=FMinYValue
  else
     outY:=FYLinearScale.Output;

  if FMaxY and (FYLinearScale.Output>FMaxYValue) then
     outY:=FMaxYValue
  else
     outY:=FYLinearScale.Output;

  FTarget.Left:=trunc(outX);
  FTarget.Top :=trunc(outY);
end;

procedure THMIControlDislocatorAnimation.SetStartLeft(v:Integer);
begin
  FStartLeft:=v;
  FXLinearScale.SysMin:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetStartTop(v:Integer);
begin
  FStartTop:=v;
  FYLinearScale.SysMin:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetEndLeft(v:Integer);
begin
  FEndLeft:=v;
  FXLinearScale.SysMax:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetEndTop(v:Integer);
begin
  FEndTop:=v;
  FYLinearScale.SysMax:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetValueStart(v:Double);
begin
  FStartValue:=v;
  FXLinearScale.PLCMin:=v;
  FYLinearScale.PLCMin:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetValueEnd(v:Double);
begin
  FEndValue:=v;
  FXLinearScale.PLCMax:=v;
  FYLinearScale.PLCMax:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetPLCTag(t:TPLCNumber);
begin
  //se o tag esta entre um dos aceitos.
  //Checks if the tag is valid (only numeric tag are acceptable)
  if (t<>nil) and (not Supports(t, ITagNumeric)) then
     raise Exception.Create(SonlyNumericTags);

  //se ja estou associado a um tag, remove
  //if the control is linked with some tag, remove the old link.
  if FTag<>nil then begin
    FTag.RemoveCallBacks(self as IHMITagInterface);
  end;

  //adiona o callback para o novo tag
  //link with the new tag.
  if t<>nil then begin
    t.AddCallBacks(self as IHMITagInterface);
    FTag := t;
    MoveObject;
  end;
  FTag := t;
end;

procedure THMIControlDislocatorAnimation.SetControl(t:TControl);
begin
  if t=FTarget then exit;

  if FTarget<>nil then begin
    FTarget.Left:=FStartLeft;
    FTarget.Top:=FStartTop;
  end;

  FTarget:=t;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.PropertyDoesNothing(v:String);
begin

end;

procedure THMIControlDislocatorAnimation.NotifyReadOk;
begin

end;

procedure THMIControlDislocatorAnimation.NotifyReadFault;
begin

end;

procedure THMIControlDislocatorAnimation.NotifyWriteOk;
begin

end;

procedure THMIControlDislocatorAnimation.NotifyWriteFault;
begin

end;

procedure THMIControlDislocatorAnimation.NotifyTagChange(Sender:TObject);
begin
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.RemoveTag(Sender:TObject);
begin
  if FTag=Sender then
     FTag:=nil;
end;

procedure THMIControlDislocatorAnimation.SetEnableMinX(v:Boolean);
begin
  FMinX:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetEnableMaxX(v:Boolean);
begin
  FMaxX:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetEnableMinY(v:Boolean);
begin
  FMinY:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetEnableMaxY(v:Boolean);
begin
  FMinY:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetMinX(v:Integer);
begin
  FMinXValue:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetMaxX(v:Integer);
begin
  FMaxXValue:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetMinY(v:Integer);
begin
  FMinYValue:=v;
  MoveObject;
end;

procedure THMIControlDislocatorAnimation.SetMaxY(v:Integer);
begin
  FMaxYValue:=v;
  MoveObject;
end;

end.

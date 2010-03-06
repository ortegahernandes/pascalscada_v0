unit uTagBuilder;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF FPC}LCLIntf, LResources, {$ELSE} Windows, {$ENDIF}Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Spin;

type
  TTagNamesItemEditor = class(TPanel)
  private
    FOnDelClick:TNotifyEvent;
    procedure UpClick(Sender: TObject);
    procedure DownClick(Sender: TObject);
    procedure DelClick(Sender: TObject);
  public
    Nome:TEdit;
    CountEmpty:TCheckBox;
    Scan:TSpinEdit;
    ZeroFill:TCheckBox;
    QtdDigitos:TSpinEdit;
    PIPES:TComboBox;
    Up,
    Down,
    Del:TButton;
    Prior,Next:TPanel;
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
  published
    property OnDelClick:TNotifyEvent read FOnDelClick write FOnDelClick;
  end;

  TfrmModbusTagBuilder = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    txtTagType: TLabel;
    Type1: TRadioButton;
    Type2: TRadioButton;
    Type3: TRadioButton;
    Type4: TRadioButton;
    Panel1: TPanel;
    btnCancel: TButton;
    btnPrior: TButton;
    btnNext: TButton;
    btnFinish: TButton;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    optPLCTagNumber: TRadioButton;
    optPLCBlock: TRadioButton;
    optPLCString: TRadioButton;
    txtMemCount: TLabel;
    MemCount: TSpinEdit;
    FirstMemAddress: TSpinEdit;
    txtFirstMemAddress: TLabel;
    txtStationAddress: TLabel;
    StationAddress: TSpinEdit;
    optSimpleFunctions: TCheckBox;
    MaxStringSize: TSpinEdit;
    txtMaxStringSize: TLabel;
    txtMaxBlockSize: TLabel;
    MaxBlockSize: TSpinEdit;
    txtStringFormat: TLabel;
    Panel2: TPanel;
    optSTR_C: TRadioButton;
    optSTR_SIEMENS: TRadioButton;
    TabSheet3: TTabSheet;
    txtStringByteSize: TLabel;
    ByteSize: TSpinEdit;
    ScrollBox1: TScrollBox;
    Panel4: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    procedure btnFinishClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure DelItem(Sender:TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure optPLCTagNumberClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  public
    CurItem:TTagNamesItemEditor;
    destructor Destroy; override;
  end;

var
  frmModbusTagBuilder: TfrmModbusTagBuilder;

implementation

{$IFDEF FPC}
{$R utagbuilder.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}


constructor TTagNamesItemEditor.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Align := alTop;
  BevelOuter := bvNone;
  Height := 24;

  Nome:=TEdit.Create(Self);
  with Nome do begin
    Parent  := Self;
    Top     := 0;
    Left    := 0;
    Height  := 21;
    Width   := 160;
    Text    := '';
  end;

  CountEmpty:=TCheckBox.Create(Self);
  with CountEmpty do begin
    Parent  := Self;
    Top     := 3;
    Left    := 174;
    Height  := 18;
    Width   := 17;
    Checked := false;
  end;

  Scan:=TSpinEdit.Create(Self);
  with Scan do begin
    Parent  := Self;
    Top     := 0;
    Left    := 202;
    Height  := 21;
    Width   := 57;
    Value   := 1000;
    MaxValue:= 7200000;
    MinValue:= 0;
  end;

  ZeroFill:=TCheckBox.Create(Self);
  with ZeroFill do begin
    Parent  := Self;
    Top     := 3;
    Left    := 267;
    Height  := 18;
    Width   := 17;
    Checked := false;
  end;

  QtdDigitos:=TSpinEdit.Create(Self);
  with QtdDigitos do begin
    Parent  := Self;
    Top     := 0;
    Left    := 296;
    Height  := 21;
    Width   := 57;
  end;

  PIPES:=TComboBox.Create(Self);
  with PIPES do begin
    Parent  := Self;
    Top     := 0;
    Left    := 351;
    Height  := 21;
    Width   := 135;
    Style   := csDropDownList;
  end;

  Up:=TButton.Create(Self);
  with Up do begin
    Parent  := Self;
    Top     := 0;
    Left    := 487;
    Height  := 21;
    Width   := 22;
    Caption := 'Up';
    OnClick := UpClick;
  end;

  Down:=TButton.Create(Self);
  with Down do begin
    Parent  := Self;
    Top     := 0;
    Left    := 509;
    Height  := 21;
    Width   := 34;
    Caption := 'Down';
    OnClick := DownClick;
  end;

  Del:=TButton.Create(Self);
  with Del do begin
    Parent  := Self;
    Top     := 0;
    Left    := 543;
    Height  := 21;
    Width   := 25;
    Caption := 'Del';
    OnClick := DelClick;
  end;
end;

destructor  TTagNamesItemEditor.Destroy;
begin

  if (Prior<>nil) and (Prior is TTagNamesItemEditor) then
    TTagNamesItemEditor(Prior).Next := Next;
  if (Next<>nil) and (Next is TTagNamesItemEditor) then
    TTagNamesItemEditor(Next).Prior := Prior;

  Nome.Destroy;
  CountEmpty.Destroy;
  Scan.Destroy;
  ZeroFill.Destroy;
  QtdDigitos.Destroy;
  PIPES.Destroy;
  Up.Destroy;
  Down.Destroy;
  Del.Destroy;
  inherited Destroy;
end;

procedure TTagNamesItemEditor.UpClick(Sender: TObject);
var
  p, p1 ,n:TTagNamesItemEditor;
begin
  p:=TTagNamesItemEditor(Self.Prior);
  n:=TTagNamesItemEditor(Self.Next);
  if p=nil then begin
    exit;
  end else begin
    Self.Top := p.Top - 1;
    p1 := TTagNamesItemEditor(p.Prior);
    TTagNamesItemEditor(p).Next := n;
  end;

  if n<>nil then
    TTagNamesItemEditor(n).Prior := p;

  if p1<>nil then
    p1.Next:=Self;
  Self.Prior:=p1;
  Self.Next := p;
  p.Prior := Self;
end;

procedure TTagNamesItemEditor.DownClick(Sender: TObject);
var
  p,n,n1:TTagNamesItemEditor;
begin
  p:=TTagNamesItemEditor(Self.Prior);
  n:=TTagNamesItemEditor(Self.Next);
  if n=nil then begin
    exit;
  end else begin
    Self.Top := n.Top + 1;
    n1 := TTagNamesItemEditor(n.Next);
    TTagNamesItemEditor(n).Prior := p;
  end;

  if p<>nil then
    TTagNamesItemEditor(p).Next := n;

  if n1<>nil then
    n1.Prior:=Self;
  Self.Next:=n1;
  Self.Prior := n;
  n.Next := Self;
end;

procedure TTagNamesItemEditor.DelClick(Sender: TObject);
begin
  if Assigned(FOnDelClick) then
    FOnDelClick(Self);
end;

////////////////////////////////////////////////////////////////////////////////

destructor TfrmModbusTagBuilder.Destroy;
var
  item : TTagNamesItemEditor;
begin

  while CurItem<>nil do begin
     item:=TTagNamesItemEditor(CurItem.Prior);
     CurItem.Destroy;
     CurItem:=item;
  end;
  inherited Destroy;
end;

procedure TfrmModbusTagBuilder.PageControl1Change(Sender: TObject);
begin
  btnPrior.Enabled:=PageControl1.TabIndex<>0;
  btnNext.Enabled:=PageControl1.TabIndex<>2;
  optPLCTagNumberClick(Sender);
  btnFinish.Enabled:=PageControl1.TabIndex=2;
end;

procedure TfrmModbusTagBuilder.DelItem(Sender:TObject);
var
  item, n, p:TTagNamesItemEditor;
begin
  //se so ha um item.
  if (CurItem.Prior=nil) and (CurItem.Next=nil) then exit;


  If MessageDlg('Deseja mesmo deletar o item?', mtConfirmation, [mbYes, mbNo],0)=mrYes then begin
    item := CurItem;
    if Sender=CurItem then begin
      CurItem := TTagNamesItemEditor(item.Prior);
      item.Destroy;
    end else begin
      while item<>nil do begin
        if item=Sender then begin
          n := TTagNamesItemEditor(item.Next);
          p := TTagNamesItemEditor(item.Prior);
          if p<>nil then
            p.Next := n;

          if n<>nil then
            n.Prior := p;
          item.Destroy;
          break;
        end;
        item := TTagNamesItemEditor(item.Prior);
      end;
    end;
  end;
end;

procedure TfrmModbusTagBuilder.FormCreate(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  CurItem := TTagNamesItemEditor.Create(Self);
  CurItem.Parent := ScrollBox1;
  CurItem.Prior := nil;
  CurItem.Next  := nil;
  CurItem.OnDelClick := DelItem;
end;

procedure TfrmModbusTagBuilder.optPLCTagNumberClick(Sender: TObject);
begin
  optSimpleFunctions.Enabled := optPLCTagNumber.Checked;
  txtMaxBlockSize.Enabled := optPLCBlock.Checked;
  MaxBlockSize.Enabled := optPLCBlock.Checked;
  txtMaxStringSize.Enabled := optPLCString.Checked;
  MaxStringSize.Enabled := optPLCString.Checked;
  txtStringFormat.Enabled := optPLCString.Checked;
  optSTR_C.Enabled := optPLCString.Checked;
  optSTR_SIEMENS.Enabled := optPLCString.Checked;
  txtStringByteSize.Enabled := optPLCString.Checked;
  ByteSize.Enabled := optPLCString.Checked;
end;

procedure TfrmModbusTagBuilder.btnFinishClick(Sender: TObject);
var
  item:TTagNamesItemEditor;
begin
  item := CurItem;
  while item<>nil do begin
    if (Trim(item.Nome.Text)<>'') AND (not (item.Nome.Text[1] in ['a'..'z','A'..'Z','_'])) then
      raise Exception.Create('Nome inv�lido!');
    item := TTagNamesItemEditor(item.Prior);
  end;

  item := CurItem;  
  while item<>nil do begin
    if ((Trim(item.Nome.Text)<>'') AND (item.Nome.Text[1] in ['a'..'z','A'..'Z','_'])) or item.CountEmpty.Checked then
      break;
    item := TTagNamesItemEditor(item.Prior);
  end;
  if item=nil then
    raise Exception.Create('� necess�rio que pelo menos um nome v�lido esteja presente ou um item tenha a op��o "Contar Vazios" marcado!');
end;

procedure TfrmModbusTagBuilder.btnNextClick(Sender: TObject);
begin
  PageControl1.TabIndex := PageControl1.TabIndex + 1;
  PageControl1Change(Sender);  
end;

procedure TfrmModbusTagBuilder.btnPriorClick(Sender: TObject);
begin
  PageControl1.TabIndex := PageControl1.TabIndex - 1;
  PageControl1Change(Sender);
end;

procedure TfrmModbusTagBuilder.Button1Click(Sender: TObject);
var
  newitem:TTagNamesItemEditor;
begin
  newitem := TTagNamesItemEditor.Create(Self);
  newitem.Parent := ScrollBox1;
  newitem.Prior := CurItem;
  CurItem.Next  := newitem;
  newitem.Next  := nil;
  newitem.OnDelClick := DelItem;
  newitem.Top := 200;
  CurItem := newitem;
end;

end.